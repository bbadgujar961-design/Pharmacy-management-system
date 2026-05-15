-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: pharmacy_management_db
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `blood_donors`
--

DROP TABLE IF EXISTS `blood_donors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blood_donors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `donor_name` varchar(100) NOT NULL,
  `blood_group` varchar(5) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `donation_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blood_donors`
--

LOCK TABLES `blood_donors` WRITE;
/*!40000 ALTER TABLE `blood_donors` DISABLE KEYS */;
INSERT INTO `blood_donors` VALUES (1,'Shreyash Nikumbha','A+','8756745623','2026-04-01'),(2,'Bhavesh Badgujar','B+','7020712960','2026-04-01'),(3,'Pranav Londhe','A+','9960352554','2026-04-02'),(4,'Vishal Behera','A+','7888253522','2026-04-06');
/*!40000 ALTER TABLE `blood_donors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blood_inventory`
--

DROP TABLE IF EXISTS `blood_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blood_inventory` (
  `id` int NOT NULL AUTO_INCREMENT,
  `blood_group` varchar(5) NOT NULL,
  `bags_available` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `blood_group` (`blood_group`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blood_inventory`
--

LOCK TABLES `blood_inventory` WRITE;
/*!40000 ALTER TABLE `blood_inventory` DISABLE KEYS */;
INSERT INTO `blood_inventory` VALUES (1,'A+',16),(2,'A-',3),(3,'B+',11),(4,'B-',2),(5,'O+',20),(6,'O-',1),(7,'AB+',8),(8,'AB-',1);
/*!40000 ALTER TABLE `blood_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicines`
--

DROP TABLE IF EXISTS `medicines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medicines` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock_quantity` int DEFAULT NULL,
  `expiry_date` datetime DEFAULT NULL,
  `category` varchar(45) DEFAULT NULL,
  `supplier` varchar(45) DEFAULT NULL,
  `item_type` varchar(50) DEFAULT 'Medicine',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicines`
--

LOCK TABLES `medicines` WRITE;
/*!40000 ALTER TABLE `medicines` DISABLE KEYS */;
INSERT INTO `medicines` VALUES (1,'Paracetamol 500mg',15.50,120,'2027-10-15 00:00:00','Analgesic','PharmaCorp India','Medicine'),(2,'Amoxicillin 250mg',45.00,6,'2028-01-20 00:00:00','Antibiotic','HealthMeds Inc','Medicine'),(3,'Cough Syrup (Adulsa)',85.00,45,'2026-04-15 00:00:00','Syrup','Wellness Co','Medicine'),(4,'Ibuprofen 400mg',22.00,200,'2026-11-30 00:00:00','Painkiller','MedLife Supplies','Medicine'),(5,'Vitamin C Tablets',30.00,85,'2027-05-10 00:00:00','Supplement','Wellness Co','Medicine'),(6,'Azithromycin 500mg',110.00,3,'2025-12-01 00:00:00','Antibiotic','PharmaCorp India','Medicine'),(7,'Cetirizine 10mg',12.00,300,'2028-06-15 00:00:00','Antihistamine','HealthMeds Inc','Medicine'),(8,'Omeprazole 20mg',35.00,50,'2026-09-01 00:00:00','Antacid','DigestWell Labs','Medicine'),(9,'Insulin Syringes',5.00,8,'2029-01-01 00:00:00','Medical Supply','Medical Supply','Medicine'),(10,'Dolo 650',32.00,150,'2026-04-20 00:00:00','Analgesic','PharmaCorp India','Medicine');
/*!40000 ALTER TABLE `medicines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales` (
  `sale_id` int NOT NULL AUTO_INCREMENT,
  `sale_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `customer_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`sale_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_item`
--

DROP TABLE IF EXISTS `sales_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sale_id` int DEFAULT NULL,
  `medicine_id` int DEFAULT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sales_item_medicines_idx` (`medicine_id`),
  KEY `fk_sales_item_sales_idx` (`sale_id`),
  CONSTRAINT `fk_sales_item_medicines` FOREIGN KEY (`medicine_id`) REFERENCES `medicines` (`id`),
  CONSTRAINT `fk_sales_item_sales` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`sale_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_item`
--

LOCK TABLES `sales_item` WRITE;
/*!40000 ALTER TABLE `sales_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suppliers` (
  `supplier_id` int NOT NULL AUTO_INCREMENT,
  `supplier_name` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suppliers`
--

LOCK TABLES `suppliers` WRITE;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `phone_number` varchar(15) NOT NULL,
  `role` varchar(50) DEFAULT 'Pharmacist',
  `name` varchar(100) DEFAULT NULL,
  `age` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone_number` (`phone_number`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'7020712960','Admin','Bhavesh Badgujar',19);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_daiy_sales_report`
--

DROP TABLE IF EXISTS `vw_daiy_sales_report`;
/*!50001 DROP VIEW IF EXISTS `vw_daiy_sales_report`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_daiy_sales_report` AS SELECT 
 1 AS `invoice_id`,
 1 AS `sale_date`,
 1 AS `customer_name`,
 1 AS `medicine_name`,
 1 AS `quantity`,
 1 AS `unit_price`,
 1 AS `subtotal`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_expaired_items`
--

DROP TABLE IF EXISTS `vw_expaired_items`;
/*!50001 DROP VIEW IF EXISTS `vw_expaired_items`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_expaired_items` AS SELECT 
 1 AS `name`,
 1 AS `expiry_date`,
 1 AS `stock_quantity`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_inventory_details`
--

DROP TABLE IF EXISTS `vw_inventory_details`;
/*!50001 DROP VIEW IF EXISTS `vw_inventory_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_inventory_details` AS SELECT 
 1 AS `med_id`,
 1 AS `medicine_name`,
 1 AS `category`,
 1 AS `price`,
 1 AS `stock_quantity`,
 1 AS `expiry_date`,
 1 AS `supplier_name`,
 1 AS `supplier_contact`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_low_stock_alerts`
--

DROP TABLE IF EXISTS `vw_low_stock_alerts`;
/*!50001 DROP VIEW IF EXISTS `vw_low_stock_alerts`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_low_stock_alerts` AS SELECT 
 1 AS `name`,
 1 AS `stock_quantity`,
 1 AS `price`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_daiy_sales_report`
--

/*!50001 DROP VIEW IF EXISTS `vw_daiy_sales_report`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_daiy_sales_report` AS select `s`.`sale_id` AS `invoice_id`,`s`.`sale_date` AS `sale_date`,`s`.`customer_name` AS `customer_name`,`m`.`name` AS `medicine_name`,`si`.`quantity` AS `quantity`,`si`.`unit_price` AS `unit_price`,(`si`.`quantity` * `si`.`unit_price`) AS `subtotal` from ((`sales` `s` join `sales_item` `si` on((`s`.`sale_id` = `si`.`sale_id`))) join `medicines` `m` on((`si`.`medicine_id` = `m`.`id`))) order by `s`.`sale_date` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_expaired_items`
--

/*!50001 DROP VIEW IF EXISTS `vw_expaired_items`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_expaired_items` AS select `medicines`.`name` AS `name`,`medicines`.`expiry_date` AS `expiry_date`,`medicines`.`stock_quantity` AS `stock_quantity` from `medicines` where ((`medicines`.`expiry_date` <= curdate()) or (`medicines`.`expiry_date` <= (curdate() + interval 30 day))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_inventory_details`
--

/*!50001 DROP VIEW IF EXISTS `vw_inventory_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_inventory_details` AS select `m`.`id` AS `med_id`,`m`.`name` AS `medicine_name`,`m`.`category` AS `category`,`m`.`price` AS `price`,`m`.`stock_quantity` AS `stock_quantity`,`m`.`expiry_date` AS `expiry_date`,`s`.`supplier_name` AS `supplier_name`,`s`.`phone` AS `supplier_contact` from (`medicines` `m` left join `suppliers` `s` on((`m`.`supplier` = `s`.`supplier_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_low_stock_alerts`
--

/*!50001 DROP VIEW IF EXISTS `vw_low_stock_alerts`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_low_stock_alerts` AS select `medicines`.`name` AS `name`,`medicines`.`stock_quantity` AS `stock_quantity`,`medicines`.`price` AS `price` from `medicines` where (`medicines`.`stock_quantity` < 10) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-10 14:26:48
