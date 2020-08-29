-- MariaDB dump 10.17  Distrib 10.5.5-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: ispyb_build
-- ------------------------------------------------------
-- Server version	10.5.5-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `AdminVar`
--

/*!40000 ALTER TABLE `AdminVar` DISABLE KEYS */;
INSERT INTO `AdminVar` (`varId`, `name`, `value`) VALUES (4,'schemaVersion','1.13.1');
/*!40000 ALTER TABLE `AdminVar` ENABLE KEYS */;

--
-- Dumping data for table `SchemaStatus`
--

/*!40000 ALTER TABLE `SchemaStatus` DISABLE KEYS */;
INSERT INTO `SchemaStatus` (`schemaStatusId`, `scriptName`, `schemaStatus`, `recordTimeStamp`) VALUES (6,'20180213_BLSample_subLocation.sql','DONE','2018-02-13 13:27:19'),(12,'20180213_DataCollectionFileAttachment_fileType.sql','DONE','2018-02-13 15:12:54'),(16,'20180303_v_run_to_table.sql','DONE','2018-07-25 15:11:18'),(19,'20180328_ImageQualityIndicators_alter_table.sql','DONE','2018-07-25 15:11:18'),(22,'20180410_BeamLineSetup_alter.sql','DONE','2018-07-25 15:11:18'),(25,'20180413_BeamLineSetup_and_Detector_alter.sql','DONE','2018-07-25 15:11:18'),(28,'20180501_DataCollectionGroup_experimentType_enum.sql','DONE','2018-07-25 15:11:18'),(31,'20180531_ScreeningOutput_alignmentSuccess.sql','DONE','2018-07-25 15:11:18'),(34,'20180629_DataCollection_imageContainerSubPath.sql','DONE','2018-07-25 15:11:18'),(35,'20180913_BeamCalendar.sql','DONE','2018-09-19 09:52:45'),(36,'2018_09_19_DataCollection_imageDirectory_comment.sql','DONE','2018-09-19 12:38:01'),(37,'2018_09_27_increase_schema_version.sql','DONE','2018-09-27 13:17:15'),(38,'2018_11_01_XrayCenteringResult.sql','DONE','2018-11-01 13:36:53'),(39,'2018_11_01_AutoProcProgram_dataCollectionId.sql','DONE','2018-11-01 15:10:38'),(40,'2018_11_01_AutoProcProgramMessage.sql','DONE','2018-11-01 15:28:17'),(44,'2018_11_01_DiffractionPlan_centeringMethod.sql','DONE','2018-11-01 22:51:36'),(45,'2018_11_02_DataCollectionGroup_experimentType_enum.sql','DONE','2018-11-02 11:54:15'),(47,'2018_11_05_spelling_of_centring.sql','DONE','2018-11-05 15:31:38'),(48,'2018_11_09_AutoProcProgram_update_processing_program.sql','DONE','2018-11-09 16:38:34'),(49,'2018_11_14_AutoProcProgramMessage_autoinc.sql','DONE','2018-11-14 10:15:27'),(50,'2018_11_22_AutoProcProgram_processingStatus_update.sql','DONE','2018-11-22 16:11:15'),(51,'2018_12_04_EnergyScan_and_XFEFluorescenceSpectrum_add_axisPosition.sql','DONE','2018-12-04 14:13:23'),(52,'2018_12_20_DataCollectionGroup_scanParameters.sql','DONE','2018-12-20 17:30:04'),(53,'2019_01_14_Proposal_state.sql','DONE','2019-01-14 12:13:31'),(54,'2019_01_14_ProcessingJobParameter_parameterValue.sql','DONE','2019-01-14 14:00:02'),(57,'2019_01_15_Detector_localName.sql','DONE','2019-01-15 23:01:15'),(58,'2019_02_04_BLSession_unique_index.sql','DONE','2019-02-04 13:52:19'),(59,'2019_03_29_BLSession_archived.sql','DONE','2019-04-03 14:43:08'),(60,'2019_04_03_UserGroup_and_Permission.sql','DONE','2019-04-03 14:51:04'),(61,'2019_04_07_AdminVar_bump_version.sql','DONE','2019-04-07 11:35:06'),(62,'2019_04_08_AdminVar_bump_version.sql','DONE','2019-04-08 15:38:01'),(63,'2019_04_23_AdminVar_bump_version.sql','DONE','2019-04-23 11:13:27'),(64,'2019_04_23_drop_v_run_view.sql','DONE','2019-04-23 11:13:35'),(67,'2019_04_23_v_run_additional_runs.sql','DONE','2019-04-23 12:39:47'),(68,'2019_05_28_AdminVar_bump_version.sql','DONE','2019-05-28 13:29:27'),(72,'2019_07_17_BLSample_crystalId_default.sql','DONE','2019-07-17 15:21:59'),(73,'2019_08_15_Sleeve.sql','DONE','2019-08-15 08:34:34'),(74,'2019_08_15_AdminVar_bump_version.sql','DONE','2019-08-15 08:57:37'),(75,'2019_08_28_AdminVar_bump_version.sql','DONE','2019-08-28 13:30:13'),(76,'2019_08_30_AdminVar_bump_version.sql','DONE','2019-08-30 11:58:16'),(77,'2019_10_06_BLSampleImage_fk3.sql','DONE','2019-10-06 16:55:44'),(78,'2019_10_08_DiffractionPlan_experimentKind.sql','DONE','2019-10-08 12:47:10'),(79,'2019_11_07_AutoProcProgramAttachment_importanceRank.sql','DONE','2019-11-07 16:35:25'),(80,'2019_11_07_AdminVar_bump_version.sql','DONE','2019-11-07 16:45:44'),(81,'2019_11_08_AdminVar_bump_version.sql','DONE','2019-11-08 16:09:52'),(82,'2019_11_26_v_run_idx1.sql','DONE','2019-11-26 15:00:21'),(83,'2019_12_02_AdminVar_bump_version.sql','DONE','2019-12-02 11:29:05'),(84,'2019_12_02_AdminVar_bump_version_v2.sql','DONE','2019-12-02 18:14:11'),(85,'2020_01_03_BLSampleImage_tables.sql','DONE','2020-01-03 16:05:45'),(86,'2020_01_06_AdminVar_bump_version.sql','DONE','2020-01-06 11:45:02'),(87,'2020_01_07_AdminVar_bump_version.sql','DONE','2020-01-07 09:45:25'),(88,'2020_01_07_AdminVar_bump_version_v2.sql','DONE','2020-01-07 10:24:54'),(89,'2020_01_07_AdminVar_bump_version_v3.sql','DONE','2020-01-07 11:16:09'),(90,'2020_01_20_AdminVar_bump_version.sql','DONE','2020-01-20 13:40:52'),(91,'2020_01_20_AdminVar_bump_version_v2.sql','DONE','2020-01-20 16:27:37'),(92,'2020_02_13_SpaceGroup_data.sql','DONE','2020-02-13 16:52:53'),(93,'2020_01_21_DiffractionPlan_experimentKind.sql','DONE','2020-02-13 17:13:17'),(94,'2020_02_21_ProposalHasPerson_role_enum.sql','DONE','2020-02-21 14:36:10'),(95,'2020_02_21_Session_has_Person_role_enum.sql','DONE','2020-02-21 14:36:17'),(96,'2020_02_27_Container_scLocationUpdated.sql','DONE','2020-02-27 13:43:51'),(97,'2020_03_09_Reprocessing_drop_tables.sql','DONE','2020-03-09 11:05:09'),(98,'2020_03_24_ProcessingPipeline_tables.sql','DONE','2020-03-26 16:37:29'),(99,'2020_03_25_ProcessingPipeline_ren_col.sql','DONE','2020-03-26 16:37:34'),(100,'2020_03_27_AdminVar_bump_version.sql','DONE','2020-03-27 08:51:52'),(101,'2020_03_27_AdminVar_bump_version_v2.sql','DONE','2020-03-27 15:07:56'),(102,'2020_04_06_alterProtein.sql','DONE','2020-04-06 13:40:18'),(103,'2020_04_27_BLSampleImageAutoScoreSchema_insert_CHIMP.sql','DONE','2020-04-27 14:37:41'),(104,'2020_05_21_BLSampleImageAutoScoreClass_insert_CHIMP.sql','DONE','2020-05-21 17:52:54'),(105,'2020_06_01_DewarRegistry_and_DewarRegistry_has_Proposal.sql','DONE','2020-06-01 10:29:19'),(106,'2020_06_01_Protein_new_columns.sql','DONE','2020-06-01 10:29:32'),(107,'2020_06_01_AdminVar_bump_version.sql','DONE','2020-06-01 10:46:11'),(108,'2020_06_08_Shipping_comments.sql','DONE','2020-06-08 16:44:26'),(109,'2020_06_10_DiffractionPlan_experimentKind.sql','DONE','2020-06-10 14:35:18'),(110,'2020_06_15_Shipping_comments.sql','DONE','2020-06-15 14:01:25'),(111,'2020_06_24_BLSampleGroup_name.sql','DONE','2020-06-24 10:56:25'),(112,'2020_06_24_DiffractionPlan_userPath.sql','DONE','2020-06-24 10:56:30'),(113,'2020_07_01_DewarRegistry_and_DewarRegistry_has_Proposal.sql','DONE','2020-07-01 13:51:49'),(114,'2020_07_06_DewarRegistry_to_DewarRegistry_has_Proposal_data.sql','DONE','2020-07-06 10:59:22'),(115,'2020_07_13_AdminVar_bump_version.sql','DONE','2020-07-13 18:14:39'),(116,'2020_08_03_AdminVar_bump_version.sql','DONE','2020-08-03 15:19:36'),(117,'2020_08_28_ComponentSubType_changes.sql','DONE','2020-08-28 16:48:43'),(118,'2020_08_28_ConcentrationType_changes.sql','DONE','2020-08-28 16:48:49'),(119,'2020_08_28_Dewar_type.sql','DONE','2020-08-28 16:52:34'),(120,'2020_08_28_DiffractionPlan_new_temperature_cols.sql','DONE','2020-08-28 16:52:46'),(121,'2020_08_28_PurificationColumn.sql','DONE','2020-08-28 16:52:56'),(122,'2020_08_29_BLSampleGroupType.sql','DONE','2020-08-29 15:05:45'),(123,'2020_08_29_Protein_isotropy.sql','DONE','2020-08-29 15:05:49');
/*!40000 ALTER TABLE `SchemaStatus` ENABLE KEYS */;

--
-- Dumping data for table `ComponentType`
--

/*!40000 ALTER TABLE `ComponentType` DISABLE KEYS */;
INSERT INTO `ComponentType` (`componentTypeId`, `name`) VALUES (1,'Protein'),(2,'DNA'),(3,'Small Molecule'),(4,'RNA');
/*!40000 ALTER TABLE `ComponentType` ENABLE KEYS */;

--
-- Dumping data for table `ComponentSubType`
--

/*!40000 ALTER TABLE `ComponentSubType` DISABLE KEYS */;
INSERT INTO `ComponentSubType` (`componentSubTypeId`, `name`, `hasPh`, `proposalType`, `active`) VALUES (1,'Buffer',1,NULL,1),(2,'Precipitant',0,NULL,1),(3,'Salt',0,NULL,1),(4,'Cell',0,'scm',1),(5,'Matrix',0,'scm',1),(6,'Powder',0,'scm',1),(7,'Solution',1,'scm',1),(8,'Powder',0,'cy',1);
/*!40000 ALTER TABLE `ComponentSubType` ENABLE KEYS */;

--
-- Dumping data for table `ConcentrationType`
--

/*!40000 ALTER TABLE `ConcentrationType` DISABLE KEYS */;
INSERT INTO `ConcentrationType` (`concentrationTypeId`, `name`, `symbol`, `proposalType`, `active`) VALUES (1,'Molar','M',NULL,1),(2,'Percentage Weight / Volume','%(w/v)',NULL,1),(3,'Percentage Volume / Volume','%(v/v)',NULL,1),(4,'Milligrams / Millilitre','mg/ml',NULL,1),(5,'Grams','g',NULL,1),(6,'Microlitre','uL','scm',1),(7,'Millilitre','ml','scm',1);
/*!40000 ALTER TABLE `ConcentrationType` ENABLE KEYS */;

--
-- Dumping data for table `InspectionType`
--

/*!40000 ALTER TABLE `InspectionType` DISABLE KEYS */;
INSERT INTO `InspectionType` (`inspectionTypeId`, `name`) VALUES (1,'Visible'),(2,'UV');
/*!40000 ALTER TABLE `InspectionType` ENABLE KEYS */;

--
-- Dumping data for table `PlateType`
--

/*!40000 ALTER TABLE `PlateType` DISABLE KEYS */;
/*!40000 ALTER TABLE `PlateType` ENABLE KEYS */;

--
-- Dumping data for table `SessionType`
--

/*!40000 ALTER TABLE `SessionType` DISABLE KEYS */;
/*!40000 ALTER TABLE `SessionType` ENABLE KEYS */;

--
-- Dumping data for table `WorkflowType`
--

/*!40000 ALTER TABLE `WorkflowType` DISABLE KEYS */;
/*!40000 ALTER TABLE `WorkflowType` ENABLE KEYS */;

--
-- Dumping data for table `Schedule`
--

/*!40000 ALTER TABLE `Schedule` DISABLE KEYS */;
INSERT INTO `Schedule` (`scheduleId`, `name`) VALUES (1,'Daily - 1 week'),(2,'Schedule 2'),(11,'Fibonacci'),(15,'3 Hour Interval');
/*!40000 ALTER TABLE `Schedule` ENABLE KEYS */;

--
-- Dumping data for table `Imager`
--

/*!40000 ALTER TABLE `Imager` DISABLE KEYS */;
INSERT INTO `Imager` (`imagerId`, `name`, `temperature`, `serial`, `capacity`) VALUES (2,'Imager1 20c',20,'Z125434',1000),(7,'VMXi sim',20,'RI1000-0000',750);
/*!40000 ALTER TABLE `Imager` ENABLE KEYS */;

--
-- Dumping data for table `Detector`
--

/*!40000 ALTER TABLE `Detector` DISABLE KEYS */;
INSERT INTO `Detector` (`detectorId`, `detectorType`, `detectorManufacturer`, `detectorModel`, `detectorPixelSizeHorizontal`, `detectorPixelSizeVertical`, `DETECTORMAXRESOLUTION`, `DETECTORMINRESOLUTION`, `detectorSerialNumber`, `detectorDistanceMin`, `detectorDistanceMax`, `trustedPixelValueRangeLower`, `trustedPixelValueRangeUpper`, `sensorThickness`, `overload`, `XGeoCorr`, `YGeoCorr`, `detectorMode`, `density`, `composition`, `numberOfPixelsX`, `numberOfPixelsY`, `detectorRollMin`, `detectorRollMax`, `localName`) VALUES (4,'Photon counting','In-house','Excalibur',NULL,NULL,NULL,NULL,'1109-434',100,300,NULL,NULL,NULL,NULL,NULL,NULL,NULL,55,'CrO3Br5Sr10',NULL,NULL,NULL,NULL,NULL),(8,'Diamond XPDF detector',NULL,NULL,NULL,NULL,NULL,NULL,'1109-761',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,10.4,'C+Br+He',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `Detector` ENABLE KEYS */;

--
-- Dumping data for table `DewarLocationList`
--

/*!40000 ALTER TABLE `DewarLocationList` DISABLE KEYS */;
/*!40000 ALTER TABLE `DewarLocationList` ENABLE KEYS */;

--
-- Dumping data for table `BeamLineSetup`
--

/*!40000 ALTER TABLE `BeamLineSetup` DISABLE KEYS */;
INSERT INTO `BeamLineSetup` (`beamLineSetupId`, `detectorId`, `synchrotronMode`, `undulatorType1`, `undulatorType2`, `undulatorType3`, `focalSpotSizeAtSample`, `focusingOptic`, `beamDivergenceHorizontal`, `beamDivergenceVertical`, `polarisation`, `monochromatorType`, `setupDate`, `synchrotronName`, `maxExpTimePerDataCollection`, `maxExposureTimePerImage`, `minExposureTimePerImage`, `goniostatMaxOscillationSpeed`, `goniostatMaxOscillationWidth`, `goniostatMinOscillationWidth`, `maxTransmission`, `minTransmission`, `recordTimeStamp`, `CS`, `beamlineName`, `beamSizeXMin`, `beamSizeXMax`, `beamSizeYMin`, `beamSizeYMax`, `energyMin`, `energyMax`, `omegaMin`, `omegaMax`, `kappaMin`, `kappaMax`, `phiMin`, `phiMax`, `active`, `numberOfImagesMax`, `numberOfImagesMin`, `boxSizeXMin`, `boxSizeXMax`, `boxSizeYMin`, `boxSizeYMax`, `monoBandwidthMin`, `monoBandwidthMax`) VALUES (1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2007-04-26 00:00:00','Diamond Light Source',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2016-03-19 22:56:25',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `BeamLineSetup` ENABLE KEYS */;

--
-- Dumping data for table `BF_component`
--

/*!40000 ALTER TABLE `BF_component` DISABLE KEYS */;
/*!40000 ALTER TABLE `BF_component` ENABLE KEYS */;

--
-- Dumping data for table `BF_subcomponent`
--

/*!40000 ALTER TABLE `BF_subcomponent` DISABLE KEYS */;
/*!40000 ALTER TABLE `BF_subcomponent` ENABLE KEYS */;

--
-- Dumping data for table `BF_system`
--

/*!40000 ALTER TABLE `BF_system` DISABLE KEYS */;
/*!40000 ALTER TABLE `BF_system` ENABLE KEYS */;

--
-- Dumping data for table `Permission`
--

/*!40000 ALTER TABLE `Permission` DISABLE KEYS */;
INSERT INTO `Permission` (`permissionId`, `type`, `description`) VALUES (1,'mx_admin','MX Administrator'),(2,'manage_groups','Manage User Groups'),(4,'manage_perms','Manage User Group Permissions'),(5,'global_stats','View Global Statistics'),(6,'fault_view','View Fault Reports'),(7,'saxs_admin','SAXS Administrator'),(8,'em_admin','EM Administrator'),(9,'gen_admin','Powder Admin'),(10,'tomo_admin','Tomo Admin'),(11,'super_admin','Site Admin'),(12,'fault_global','Globally edit all faults'),(13,'schedules','Manage Imaging Schedules'),(15,'schedule_comps','Manage Imaging Schedule Components'),(16,'imaging_dash','Imaging Dashboard'),(17,'vmxi_queue','VMXi Data Collection Queue'),(18,'sm_admin','Small Molecule Admin'),(20,'pow_admin','Power Admin'),(23,'all_dewars','View All Dewars'),(26,'all_prop_stats','View All Proposal Stats'),(29,'all_breakdown','View Aggregated Visit Breakdown Stats'),(32,'disp_cont','VMXi Dispose Container'),(37,'view_manifest','View Shipping Manifest'),(43,'schedule_comp','typo fill in'),(49,'xpdf_admin','XPDF Admin'),(55,'edit_presets','Edit Beamline DC Presets'),(58,'manage_params','Edit Beamline Parameter Limits'),(64,'manage_detector','Manage Beamline Detector Limits'),(69,'auto_dash','AutoCollect Dashboard'),(77,'fault_admin','Edit Fault Categories'),(80,'fault_add','Add New Fault Reports');
/*!40000 ALTER TABLE `Permission` ENABLE KEYS */;

--
-- Dumping data for table `BLSampleImageAutoScoreSchema`
--

/*!40000 ALTER TABLE `BLSampleImageAutoScoreSchema` DISABLE KEYS */;
INSERT INTO `BLSampleImageAutoScoreSchema` (`blSampleImageAutoScoreSchemaId`, `schemaName`, `enabled`) VALUES (1,'MARCO',1),(2,'CHIMP',1);
/*!40000 ALTER TABLE `BLSampleImageAutoScoreSchema` ENABLE KEYS */;

--
-- Dumping data for table `BLSampleImageAutoScoreClass`
--

/*!40000 ALTER TABLE `BLSampleImageAutoScoreClass` DISABLE KEYS */;
INSERT INTO `BLSampleImageAutoScoreClass` (`blSampleImageAutoScoreClassId`, `blSampleImageAutoScoreSchemaId`, `scoreClass`) VALUES (1,1,'clear'),(2,1,'crystal'),(3,1,'precipitant'),(4,1,'other'),(5,2,'clear'),(6,2,'crystal'),(7,2,'precipitant'),(8,2,'other');
/*!40000 ALTER TABLE `BLSampleImageAutoScoreClass` ENABLE KEYS */;

--
-- Dumping data for table `SpaceGroup`
--

/*!40000 ALTER TABLE `SpaceGroup` DISABLE KEYS */;
INSERT INTO `SpaceGroup` (`spaceGroupId`, `spaceGroupNumber`, `spaceGroupShortName`, `spaceGroupName`, `bravaisLattice`, `bravaisLatticeName`, `pointGroup`, `geometryClassnameId`, `MX_used`) VALUES (1,1,'P1','P 1','aP',NULL,NULL,NULL,0),(2,10,'P12/m1','P 12/m 1',NULL,NULL,NULL,NULL,0),(3,100,'P4bm','P4 b m',NULL,NULL,NULL,NULL,0),(4,101,'P42cm','P42 c m',NULL,NULL,NULL,NULL,0),(5,102,'P42nm','P42 n m',NULL,NULL,NULL,NULL,0),(6,103,'P4cc','P4 c c',NULL,NULL,NULL,NULL,0),(7,104,'P4nc','P4 n c',NULL,NULL,NULL,NULL,0),(8,105,'P42mc','P42 m c',NULL,NULL,NULL,NULL,0),(9,106,'P42bc','P42 b c',NULL,NULL,NULL,NULL,0),(10,107,'I4mm','I4 m m',NULL,NULL,NULL,NULL,0),(11,108,'I4cm','I4 c m',NULL,NULL,NULL,NULL,0),(12,109,'I41md','I41 m d',NULL,NULL,NULL,NULL,0),(13,11,'P121/m1','P 121/m 1',NULL,NULL,NULL,NULL,0),(14,110,'I41cd','I41 c d',NULL,NULL,NULL,NULL,0),(15,111,'P-42m','P-4 2 m',NULL,NULL,NULL,NULL,0),(16,112,'P-42c','P-4 2 c',NULL,NULL,NULL,NULL,0),(17,113,'P-421m','P-4 21 m',NULL,NULL,NULL,NULL,0),(18,114,'P-421c','P-4 21 c',NULL,NULL,NULL,NULL,0),(19,115,'P-4m2','P-4 m 2',NULL,NULL,NULL,NULL,0),(20,116,'P-4c2','P-4 c 2',NULL,NULL,NULL,NULL,0),(21,117,'P-4b2','P-4 b 2',NULL,NULL,NULL,NULL,0),(22,118,'P-4n2','P-4 n 2',NULL,NULL,NULL,NULL,0),(23,119,'I-4m2','I-4 m 2',NULL,NULL,NULL,NULL,0),(24,12,'C12/m1','C 12/m 1',NULL,NULL,NULL,NULL,0),(25,120,'I-4c2','I-4 c 2',NULL,NULL,NULL,NULL,0),(26,121,'I-42m','I-4 2 m',NULL,NULL,NULL,NULL,0),(27,122,'I-42d','I-4 2 d',NULL,NULL,NULL,NULL,0),(28,123,'P4/mmm','P4/m m m',NULL,NULL,NULL,NULL,0),(29,124,'P4/mcc','P4/m c c',NULL,NULL,NULL,NULL,0),(30,125,'P4/nbm','P4/n b m',NULL,NULL,NULL,NULL,0),(31,126,'P4/nnc','P4/n n c',NULL,NULL,NULL,NULL,0),(32,127,'P4/mbm1','P4/m b m1',NULL,NULL,NULL,NULL,0),(33,128,'P4/mnc1','P4/m n c1',NULL,NULL,NULL,NULL,0),(34,129,'P4/nmm1','P4/n m m1',NULL,NULL,NULL,NULL,0),(35,13,'P12/c1','P 12/c 1',NULL,NULL,NULL,NULL,0),(36,130,'P4/ncc1','P4/n c c1',NULL,NULL,NULL,NULL,0),(37,131,'P42/mmc','P42/m m c',NULL,NULL,NULL,NULL,0),(38,132,'P42/mcm','P42/m c m',NULL,NULL,NULL,NULL,0),(39,133,'P42/nbc','P42/n b c',NULL,NULL,NULL,NULL,0),(40,134,'P42/nnm','P42/n n m',NULL,NULL,NULL,NULL,0),(41,135,'P42/mbc','P42/m b c',NULL,NULL,NULL,NULL,0),(42,136,'P42/mnm','P42/m n m',NULL,NULL,NULL,NULL,0),(43,137,'P42/nmc','P42/n m c',NULL,NULL,NULL,NULL,0),(44,138,'P42/ncm','P42/n c m',NULL,NULL,NULL,NULL,0),(45,139,'I4/mmm','I4/m m m',NULL,NULL,NULL,NULL,0),(46,14,'P121/c1','P 121/c 1',NULL,NULL,NULL,NULL,0),(47,140,'I4/mcm','I4/m c m',NULL,NULL,NULL,NULL,0),(48,141,'I41/amd','I41/a m d',NULL,NULL,NULL,NULL,0),(49,142,'I41/acd','I41/a c d',NULL,NULL,NULL,NULL,0),(50,143,'P3','P3','hP',NULL,NULL,NULL,0),(51,144,'P31','P31','hP',NULL,NULL,NULL,0),(52,145,'P32','P32','hP',NULL,NULL,NULL,0),(53,146,'H3','H3','hR',NULL,NULL,NULL,0),(54,147,'P-3','P-3',NULL,NULL,NULL,NULL,0),(55,148,'H-3','H-3',NULL,NULL,NULL,NULL,0),(56,149,'P312','P3 1 2','hP',NULL,NULL,NULL,0),(57,15,'C12/c1','C 12/c 1',NULL,NULL,NULL,NULL,0),(58,150,'P321','P3 2 1','hP',NULL,NULL,NULL,0),(59,151,'P3112','P31 1 2','hP',NULL,NULL,NULL,0),(60,152,'P3121','P31 2 1','hP',NULL,NULL,NULL,0),(61,153,'P3212','P32 1 2','hP',NULL,NULL,NULL,0),(62,154,'P3221','P32 2 1','hP',NULL,NULL,NULL,0),(63,155,'H32','H3 2','hR',NULL,NULL,NULL,0),(64,156,'P3m1','P3 m 1',NULL,NULL,NULL,NULL,0),(65,157,'P31m','P3 1 m',NULL,NULL,NULL,NULL,0),(66,158,'P3c1','P3 c 1',NULL,NULL,NULL,NULL,0),(67,159,'P31c','P3 1 c',NULL,NULL,NULL,NULL,0),(68,16,'P222','P 22 2','oP',NULL,NULL,NULL,0),(69,160,'H3m','H3 m',NULL,NULL,NULL,NULL,0),(70,161,'H3c','H3 c',NULL,NULL,NULL,NULL,0),(71,162,'P-31m','P-3 1 m',NULL,NULL,NULL,NULL,0),(72,163,'P-31c','P-3 1 c',NULL,NULL,NULL,NULL,0),(73,164,'P-3m1','P-3 m 1',NULL,NULL,NULL,NULL,0),(74,165,'P-3c1','P-3 c 1',NULL,NULL,NULL,NULL,0),(75,166,'H-3m','H-3 m',NULL,NULL,NULL,NULL,0),(76,167,'H-3c','H-3 c',NULL,NULL,NULL,NULL,0),(77,168,'P6','P6','hP',NULL,NULL,NULL,0),(78,169,'P61','P61','hP',NULL,NULL,NULL,0),(79,17,'P2221','P 22 21','oP',NULL,NULL,NULL,0),(80,170,'P65','P65','hP',NULL,NULL,NULL,0),(81,171,'P62','P62','hP',NULL,NULL,NULL,0),(82,172,'P64','P64','hP',NULL,NULL,NULL,0),(83,173,'P63','P63','hP',NULL,NULL,NULL,0),(84,174,'P-6','P-6',NULL,NULL,NULL,NULL,0),(85,175,'P6/m','P6/m',NULL,NULL,NULL,NULL,0),(86,176,'P63/m','P63/m',NULL,NULL,NULL,NULL,0),(87,177,'P622','P6 2 2','hP',NULL,NULL,NULL,0),(88,178,'P6122','P61 2 2','hP',NULL,NULL,NULL,0),(89,179,'P6522','P65 2 2','hP',NULL,NULL,NULL,0),(90,18,'P21212','P21 21 2','oP',NULL,NULL,NULL,0),(91,180,'P6222','P62 2 2','hP',NULL,NULL,NULL,0),(92,181,'P6422','P64 2 2','hP',NULL,NULL,NULL,0),(93,182,'P6322','P63 2 2','hP',NULL,NULL,NULL,0),(94,183,'P6mm','P6 m m',NULL,NULL,NULL,NULL,0),(95,184,'P6cc','P6 c c',NULL,NULL,NULL,NULL,0),(96,185,'P63cm','P63 c m',NULL,NULL,NULL,NULL,0),(97,186,'P63mc','P63 m c',NULL,NULL,NULL,NULL,0),(98,187,'P-6m2','P-6 m 2',NULL,NULL,NULL,NULL,0),(99,188,'P-6c2','P-6 c 2',NULL,NULL,NULL,NULL,0),(100,189,'P-62m','P-6 2 m',NULL,NULL,NULL,NULL,0),(101,19,'P212121','P21 21 21','oP',NULL,NULL,NULL,0),(102,190,'P-62c','P-6 2 c',NULL,NULL,NULL,NULL,0),(103,191,'P6/mmm','P6/m m m',NULL,NULL,NULL,NULL,0),(104,192,'P6/mcc','P6/m c c',NULL,NULL,NULL,NULL,0),(105,193,'P63/mcm','P63/m c m',NULL,NULL,NULL,NULL,0),(106,194,'P\n63/mmc','P\n63/m m c',NULL,NULL,NULL,NULL,0),(107,195,'P23','P2 3','cP',NULL,NULL,NULL,0),(108,196,'F23','F2 3','cF',NULL,NULL,NULL,0),(109,197,'I23','I2 3','cI',NULL,NULL,NULL,0),(110,198,'P213','P21 3','cP',NULL,NULL,NULL,0),(111,199,'I213','I21 3','cI',NULL,NULL,NULL,0),(112,2,'P-1','P-1',NULL,NULL,NULL,NULL,0),(113,20,'C2221','C 22 21','oC',NULL,NULL,NULL,0),(114,200,'Pm-3','Pm -3',NULL,NULL,NULL,NULL,0),(115,201,'Pn-3','Pn -3',NULL,NULL,NULL,NULL,0),(116,202,'Fm-3','Fm -3',NULL,NULL,NULL,NULL,0),(117,203,'Fd-3','Fd -3',NULL,NULL,NULL,NULL,0),(118,204,'Im-3','Im -3',NULL,NULL,NULL,NULL,0),(119,205,'Pa-31','Pa -31',NULL,NULL,NULL,NULL,0),(120,206,'Ia-31','Ia -31',NULL,NULL,NULL,NULL,0),(121,207,'P432','P4 3 2','cP',NULL,NULL,NULL,0),(122,208,'P4232','P42 3 2','cP',NULL,NULL,NULL,0),(123,209,'F432','F4 3 2','cF',NULL,NULL,NULL,0),(124,21,'C222','C 22 2','oC',NULL,NULL,NULL,0),(125,210,'F4132','F41 3 2','cF',NULL,NULL,NULL,0),(126,211,'I432','I4 3 2','cI',NULL,NULL,NULL,0),(127,212,'P4332','P43 3 2','cP',NULL,NULL,NULL,0),(128,213,'P4132','P41 3 2','cP',NULL,NULL,NULL,0),(129,214,'I4132','I41 3 2','cI',NULL,NULL,NULL,0),(130,215,'P-43m','P-4 3 m',NULL,NULL,NULL,NULL,0),(131,216,'F-43m','F-4 3 m',NULL,NULL,NULL,NULL,0),(132,217,'I-43m','I-4 3 m',NULL,NULL,NULL,NULL,0),(133,218,'P-43n','P-4 3 n',NULL,NULL,NULL,NULL,0),(134,219,'F-43c','F-4 3 c',NULL,NULL,NULL,NULL,0),(135,22,'F222','F 22 2','oF',NULL,NULL,NULL,0),(136,220,'I-43d','I-4 3 d',NULL,NULL,NULL,NULL,0),(137,221,'Pm-3m','Pm -3 m',NULL,NULL,NULL,NULL,0),(138,222,'Pn-3n','Pn -3 n',NULL,NULL,NULL,NULL,0),(139,223,'Pm-3n1','Pm -3 n1',NULL,NULL,NULL,NULL,0),(140,224,'Pn-3m1','Pn -3 m1',NULL,NULL,NULL,NULL,0),(141,225,'Fm-3m','Fm -3 m',NULL,NULL,NULL,NULL,0),(142,226,'Fm-3c','Fm -3 c',NULL,NULL,NULL,NULL,0),(143,227,'Fd-3m1','Fd -3 m1',NULL,NULL,NULL,NULL,0),(144,228,'Fd-3c1','Fd -3 c1',NULL,NULL,NULL,NULL,0),(145,229,'Im-3m','Im -3 m',NULL,NULL,NULL,NULL,0),(146,23,'I222','I 22 2','oI',NULL,NULL,NULL,0),(147,230,'Ia-3d1','Ia -3 d1',NULL,NULL,NULL,NULL,0),(148,24,'I212121','I21 21 21','oI',NULL,NULL,NULL,0),(149,25,'Pmm2','P mm 2',NULL,NULL,NULL,NULL,0),(150,26,'Pmc21','P mc 21',NULL,NULL,NULL,NULL,0),(151,27,'Pcc2','P cc 2',NULL,NULL,NULL,NULL,0),(152,28,'Pma2','P ma 2',NULL,NULL,NULL,NULL,0),(153,29,'Pca21','P ca 21',NULL,NULL,NULL,NULL,0),(154,3,'P121','P 12 1','mP',NULL,NULL,NULL,0),(155,30,'Pnc2','P nc 2',NULL,NULL,NULL,NULL,0),(156,31,'Pmn21','P mn 21',NULL,NULL,NULL,NULL,0),(157,32,'Pba2','P ba 2',NULL,NULL,NULL,NULL,0),(158,33,'Pna21','P na 21',NULL,NULL,NULL,NULL,0),(159,34,'Pnn2','P nn 2',NULL,NULL,NULL,NULL,0),(160,35,'Cmm2','C mm 2',NULL,NULL,NULL,NULL,0),(161,36,'Cmc21','C mc 21',NULL,NULL,NULL,NULL,0),(162,37,'Ccc2','C cc 2',NULL,NULL,NULL,NULL,0),(163,38,'Amm2','A mm 2',NULL,NULL,NULL,NULL,0),(164,39,'Abm2','A bm 2',NULL,NULL,NULL,NULL,0),(165,4,'P1211','P 121 1','mP',NULL,NULL,NULL,0),(166,40,'Ama2','A ma 2',NULL,NULL,NULL,NULL,0),(167,41,'Aba2','A ba 2',NULL,NULL,NULL,NULL,0),(168,42,'Fmm2','F mm 2',NULL,NULL,NULL,NULL,0),(169,43,'Fdd2','F dd 2',NULL,NULL,NULL,NULL,0),(170,44,'Imm2','I mm 2',NULL,NULL,NULL,NULL,0),(171,45,'Iba2','I ba 2',NULL,NULL,NULL,NULL,0),(172,46,'Ima2','I ma 2',NULL,NULL,NULL,NULL,0),(173,47,'Pmmm','P mm m',NULL,NULL,NULL,NULL,0),(174,48,'Pnnn','P nn n',NULL,NULL,NULL,NULL,0),(175,49,'Pccm','P cc m',NULL,NULL,NULL,NULL,0),(176,5,'C121','C 12 1','mC,mI',NULL,NULL,NULL,0),(177,50,'Pban','P ba n',NULL,NULL,NULL,NULL,0),(178,51,'Pmma1','P mm a1',NULL,NULL,NULL,NULL,0),(179,52,'Pnna1','P nn a1',NULL,NULL,NULL,NULL,0),(180,53,'Pmna1','P mn a1',NULL,NULL,NULL,NULL,0),(181,54,'Pcca1','P cc a1',NULL,NULL,NULL,NULL,0),(182,55,'Pbam1','P ba m1',NULL,NULL,NULL,NULL,0),(183,56,'Pccn1','P cc n1',NULL,NULL,NULL,NULL,0),(184,57,'Pbcm1','P bc m1',NULL,NULL,NULL,NULL,0),(185,58,'Pnnm1','P nn m1',NULL,NULL,NULL,NULL,0),(186,59,'Pmmn1','P mm n1',NULL,NULL,NULL,NULL,0),(187,6,'P1m1','P 1m 1',NULL,NULL,NULL,NULL,0),(188,60,'Pbcn1','P bc n1',NULL,NULL,NULL,NULL,0),(189,61,'Pbca1','P bc a1',NULL,NULL,NULL,NULL,0),(190,62,'Pnma1','P nm a1',NULL,NULL,NULL,NULL,0),(191,63,'Cmcm1','C mc m1',NULL,NULL,NULL,NULL,0),(192,64,'Cmca1','C mc a1',NULL,NULL,NULL,NULL,0),(193,65,'Cmmm','C mm m',NULL,NULL,NULL,NULL,0),(194,66,'Cccm','C cc m',NULL,NULL,NULL,NULL,0),(195,67,'Cmma','C mm a',NULL,NULL,NULL,NULL,0),(196,68,'Ccca','C cc a',NULL,NULL,NULL,NULL,0),(197,69,'Fmmm','F mm m',NULL,NULL,NULL,NULL,0),(198,7,'P1c1','P 1c 1',NULL,NULL,NULL,NULL,0),(199,70,'Fddd','F dd d',NULL,NULL,NULL,NULL,0),(200,71,'Immm','I mm m',NULL,NULL,NULL,NULL,0),(201,72,'Ibam','I ba m',NULL,NULL,NULL,NULL,0),(202,73,'Ibca1','I b c a1',NULL,NULL,NULL,NULL,0),(203,74,'Imma1','I mm a1',NULL,NULL,NULL,NULL,0),(204,75,'P4','P4','tP',NULL,NULL,NULL,0),(205,76,'P41','P41','tP',NULL,NULL,NULL,0),(206,77,'P42','P42','tP',NULL,NULL,NULL,0),(207,78,'P43','P43','tP',NULL,NULL,NULL,0),(208,79,'I4','I4','tI',NULL,NULL,NULL,0),(209,8,'C1m1','C 1m 1',NULL,NULL,NULL,NULL,0),(210,80,'I41','I41','tI',NULL,NULL,NULL,0),(211,81,'P-4','P-4',NULL,NULL,NULL,NULL,0),(212,82,'I-4','I-4',NULL,NULL,NULL,NULL,0),(213,83,'P4/m','P4/m',NULL,NULL,NULL,NULL,0),(214,84,'P42/m','P42/m',NULL,NULL,NULL,NULL,0),(215,85,'P4/n','P4/n',NULL,NULL,NULL,NULL,0),(216,86,'P42/n','P42/n',NULL,NULL,NULL,NULL,0),(217,87,'I4/m','I4/m',NULL,NULL,NULL,NULL,0),(218,88,'I41/a','I41/a',NULL,NULL,NULL,NULL,0),(219,89,'P422','P 42 2','tP',NULL,NULL,NULL,0),(220,9,'C1c1','C 1c 1',NULL,NULL,NULL,NULL,0),(221,90,'P4212','P 421 2','tP',NULL,NULL,NULL,0),(222,91,'P4122','P41 2 2','tP',NULL,NULL,NULL,0),(223,92,'P41212','P41 21 2','tP',NULL,NULL,NULL,0),(224,93,'P4222','P42 2 2','tP',NULL,NULL,NULL,0),(225,94,'P42212','P42 21 2','tP',NULL,NULL,NULL,0),(226,95,'P4322','P43 2 2','tP',NULL,NULL,NULL,0),(227,96,'P43212','P43 21 2','tP',NULL,NULL,NULL,0),(228,97,'I422','I 42 2','tI',NULL,NULL,NULL,0),(229,98,'I4122','I41 2 2','tI',NULL,NULL,NULL,0),(230,99,'P4mm','P 4m m',NULL,NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `SpaceGroup` ENABLE KEYS */;

--
-- Dumping data for table `ProcessingPipeline`
--

/*!40000 ALTER TABLE `ProcessingPipeline` DISABLE KEYS */;
INSERT INTO `ProcessingPipeline` (`processingPipelineId`, `processingPipelineCategoryId`, `name`, `discipline`, `pipelineStatus`, `reprocessing`) VALUES (1,1,'Mosflm','MX','automatic',0),(2,1,'EDNA','MX','automatic',0),(3,2,'Fast DP','MX','automatic',1),(4,2,'xia2/3dii','MX','deprecated',0),(5,2,'xia2/Multiplex','MX','automatic',1),(6,2,'xia2/DIALS','MX','optional',1),(7,2,'xia2/XDS','MX','optional',1),(8,2,'autoPROC','MX','optional',1),(9,3,'Fast EP','MX','automatic',0),(10,3,'Dimple','MX','automatic',0),(11,3,'MrBUMP','MX','automatic',0),(12,3,'Big EP/XDS','MX','automatic',0),(13,3,'Big EP/DIALS','MX','automatic',0);
/*!40000 ALTER TABLE `ProcessingPipeline` ENABLE KEYS */;

--
-- Dumping data for table `ProcessingPipelineCategory`
--

/*!40000 ALTER TABLE `ProcessingPipelineCategory` DISABLE KEYS */;
INSERT INTO `ProcessingPipelineCategory` (`processingPipelineCategoryId`, `name`) VALUES (1,'screening'),(2,'processing'),(3,'post processing');
/*!40000 ALTER TABLE `ProcessingPipelineCategory` ENABLE KEYS */;

--
-- Dumping data for table `PurificationColumn`
--

/*!40000 ALTER TABLE `PurificationColumn` DISABLE KEYS */;
INSERT INTO `PurificationColumn` (`purificationColumnId`, `name`, `active`) VALUES (1,'user supplied',1),(2,'s75',1),(3,'s200',1),(4,'superose6',1),(5,'kw402.5',1),(6,'kw403',1),(7,'kw404',1),(8,'kw405',1);
/*!40000 ALTER TABLE `PurificationColumn` ENABLE KEYS */;

--
-- Dumping data for table `BLSampleGroupType`
--

/*!40000 ALTER TABLE `BLSampleGroupType` DISABLE KEYS */;
INSERT INTO `BLSampleGroupType` (`blSampleGroupTypeId`, `name`, `proposalType`, `active`) VALUES (1,'background','xpdf',1),(2,'container','xpdf',1),(3,'sample','xpdf',1),(4,'calibrant','xpdf',1),(5,'buffer','scm',1),(6,'sample','scm',1),(7,'sample','mx',1);
/*!40000 ALTER TABLE `BLSampleGroupType` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-08-29 16:06:01
