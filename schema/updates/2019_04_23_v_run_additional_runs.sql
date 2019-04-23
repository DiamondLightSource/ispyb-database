-- This script contains Diamond test data only.
-- Do not run this on a production database as
-- other synchrotrons/facilities will have their own
-- run schedule.


/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;

LOCK TABLES `v_run` WRITE;
/*!40000 ALTER TABLE `v_run` DISABLE KEYS */;
INSERT INTO `v_run` VALUES (62,'2018-03','2018-05-24 09:00:00','2018-08-10 08:59:59'),(63,'2018-04','2018-08-10 09:00:00','2018-10-26 08:59:59'),(64,'2018-05','2018-10-26 09:00:00','2018-12-18 08:59:59'),(65,'2019-01','2018-12-18 09:00:00','2019-03-08 08:59:59'),(66,'2019-02','2019-03-08 09:00:00','2019-05-23 08:59:59'),(67,'2019-03','2019-05-23 09:00:00','2019-08-09 08:59:59');
/*!40000 ALTER TABLE `v_run` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
