from flask import Flask, jsonify, request
import random
import mysql.connector
from flask_cors import CORS

app = Flask(__name__)
CORS(app) 

db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': 'Bhavesh@89',
    'database': 'pharmacy_management_db'
}

def get_db_connection():
    return mysql.connector.connect(**db_config)

otp_storage = {}


@app.route('/api/request-otp', methods=['POST'])
def request_otp():
    try:
        data = request.json
        phone = data.get('phone')
        name = data.get('name')
        age = data.get('age')

        conn = get_db_connection()
        cursor = conn.cursor()
        
        cursor.execute("SELECT * FROM users WHERE phone_number = %s", (phone,))
        user = cursor.fetchone()
        
        cursor.close()
        conn.close()

        if not user:
            return jsonify({"error": "Unauthorized number. Contact Admin."}), 403

        otp = str(random.randint(1000, 9999))
        otp_storage[phone] = otp 

        print("\n" + "="*40)
        print(f"📱 MOCK SMS TO {name} ({phone}):")
        print(f"Your PharmaSync Login OTP is: {otp}")
        print("="*40 + "\n")

        return jsonify({"message": "OTP sent!"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/verify-otp', methods=['POST'])
def verify_otp():
    try:
        data = request.json
        phone = data.get('phone')
        user_otp = data.get('otp')

        if phone in otp_storage and otp_storage[phone] == user_otp:
            del otp_storage[phone]
            return jsonify({"message": "Login successful!"}), 200
        else:
            return jsonify({"error": "Invalid or expired OTP."}), 401
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route('/api/inventory', methods=['GET'])
def get_inventory():
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True) 
        cursor.execute("SELECT * FROM medicines ORDER BY id DESC") 
        results = cursor.fetchall()
        for row in results:
            if row['expiry_date']:
                row['expiry_date'] = row['expiry_date'].strftime('%Y-%m-%d')
        cursor.close()
        conn.close()
        return jsonify(results)
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/inventory', methods=['POST'])
def add_medicine():
    try:
        data = request.json
        conn = get_db_connection()
        cursor = conn.cursor()

        # NEW: Added item_type
        sql = """INSERT INTO medicines (name, category, supplier, price, stock_quantity, expiry_date, item_type) 
                 VALUES (%s, %s, %s, %s, %s, %s, %s)"""
        
        expiry = data.get('expiry_date') if data.get('expiry_date') else None
        
        values = (data.get('name'), data.get('category'), data.get('supplier'), 
                  data.get('unit_price'), data.get('stock_quantity'), expiry, data.get('item_type'))
        
        cursor.execute(sql, values)
        conn.commit() 
        cursor.close()
        conn.close()
        return jsonify({"message": "Item added!"}), 201
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/inventory/<int:item_id>', methods=['PUT'])
def update_medicine(item_id):
    try:
        data = request.json
        conn = get_db_connection()
        cursor = conn.cursor()

        # NEW: Added item_type
        sql = """UPDATE medicines 
                 SET name = %s, category = %s, supplier = %s, price = %s, stock_quantity = %s, expiry_date = %s, item_type = %s 
                 WHERE id = %s"""
                 
        expiry = data.get('expiry_date') if data.get('expiry_date') else None
        
        values = (data.get('name'), data.get('category'), data.get('supplier'), 
                  data.get('unit_price'), data.get('stock_quantity'), expiry, data.get('item_type'), item_id)
        
        cursor.execute(sql, values)
        conn.commit() 
        cursor.close()
        conn.close()
        return jsonify({"message": "Item updated!"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/inventory/<int:item_id>', methods=['DELETE'])
def delete_medicine(item_id):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("DELETE FROM medicines WHERE id = %s", (item_id,))
        cursor.execute("SELECT COUNT(*) FROM medicines")
        if cursor.fetchone()[0] == 0:
            cursor.execute("ALTER TABLE medicines AUTO_INCREMENT = 1")
        conn.commit() 
        cursor.close()
        conn.close()
        return jsonify({"message": "Deleted!"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/inventory/sell/<int:item_id>', methods=['POST'])
def sell_medicine(item_id):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("UPDATE medicines SET stock_quantity = stock_quantity - 1 WHERE id = %s AND stock_quantity > 0", (item_id,))
        conn.commit() 
        cursor.close()
        conn.close()
        return jsonify({"message": "1 Unit Sold!"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route('/api/blood/dashboard', methods=['GET'])
def get_blood_dashboard():
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        
        # Get Stock
        cursor.execute("SELECT * FROM blood_inventory ORDER BY blood_group")
        stock = cursor.fetchall()
        
        # Get Recent Donors
        cursor.execute("SELECT * FROM blood_donors ORDER BY id DESC LIMIT 10")
        donors = cursor.fetchall()
        for d in donors:
            if d['donation_date']:
                d['donation_date'] = d['donation_date'].strftime('%Y-%m-%d')
                
        cursor.close()
        conn.close()
        return jsonify({"stock": stock, "donors": donors}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route('/api/blood/donate', methods=['POST'])
def add_donation():
    try:
        data = request.json
        b_group = data.get('blood_group')
        
        conn = get_db_connection()
        cursor = conn.cursor()
        
        # 1. Record the donor
        sql_donor = "INSERT INTO blood_donors (donor_name, blood_group, phone, donation_date) VALUES (%s, %s, %s, %s)"
        cursor.execute(sql_donor, (data.get('donor_name'), b_group, data.get('phone'), data.get('donation_date')))
        
        # 2. Increase the blood stock by 1 bag
        sql_stock = "UPDATE blood_inventory SET bags_available = bags_available + 1 WHERE blood_group = %s"
        cursor.execute(sql_stock, (b_group,))
        
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({"message": "Donation recorded & stock updated!"}), 201
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route('/api/blood/dispense', methods=['POST'])
def dispense_blood():
    try:
        data = request.json
        b_group = data.get('blood_group')
        
        conn = get_db_connection()
        cursor = conn.cursor()
        
        # Decrease stock by 1 only if there is stock available
        cursor.execute("UPDATE blood_inventory SET bags_available = bags_available - 1 WHERE blood_group = %s AND bags_available > 0", (b_group,))
        
        if cursor.rowcount == 0:
            return jsonify({"error": f"No stock available for {b_group}!"}), 400
            
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({"message": f"1 Bag of {b_group} Dispensed!"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

        
if __name__ == '__main__':
    app.run(debug=True, port=5000)