-- MariaDB dump 10.19  Distrib 10.5.10-MariaDB, for Linux (x86_64)
--
-- Host: 10.88.0.5    Database: ispyb_build
-- ------------------------------------------------------
-- Server version	10.4.19-MariaDB-1:10.4.19+maria~bionic

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
INSERT INTO `AdminVar` (`varId`, `name`, `value`) VALUES (4,'schemaVersion','1.24.0');
/*!40000 ALTER TABLE `AdminVar` ENABLE KEYS */;

--
-- Dumping data for table `SchemaStatus`
--

/*!40000 ALTER TABLE `SchemaStatus` DISABLE KEYS */;
INSERT INTO `SchemaStatus` (`schemaStatusId`, `scriptName`, `schemaStatus`, `recordTimeStamp`) VALUES (6,'20180213_BLSample_subLocation.sql','DONE','2018-02-13 13:27:19'),(12,'20180213_DataCollectionFileAttachment_fileType.sql','DONE','2018-02-13 15:12:54'),(16,'20180303_v_run_to_table.sql','DONE','2018-07-25 15:11:18'),(19,'20180328_ImageQualityIndicators_alter_table.sql','DONE','2018-07-25 15:11:18'),(22,'20180410_BeamLineSetup_alter.sql','DONE','2018-07-25 15:11:18'),(25,'20180413_BeamLineSetup_and_Detector_alter.sql','DONE','2018-07-25 15:11:18'),(28,'20180501_DataCollectionGroup_experimentType_enum.sql','DONE','2018-07-25 15:11:18'),(31,'20180531_ScreeningOutput_alignmentSuccess.sql','DONE','2018-07-25 15:11:18'),(34,'20180629_DataCollection_imageContainerSubPath.sql','DONE','2018-07-25 15:11:18'),(35,'20180913_BeamCalendar.sql','DONE','2018-09-19 09:52:45'),(36,'2018_09_19_DataCollection_imageDirectory_comment.sql','DONE','2018-09-19 12:38:01'),(37,'2018_09_27_increase_schema_version.sql','DONE','2018-09-27 13:17:15'),(38,'2018_11_01_XrayCenteringResult.sql','DONE','2018-11-01 13:36:53'),(39,'2018_11_01_AutoProcProgram_dataCollectionId.sql','DONE','2018-11-01 15:10:38'),(40,'2018_11_01_AutoProcProgramMessage.sql','DONE','2018-11-01 15:28:17'),(44,'2018_11_01_DiffractionPlan_centeringMethod.sql','DONE','2018-11-01 22:51:36'),(45,'2018_11_02_DataCollectionGroup_experimentType_enum.sql','DONE','2018-11-02 11:54:15'),(47,'2018_11_05_spelling_of_centring.sql','DONE','2018-11-05 15:31:38'),(48,'2018_11_09_AutoProcProgram_update_processing_program.sql','DONE','2018-11-09 16:38:34'),(49,'2018_11_14_AutoProcProgramMessage_autoinc.sql','DONE','2018-11-14 10:15:27'),(50,'2018_11_22_AutoProcProgram_processingStatus_update.sql','DONE','2018-11-22 16:11:15'),(51,'2018_12_04_EnergyScan_and_XFEFluorescenceSpectrum_add_axisPosition.sql','DONE','2018-12-04 14:13:23'),(52,'2018_12_20_DataCollectionGroup_scanParameters.sql','DONE','2018-12-20 17:30:04'),(53,'2019_01_14_Proposal_state.sql','DONE','2019-01-14 12:13:31'),(54,'2019_01_14_ProcessingJobParameter_parameterValue.sql','DONE','2019-01-14 14:00:02'),(57,'2019_01_15_Detector_localName.sql','DONE','2019-01-15 23:01:15'),(58,'2019_02_04_BLSession_unique_index.sql','DONE','2019-02-04 13:52:19'),(59,'2019_03_29_BLSession_archived.sql','DONE','2019-04-03 14:43:08'),(60,'2019_04_03_UserGroup_and_Permission.sql','DONE','2019-04-03 14:51:04'),(61,'2019_04_07_AdminVar_bump_version.sql','DONE','2019-04-07 11:35:06'),(62,'2019_04_08_AdminVar_bump_version.sql','DONE','2019-04-08 15:38:01'),(63,'2019_04_23_AdminVar_bump_version.sql','DONE','2019-04-23 11:13:27'),(64,'2019_04_23_drop_v_run_view.sql','DONE','2019-04-23 11:13:35'),(67,'2019_04_23_v_run_additional_runs.sql','DONE','2019-04-23 12:39:47'),(68,'2019_05_28_AdminVar_bump_version.sql','DONE','2019-05-28 13:29:27'),(72,'2019_07_17_BLSample_crystalId_default.sql','DONE','2019-07-17 15:21:59'),(73,'2019_08_15_Sleeve.sql','DONE','2019-08-15 08:34:34'),(74,'2019_08_15_AdminVar_bump_version.sql','DONE','2019-08-15 08:57:37'),(75,'2019_08_28_AdminVar_bump_version.sql','DONE','2019-08-28 13:30:13'),(76,'2019_08_30_AdminVar_bump_version.sql','DONE','2019-08-30 11:58:16'),(77,'2019_10_06_BLSampleImage_fk3.sql','DONE','2019-10-06 16:55:44'),(78,'2019_10_08_DiffractionPlan_experimentKind.sql','DONE','2019-10-08 12:47:10'),(79,'2019_11_07_AutoProcProgramAttachment_importanceRank.sql','DONE','2019-11-07 16:35:25'),(80,'2019_11_07_AdminVar_bump_version.sql','DONE','2019-11-07 16:45:44'),(81,'2019_11_08_AdminVar_bump_version.sql','DONE','2019-11-08 16:09:52'),(82,'2019_11_26_v_run_idx1.sql','DONE','2019-11-26 15:00:21'),(83,'2019_12_02_AdminVar_bump_version.sql','DONE','2019-12-02 11:29:05'),(84,'2019_12_02_AdminVar_bump_version_v2.sql','DONE','2019-12-02 18:14:11'),(85,'2020_01_03_BLSampleImage_tables.sql','DONE','2020-01-03 16:05:45'),(86,'2020_01_06_AdminVar_bump_version.sql','DONE','2020-01-06 11:45:02'),(87,'2020_01_07_AdminVar_bump_version.sql','DONE','2020-01-07 09:45:25'),(88,'2020_01_07_AdminVar_bump_version_v2.sql','DONE','2020-01-07 10:24:54'),(89,'2020_01_07_AdminVar_bump_version_v3.sql','DONE','2020-01-07 11:16:09'),(90,'2020_01_20_AdminVar_bump_version.sql','DONE','2020-01-20 13:40:52'),(91,'2020_01_20_AdminVar_bump_version_v2.sql','DONE','2020-01-20 16:27:37'),(92,'2020_02_13_SpaceGroup_data.sql','DONE','2020-02-13 16:52:53'),(93,'2020_01_21_DiffractionPlan_experimentKind.sql','DONE','2020-02-13 17:13:17'),(94,'2020_02_21_ProposalHasPerson_role_enum.sql','DONE','2020-02-21 14:36:10'),(95,'2020_02_21_Session_has_Person_role_enum.sql','DONE','2020-02-21 14:36:17'),(96,'2020_02_27_Container_scLocationUpdated.sql','DONE','2020-02-27 13:43:51'),(97,'2020_03_09_Reprocessing_drop_tables.sql','DONE','2020-03-09 11:05:09'),(98,'2020_03_24_ProcessingPipeline_tables.sql','DONE','2020-03-26 16:37:29'),(99,'2020_03_25_ProcessingPipeline_ren_col.sql','DONE','2020-03-26 16:37:34'),(100,'2020_03_27_AdminVar_bump_version.sql','DONE','2020-03-27 08:51:52'),(101,'2020_03_27_AdminVar_bump_version_v2.sql','DONE','2020-03-27 15:07:56'),(102,'2020_04_06_alterProtein.sql','DONE','2020-04-06 13:40:18'),(103,'2020_04_27_BLSampleImageAutoScoreSchema_insert_CHIMP.sql','DONE','2020-04-27 14:37:41'),(104,'2020_05_21_BLSampleImageAutoScoreClass_insert_CHIMP.sql','DONE','2020-05-21 17:52:54'),(105,'2020_06_01_DewarRegistry_and_DewarRegistry_has_Proposal.sql','DONE','2020-06-01 10:29:19'),(106,'2020_06_01_Protein_new_columns.sql','DONE','2020-06-01 10:29:32'),(107,'2020_06_01_AdminVar_bump_version.sql','DONE','2020-06-01 10:46:11'),(108,'2020_06_08_Shipping_comments.sql','DONE','2020-06-08 16:44:26'),(109,'2020_06_10_DiffractionPlan_experimentKind.sql','DONE','2020-06-10 14:35:18'),(110,'2020_06_15_Shipping_comments.sql','DONE','2020-06-15 14:01:25'),(111,'2020_06_24_BLSampleGroup_name.sql','DONE','2020-06-24 10:56:25'),(112,'2020_06_24_DiffractionPlan_userPath.sql','DONE','2020-06-24 10:56:30'),(113,'2020_07_01_DewarRegistry_and_DewarRegistry_has_Proposal.sql','DONE','2020-07-01 13:51:49'),(114,'2020_07_06_DewarRegistry_to_DewarRegistry_has_Proposal_data.sql','DONE','2020-07-06 10:59:22'),(115,'2020_07_13_AdminVar_bump_version.sql','DONE','2020-07-13 18:14:39'),(116,'2020_08_03_AdminVar_bump_version.sql','DONE','2020-08-03 15:19:36'),(117,'2020_09_02_AutoProcScalingStatistics_new_index.sql','DONE','2020-09-02 17:02:33'),(118,'2020_09_08_DewarRegistry_modify_fks.sql','DONE','2020-09-08 15:26:14'),(119,'2020_08_28_ComponentSubType_changes.sql','DONE','2020-10-14 18:15:55'),(120,'2020_08_28_ConcentrationType_changes.sql','DONE','2020-10-14 18:15:55'),(121,'2020_08_28_Dewar_type.sql','DONE','2020-10-14 18:15:55'),(122,'2020_08_28_DiffractionPlan_new_temperature_cols.sql','DONE','2020-10-14 18:15:55'),(123,'2020_08_28_ExperimentType.sql','DONE','2020-10-14 18:15:55'),(124,'2020_08_28_PurificationColumn.sql','DONE','2020-10-14 18:15:55'),(125,'2020_08_29_BLSampleType.sql','DONE','2020-10-14 18:15:55'),(126,'2020_08_29_Protein_isotropy.sql','DONE','2020-10-14 18:15:55'),(127,'2020_10_16_AdminVar_bump_version.sql','DONE','2020-10-16 22:05:36'),(128,'2020_10_19_AdminVar_bump_version.sql','DONE','2020-10-20 04:21:23'),(129,'2020_10_22_GridInfo_dcId.sql','DONE','2020-11-09 13:57:27'),(130,'2020_11_09_Phasing_method_enum.sql','DONE','2020-11-09 13:57:27'),(133,'2020_11_09_AdminVar_bump_version.sql','DONE','2020-11-09 22:26:13'),(134,'2020_11_10_SpaceGroup_update.sql','DONE','2020-11-20 17:49:46'),(135,'2020_11_13_Dewar_facilityCode.sql','DONE','2020-11-20 17:49:46'),(136,'2020_11_20_AdminVar_bump_version.sql','DONE','2020-11-20 17:49:46'),(137,'2020_12_01_AdminVar_bump_version.sql','DONE','2020-12-01 12:21:43'),(138,'2020_12_04_Container_experimentTypeId_FK.sql','DONE','2020-12-04 16:34:05'),(139,'2020_12_04_AdminVar_bump_version.sql','DONE','2020-12-04 16:40:14'),(140,'2020_11_22_diffractionplan_priority_and_mode.sql','DONE','2020-12-29 18:29:08'),(141,'2020_12_07_AutoProc_index_unit_cell.sql','DONE','2020-12-29 18:29:08'),(142,'2020_12_07_DataCollection_index_startTime.sql','DONE','2020-12-29 18:29:08'),(143,'2020_12_10_BLSubSample_source.sql','DONE','2020-12-29 18:29:08'),(144,'2020_12_30_AdminVar_bump_version.sql','DONE','2020-12-30 14:36:17'),(145,'2021_01_13_AdminVar_bump_version.sql','DONE','2021-01-13 12:12:57'),(146,'2021_01_14_AdminVar_bump_version.sql','DONE','2021-01-14 11:04:57'),(147,'2020_07_31_add_offset_blsampleimage.sql','DONE','2021-02-22 12:28:16'),(148,'2020_07_31_add_type_blsubsample.sql','DONE','2021-02-22 12:28:16'),(149,'2020_07_31_extend_dcattachment_enum.sql','DONE','2021-02-22 12:28:16'),(150,'2020_07_31_extend_dcg_type_enum.sql','DONE','2021-02-22 12:28:16'),(151,'2020_07_31_extend_robotaction_enum.sql','DONE','2021-02-22 12:28:16'),(152,'2020_07_31_refactor_xrfmapping.sql','DONE','2021-02-22 12:28:16'),(153,'2020_11_22_blsample_staff_comments.sql','DONE','2021-02-22 12:28:16'),(154,'2021_01_28_beamlinesetup_add_datacentre.sql','DONE','2021-02-22 12:28:16'),(155,'2021_02_04_DiffractionPlan_strategyOption.sql','DONE','2021-02-22 12:28:16'),(156,'2021_02_22_AdminVar_bump_version.sql','DONE','2021-02-22 13:06:57'),(157,'2021_02_22_AdminVar_bump_version_v2.sql','DONE','2021-02-22 15:37:45'),(158,'2020_08_28_ContainerType.sql','DONE','2021-03-05 16:09:40'),(159,'2021_03_03_BF_automationError.sql','DONE','2021-03-05 16:09:41'),(160,'2021_03_03_BF_automationFault.sql','DONE','2021-03-05 16:09:41'),(161,'2021_03_03_cryoEMv2_0_tables.sql','DONE','2021-03-05 16:09:41'),(162,'2021_03_05_AdminVar_bump_version.sql','DONE','2021-03-05 16:09:41'),(163,'2021_03_05_ContainerType_update.sql','DONE','2021-04-13 15:50:39'),(164,'2021_03_08_ContainerType_update.sql','DONE','2021-04-13 15:50:39'),(165,'2021_03_09_SpaceGroup_update.sql','DONE','2021-04-13 15:50:39'),(166,'2021_03_19_add_drop_indices.sql','DONE','2021-04-13 15:50:39'),(167,'2021_03_19_ExperimentType_update.sql','DONE','2021-04-13 15:50:39'),(168,'2021_04_01_BLSampleGroup_has_BLSample_modify_type.sql','DONE','2021-04-13 15:50:39'),(169,'2021_04_01_ContainerType_insert.sql','DONE','2021-04-13 15:50:39'),(170,'2021_04_12_cryoEMv2_1.sql','DONE','2021-04-13 15:50:39'),(171,'2021_04_13_AdminVar_bump_version.sql','DONE','2021-04-13 16:17:12'),(173,'2021_04_13_ContainerType_update.sql','DONE','2021-04-13 16:42:57'),(174,'2021_04_20_AdminVar_bump_version.sql','DONE','2021-04-20 17:05:50'),(175,'2020_11_19_ContainerQueueSample.sql','DONE','2021-05-14 16:07:45'),(176,'2020_11_19_DataCollection.sql','DONE','2021-05-14 16:07:45'),(177,'2021_04_23_Dewar_fk_constraint.sql','DONE','2021-05-14 16:07:46'),(178,'2021_05_12_ParticleClassification_rotationAccuracy.sql','DONE','2021-05-14 16:07:46'),(179,'2021_05_14_AdminVar_bump_version.sql','DONE','2021-05-14 16:21:50'),(180,'2021_05_19_AdminVar_bump_version.sql','DONE','2021-05-19 16:01:54'),(181,'2021_05_20_AdminVar_bump_version.sql','DONE','2021-05-20 10:30:35'),(182,'2021_05_28_AdminVar_bump_version.sql','DONE','2021-05-28 15:46:50'),(183,'2020_08_28_DiffractionPlan_new_cols.sql','DONE','2021-07-07 09:32:34'),(184,'2021_06_01_BLSampleGroup_fk_proposalId.sql','DONE','2021-07-07 09:32:34'),(185,'2021_06_09_DataCollectionGroup_experimentType_enum.sql','DONE','2021-07-07 09:32:34'),(186,'2021_06_11_DataCollectionGroup_experimentType_enum.sql','DONE','2021-07-07 09:32:34'),(187,'2021_06_17_SpaceGroup_update.sql','DONE','2021-07-07 09:32:34'),(188,'2021_06_30_zc_ZocaloBuffer.sql','DONE','2021-07-07 09:32:34'),(189,'2021_07_01_ParticleClassification_classDistribution.sql','DONE','2021-07-07 09:32:34'),(190,'2021_07_01_ParticlePicker_summaryImageFullPath.sql','DONE','2021-07-07 09:32:34'),(191,'2021_07_02_UserGroup_insert.sql','DONE','2021-07-07 09:32:34'),(192,'2021_07_07_AdminVar_bump_version.sql','DONE','2021-07-07 10:35:39'),(193,'2021_07_07_AdminVar_bump_version_v2.sql','DONE','2021-07-07 11:37:27'),(194,'2021_07_08_AutoProcScalingStatistics_resIOverSigI2.sql','DONE','2021-07-23 17:36:44'),(195,'2021_07_08_Screening_autoProcProgramId.sql','DONE','2021-07-23 17:36:45'),(196,'2021_07_09_ProposalHasPerson_role_enum.sql','DONE','2021-07-23 17:36:45'),(197,'2021_07_09_Session_has_Person_role_enum.sql','DONE','2021-07-23 17:36:45'),(198,'2021_07_21_Positioner_tables.sql','DONE','2021-07-23 17:36:45'),(199,'2021_07_23_AdminVar_bump_version.sql','DONE','2021-07-23 17:36:45'),(200,'2021_07_23_AutoProcProgram_drop_dataCollectionId.sql','DONE','2021-07-23 17:36:45');
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
-- Dumping data for table `ContainerType`
--

/*!40000 ALTER TABLE `ContainerType` DISABLE KEYS */;
INSERT INTO `ContainerType` (`containerTypeId`, `name`, `proposalType`, `active`, `capacity`, `wellPerRow`, `dropPerWellX`, `dropPerWellY`, `dropHeight`, `dropWidth`, `dropOffsetX`, `dropOffsetY`, `wellDrop`) VALUES (1,'B21_8+1','saxs',1,9,9,1,1,1,1,0,0,-1),(2,'B21_96','saxs',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,'B21_1tube','saxs',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,'I22_Capillary_Rack_20','saxs',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,'I22_Grid_100','saxs',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,'I22_Grid_45','saxs',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,'P38_Capillary_Rack_27','saxs',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,'P38_Solids','saxs',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,'P38_Powder','saxs',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(10,'B22_6','saxs',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11,'I11_Capillary_Rack_6','saxs',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(12,'Puck','mx',1,16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(13,'ReferencePlate','mx',1,16,2,1,1,1,1,0,0,-1),(14,'CrystalQuickX','mx',1,192,12,2,1,0.5,1,0,0,-1),(15,'MitegenInSitu','mx',1,192,12,2,1,0.5,1,0,0,-1),(16,'FilmBatch','mx',1,96,12,1,1,1,1,0,0,-1),(17,'MitegenInSitu_3_Drop','mx',1,288,12,3,1,0.5,1,0,0,-1),(18,'Greiner 3 Drop','mx',1,288,12,3,1,0.5,1,0,0,-1),(19,'MRC Maxi','mx',1,48,6,1,1,1,0.5,0,0,-1),(20,'MRC 2 Drop','mx',1,192,12,1,2,1,0.5,0.5,0,-1),(21,'Griener 1536','mx',1,1536,12,4,4,1,1,0,0,-1),(22,'3 Drop Square','mx',1,288,12,2,2,1,1,0,0,3),(23,'SWISSCI 3 Drop','mx',1,288,12,2,2,1,1,0,0,1),(24,'1 drop','mx',1,96,12,1,1,0.5,0.5,0,0,-1),(25,'LCP Glass','mx',1,96,12,1,1,1,1,0,0,-1),(26,'PCRStrip','saxs',1,9,9,1,1,1,1,0,0,-1),(27,'Basket','mx',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(28,'Cane','mx',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(29,'Terasaki72','mx',0,72,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(30,'Puck-16','mx',1,16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(31,'Block-4','mx',1,16,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(32,'Box','xpdf',1,25,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(33,'Puck-22','xpdf',1,22,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `ContainerType` ENABLE KEYS */;

--
-- Dumping data for table `ExperimentType`
--

/*!40000 ALTER TABLE `ExperimentType` DISABLE KEYS */;
INSERT INTO `ExperimentType` (`experimentTypeId`, `name`, `proposalType`, `active`) VALUES (1,'Default',NULL,1),(2,'MXPressE','mx',1),(3,'MXPressO','mx',1),(4,'MXPressE_SAD','mx',1),(5,'MXScore','mx',1),(6,'MXPressM','mx',1),(7,'MAD','mx',1),(8,'SAD','mx',1),(9,'Fixed','mx',1),(10,'Ligand binding','mx',1),(11,'Refinement','mx',1),(12,'OSC','mx',1),(13,'MAD - Inverse Beam','mx',1),(14,'SAD - Inverse Beam','mx',1),(15,'MESH','mx',1),(16,'XFE','mx',1),(17,'Stepped transmission','mx',1),(18,'XChem High Symmetry','mx',1),(19,'XChem Low Symmetry','mx',1),(20,'Commissioning','mx',1),(21,'HPLC','saxs',1),(22,'Robot','saxs',1),(23,'Rack','saxs',1),(24,'Grid','saxs',1),(25,'Solids','saxs',1),(26,'Powder','saxs',1),(27,'Peltier','saxs',1),(28,'Spectroscopy','saxs',1),(29,'CD Spectroscopy','saxs',1),(30,'Microscopy','saxs',1),(31,'Imaging','saxs',1),(32,'CD Thermal Melt','saxs',1),(33,'Fixed Energy At Ambient With Robot','saxs',1),(34,'Mesh3D','mx',1),(35,'Screening','sm',1);
/*!40000 ALTER TABLE `ExperimentType` ENABLE KEYS */;

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
-- Dumping data for table `ScheduleComponent`
--

/*!40000 ALTER TABLE `ScheduleComponent` DISABLE KEYS */;
INSERT INTO `ScheduleComponent` (`scheduleComponentId`, `scheduleId`, `offset_hours`, `inspectionTypeId`) VALUES (1,1,0,1),(2,1,12,1),(3,1,24,1),(4,1,96,1),(5,1,48,1),(6,1,72,1),(8,2,24,1),(11,2,48,2),(14,11,0,1),(17,11,12,1),(20,11,24,1),(23,11,36,1),(26,11,60,1),(29,11,96,1),(32,11,156,1),(35,11,252,1),(38,11,408,1),(41,11,660,1),(44,11,1068,1),(47,11,1728,1),(50,11,2796,1),(54,15,3,1),(57,15,6,1),(60,15,9,1),(63,15,12,1),(66,15,18,1),(69,15,24,1),(72,15,30,1),(75,15,36,1),(78,15,42,1),(81,15,48,1),(84,1,120,1),(87,1,144,1),(90,1,168,1),(93,1,336,1),(96,1,504,1);
/*!40000 ALTER TABLE `ScheduleComponent` ENABLE KEYS */;

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
INSERT INTO `SpaceGroup` (`spaceGroupId`, `spaceGroupNumber`, `spaceGroupShortName`, `spaceGroupName`, `bravaisLattice`, `bravaisLatticeName`, `pointGroup`, `geometryClassnameId`, `MX_used`) VALUES (1,1,'P1','P 1','aP',NULL,NULL,NULL,1),(2,2,'P-1','P-1',NULL,NULL,NULL,NULL,1),(3,3,'P2','P 12 1','mP',NULL,NULL,NULL,1),(4,4,'P21','P 121 1','mP',NULL,NULL,NULL,1),(5,5,'C2','C 12 1','mC,mI',NULL,NULL,NULL,1),(6,6,'P1m1','P 1m 1',NULL,NULL,NULL,NULL,0),(7,7,'P1c1','P 1c 1',NULL,NULL,NULL,NULL,0),(8,8,'C1m1','C 1m 1',NULL,NULL,NULL,NULL,0),(9,9,'C1c1','C 1c 1',NULL,NULL,NULL,NULL,0),(10,10,'P12/m1','P 12/m 1',NULL,NULL,NULL,NULL,0),(11,11,'P121/m1','P 121/m 1',NULL,NULL,NULL,NULL,0),(12,12,'C12/m1','C 12/m 1',NULL,NULL,NULL,NULL,0),(13,13,'P12/c1','P 12/c 1',NULL,NULL,NULL,NULL,0),(14,14,'P121/c1','P 121/c 1',NULL,NULL,NULL,NULL,0),(15,15,'C12/c1','C 12/c 1',NULL,NULL,NULL,NULL,0),(16,16,'P222','P 22 2','oP',NULL,NULL,NULL,1),(17,17,'P2221','P 22 21','oP',NULL,NULL,NULL,1),(18,18,'P21212','P21 21 2','oP',NULL,NULL,NULL,1),(19,19,'P212121','P21 21 21','oP',NULL,NULL,NULL,1),(20,20,'C2221','C 22 21','oC',NULL,NULL,NULL,1),(21,21,'C222','C 22 2','oC',NULL,NULL,NULL,1),(22,22,'F222','F 22 2','oF',NULL,NULL,NULL,1),(23,23,'I222','I 22 2','oI',NULL,NULL,NULL,1),(24,24,'I212121','I21 21 21','oI',NULL,NULL,NULL,1),(25,25,'Pmm2','P mm 2',NULL,NULL,NULL,NULL,0),(26,26,'Pmc21','P mc 21',NULL,NULL,NULL,NULL,0),(27,27,'Pcc2','P cc 2',NULL,NULL,NULL,NULL,0),(28,28,'Pma2','P ma 2',NULL,NULL,NULL,NULL,0),(29,29,'Pca21','P ca 21',NULL,NULL,NULL,NULL,0),(30,30,'Pnc2','P nc 2',NULL,NULL,NULL,NULL,0),(31,31,'Pmn21','P mn 21',NULL,NULL,NULL,NULL,0),(32,32,'Pba2','P ba 2',NULL,NULL,NULL,NULL,0),(33,33,'Pna21','P na 21',NULL,NULL,NULL,NULL,0),(34,34,'Pnn2','P nn 2',NULL,NULL,NULL,NULL,0),(35,35,'Cmm2','C mm 2',NULL,NULL,NULL,NULL,0),(36,36,'Cmc21','C mc 21',NULL,NULL,NULL,NULL,0),(37,37,'Ccc2','C cc 2',NULL,NULL,NULL,NULL,0),(38,38,'Amm2','A mm 2',NULL,NULL,NULL,NULL,0),(39,39,'Abm2','A bm 2',NULL,NULL,NULL,NULL,0),(40,40,'Ama2','A ma 2',NULL,NULL,NULL,NULL,0),(41,41,'Aba2','A ba 2',NULL,NULL,NULL,NULL,0),(42,42,'Fmm2','F mm 2',NULL,NULL,NULL,NULL,0),(43,43,'Fdd2','F dd 2',NULL,NULL,NULL,NULL,0),(44,44,'Imm2','I mm 2',NULL,NULL,NULL,NULL,0),(45,45,'Iba2','I ba 2',NULL,NULL,NULL,NULL,0),(46,46,'Ima2','I ma 2',NULL,NULL,NULL,NULL,0),(47,47,'Pmmm','P mm m',NULL,NULL,NULL,NULL,0),(48,48,'Pnnn','P nn n',NULL,NULL,NULL,NULL,0),(49,49,'Pccm','P cc m',NULL,NULL,NULL,NULL,0),(50,50,'Pban','P ba n',NULL,NULL,NULL,NULL,0),(51,51,'Pmma1','P mm a1',NULL,NULL,NULL,NULL,0),(52,52,'Pnna1','P nn a1',NULL,NULL,NULL,NULL,0),(53,53,'Pmna1','P mn a1',NULL,NULL,NULL,NULL,0),(54,54,'Pcca1','P cc a1',NULL,NULL,NULL,NULL,0),(55,55,'Pbam1','P ba m1',NULL,NULL,NULL,NULL,0),(56,56,'Pccn1','P cc n1',NULL,NULL,NULL,NULL,0),(57,57,'Pbcm1','P bc m1',NULL,NULL,NULL,NULL,0),(58,58,'Pnnm1','P nn m1',NULL,NULL,NULL,NULL,0),(59,59,'Pmmn1','P mm n1',NULL,NULL,NULL,NULL,0),(60,60,'Pbcn1','P bc n1',NULL,NULL,NULL,NULL,0),(61,61,'Pbca1','P bc a1',NULL,NULL,NULL,NULL,0),(62,62,'Pnma1','P nm a1',NULL,NULL,NULL,NULL,0),(63,63,'Cmcm1','C mc m1',NULL,NULL,NULL,NULL,0),(64,64,'Cmca1','C mc a1',NULL,NULL,NULL,NULL,0),(65,65,'Cmmm','C mm m',NULL,NULL,NULL,NULL,0),(66,66,'Cccm','C cc m',NULL,NULL,NULL,NULL,0),(67,67,'Cmma','C mm a',NULL,NULL,NULL,NULL,0),(68,68,'Ccca','C cc a',NULL,NULL,NULL,NULL,0),(69,69,'Fmmm','F mm m',NULL,NULL,NULL,NULL,0),(70,70,'Fddd','F dd d',NULL,NULL,NULL,NULL,0),(71,71,'Immm','I mm m',NULL,NULL,NULL,NULL,0),(72,72,'Ibam','I ba m',NULL,NULL,NULL,NULL,0),(73,73,'Ibca1','I b c a1',NULL,NULL,NULL,NULL,0),(74,74,'Imma1','I mm a1',NULL,NULL,NULL,NULL,0),(75,75,'P4','P4','tP',NULL,NULL,NULL,1),(76,76,'P41','P41','tP',NULL,NULL,NULL,1),(77,77,'P42','P42','tP',NULL,NULL,NULL,1),(78,78,'P43','P43','tP',NULL,NULL,NULL,1),(79,79,'I4','I4','tI',NULL,NULL,NULL,1),(80,80,'I41','I41','tI',NULL,NULL,NULL,1),(81,81,'P-4','P-4',NULL,NULL,NULL,NULL,0),(82,82,'I-4','I-4',NULL,NULL,NULL,NULL,0),(83,83,'P4/m','P4/m',NULL,NULL,NULL,NULL,0),(84,84,'P42/m','P42/m',NULL,NULL,NULL,NULL,0),(85,85,'P4/n','P4/n',NULL,NULL,NULL,NULL,0),(86,86,'P42/n','P42/n',NULL,NULL,NULL,NULL,0),(87,87,'I4/m','I4/m',NULL,NULL,NULL,NULL,0),(88,88,'I41/a','I41/a',NULL,NULL,NULL,NULL,0),(89,89,'P422','P 42 2','tP',NULL,NULL,NULL,1),(90,90,'P4212','P 421 2','tP',NULL,NULL,NULL,1),(91,91,'P4122','P41 2 2','tP',NULL,NULL,NULL,1),(92,92,'P41212','P41 21 2','tP',NULL,NULL,NULL,1),(93,93,'P4222','P42 2 2','tP',NULL,NULL,NULL,1),(94,94,'P42212','P42 21 2','tP',NULL,NULL,NULL,1),(95,95,'P4322','P43 2 2','tP',NULL,NULL,NULL,1),(96,96,'P43212','P43 21 2','tP',NULL,NULL,NULL,1),(97,97,'I422','I 42 2','tI',NULL,NULL,NULL,1),(98,98,'I4122','I41 2 2','tI',NULL,NULL,NULL,1),(99,99,'P4mm','P 4m m',NULL,NULL,NULL,NULL,0),(100,100,'P4bm','P4 b m',NULL,NULL,NULL,NULL,0),(101,101,'P42cm','P42 c m',NULL,NULL,NULL,NULL,0),(102,102,'P42nm','P42 n m',NULL,NULL,NULL,NULL,0),(103,103,'P4cc','P4 c c',NULL,NULL,NULL,NULL,0),(104,104,'P4nc','P4 n c',NULL,NULL,NULL,NULL,0),(105,105,'P42mc','P42 m c',NULL,NULL,NULL,NULL,0),(106,106,'P42bc','P42 b c',NULL,NULL,NULL,NULL,0),(107,107,'I4mm','I4 m m',NULL,NULL,NULL,NULL,0),(108,108,'I4cm','I4 c m',NULL,NULL,NULL,NULL,0),(109,109,'I41md','I41 m d',NULL,NULL,NULL,NULL,0),(110,110,'I41cd','I41 c d',NULL,NULL,NULL,NULL,0),(111,111,'P-42m','P-4 2 m',NULL,NULL,NULL,NULL,0),(112,112,'P-42c','P-4 2 c',NULL,NULL,NULL,NULL,0),(113,113,'P-421m','P-4 21 m',NULL,NULL,NULL,NULL,0),(114,114,'P-421c','P-4 21 c',NULL,NULL,NULL,NULL,0),(115,115,'P-4m2','P-4 m 2',NULL,NULL,NULL,NULL,0),(116,116,'P-4c2','P-4 c 2',NULL,NULL,NULL,NULL,0),(117,117,'P-4b2','P-4 b 2',NULL,NULL,NULL,NULL,0),(118,118,'P-4n2','P-4 n 2',NULL,NULL,NULL,NULL,0),(119,119,'I-4m2','I-4 m 2',NULL,NULL,NULL,NULL,0),(120,120,'I-4c2','I-4 c 2',NULL,NULL,NULL,NULL,0),(121,121,'I-42m','I-4 2 m',NULL,NULL,NULL,NULL,0),(122,122,'I-42d','I-4 2 d',NULL,NULL,NULL,NULL,0),(123,123,'P4/mmm','P4/m m m',NULL,NULL,NULL,NULL,0),(124,124,'P4/mcc','P4/m c c',NULL,NULL,NULL,NULL,0),(125,125,'P4/nbm','P4/n b m',NULL,NULL,NULL,NULL,0),(126,126,'P4/nnc','P4/n n c',NULL,NULL,NULL,NULL,0),(127,127,'P4/mbm1','P4/m b m1',NULL,NULL,NULL,NULL,0),(128,128,'P4/mnc1','P4/m n c1',NULL,NULL,NULL,NULL,0),(129,129,'P4/nmm1','P4/n m m1',NULL,NULL,NULL,NULL,0),(130,130,'P4/ncc1','P4/n c c1',NULL,NULL,NULL,NULL,0),(131,131,'P42/mmc','P42/m m c',NULL,NULL,NULL,NULL,0),(132,132,'P42/mcm','P42/m c m',NULL,NULL,NULL,NULL,0),(133,133,'P42/nbc','P42/n b c',NULL,NULL,NULL,NULL,0),(134,134,'P42/nnm','P42/n n m',NULL,NULL,NULL,NULL,0),(135,135,'P42/mbc','P42/m b c',NULL,NULL,NULL,NULL,0),(136,136,'P42/mnm','P42/m n m',NULL,NULL,NULL,NULL,0),(137,137,'P42/nmc','P42/n m c',NULL,NULL,NULL,NULL,0),(138,138,'P42/ncm','P42/n c m',NULL,NULL,NULL,NULL,0),(139,139,'I4/mmm','I4/m m m',NULL,NULL,NULL,NULL,0),(140,140,'I4/mcm','I4/m c m',NULL,NULL,NULL,NULL,0),(141,141,'I41/amd','I41/a m d',NULL,NULL,NULL,NULL,0),(142,142,'I41/acd','I41/a c d',NULL,NULL,NULL,NULL,0),(143,143,'P3','P3','hP',NULL,NULL,NULL,1),(144,144,'P31','P31','hP',NULL,NULL,NULL,1),(145,145,'P32','P32','hP',NULL,NULL,NULL,1),(146,146,'R3','H3','hR',NULL,NULL,NULL,1),(147,147,'P-3','P-3',NULL,NULL,NULL,NULL,0),(148,148,'H-3','H-3',NULL,NULL,NULL,NULL,0),(149,149,'P312','P3 1 2','hP',NULL,NULL,NULL,1),(150,150,'P321','P3 2 1','hP',NULL,NULL,NULL,1),(151,151,'P3112','P31 1 2','hP',NULL,NULL,NULL,1),(152,152,'P3121','P31 2 1','hP',NULL,NULL,NULL,1),(153,153,'P3212','P32 1 2','hP',NULL,NULL,NULL,1),(154,154,'P3221','P32 2 1','hP',NULL,NULL,NULL,1),(155,155,'R32','H3 2','hR',NULL,NULL,NULL,1),(156,156,'P3m1','P3 m 1',NULL,NULL,NULL,NULL,0),(157,157,'P31m','P3 1 m',NULL,NULL,NULL,NULL,0),(158,158,'P3c1','P3 c 1',NULL,NULL,NULL,NULL,0),(159,159,'P31c','P3 1 c',NULL,NULL,NULL,NULL,0),(160,160,'H3m','H3 m',NULL,NULL,NULL,NULL,0),(161,161,'H3c','H3 c',NULL,NULL,NULL,NULL,0),(162,162,'P-31m','P-3 1 m',NULL,NULL,NULL,NULL,0),(163,163,'P-31c','P-3 1 c',NULL,NULL,NULL,NULL,0),(164,164,'P-3m1','P-3 m 1',NULL,NULL,NULL,NULL,0),(165,165,'P-3c1','P-3 c 1',NULL,NULL,NULL,NULL,0),(166,166,'H-3m','H-3 m',NULL,NULL,NULL,NULL,0),(167,167,'H-3c','H-3 c',NULL,NULL,NULL,NULL,0),(168,168,'P6','P6','hP',NULL,NULL,NULL,1),(169,169,'P61','P61','hP',NULL,NULL,NULL,1),(170,170,'P65','P65','hP',NULL,NULL,NULL,1),(171,171,'P62','P62','hP',NULL,NULL,NULL,1),(172,172,'P64','P64','hP',NULL,NULL,NULL,1),(173,173,'P63','P63','hP',NULL,NULL,NULL,1),(174,174,'P-6','P-6',NULL,NULL,NULL,NULL,0),(175,175,'P6/m','P6/m',NULL,NULL,NULL,NULL,0),(176,176,'P63/m','P63/m',NULL,NULL,NULL,NULL,0),(177,177,'P622','P6 2 2','hP',NULL,NULL,NULL,1),(178,178,'P6122','P61 2 2','hP',NULL,NULL,NULL,1),(179,179,'P6522','P65 2 2','hP',NULL,NULL,NULL,1),(180,180,'P6222','P62 2 2','hP',NULL,NULL,NULL,1),(181,181,'P6422','P64 2 2','hP',NULL,NULL,NULL,1),(182,182,'P6322','P63 2 2','hP',NULL,NULL,NULL,1),(183,183,'P6mm','P6 m m',NULL,NULL,NULL,NULL,0),(184,184,'P6cc','P6 c c',NULL,NULL,NULL,NULL,0),(185,185,'P63cm','P63 c m',NULL,NULL,NULL,NULL,0),(186,186,'P63mc','P63 m c',NULL,NULL,NULL,NULL,0),(187,187,'P-6m2','P-6 m 2',NULL,NULL,NULL,NULL,0),(188,188,'P-6c2','P-6 c 2',NULL,NULL,NULL,NULL,0),(189,189,'P-62m','P-6 2 m',NULL,NULL,NULL,NULL,0),(190,190,'P-62c','P-6 2 c',NULL,NULL,NULL,NULL,0),(191,191,'P6/mmm','P6/m m m',NULL,NULL,NULL,NULL,0),(192,192,'P6/mcc','P6/m c c',NULL,NULL,NULL,NULL,0),(193,193,'P63/mcm','P63/m c m',NULL,NULL,NULL,NULL,0),(194,194,'P63/mmc','P63/m m c',NULL,NULL,NULL,NULL,0),(195,195,'P23','P2 3','cP',NULL,NULL,NULL,1),(196,196,'F23','F2 3','cF',NULL,NULL,NULL,1),(197,197,'I23','I2 3','cI',NULL,NULL,NULL,1),(198,198,'P213','P21 3','cP',NULL,NULL,NULL,1),(199,199,'I213','I21 3','cI',NULL,NULL,NULL,1),(200,200,'Pm-3','Pm -3',NULL,NULL,NULL,NULL,0),(201,201,'Pn-3','Pn -3',NULL,NULL,NULL,NULL,0),(202,202,'Fm-3','Fm -3',NULL,NULL,NULL,NULL,0),(203,203,'Fd-3','Fd -3',NULL,NULL,NULL,NULL,0),(204,204,'Im-3','Im -3',NULL,NULL,NULL,NULL,0),(205,205,'Pa-31','Pa -31',NULL,NULL,NULL,NULL,0),(206,206,'Ia-31','Ia -31',NULL,NULL,NULL,NULL,0),(207,207,'P432','P4 3 2','cP',NULL,NULL,NULL,1),(208,208,'P4232','P42 3 2','cP',NULL,NULL,NULL,1),(209,209,'F432','F4 3 2','cF',NULL,NULL,NULL,1),(210,210,'F4132','F41 3 2','cF',NULL,NULL,NULL,1),(211,211,'I432','I4 3 2','cI',NULL,NULL,NULL,1),(212,212,'P4332','P43 3 2','cP',NULL,NULL,NULL,1),(213,213,'P4132','P41 3 2','cP',NULL,NULL,NULL,1),(214,214,'I4132','I41 3 2','cI',NULL,NULL,NULL,1),(215,215,'P-43m','P-4 3 m',NULL,NULL,NULL,NULL,0),(216,216,'F-43m','F-4 3 m',NULL,NULL,NULL,NULL,0),(217,217,'I-43m','I-4 3 m',NULL,NULL,NULL,NULL,0),(218,218,'P-43n','P-4 3 n',NULL,NULL,NULL,NULL,0),(219,219,'F-43c','F-4 3 c',NULL,NULL,NULL,NULL,0),(220,220,'I-43d','I-4 3 d',NULL,NULL,NULL,NULL,0),(221,221,'Pm-3m','Pm -3 m',NULL,NULL,NULL,NULL,0),(222,222,'Pn-3n','Pn -3 n',NULL,NULL,NULL,NULL,0),(223,223,'Pm-3n1','Pm -3 n1',NULL,NULL,NULL,NULL,0),(224,224,'Pn-3m1','Pn -3 m1',NULL,NULL,NULL,NULL,0),(225,225,'Fm-3m','Fm -3 m',NULL,NULL,NULL,NULL,0),(226,226,'Fm-3c','Fm -3 c',NULL,NULL,NULL,NULL,0),(227,227,'Fd-3m1','Fd -3 m1',NULL,NULL,NULL,NULL,0),(228,228,'Fd-3c1','Fd -3 c1',NULL,NULL,NULL,NULL,0),(229,229,'Im-3m','Im -3 m',NULL,NULL,NULL,NULL,0),(230,230,'Ia-3d1','Ia -3 d1',NULL,NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `SpaceGroup` ENABLE KEYS */;

--
-- Dumping data for table `ProcessingPipelineCategory`
--

/*!40000 ALTER TABLE `ProcessingPipelineCategory` DISABLE KEYS */;
INSERT INTO `ProcessingPipelineCategory` (`processingPipelineCategoryId`, `name`) VALUES (1,'screening'),(2,'processing'),(3,'post processing');
/*!40000 ALTER TABLE `ProcessingPipelineCategory` ENABLE KEYS */;

--
-- Dumping data for table `ProcessingPipeline`
--

/*!40000 ALTER TABLE `ProcessingPipeline` DISABLE KEYS */;
INSERT INTO `ProcessingPipeline` (`processingPipelineId`, `processingPipelineCategoryId`, `name`, `discipline`, `pipelineStatus`, `reprocessing`) VALUES (1,1,'Mosflm','MX','automatic',0),(2,1,'EDNA','MX','automatic',0),(3,2,'Fast DP','MX','automatic',1),(4,2,'xia2/3dii','MX','deprecated',0),(5,2,'xia2/Multiplex','MX','automatic',1),(6,2,'xia2/DIALS','MX','optional',1),(7,2,'xia2/XDS','MX','optional',1),(8,2,'autoPROC','MX','optional',1),(9,3,'Fast EP','MX','automatic',0),(10,3,'Dimple','MX','automatic',0),(11,3,'MrBUMP','MX','automatic',0),(12,3,'Big EP/XDS','MX','automatic',0),(13,3,'Big EP/DIALS','MX','automatic',0);
/*!40000 ALTER TABLE `ProcessingPipeline` ENABLE KEYS */;

--
-- Dumping data for table `BLSampleType`
--

/*!40000 ALTER TABLE `BLSampleType` DISABLE KEYS */;
INSERT INTO `BLSampleType` (`blSampleTypeId`, `name`, `proposalType`, `active`) VALUES (1,'background','xpdf',1),(2,'container','xpdf',1),(3,'sample','xpdf',1),(4,'calibrant','xpdf',1),(5,'buffer','scm',1),(6,'sample','scm',1),(7,'sample','mx',1);
/*!40000 ALTER TABLE `BLSampleType` ENABLE KEYS */;

--
-- Dumping data for table `PurificationColumn`
--

/*!40000 ALTER TABLE `PurificationColumn` DISABLE KEYS */;
INSERT INTO `PurificationColumn` (`purificationColumnId`, `name`, `active`) VALUES (1,'user supplied',1),(2,'s75',1),(3,'s200',1),(4,'superose6',1),(5,'kw402.5',1),(6,'kw403',1),(7,'kw404',1),(8,'kw405',1);
/*!40000 ALTER TABLE `PurificationColumn` ENABLE KEYS */;

--
-- Dumping data for table `UserGroup`
--

/*!40000 ALTER TABLE `UserGroup` DISABLE KEYS */;
INSERT INTO `UserGroup` (`userGroupId`, `name`) VALUES (39,'autocollect'),(17,'bag_stats'),(20,'bl_stats'),(45,'detector_admin'),(8,'developers'),(9,'ehc'),(6,'em_admin'),(10,'fault_admin'),(50,'goods_handling'),(53,'imaging_admin'),(59,'mm_admin'),(2,'mx_admin'),(14,'pdb_stats'),(4,'powder_admin'),(47,'prop_admin'),(3,'saxs_admin'),(28,'ship_manage'),(12,'sm_admin'),(56,'spectroscopy_admin'),(1,'super_admin'),(24,'temp_mx_admin'),(5,'tomo_admin'),(11,'vmxi'),(34,'xpdf_admin');
/*!40000 ALTER TABLE `UserGroup` ENABLE KEYS */;

--
-- Dumping data for table `Permission`
--

/*!40000 ALTER TABLE `Permission` DISABLE KEYS */;
INSERT INTO `Permission` (`permissionId`, `type`, `description`) VALUES (1,'mx_admin','MX Administrator'),(2,'manage_groups','Manage User Groups'),(4,'manage_perms','Manage User Group Permissions'),(5,'global_stats','View Global Statistics'),(6,'fault_view','View Fault Reports'),(7,'saxs_admin','SAXS Administrator'),(8,'em_admin','EM Administrator'),(9,'gen_admin','Powder Admin'),(10,'tomo_admin','Tomo Admin'),(11,'super_admin','Site Admin'),(12,'fault_global','Globally edit all faults'),(13,'schedules','Manage Imaging Schedules'),(15,'schedule_comps','Manage Imaging Schedule Components'),(16,'imaging_dash','Imaging Dashboard'),(17,'vmxi_queue','VMXi Data Collection Queue'),(18,'sm_admin','Small Molecule Admin'),(20,'pow_admin','Power Admin'),(23,'all_dewars','View All Dewars'),(26,'all_prop_stats','View All Proposal Stats'),(29,'all_breakdown','View Aggregated Visit Breakdown Stats'),(32,'disp_cont','VMXi Dispose Container'),(37,'view_manifest','View Shipping Manifest'),(43,'schedule_comp','typo fill in'),(49,'xpdf_admin','XPDF Admin'),(55,'edit_presets','Edit Beamline DC Presets'),(58,'manage_params','Edit Beamline Parameter Limits'),(64,'manage_detector','Manage Beamline Detector Limits'),(69,'auto_dash','AutoCollect Dashboard'),(77,'fault_admin','Edit Fault Categories'),(80,'fault_add','Add New Fault Reports');
/*!40000 ALTER TABLE `Permission` ENABLE KEYS */;

--
-- Dumping data for table `UserGroup_has_Permission`
--

/*!40000 ALTER TABLE `UserGroup_has_Permission` DISABLE KEYS */;
INSERT INTO `UserGroup_has_Permission` (`userGroupId`, `permissionId`) VALUES (1,1),(1,7),(1,8),(1,9),(1,10),(1,11),(1,18),(1,20),(1,23),(1,49),(2,1),(2,6),(2,23),(2,80),(3,7),(3,23),(4,20),(5,10),(6,8),(6,23),(8,1),(8,2),(8,4),(8,6),(8,7),(8,8),(8,9),(8,10),(8,11),(8,18),(8,20),(8,23),(8,26),(8,29),(8,37),(8,49),(9,1),(9,6),(10,12),(10,77),(11,13),(11,15),(11,16),(11,17),(11,32),(11,43),(11,55),(11,58),(11,64),(12,18),(14,1),(17,26),(20,29),(24,1),(28,23),(28,37),(34,49),(39,69);
/*!40000 ALTER TABLE `UserGroup_has_Permission` ENABLE KEYS */;

--
-- Dumping data for table `ScanParametersService`
--

/*!40000 ALTER TABLE `ScanParametersService` DISABLE KEYS */;
INSERT INTO `ScanParametersService` (`scanParametersServiceId`, `name`, `description`) VALUES (4,'Temperature','Temperature in Celsius'),(7,'Pressure','Pressure in pascal (Pa)');
/*!40000 ALTER TABLE `ScanParametersService` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-07-23 18:38:11
