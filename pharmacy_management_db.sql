USE pharmacy_management_db;
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    role VARCHAR(50) DEFAULT 'Pharmacist'
);

INSERT INTO users (phone_number, role) VALUES ('7020712960', 'Admin');