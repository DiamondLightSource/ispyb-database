
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `AdminActivity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AdminActivity` (
  `adminActivityId` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL DEFAULT '',
  `action` varchar(45) DEFAULT NULL,
  `comments` varchar(100) DEFAULT NULL,
  `dateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`adminActivityId`),
  UNIQUE KEY `username` (`username`),
  KEY `AdminActivity_FKAction` (`action`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `AdminVar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AdminVar` (
  `varId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  `value` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`varId`),
  KEY `AdminVar_FKIndexName` (`name`),
  KEY `AdminVar_FKIndexValue` (`value`(767))
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='ISPyB administration values';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Aperture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Aperture` (
  `apertureId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sizeX` float DEFAULT NULL,
  PRIMARY KEY (`apertureId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `AutoProc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AutoProc` (
  `autoProcId` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key (auto-incremented)',
  `autoProcProgramId` int(10) unsigned DEFAULT NULL COMMENT 'Related program item',
  `spaceGroup` varchar(45) DEFAULT NULL COMMENT 'Space group',
  `refinedCell_a` float DEFAULT NULL COMMENT 'Refined cell',
  `refinedCell_b` float DEFAULT NULL COMMENT 'Refined cell',
  `refinedCell_c` float DEFAULT NULL COMMENT 'Refined cell',
  `refinedCell_alpha` float DEFAULT NULL COMMENT 'Refined cell',
  `refinedCell_beta` float DEFAULT NULL COMMENT 'Refined cell',
  `refinedCell_gamma` float DEFAULT NULL COMMENT 'Refined cell',
  `recordTimeStamp` datetime DEFAULT NULL COMMENT 'Creation or last update date/time',
  PRIMARY KEY (`autoProcId`),
  KEY `AutoProc_FKIndex1` (`autoProcProgramId`),
  KEY `AutoProc_refined_unit_cell` (`refinedCell_a`,`refinedCell_b`,`refinedCell_c`,`refinedCell_alpha`,`refinedCell_beta`,`refinedCell_gamma`,`spaceGroup`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `AutoProcIntegration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AutoProcIntegration` (
  `autoProcIntegrationId` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key (auto-incremented)',
  `dataCollectionId` int(11) unsigned NOT NULL COMMENT 'DataCollection item',
  `autoProcProgramId` int(10) unsigned DEFAULT NULL COMMENT 'Related program item',
  `startImageNumber` int(10) unsigned DEFAULT NULL COMMENT 'start image number',
  `endImageNumber` int(10) unsigned DEFAULT NULL COMMENT 'end image number',
  `refinedDetectorDistance` float DEFAULT NULL COMMENT 'Refined DataCollection.detectorDistance',
  `refinedXBeam` float DEFAULT NULL COMMENT 'Refined DataCollection.xBeam',
  `refinedYBeam` float DEFAULT NULL COMMENT 'Refined DataCollection.yBeam',
  `rotationAxisX` float DEFAULT NULL COMMENT 'Rotation axis',
  `rotationAxisY` float DEFAULT NULL COMMENT 'Rotation axis',
  `rotationAxisZ` float DEFAULT NULL COMMENT 'Rotation axis',
  `beamVectorX` float DEFAULT NULL COMMENT 'Beam vector',
  `beamVectorY` float DEFAULT NULL COMMENT 'Beam vector',
  `beamVectorZ` float DEFAULT NULL COMMENT 'Beam vector',
  `cell_a` float DEFAULT NULL COMMENT 'Unit cell',
  `cell_b` float DEFAULT NULL COMMENT 'Unit cell',
  `cell_c` float DEFAULT NULL COMMENT 'Unit cell',
  `cell_alpha` float DEFAULT NULL COMMENT 'Unit cell',
  `cell_beta` float DEFAULT NULL COMMENT 'Unit cell',
  `cell_gamma` float DEFAULT NULL COMMENT 'Unit cell',
  `recordTimeStamp` datetime DEFAULT NULL COMMENT 'Creation or last update date/time',
  `anomalous` tinyint(1) DEFAULT 0 COMMENT 'boolean type:0 noanoum - 1 anoum',
  PRIMARY KEY (`autoProcIntegrationId`),
  KEY `AutoProcIntegrationIdx1` (`dataCollectionId`),
  KEY `AutoProcIntegration_FKIndex1` (`autoProcProgramId`),
  CONSTRAINT `AutoProcIntegration_ibfk_1` FOREIGN KEY (`dataCollectionId`) REFERENCES `DataCollection` (`dataCollectionId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `AutoProcIntegration_ibfk_2` FOREIGN KEY (`autoProcProgramId`) REFERENCES `AutoProcProgram` (`autoProcProgramId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `AutoProcProgram`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AutoProcProgram` (
  `autoProcProgramId` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key (auto-incremented)',
  `processingCommandLine` varchar(255) DEFAULT NULL COMMENT 'Command line for running the automatic processing',
  `processingPrograms` varchar(255) DEFAULT NULL COMMENT 'Processing programs (comma separated)',
  `processingStatus` tinyint(1) DEFAULT NULL COMMENT 'success (1) / fail (0)',
  `processingMessage` varchar(255) DEFAULT NULL COMMENT 'warning, error,...',
  `processingStartTime` datetime DEFAULT NULL COMMENT 'Processing start time',
  `processingEndTime` datetime DEFAULT NULL COMMENT 'Processing end time',
  `processingEnvironment` varchar(255) DEFAULT NULL COMMENT 'Cpus, Nodes,...',
  `recordTimeStamp` datetime DEFAULT NULL COMMENT 'Creation or last update date/time',
  `processingJobId` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`autoProcProgramId`),
  KEY `AutoProcProgram_FK2` (`processingJobId`),
  CONSTRAINT `AutoProcProgram_FK2` FOREIGN KEY (`processingJobId`) REFERENCES `ProcessingJob` (`processingJobId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `AutoProcProgramAttachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AutoProcProgramAttachment` (
  `autoProcProgramAttachmentId` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key (auto-incremented)',
  `autoProcProgramId` int(10) unsigned NOT NULL COMMENT 'Related autoProcProgram item',
  `fileType` enum('Log','Result','Graph','Debug','Input') DEFAULT NULL COMMENT 'Type of file Attachment',
  `fileName` varchar(255) DEFAULT NULL COMMENT 'Attachment filename',
  `filePath` varchar(255) DEFAULT NULL COMMENT 'Attachment filepath to disk storage',
  `recordTimeStamp` datetime DEFAULT NULL COMMENT 'Creation or last update date/time',
  `importanceRank` tinyint(3) unsigned DEFAULT NULL COMMENT 'For the particular autoProcProgramId and fileType, indicate the importance of the attachment. Higher numbers are more important',
  PRIMARY KEY (`autoProcProgramAttachmentId`),
  KEY `AutoProcProgramAttachmentIdx1` (`autoProcProgramId`),
  CONSTRAINT `AutoProcProgramAttachmentFk1` FOREIGN KEY (`autoProcProgramId`) REFERENCES `AutoProcProgram` (`autoProcProgramId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `AutoProcProgramMessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AutoProcProgramMessage` (
  `autoProcProgramMessageId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `autoProcProgramId` int(10) unsigned DEFAULT NULL,
  `recordTimeStamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `severity` enum('ERROR','WARNING','INFO') DEFAULT NULL,
  `message` varchar(200) DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`autoProcProgramMessageId`),
  KEY `AutoProcProgramMessage_fk1` (`autoProcProgramId`),
  CONSTRAINT `AutoProcProgramMessage_fk1` FOREIGN KEY (`autoProcProgramId`) REFERENCES `AutoProcProgram` (`autoProcProgramId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `AutoProcScaling`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AutoProcScaling` (
  `autoProcScalingId` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key (auto-incremented)',
  `autoProcId` int(10) unsigned DEFAULT NULL COMMENT 'Related autoProc item (used by foreign key)',
  `recordTimeStamp` datetime DEFAULT NULL COMMENT 'Creation or last update date/time',
  PRIMARY KEY (`autoProcScalingId`),
  KEY `AutoProcScalingFk1` (`autoProcId`),
  KEY `AutoProcScalingIdx1` (`autoProcScalingId`,`autoProcId`),
  CONSTRAINT `AutoProcScalingFk1` FOREIGN KEY (`autoProcId`) REFERENCES `AutoProc` (`autoProcId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `AutoProcScalingStatistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AutoProcScalingStatistics` (
  `autoProcScalingStatisticsId` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key (auto-incremented)',
  `autoProcScalingId` int(10) unsigned DEFAULT NULL COMMENT 'Related autoProcScaling item (used by foreign key)',
  `scalingStatisticsType` enum('overall','innerShell','outerShell') NOT NULL DEFAULT 'overall' COMMENT 'Scaling statistics type',
  `comments` varchar(255) DEFAULT NULL COMMENT 'Comments...',
  `resolutionLimitLow` float DEFAULT NULL COMMENT 'Low resolution limit',
  `resolutionLimitHigh` float DEFAULT NULL COMMENT 'High resolution limit',
  `rMerge` float DEFAULT NULL COMMENT 'Rmerge',
  `rMeasWithinIPlusIMinus` float DEFAULT NULL COMMENT 'Rmeas (within I+/I-)',
  `rMeasAllIPlusIMinus` float DEFAULT NULL COMMENT 'Rmeas (all I+ & I-)',
  `rPimWithinIPlusIMinus` float DEFAULT NULL COMMENT 'Rpim (within I+/I-) ',
  `rPimAllIPlusIMinus` float DEFAULT NULL COMMENT 'Rpim (all I+ & I-)',
  `fractionalPartialBias` float DEFAULT NULL COMMENT 'Fractional partial bias',
  `nTotalObservations` int(10) DEFAULT NULL COMMENT 'Total number of observations',
  `nTotalUniqueObservations` int(10) DEFAULT NULL COMMENT 'Total number unique',
  `meanIOverSigI` float DEFAULT NULL COMMENT 'Mean((I)/sd(I))',
  `completeness` float DEFAULT NULL COMMENT 'Completeness',
  `multiplicity` float DEFAULT NULL COMMENT 'Multiplicity',
  `anomalousCompleteness` float DEFAULT NULL COMMENT 'Anomalous completeness',
  `anomalousMultiplicity` float DEFAULT NULL COMMENT 'Anomalous multiplicity',
  `recordTimeStamp` datetime DEFAULT NULL COMMENT 'Creation or last update date/time',
  `anomalous` tinyint(1) DEFAULT 0 COMMENT 'boolean type:0 noanoum - 1 anoum',
  `ccHalf` float DEFAULT NULL COMMENT 'information from XDS',
  `ccAnomalous` float DEFAULT NULL,
  `resIOverSigI2` float DEFAULT NULL COMMENT 'Resolution where I/Sigma(I) equals 2',
  PRIMARY KEY (`autoProcScalingStatisticsId`),
  KEY `AutoProcScalingStatistics_FKindexType` (`scalingStatisticsType`),
  KEY `AutoProcScalingStatistics_scalingId_statisticsType` (`autoProcScalingId`,`scalingStatisticsType`),
  CONSTRAINT `_AutoProcScalingStatisticsFk1` FOREIGN KEY (`autoProcScalingId`) REFERENCES `AutoProcScaling` (`autoProcScalingId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `AutoProcScaling_has_Int`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AutoProcScaling_has_Int` (
  `autoProcScaling_has_IntId` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key (auto-incremented)',
  `autoProcScalingId` int(10) unsigned DEFAULT NULL COMMENT 'AutoProcScaling item',
  `autoProcIntegrationId` int(10) unsigned NOT NULL COMMENT 'AutoProcIntegration item',
  `recordTimeStamp` datetime DEFAULT NULL COMMENT 'Creation or last update date/time',
  PRIMARY KEY (`autoProcScaling_has_IntId`),
  KEY `AutoProcScalingHasInt_FKIndex3` (`autoProcScalingId`,`autoProcIntegrationId`),
  KEY `AutoProcScal_has_IntIdx2` (`autoProcIntegrationId`),
  CONSTRAINT `AutoProcScaling_has_IntFk1` FOREIGN KEY (`autoProcScalingId`) REFERENCES `AutoProcScaling` (`autoProcScalingId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `AutoProcScaling_has_IntFk2` FOREIGN KEY (`autoProcIntegrationId`) REFERENCES `AutoProcIntegration` (`autoProcIntegrationId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `AutoProcStatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AutoProcStatus` (
  `autoProcStatusId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key (auto-incremented)',
  `autoProcIntegrationId` int(10) unsigned NOT NULL,
  `step` enum('Indexing','Integration','Correction','Scaling','Importing') NOT NULL COMMENT 'autoprocessing step',
  `status` enum('Launched','Successful','Failed') NOT NULL COMMENT 'autoprocessing status',
  `comments` varchar(1024) DEFAULT NULL COMMENT 'comments',
  `bltimeStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`autoProcStatusId`),
  KEY `AutoProcStatus_FKIndex1` (`autoProcIntegrationId`),
  CONSTRAINT `AutoProcStatus_ibfk_1` FOREIGN KEY (`autoProcIntegrationId`) REFERENCES `AutoProcIntegration` (`autoProcIntegrationId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='AutoProcStatus table is linked to AutoProcIntegration';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BF_automationError`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BF_automationError` (
  `automationErrorId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `errorType` varchar(40) NOT NULL,
  `solution` text DEFAULT NULL,
  PRIMARY KEY (`automationErrorId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BF_automationFault`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BF_automationFault` (
  `automationFaultId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `automationErrorId` int(10) unsigned DEFAULT NULL,
  `containerId` int(10) unsigned DEFAULT NULL,
  `severity` enum('1','2','3') DEFAULT NULL,
  `stacktrace` text DEFAULT NULL,
  `resolved` tinyint(1) DEFAULT NULL,
  `faultTimeStamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`automationFaultId`),
  KEY `BF_automationFault_ibfk1` (`automationErrorId`),
  KEY `BF_automationFault_ibfk2` (`containerId`),
  CONSTRAINT `BF_automationFault_ibfk1` FOREIGN KEY (`automationErrorId`) REFERENCES `BF_automationError` (`automationErrorId`),
  CONSTRAINT `BF_automationFault_ibfk2` FOREIGN KEY (`containerId`) REFERENCES `Container` (`containerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BF_component`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BF_component` (
  `componentId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `systemId` int(10) unsigned DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`componentId`),
  KEY `bf_component_FK1` (`systemId`),
  CONSTRAINT `bf_component_FK1` FOREIGN KEY (`systemId`) REFERENCES `BF_system` (`systemId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BF_component_beamline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BF_component_beamline` (
  `component_beamlineId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `componentId` int(10) unsigned DEFAULT NULL,
  `beamlinename` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`component_beamlineId`),
  KEY `bf_component_beamline_FK1` (`componentId`),
  CONSTRAINT `bf_component_beamline_FK1` FOREIGN KEY (`componentId`) REFERENCES `BF_component` (`componentId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BF_fault`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BF_fault` (
  `faultId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sessionId` int(10) unsigned NOT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `subcomponentId` int(10) unsigned DEFAULT NULL,
  `starttime` datetime DEFAULT NULL,
  `endtime` datetime DEFAULT NULL,
  `beamtimelost` tinyint(1) DEFAULT NULL,
  `beamtimelost_starttime` datetime DEFAULT NULL,
  `beamtimelost_endtime` datetime DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `resolved` tinyint(1) DEFAULT NULL,
  `resolution` text DEFAULT NULL,
  `attachment` varchar(200) DEFAULT NULL,
  `eLogId` int(11) DEFAULT NULL,
  `assignee` varchar(50) DEFAULT NULL,
  `personId` int(10) unsigned DEFAULT NULL,
  `assigneeId` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`faultId`),
  KEY `bf_fault_FK1` (`sessionId`),
  KEY `bf_fault_FK2` (`subcomponentId`),
  KEY `bf_fault_FK3` (`personId`),
  KEY `bf_fault_FK4` (`assigneeId`),
  CONSTRAINT `bf_fault_FK1` FOREIGN KEY (`sessionId`) REFERENCES `BLSession` (`sessionId`),
  CONSTRAINT `bf_fault_FK2` FOREIGN KEY (`subcomponentId`) REFERENCES `BF_subcomponent` (`subcomponentId`),
  CONSTRAINT `bf_fault_FK3` FOREIGN KEY (`personId`) REFERENCES `Person` (`personId`),
  CONSTRAINT `bf_fault_FK4` FOREIGN KEY (`assigneeId`) REFERENCES `Person` (`personId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BF_subcomponent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BF_subcomponent` (
  `subcomponentId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `componentId` int(10) unsigned DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`subcomponentId`),
  KEY `bf_subcomponent_FK1` (`componentId`),
  CONSTRAINT `bf_subcomponent_FK1` FOREIGN KEY (`componentId`) REFERENCES `BF_component` (`componentId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BF_subcomponent_beamline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BF_subcomponent_beamline` (
  `subcomponent_beamlineId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `subcomponentId` int(10) unsigned DEFAULT NULL,
  `beamlinename` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`subcomponent_beamlineId`),
  KEY `bf_subcomponent_beamline_FK1` (`subcomponentId`),
  CONSTRAINT `bf_subcomponent_beamline_FK1` FOREIGN KEY (`subcomponentId`) REFERENCES `BF_subcomponent` (`subcomponentId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BF_system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BF_system` (
  `systemId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`systemId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BF_system_beamline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BF_system_beamline` (
  `system_beamlineId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `systemId` int(10) unsigned DEFAULT NULL,
  `beamlineName` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`system_beamlineId`),
  KEY `bf_system_beamline_FK1` (`systemId`),
  CONSTRAINT `bf_system_beamline_FK1` FOREIGN KEY (`systemId`) REFERENCES `BF_system` (`systemId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BFactorFit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BFactorFit` (
  `bFactorFitId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `particleClassificationId` int(11) unsigned NOT NULL,
  `resolution` float DEFAULT NULL COMMENT 'Resolution of a refined map using a given number of particles',
  `numberOfParticles` int(10) unsigned DEFAULT NULL COMMENT 'Number of particles used in refinement',
  `particleBatchSize` int(10) unsigned DEFAULT NULL COMMENT 'Number of particles in the batch that the B-factor analysis was performed on',
  PRIMARY KEY (`bFactorFitId`),
  KEY `BFactorFit_fk_particleClassificationId` (`particleClassificationId`),
  CONSTRAINT `BFactorFit_fk_particleClassificationId` FOREIGN KEY (`particleClassificationId`) REFERENCES `ParticleClassification` (`particleClassificationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='CryoEM reconstruction resolution as a function of the number of particles for the creation of a Rosenthal-Henderson plot and the calculation of B-factors';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BLSample`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BLSample` (
  `blSampleId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `diffractionPlanId` int(10) unsigned DEFAULT NULL,
  `crystalId` int(10) unsigned DEFAULT NULL,
  `containerId` int(10) unsigned DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `code` varchar(45) DEFAULT NULL,
  `location` varchar(45) DEFAULT NULL,
  `holderLength` double DEFAULT NULL,
  `loopLength` double DEFAULT NULL,
  `loopType` varchar(45) DEFAULT NULL,
  `wireWidth` double DEFAULT NULL,
  `comments` varchar(1024) DEFAULT NULL,
  `completionStage` varchar(45) DEFAULT NULL,
  `structureStage` varchar(45) DEFAULT NULL,
  `publicationStage` varchar(45) DEFAULT NULL,
  `publicationComments` varchar(255) DEFAULT NULL,
  `blSampleStatus` varchar(20) DEFAULT NULL,
  `isInSampleChanger` tinyint(1) DEFAULT NULL,
  `lastKnownCenteringPosition` varchar(255) DEFAULT NULL,
  `POSITIONID` int(11) unsigned DEFAULT NULL,
  `recordTimeStamp` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Creation or last update date/time',
  `SMILES` varchar(400) DEFAULT NULL COMMENT 'the symbolic description of the structure of a chemical compound',
  `blSubSampleId` int(11) unsigned DEFAULT NULL,
  `lastImageURL` varchar(255) DEFAULT NULL,
  `screenComponentGroupId` int(11) unsigned DEFAULT NULL,
  `volume` float DEFAULT NULL,
  `dimension1` double DEFAULT NULL,
  `dimension2` double DEFAULT NULL,
  `dimension3` double DEFAULT NULL,
  `shape` varchar(15) DEFAULT NULL,
  `packingFraction` float DEFAULT NULL,
  `preparationTemeprature` mediumint(9) DEFAULT NULL COMMENT 'Sample preparation temperature, Units: kelvin',
  `preparationHumidity` float DEFAULT NULL COMMENT 'Sample preparation humidity, Units: %',
  `blottingTime` int(11) unsigned DEFAULT NULL COMMENT 'Blotting time, Units: sec',
  `blottingForce` float DEFAULT NULL COMMENT 'Force used when blotting sample, Units: N?',
  `blottingDrainTime` int(11) unsigned DEFAULT NULL COMMENT 'Time sample left to drain after blotting, Units: sec',
  `support` varchar(50) DEFAULT NULL COMMENT 'Sample support material',
  `subLocation` smallint(5) unsigned DEFAULT NULL COMMENT 'Indicates the sample''s location on a multi-sample pin, where 1 is closest to the pin base',
  `staffComments` varchar(255) DEFAULT NULL COMMENT 'Any staff comments on the sample',
  PRIMARY KEY (`blSampleId`),
  KEY `BLSample_FKIndex1` (`containerId`),
  KEY `BLSample_FKIndex3` (`diffractionPlanId`),
  KEY `BLSample_FKIndex_Status` (`blSampleStatus`),
  KEY `BLSample_Index1` (`name`),
  KEY `crystalId` (`crystalId`,`containerId`),
  KEY `BLSampleImage_idx1` (`blSubSampleId`),
  KEY `BLSample_fk5` (`screenComponentGroupId`),
  CONSTRAINT `BLSample_fk5` FOREIGN KEY (`screenComponentGroupId`) REFERENCES `ScreenComponentGroup` (`screenComponentGroupId`),
  CONSTRAINT `BLSample_ibfk4` FOREIGN KEY (`blSubSampleId`) REFERENCES `BLSubSample` (`blSubSampleId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `BLSample_ibfk_1` FOREIGN KEY (`containerId`) REFERENCES `Container` (`containerId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `BLSample_ibfk_2` FOREIGN KEY (`crystalId`) REFERENCES `Crystal` (`crystalId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `BLSample_ibfk_3` FOREIGN KEY (`diffractionPlanId`) REFERENCES `DiffractionPlan` (`diffractionPlanId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BLSampleGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BLSampleGroup` (
  `blSampleGroupId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL COMMENT 'Human-readable name',
  `proposalId` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`blSampleGroupId`),
  KEY `BLSampleGroup_fk_proposalId` (`proposalId`),
  CONSTRAINT `BLSampleGroup_fk_proposalId` FOREIGN KEY (`proposalId`) REFERENCES `Proposal` (`proposalId`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BLSampleGroup_has_BLSample`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BLSampleGroup_has_BLSample` (
  `blSampleGroupId` int(11) unsigned NOT NULL,
  `blSampleId` int(11) unsigned NOT NULL,
  `groupOrder` mediumint(9) DEFAULT NULL,
  `type` enum('background','container','sample','calibrant','capillary') DEFAULT NULL,
  `blSampleTypeId` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`blSampleGroupId`,`blSampleId`),
  KEY `BLSampleGroup_has_BLSample_ibfk2` (`blSampleId`),
  KEY `BLSampleGroup_has_BLSample_ibfk3` (`blSampleTypeId`),
  CONSTRAINT `BLSampleGroup_has_BLSample_ibfk1` FOREIGN KEY (`blSampleGroupId`) REFERENCES `BLSampleGroup` (`blSampleGroupId`),
  CONSTRAINT `BLSampleGroup_has_BLSample_ibfk2` FOREIGN KEY (`blSampleId`) REFERENCES `BLSample` (`blSampleId`),
  CONSTRAINT `BLSampleGroup_has_BLSample_ibfk3` FOREIGN KEY (`blSampleTypeId`) REFERENCES `BLSampleType` (`blSampleTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BLSampleImage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BLSampleImage` (
  `blSampleImageId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `blSampleId` int(11) unsigned NOT NULL,
  `micronsPerPixelX` float DEFAULT NULL,
  `micronsPerPixelY` float DEFAULT NULL,
  `imageFullPath` varchar(255) DEFAULT NULL,
  `blSampleImageScoreId` int(11) unsigned DEFAULT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `blTimeStamp` datetime DEFAULT NULL,
  `containerInspectionId` int(11) unsigned DEFAULT NULL,
  `modifiedTimeStamp` datetime DEFAULT NULL,
  `offsetX` int(11) NOT NULL DEFAULT 0 COMMENT 'The x offset of the image relative to the canvas',
  `offsetY` int(11) NOT NULL DEFAULT 0 COMMENT 'The y offset of the image relative to the canvas',
  PRIMARY KEY (`blSampleImageId`),
  UNIQUE KEY `BLSampleImage_imageFullPath` (`imageFullPath`),
  KEY `BLSampleImage_idx1` (`blSampleId`),
  KEY `BLSampleImage_fk2` (`containerInspectionId`),
  KEY `BLSampleImage_fk3` (`blSampleImageScoreId`),
  CONSTRAINT `BLSampleImage_fk1` FOREIGN KEY (`blSampleId`) REFERENCES `BLSample` (`blSampleId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `BLSampleImage_fk2` FOREIGN KEY (`containerInspectionId`) REFERENCES `ContainerInspection` (`containerInspectionId`),
  CONSTRAINT `BLSampleImage_fk3` FOREIGN KEY (`blSampleImageScoreId`) REFERENCES `BLSampleImageScore` (`blSampleImageScoreId`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BLSampleImageAnalysis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BLSampleImageAnalysis` (
  `blSampleImageAnalysisId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `blSampleImageId` int(11) unsigned DEFAULT NULL,
  `oavSnapshotBefore` varchar(255) DEFAULT NULL,
  `oavSnapshotAfter` varchar(255) DEFAULT NULL,
  `deltaX` int(11) DEFAULT NULL,
  `deltaY` int(11) DEFAULT NULL,
  `goodnessOfFit` float DEFAULT NULL,
  `scaleFactor` float DEFAULT NULL,
  `resultCode` varchar(15) DEFAULT NULL,
  `matchStartTimeStamp` timestamp NULL DEFAULT current_timestamp(),
  `matchEndTimeStamp` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`blSampleImageAnalysisId`),
  KEY `BLSampleImageAnalysis_ibfk1` (`blSampleImageId`),
  CONSTRAINT `BLSampleImageAnalysis_ibfk1` FOREIGN KEY (`blSampleImageId`) REFERENCES `BLSampleImage` (`blSampleImageId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BLSampleImageAutoScoreClass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BLSampleImageAutoScoreClass` (
  `blSampleImageAutoScoreClassId` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `blSampleImageAutoScoreSchemaId` tinyint(3) unsigned DEFAULT NULL,
  `scoreClass` varchar(15) NOT NULL COMMENT 'Thing being scored e.g. crystal, precipitant',
  PRIMARY KEY (`blSampleImageAutoScoreClassId`),
  KEY `BLSampleImageAutoScoreClass_fk1` (`blSampleImageAutoScoreSchemaId`),
  CONSTRAINT `BLSampleImageAutoScoreClass_fk1` FOREIGN KEY (`blSampleImageAutoScoreSchemaId`) REFERENCES `BLSampleImageAutoScoreSchema` (`blSampleImageAutoScoreSchemaId`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='The automated scoring classes - the thing being scored';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BLSampleImageAutoScoreSchema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BLSampleImageAutoScoreSchema` (
  `blSampleImageAutoScoreSchemaId` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `schemaName` varchar(25) NOT NULL COMMENT 'Name of the schema e.g. Hampton, MARCO',
  `enabled` tinyint(1) DEFAULT 1 COMMENT 'Whether this schema is enabled (could be configurable in the UI)',
  PRIMARY KEY (`blSampleImageAutoScoreSchemaId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='Scoring schema name and whether it is enabled';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BLSampleImageMeasurement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BLSampleImageMeasurement` (
  `blSampleImageMeasurementId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `blSampleImageId` int(11) unsigned NOT NULL,
  `blSubSampleId` int(11) unsigned DEFAULT NULL,
  `startPosX` double DEFAULT NULL,
  `startPosY` double DEFAULT NULL,
  `endPosX` double DEFAULT NULL,
  `endPosY` double DEFAULT NULL,
  `blTimeStamp` datetime DEFAULT NULL,
  PRIMARY KEY (`blSampleImageMeasurementId`),
  KEY `BLSampleImageMeasurement_ibfk_1` (`blSampleImageId`),
  KEY `BLSampleImageMeasurement_ibfk_2` (`blSubSampleId`),
  CONSTRAINT `BLSampleImageMeasurement_ibfk_1` FOREIGN KEY (`blSampleImageId`) REFERENCES `BLSampleImage` (`blSampleImageId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `BLSampleImageMeasurement_ibfk_2` FOREIGN KEY (`blSubSampleId`) REFERENCES `BLSubSample` (`blSubSampleId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='For measuring crystal growth over time';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BLSampleImageScore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BLSampleImageScore` (
  `blSampleImageScoreId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `score` float DEFAULT NULL,
  `colour` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`blSampleImageScoreId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BLSampleImage_has_AutoScoreClass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BLSampleImage_has_AutoScoreClass` (
  `blSampleImageId` int(11) unsigned NOT NULL,
  `blSampleImageAutoScoreClassId` tinyint(3) unsigned NOT NULL,
  `probability` float DEFAULT NULL,
  PRIMARY KEY (`blSampleImageId`,`blSampleImageAutoScoreClassId`),
  KEY `BLSampleImage_has_AutoScoreClass_fk2` (`blSampleImageAutoScoreClassId`),
  CONSTRAINT `BLSampleImage_has_AutoScoreClass_fk1` FOREIGN KEY (`blSampleImageId`) REFERENCES `BLSampleImage` (`blSampleImageId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `BLSampleImage_has_AutoScoreClass_fk2` FOREIGN KEY (`blSampleImageAutoScoreClassId`) REFERENCES `BLSampleImageAutoScoreClass` (`blSampleImageAutoScoreClassId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='Many-to-many relationship between drop images and thing being scored, as well as the actual probability (score) that the drop image contains that thing';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BLSampleImage_has_Positioner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BLSampleImage_has_Positioner` (
  `blSampleImageHasPositionerId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `blSampleImageId` int(10) unsigned NOT NULL,
  `positionerId` int(10) unsigned NOT NULL,
  `value` float DEFAULT NULL COMMENT 'The position of this positioner for this blsampleimage',
  PRIMARY KEY (`blSampleImageHasPositionerId`),
  KEY `BLSampleImageHasPositioner_ibfk1` (`blSampleImageId`),
  KEY `BLSampleImageHasPositioner_ibfk2` (`positionerId`),
  CONSTRAINT `BLSampleImageHasPositioner_ibfk1` FOREIGN KEY (`blSampleImageId`) REFERENCES `BLSampleImage` (`blSampleImageId`),
  CONSTRAINT `BLSampleImageHasPositioner_ibfk2` FOREIGN KEY (`positionerId`) REFERENCES `Positioner` (`positionerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Allows a BLSampleImage to store motor positions along with the image';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BLSampleType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BLSampleType` (
  `blSampleTypeId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `proposalType` varchar(10) DEFAULT NULL,
  `active` tinyint(1) DEFAULT 1 COMMENT '1=active, 0=inactive',
  PRIMARY KEY (`blSampleTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BLSampleType_has_Component`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BLSampleType_has_Component` (
  `blSampleTypeId` int(10) unsigned NOT NULL,
  `componentId` int(10) unsigned NOT NULL,
  `abundance` float DEFAULT NULL,
  PRIMARY KEY (`blSampleTypeId`,`componentId`),
  KEY `blSampleType_has_Component_fk2` (`componentId`),
  CONSTRAINT `blSampleType_has_Component_fk1` FOREIGN KEY (`blSampleTypeId`) REFERENCES `Crystal` (`crystalId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `blSampleType_has_Component_fk2` FOREIGN KEY (`componentId`) REFERENCES `Protein` (`proteinId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BLSample_has_DataCollectionPlan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BLSample_has_DataCollectionPlan` (
  `blSampleId` int(11) unsigned NOT NULL,
  `dataCollectionPlanId` int(11) unsigned NOT NULL,
  `planOrder` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`blSampleId`,`dataCollectionPlanId`),
  KEY `BLSample_has_DataCollectionPlan_ibfk2` (`dataCollectionPlanId`),
  CONSTRAINT `BLSample_has_DataCollectionPlan_ibfk1` FOREIGN KEY (`blSampleId`) REFERENCES `BLSample` (`blSampleId`),
  CONSTRAINT `BLSample_has_DataCollectionPlan_ibfk2` FOREIGN KEY (`dataCollectionPlanId`) REFERENCES `DiffractionPlan` (`diffractionPlanId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BLSample_has_EnergyScan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BLSample_has_EnergyScan` (
  `blSampleId` int(10) unsigned NOT NULL DEFAULT 0,
  `energyScanId` int(10) unsigned NOT NULL DEFAULT 0,
  `blSampleHasEnergyScanId` int(10) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`blSampleHasEnergyScanId`),
  KEY `BLSample_has_EnergyScan_FKIndex1` (`blSampleId`),
  KEY `BLSample_has_EnergyScan_FKIndex2` (`energyScanId`),
  CONSTRAINT `BLSample_has_EnergyScan_ibfk_1` FOREIGN KEY (`blSampleId`) REFERENCES `BLSample` (`blSampleId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `BLSample_has_EnergyScan_ibfk_2` FOREIGN KEY (`energyScanId`) REFERENCES `EnergyScan` (`energyScanId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BLSample_has_Positioner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BLSample_has_Positioner` (
  `blSampleHasPositioner` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `blSampleId` int(10) unsigned NOT NULL,
  `positionerId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`blSampleHasPositioner`),
  KEY `BLSampleHasPositioner_ibfk1` (`blSampleId`),
  KEY `BLSampleHasPositioner_ibfk2` (`positionerId`),
  CONSTRAINT `BLSampleHasPositioner_ibfk1` FOREIGN KEY (`blSampleId`) REFERENCES `BLSample` (`blSampleId`),
  CONSTRAINT `BLSampleHasPositioner_ibfk2` FOREIGN KEY (`positionerId`) REFERENCES `Positioner` (`positionerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BLSession`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BLSession` (
  `sessionId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `beamLineSetupId` int(10) unsigned DEFAULT NULL,
  `proposalId` int(10) unsigned NOT NULL DEFAULT 0,
  `beamCalendarId` int(10) unsigned DEFAULT NULL,
  `startDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `beamLineName` varchar(45) DEFAULT NULL,
  `scheduled` tinyint(1) DEFAULT NULL,
  `nbShifts` int(10) unsigned DEFAULT NULL,
  `comments` varchar(2000) DEFAULT NULL,
  `beamLineOperator` varchar(255) DEFAULT NULL,
  `bltimeStamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `visit_number` int(10) unsigned DEFAULT 0,
  `usedFlag` tinyint(1) DEFAULT NULL COMMENT 'indicates if session has Datacollections or XFE or EnergyScans attached',
  `lastUpdate` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'last update timestamp: by default the end of the session, the last collect...',
  `externalId` binary(16) DEFAULT NULL,
  `archived` tinyint(1) DEFAULT 0 COMMENT 'The data for the session is archived and no longer available on disk',
  `riskRating` enum('Low','Medium','High','Not Permitted') DEFAULT NULL COMMENT 'ERA in user admin system',
  PRIMARY KEY (`sessionId`),
  UNIQUE KEY `proposalId` (`proposalId`,`visit_number`),
  KEY `Session_FKIndex2` (`beamLineSetupId`),
  KEY `Session_FKIndexBeamLineName` (`beamLineName`),
  KEY `Session_FKIndexEndDate` (`endDate`),
  KEY `Session_FKIndexStartDate` (`startDate`),
  KEY `BLSession_fk_beamCalendarId` (`beamCalendarId`),
  CONSTRAINT `BLSession_fk_beamCalendarId` FOREIGN KEY (`beamCalendarId`) REFERENCES `BeamCalendar` (`beamCalendarId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `BLSession_ibfk_1` FOREIGN KEY (`proposalId`) REFERENCES `Proposal` (`proposalId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `BLSession_ibfk_2` FOREIGN KEY (`beamLineSetupId`) REFERENCES `BeamLineSetup` (`beamLineSetupId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BLSession_has_SCPosition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BLSession_has_SCPosition` (
  `blsessionhasscpositionid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `blsessionid` int(11) unsigned NOT NULL,
  `scContainer` smallint(5) unsigned DEFAULT NULL COMMENT 'Position of container within sample changer',
  `containerPosition` smallint(5) unsigned DEFAULT NULL COMMENT 'Position of sample within container',
  PRIMARY KEY (`blsessionhasscpositionid`),
  KEY `blsession_has_scposition_FK1` (`blsessionid`),
  CONSTRAINT `blsession_has_scposition_FK1` FOREIGN KEY (`blsessionid`) REFERENCES `BLSession` (`sessionId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BLSubSample`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BLSubSample` (
  `blSubSampleId` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key (auto-incremented)',
  `blSampleId` int(10) unsigned NOT NULL COMMENT 'sample',
  `diffractionPlanId` int(10) unsigned DEFAULT NULL COMMENT 'eventually diffractionPlan',
  `blSampleImageId` int(11) unsigned DEFAULT NULL,
  `positionId` int(11) unsigned DEFAULT NULL COMMENT 'position of the subsample',
  `position2Id` int(11) unsigned DEFAULT NULL,
  `motorPositionId` int(11) unsigned DEFAULT NULL COMMENT 'motor position',
  `blSubSampleUUID` varchar(45) DEFAULT NULL COMMENT 'uuid of the blsubsample',
  `imgFileName` varchar(255) DEFAULT NULL COMMENT 'image filename',
  `imgFilePath` varchar(1024) DEFAULT NULL COMMENT 'url image',
  `comments` varchar(1024) DEFAULT NULL COMMENT 'comments',
  `recordTimeStamp` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Creation or last update date/time',
  `source` enum('manual','auto') DEFAULT 'manual',
  `type` varchar(10) DEFAULT NULL COMMENT 'The type of subsample, i.e. roi (region), poi (point), loi (line)',
  PRIMARY KEY (`blSubSampleId`),
  KEY `BLSubSample_FKIndex1` (`blSampleId`),
  KEY `BLSubSample_FKIndex2` (`diffractionPlanId`),
  KEY `BLSubSample_FKIndex3` (`positionId`),
  KEY `BLSubSample_FKIndex4` (`motorPositionId`),
  KEY `BLSubSample_FKIndex5` (`position2Id`),
  KEY `BLSubSample_blSampleImagefk_1` (`blSampleImageId`),
  CONSTRAINT `BLSubSample_blSampleImagefk_1` FOREIGN KEY (`blSampleImageId`) REFERENCES `BLSampleImage` (`blSampleImageId`),
  CONSTRAINT `BLSubSample_blSamplefk_1` FOREIGN KEY (`blSampleId`) REFERENCES `BLSample` (`blSampleId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `BLSubSample_diffractionPlanfk_1` FOREIGN KEY (`diffractionPlanId`) REFERENCES `DiffractionPlan` (`diffractionPlanId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `BLSubSample_motorPositionfk_1` FOREIGN KEY (`motorPositionId`) REFERENCES `MotorPosition` (`motorPositionId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `BLSubSample_positionfk_1` FOREIGN KEY (`positionId`) REFERENCES `Position` (`positionId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `BLSubSample_positionfk_2` FOREIGN KEY (`position2Id`) REFERENCES `Position` (`positionId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BLSubSample_has_Positioner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BLSubSample_has_Positioner` (
  `blSubSampleHasPositioner` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `blSubSampleId` int(10) unsigned NOT NULL,
  `positionerId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`blSubSampleHasPositioner`),
  KEY `BLSubSampleHasPositioner_ibfk1` (`blSubSampleId`),
  KEY `BLSubSampleHasPositioner_ibfk2` (`positionerId`),
  CONSTRAINT `BLSubSampleHasPositioner_ibfk1` FOREIGN KEY (`blSubSampleId`) REFERENCES `BLSubSample` (`blSubSampleId`),
  CONSTRAINT `BLSubSampleHasPositioner_ibfk2` FOREIGN KEY (`positionerId`) REFERENCES `Positioner` (`positionerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BeamApertures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BeamApertures` (
  `beamAperturesid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `beamlineStatsId` int(11) unsigned DEFAULT NULL,
  `flux` double DEFAULT NULL,
  `x` float DEFAULT NULL,
  `y` float DEFAULT NULL,
  `apertureSize` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`beamAperturesid`),
  KEY `beamapertures_FK1` (`beamlineStatsId`),
  CONSTRAINT `beamapertures_FK1` FOREIGN KEY (`beamlineStatsId`) REFERENCES `BeamlineStats` (`beamlineStatsId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BeamCalendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BeamCalendar` (
  `beamCalendarId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `run` varchar(7) NOT NULL,
  `beamStatus` varchar(24) NOT NULL,
  `startDate` datetime NOT NULL,
  `endDate` datetime NOT NULL,
  PRIMARY KEY (`beamCalendarId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BeamCentres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BeamCentres` (
  `beamCentresid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `beamlineStatsId` int(11) unsigned DEFAULT NULL,
  `x` float DEFAULT NULL,
  `y` float DEFAULT NULL,
  `zoom` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`beamCentresid`),
  KEY `beamCentres_FK1` (`beamlineStatsId`),
  CONSTRAINT `beamCentres_FK1` FOREIGN KEY (`beamlineStatsId`) REFERENCES `BeamlineStats` (`beamlineStatsId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BeamLineSetup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BeamLineSetup` (
  `beamLineSetupId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `detectorId` int(11) DEFAULT NULL,
  `synchrotronMode` varchar(255) DEFAULT NULL,
  `undulatorType1` varchar(45) DEFAULT NULL,
  `undulatorType2` varchar(45) DEFAULT NULL,
  `undulatorType3` varchar(45) DEFAULT NULL,
  `focalSpotSizeAtSample` float DEFAULT NULL,
  `focusingOptic` varchar(255) DEFAULT NULL,
  `beamDivergenceHorizontal` float DEFAULT NULL,
  `beamDivergenceVertical` float DEFAULT NULL,
  `polarisation` float DEFAULT NULL,
  `monochromatorType` varchar(255) DEFAULT NULL,
  `setupDate` datetime DEFAULT NULL,
  `synchrotronName` varchar(255) DEFAULT NULL,
  `maxExpTimePerDataCollection` double DEFAULT NULL,
  `maxExposureTimePerImage` float DEFAULT NULL COMMENT 'unit: seconds',
  `minExposureTimePerImage` double DEFAULT NULL,
  `goniostatMaxOscillationSpeed` double DEFAULT NULL,
  `goniostatMaxOscillationWidth` double DEFAULT NULL COMMENT 'unit: degrees',
  `goniostatMinOscillationWidth` double DEFAULT NULL,
  `maxTransmission` double DEFAULT NULL COMMENT 'unit: percentage',
  `minTransmission` double DEFAULT NULL,
  `recordTimeStamp` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Creation or last update date/time',
  `CS` float DEFAULT NULL COMMENT 'Spherical Aberration, Units: mm?',
  `beamlineName` varchar(50) DEFAULT NULL COMMENT 'Beamline that this setup relates to',
  `beamSizeXMin` float DEFAULT NULL COMMENT 'unit: um',
  `beamSizeXMax` float DEFAULT NULL COMMENT 'unit: um',
  `beamSizeYMin` float DEFAULT NULL COMMENT 'unit: um',
  `beamSizeYMax` float DEFAULT NULL COMMENT 'unit: um',
  `energyMin` float DEFAULT NULL COMMENT 'unit: eV',
  `energyMax` float DEFAULT NULL COMMENT 'unit: eV',
  `omegaMin` float DEFAULT NULL COMMENT 'unit: degrees',
  `omegaMax` float DEFAULT NULL COMMENT 'unit: degrees',
  `kappaMin` float DEFAULT NULL COMMENT 'unit: degrees',
  `kappaMax` float DEFAULT NULL COMMENT 'unit: degrees',
  `phiMin` float DEFAULT NULL COMMENT 'unit: degrees',
  `phiMax` float DEFAULT NULL COMMENT 'unit: degrees',
  `active` tinyint(1) NOT NULL DEFAULT 0,
  `numberOfImagesMax` mediumint(8) unsigned DEFAULT NULL,
  `numberOfImagesMin` mediumint(8) unsigned DEFAULT NULL,
  `boxSizeXMin` double DEFAULT NULL COMMENT 'For gridscans, unit: um',
  `boxSizeXMax` double DEFAULT NULL COMMENT 'For gridscans, unit: um',
  `boxSizeYMin` double DEFAULT NULL COMMENT 'For gridscans, unit: um',
  `boxSizeYMax` double DEFAULT NULL COMMENT 'For gridscans, unit: um',
  `monoBandwidthMin` double DEFAULT NULL COMMENT 'unit: percentage',
  `monoBandwidthMax` double DEFAULT NULL COMMENT 'unit: percentage',
  `preferredDataCentre` varchar(30) DEFAULT NULL COMMENT 'Relevant datacentre to use to process data from this beamline',
  `amplitudeContrast` float DEFAULT NULL COMMENT 'Needed for cryo-ET',
  PRIMARY KEY (`beamLineSetupId`),
  KEY `BeamLineSetup_ibfk_1` (`detectorId`),
  CONSTRAINT `BeamLineSetup_ibfk_1` FOREIGN KEY (`detectorId`) REFERENCES `Detector` (`detectorId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BeamlineAction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BeamlineAction` (
  `beamlineActionId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sessionId` int(11) unsigned DEFAULT NULL,
  `startTimestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `endTimestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `message` varchar(255) DEFAULT NULL,
  `parameter` varchar(50) DEFAULT NULL,
  `value` varchar(30) DEFAULT NULL,
  `loglevel` enum('DEBUG','CRITICAL','INFO') DEFAULT NULL,
  `status` enum('PAUSED','RUNNING','TERMINATED','COMPLETE','ERROR','EPICSFAIL') DEFAULT NULL,
  PRIMARY KEY (`beamlineActionId`),
  KEY `BeamlineAction_ibfk1` (`sessionId`),
  CONSTRAINT `BeamlineAction_ibfk1` FOREIGN KEY (`sessionId`) REFERENCES `BLSession` (`sessionId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `BeamlineStats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BeamlineStats` (
  `beamlineStatsId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `beamline` varchar(10) DEFAULT NULL,
  `recordTimeStamp` datetime DEFAULT NULL,
  `ringCurrent` float DEFAULT NULL,
  `energy` float DEFAULT NULL,
  `gony` float DEFAULT NULL,
  `beamW` float DEFAULT NULL,
  `beamH` float DEFAULT NULL,
  `flux` double DEFAULT NULL,
  `scanFileW` varchar(255) DEFAULT NULL,
  `scanFileH` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`beamlineStatsId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `CTF`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CTF` (
  `ctfId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `motionCorrectionId` int(11) unsigned DEFAULT NULL,
  `autoProcProgramId` int(11) unsigned DEFAULT NULL,
  `boxSizeX` float DEFAULT NULL COMMENT 'Box size in x, Units: pixels',
  `boxSizeY` float DEFAULT NULL COMMENT 'Box size in y, Units: pixels',
  `minResolution` float DEFAULT NULL COMMENT 'Minimum resolution for CTF, Units: A',
  `maxResolution` float DEFAULT NULL COMMENT 'Units: A',
  `minDefocus` float DEFAULT NULL COMMENT 'Units: A',
  `maxDefocus` float DEFAULT NULL COMMENT 'Units: A',
  `defocusStepSize` float DEFAULT NULL COMMENT 'Units: A',
  `astigmatism` float DEFAULT NULL COMMENT 'Units: A',
  `astigmatismAngle` float DEFAULT NULL COMMENT 'Units: deg?',
  `estimatedResolution` float DEFAULT NULL COMMENT 'Units: A',
  `estimatedDefocus` float DEFAULT NULL COMMENT 'Units: A',
  `amplitudeContrast` float DEFAULT NULL COMMENT 'Units: %?',
  `ccValue` float DEFAULT NULL COMMENT 'Correlation value',
  `fftTheoreticalFullPath` varchar(255) DEFAULT NULL COMMENT 'Full path to the jpg image of the simulated FFT',
  `comments` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ctfId`),
  KEY `CTF_ibfk1` (`motionCorrectionId`),
  KEY `CTF_ibfk2` (`autoProcProgramId`),
  CONSTRAINT `CTF_ibfk1` FOREIGN KEY (`motionCorrectionId`) REFERENCES `MotionCorrection` (`motionCorrectionId`),
  CONSTRAINT `CTF_ibfk2` FOREIGN KEY (`autoProcProgramId`) REFERENCES `AutoProcProgram` (`autoProcProgramId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `CalendarHash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CalendarHash` (
  `calendarHashId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ckey` varchar(50) DEFAULT NULL,
  `hash` varchar(128) DEFAULT NULL,
  `beamline` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`calendarHashId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='Lets people get to their calendars without logging in using a private (hash) url';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Component`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Component` (
  `componentId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `componentTypeId` int(11) unsigned NOT NULL,
  `proposalId` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `composition` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`componentId`),
  KEY `componentTypeId` (`componentTypeId`),
  KEY `proposalId` (`proposalId`),
  CONSTRAINT `Component_ibfk_1` FOREIGN KEY (`componentTypeId`) REFERENCES `ComponentType` (`componentTypeId`),
  CONSTRAINT `Component_ibfk_2` FOREIGN KEY (`proposalId`) REFERENCES `Proposal` (`proposalId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Description of a component that can be used inside a crystal or a sample.';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ComponentLattice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ComponentLattice` (
  `componentLatticeId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `componentId` int(10) unsigned DEFAULT NULL,
  `spaceGroup` varchar(20) DEFAULT NULL,
  `cell_a` double DEFAULT NULL,
  `cell_b` double DEFAULT NULL,
  `cell_c` double DEFAULT NULL,
  `cell_alpha` double DEFAULT NULL,
  `cell_beta` double DEFAULT NULL,
  `cell_gamma` double DEFAULT NULL,
  PRIMARY KEY (`componentLatticeId`),
  KEY `ComponentLattice_ibfk1` (`componentId`),
  CONSTRAINT `ComponentLattice_ibfk1` FOREIGN KEY (`componentId`) REFERENCES `Protein` (`proteinId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ComponentSubType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ComponentSubType` (
  `componentSubTypeId` int(11) unsigned NOT NULL,
  `name` varchar(31) NOT NULL,
  `hasPh` tinyint(1) DEFAULT 0,
  `proposalType` varchar(10) DEFAULT NULL,
  `active` tinyint(1) DEFAULT 1 COMMENT '1=active, 0=inactive',
  PRIMARY KEY (`componentSubTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ComponentType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ComponentType` (
  `componentTypeId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(31) NOT NULL,
  PRIMARY KEY (`componentTypeId`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Component_has_SubType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Component_has_SubType` (
  `componentId` int(10) unsigned NOT NULL,
  `componentSubTypeId` int(11) unsigned NOT NULL,
  PRIMARY KEY (`componentId`,`componentSubTypeId`),
  KEY `component_has_SubType_fk2` (`componentSubTypeId`),
  CONSTRAINT `component_has_SubType_fk1` FOREIGN KEY (`componentId`) REFERENCES `Protein` (`proteinId`) ON DELETE CASCADE,
  CONSTRAINT `component_has_SubType_fk2` FOREIGN KEY (`componentSubTypeId`) REFERENCES `ComponentSubType` (`componentSubTypeId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ConcentrationType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ConcentrationType` (
  `concentrationTypeId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(31) NOT NULL,
  `symbol` varchar(8) NOT NULL,
  `proposalType` varchar(10) DEFAULT NULL,
  `active` tinyint(1) DEFAULT 1 COMMENT '1=active, 0=inactive',
  PRIMARY KEY (`concentrationTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Container`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Container` (
  `containerId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dewarId` int(10) unsigned DEFAULT NULL,
  `code` varchar(45) DEFAULT NULL,
  `containerType` varchar(20) DEFAULT NULL,
  `capacity` int(10) unsigned DEFAULT NULL,
  `sampleChangerLocation` varchar(20) DEFAULT NULL,
  `containerStatus` varchar(45) DEFAULT NULL,
  `bltimeStamp` datetime DEFAULT NULL,
  `beamlineLocation` varchar(20) DEFAULT NULL,
  `screenId` int(11) unsigned DEFAULT NULL,
  `scheduleId` int(11) unsigned DEFAULT NULL,
  `barcode` varchar(45) DEFAULT NULL,
  `imagerId` int(11) unsigned DEFAULT NULL,
  `sessionId` int(10) unsigned DEFAULT NULL,
  `ownerId` int(10) unsigned DEFAULT NULL,
  `requestedImagerId` int(11) unsigned DEFAULT NULL,
  `requestedReturn` tinyint(1) DEFAULT 0 COMMENT 'True for requesting return, False means container will be disposed',
  `comments` varchar(255) DEFAULT NULL,
  `experimentType` varchar(20) DEFAULT NULL,
  `storageTemperature` float DEFAULT NULL COMMENT 'NULL=ambient',
  `containerRegistryId` int(11) unsigned DEFAULT NULL,
  `scLocationUpdated` datetime DEFAULT NULL,
  `priorityPipelineId` int(11) unsigned DEFAULT 6 COMMENT 'Processing pipeline to prioritise, defaults to 6 which is xia2/DIALS',
  `experimentTypeId` int(10) unsigned DEFAULT NULL,
  `containerTypeId` int(10) unsigned DEFAULT NULL,
  `currentDewarId` int(10) unsigned DEFAULT NULL COMMENT 'The dewar with which the container is currently associated',
  `parentContainerId` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`containerId`),
  UNIQUE KEY `Container_UNIndex1` (`barcode`),
  KEY `Container_FKIndex` (`beamlineLocation`),
  KEY `Container_FKIndex1` (`dewarId`),
  KEY `Container_FKIndexStatus` (`containerStatus`),
  KEY `Container_ibfk2` (`screenId`),
  KEY `Container_ibfk3` (`scheduleId`),
  KEY `Container_ibfk4` (`imagerId`),
  KEY `Container_ibfk5` (`ownerId`),
  KEY `Container_ibfk7` (`requestedImagerId`),
  KEY `Container_ibfk8` (`containerRegistryId`),
  KEY `Container_ibfk6` (`sessionId`),
  KEY `Container_ibfk9` (`priorityPipelineId`),
  KEY `Container_fk_experimentTypeId` (`experimentTypeId`),
  KEY `Container_ibfk10` (`containerTypeId`),
  KEY `Container_fk_currentDewarId` (`currentDewarId`),
  KEY `Container_fk_parentContainerId` (`parentContainerId`),
  CONSTRAINT `Container_fk_currentDewarId` FOREIGN KEY (`currentDewarId`) REFERENCES `Dewar` (`dewarId`),
  CONSTRAINT `Container_fk_experimentTypeId` FOREIGN KEY (`experimentTypeId`) REFERENCES `ExperimentType` (`experimentTypeId`),
  CONSTRAINT `Container_fk_parentContainerId` FOREIGN KEY (`parentContainerId`) REFERENCES `Container` (`containerId`),
  CONSTRAINT `Container_ibfk10` FOREIGN KEY (`containerTypeId`) REFERENCES `ContainerType` (`containerTypeId`),
  CONSTRAINT `Container_ibfk2` FOREIGN KEY (`screenId`) REFERENCES `Screen` (`screenId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Container_ibfk3` FOREIGN KEY (`scheduleId`) REFERENCES `Schedule` (`scheduleId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Container_ibfk4` FOREIGN KEY (`imagerId`) REFERENCES `Imager` (`imagerId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Container_ibfk5` FOREIGN KEY (`ownerId`) REFERENCES `Person` (`personId`),
  CONSTRAINT `Container_ibfk6` FOREIGN KEY (`sessionId`) REFERENCES `BLSession` (`sessionId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Container_ibfk7` FOREIGN KEY (`requestedImagerId`) REFERENCES `Imager` (`imagerId`),
  CONSTRAINT `Container_ibfk8` FOREIGN KEY (`containerRegistryId`) REFERENCES `ContainerRegistry` (`containerRegistryId`),
  CONSTRAINT `Container_ibfk9` FOREIGN KEY (`priorityPipelineId`) REFERENCES `ProcessingPipeline` (`processingPipelineId`),
  CONSTRAINT `Container_ibfk_1` FOREIGN KEY (`dewarId`) REFERENCES `Dewar` (`dewarId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ContainerHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ContainerHistory` (
  `containerHistoryId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `containerId` int(10) unsigned DEFAULT NULL,
  `location` varchar(45) DEFAULT NULL,
  `blTimeStamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` varchar(45) DEFAULT NULL,
  `beamlineName` varchar(20) DEFAULT NULL,
  `currentDewarId` int(10) unsigned DEFAULT NULL COMMENT 'The dewar with which the container was associated at the creation of this row',
  PRIMARY KEY (`containerHistoryId`),
  KEY `ContainerHistory_ibfk1` (`containerId`),
  KEY `ContainerHistory_fk_dewarId` (`currentDewarId`),
  CONSTRAINT `ContainerHistory_fk_dewarId` FOREIGN KEY (`currentDewarId`) REFERENCES `Dewar` (`dewarId`),
  CONSTRAINT `ContainerHistory_ibfk1` FOREIGN KEY (`containerId`) REFERENCES `Container` (`containerId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ContainerInspection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ContainerInspection` (
  `containerInspectionId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `containerId` int(11) unsigned NOT NULL,
  `inspectionTypeId` int(11) unsigned NOT NULL,
  `imagerId` int(11) unsigned DEFAULT NULL,
  `temperature` float DEFAULT NULL,
  `blTimeStamp` datetime DEFAULT NULL,
  `scheduleComponentid` int(11) unsigned DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `priority` smallint(6) DEFAULT NULL,
  `manual` tinyint(1) DEFAULT NULL,
  `scheduledTimeStamp` datetime DEFAULT NULL,
  `completedTimeStamp` datetime DEFAULT NULL,
  PRIMARY KEY (`containerInspectionId`),
  KEY `ContainerInspection_idx2` (`inspectionTypeId`),
  KEY `ContainerInspection_idx3` (`imagerId`),
  KEY `ContainerInspection_fk4` (`scheduleComponentid`),
  KEY `ContainerInspection_idx4` (`containerId`,`scheduleComponentid`,`state`,`manual`),
  CONSTRAINT `ContainerInspection_fk1` FOREIGN KEY (`containerId`) REFERENCES `Container` (`containerId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ContainerInspection_fk2` FOREIGN KEY (`inspectionTypeId`) REFERENCES `InspectionType` (`inspectionTypeId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ContainerInspection_fk3` FOREIGN KEY (`imagerId`) REFERENCES `Imager` (`imagerId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ContainerInspection_fk4` FOREIGN KEY (`scheduleComponentid`) REFERENCES `ScheduleComponent` (`scheduleComponentId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ContainerQueue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ContainerQueue` (
  `containerQueueId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `containerId` int(10) unsigned DEFAULT NULL,
  `personId` int(10) unsigned DEFAULT NULL,
  `createdTimeStamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `completedTimeStamp` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`containerQueueId`),
  KEY `ContainerQueue_ibfk1` (`containerId`),
  KEY `ContainerQueue_ibfk2` (`personId`),
  CONSTRAINT `ContainerQueue_ibfk1` FOREIGN KEY (`containerId`) REFERENCES `Container` (`containerId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ContainerQueue_ibfk2` FOREIGN KEY (`personId`) REFERENCES `Person` (`personId`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ContainerQueueSample`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ContainerQueueSample` (
  `containerQueueSampleId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `containerQueueId` int(11) unsigned DEFAULT NULL,
  `blSubSampleId` int(11) unsigned DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL COMMENT 'The status of the queued item, i.e. skipped, reinspect. Completed / failed should be inferred from related DataCollection',
  `startTime` datetime DEFAULT NULL COMMENT 'Start time of processing the queue item',
  `endTime` datetime DEFAULT NULL COMMENT 'End time of processing the queue item',
  `dataCollectionPlanId` int(10) unsigned DEFAULT NULL,
  `blSampleId` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`containerQueueSampleId`),
  KEY `ContainerQueueSample_ibfk1` (`containerQueueId`),
  KEY `ContainerQueueSample_ibfk2` (`blSubSampleId`),
  KEY `ContainerQueueSample_dataCollectionPlanId` (`dataCollectionPlanId`),
  KEY `ContainerQueueSample_blSampleId` (`blSampleId`),
  CONSTRAINT `ContainerQueueSample_blSampleId` FOREIGN KEY (`blSampleId`) REFERENCES `BLSample` (`blSampleId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ContainerQueueSample_dataCollectionPlanId` FOREIGN KEY (`dataCollectionPlanId`) REFERENCES `DiffractionPlan` (`diffractionPlanId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ContainerQueueSample_ibfk1` FOREIGN KEY (`containerQueueId`) REFERENCES `ContainerQueue` (`containerQueueId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ContainerQueueSample_ibfk2` FOREIGN KEY (`blSubSampleId`) REFERENCES `BLSubSample` (`blSubSampleId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ContainerRegistry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ContainerRegistry` (
  `containerRegistryId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `barcode` varchar(20) NOT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `recordTimestamp` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`containerRegistryId`),
  UNIQUE KEY `ContainerRegistry_uniq_barcode` (`barcode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ContainerRegistry_has_Proposal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ContainerRegistry_has_Proposal` (
  `containerRegistryHasProposalId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `containerRegistryId` int(11) unsigned DEFAULT NULL,
  `proposalId` int(10) unsigned DEFAULT NULL,
  `personId` int(10) unsigned DEFAULT NULL COMMENT 'Person registering the container',
  `recordTimestamp` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`containerRegistryHasProposalId`),
  UNIQUE KEY `containerRegistryId` (`containerRegistryId`,`proposalId`),
  KEY `ContainerRegistry_has_Proposal_ibfk2` (`proposalId`),
  KEY `ContainerRegistry_has_Proposal_ibfk3` (`personId`),
  CONSTRAINT `ContainerRegistry_has_Proposal_ibfk1` FOREIGN KEY (`containerRegistryId`) REFERENCES `ContainerRegistry` (`containerRegistryId`),
  CONSTRAINT `ContainerRegistry_has_Proposal_ibfk2` FOREIGN KEY (`proposalId`) REFERENCES `Proposal` (`proposalId`),
  CONSTRAINT `ContainerRegistry_has_Proposal_ibfk3` FOREIGN KEY (`personId`) REFERENCES `Person` (`personId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ContainerReport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ContainerReport` (
  `containerReportId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `containerRegistryId` int(11) unsigned DEFAULT NULL,
  `personId` int(10) unsigned DEFAULT NULL COMMENT 'Person making report',
  `report` text DEFAULT NULL,
  `attachmentFilePath` varchar(255) DEFAULT NULL,
  `recordTimestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`containerReportId`),
  KEY `ContainerReport_ibfk1` (`containerRegistryId`),
  KEY `ContainerReport_ibfk2` (`personId`),
  CONSTRAINT `ContainerReport_ibfk1` FOREIGN KEY (`containerRegistryId`) REFERENCES `ContainerRegistry` (`containerRegistryId`),
  CONSTRAINT `ContainerReport_ibfk2` FOREIGN KEY (`personId`) REFERENCES `Person` (`personId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ContainerType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ContainerType` (
  `containerTypeId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `proposalType` varchar(10) DEFAULT NULL,
  `active` tinyint(1) DEFAULT 1 COMMENT '1=active, 0=inactive',
  `capacity` int(11) DEFAULT NULL,
  `wellPerRow` smallint(6) DEFAULT NULL,
  `dropPerWellX` smallint(6) DEFAULT NULL,
  `dropPerWellY` smallint(6) DEFAULT NULL,
  `dropHeight` float DEFAULT NULL,
  `dropWidth` float DEFAULT NULL,
  `dropOffsetX` float DEFAULT NULL,
  `dropOffsetY` float DEFAULT NULL,
  `wellDrop` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`containerTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='A lookup table for different types of containers';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `CourierTermsAccepted`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CourierTermsAccepted` (
  `courierTermsAcceptedId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `proposalId` int(10) unsigned NOT NULL,
  `personId` int(10) unsigned NOT NULL,
  `shippingName` varchar(100) DEFAULT NULL,
  `timestamp` datetime DEFAULT current_timestamp(),
  `shippingId` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`courierTermsAcceptedId`),
  KEY `CourierTermsAccepted_ibfk_1` (`proposalId`),
  KEY `CourierTermsAccepted_ibfk_2` (`personId`),
  KEY `CourierTermsAccepted_ibfk_3` (`shippingId`),
  CONSTRAINT `CourierTermsAccepted_ibfk_1` FOREIGN KEY (`proposalId`) REFERENCES `Proposal` (`proposalId`),
  CONSTRAINT `CourierTermsAccepted_ibfk_2` FOREIGN KEY (`personId`) REFERENCES `Person` (`personId`),
  CONSTRAINT `CourierTermsAccepted_ibfk_3` FOREIGN KEY (`shippingId`) REFERENCES `Shipping` (`shippingId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='Records acceptances of the courier T and C';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `CryoemInitialModel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CryoemInitialModel` (
  `cryoemInitialModelId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `resolution` float DEFAULT NULL COMMENT 'Unit: Angstroms',
  `numberOfParticles` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`cryoemInitialModelId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='Initial cryo-EM model generation results';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Crystal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Crystal` (
  `crystalId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `diffractionPlanId` int(10) unsigned DEFAULT NULL,
  `proteinId` int(10) unsigned NOT NULL DEFAULT 0,
  `crystalUUID` varchar(45) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `spaceGroup` varchar(20) DEFAULT NULL,
  `morphology` varchar(255) DEFAULT NULL,
  `color` varchar(45) DEFAULT NULL,
  `size_X` double DEFAULT NULL,
  `size_Y` double DEFAULT NULL,
  `size_Z` double DEFAULT NULL,
  `cell_a` double DEFAULT NULL,
  `cell_b` double DEFAULT NULL,
  `cell_c` double DEFAULT NULL,
  `cell_alpha` double DEFAULT NULL,
  `cell_beta` double DEFAULT NULL,
  `cell_gamma` double DEFAULT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `pdbFileName` varchar(255) DEFAULT NULL COMMENT 'pdb file name',
  `pdbFilePath` varchar(1024) DEFAULT NULL COMMENT 'pdb file path',
  `recordTimeStamp` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Creation or last update date/time',
  `abundance` float DEFAULT NULL,
  `theoreticalDensity` float DEFAULT NULL,
  PRIMARY KEY (`crystalId`),
  KEY `Crystal_FKIndex1` (`proteinId`),
  KEY `Crystal_FKIndex2` (`diffractionPlanId`),
  CONSTRAINT `Crystal_ibfk_1` FOREIGN KEY (`proteinId`) REFERENCES `Protein` (`proteinId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Crystal_ibfk_2` FOREIGN KEY (`diffractionPlanId`) REFERENCES `DiffractionPlan` (`diffractionPlanId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `CrystalComposition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CrystalComposition` (
  `crystalCompositionId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `componentId` int(11) unsigned NOT NULL,
  `crystalId` int(11) unsigned NOT NULL,
  `concentrationTypeId` int(10) unsigned DEFAULT NULL,
  `abundance` float DEFAULT NULL COMMENT 'Abundance or concentration in the unit defined by concentrationTypeId.',
  `ratio` float DEFAULT NULL,
  `pH` float DEFAULT NULL,
  PRIMARY KEY (`crystalCompositionId`),
  KEY `componentId` (`componentId`),
  KEY `crystalId` (`crystalId`),
  KEY `concentrationTypeId` (`concentrationTypeId`),
  CONSTRAINT `CrystalComposition_ibfk_1` FOREIGN KEY (`componentId`) REFERENCES `Component` (`componentId`),
  CONSTRAINT `CrystalComposition_ibfk_2` FOREIGN KEY (`crystalId`) REFERENCES `Crystal` (`crystalId`),
  CONSTRAINT `CrystalComposition_ibfk_3` FOREIGN KEY (`concentrationTypeId`) REFERENCES `ConcentrationType` (`concentrationTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Links a crystal to its components with a specified abundance or ratio.';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Crystal_has_UUID`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Crystal_has_UUID` (
  `crystal_has_UUID_Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `crystalId` int(10) unsigned NOT NULL,
  `UUID` varchar(45) DEFAULT NULL,
  `imageURL` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`crystal_has_UUID_Id`),
  KEY `Crystal_has_UUID_FKIndex1` (`crystalId`),
  KEY `Crystal_has_UUID_FKIndex2` (`UUID`),
  CONSTRAINT `ibfk_1` FOREIGN KEY (`crystalId`) REFERENCES `Crystal` (`crystalId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `DataAcquisition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DataAcquisition` (
  `dataAcquisitionId` int(10) NOT NULL AUTO_INCREMENT,
  `sampleCellId` int(10) NOT NULL,
  `framesCount` varchar(45) DEFAULT NULL,
  `energy` varchar(45) DEFAULT NULL,
  `waitTime` varchar(45) DEFAULT NULL,
  `detectorDistance` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`dataAcquisitionId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `DataCollection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DataCollection` (
  `dataCollectionId` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key (auto-incremented)',
  `BLSAMPLEID` int(11) unsigned DEFAULT NULL,
  `SESSIONID` int(11) unsigned DEFAULT 0,
  `experimenttype` varchar(24) DEFAULT NULL,
  `dataCollectionNumber` int(10) unsigned DEFAULT NULL,
  `startTime` datetime DEFAULT NULL COMMENT 'Start time of the dataCollection',
  `endTime` datetime DEFAULT NULL COMMENT 'end time of the dataCollection',
  `runStatus` varchar(45) DEFAULT NULL,
  `axisStart` float DEFAULT NULL,
  `axisEnd` float DEFAULT NULL,
  `axisRange` float DEFAULT NULL,
  `overlap` float DEFAULT NULL,
  `numberOfImages` int(10) unsigned DEFAULT NULL,
  `startImageNumber` int(10) unsigned DEFAULT NULL,
  `numberOfPasses` int(10) unsigned DEFAULT NULL,
  `exposureTime` float DEFAULT NULL,
  `imageDirectory` varchar(255) DEFAULT NULL COMMENT 'The directory where files reside - should end with a slash',
  `imagePrefix` varchar(45) DEFAULT NULL,
  `imageSuffix` varchar(45) DEFAULT NULL,
  `imageContainerSubPath` varchar(255) DEFAULT NULL COMMENT 'Internal path of a HDF5 file pointing to the data for this data collection',
  `fileTemplate` varchar(255) DEFAULT NULL,
  `wavelength` float DEFAULT NULL,
  `resolution` float DEFAULT NULL,
  `detectorDistance` float DEFAULT NULL,
  `xBeam` float DEFAULT NULL,
  `yBeam` float DEFAULT NULL,
  `comments` varchar(1024) DEFAULT NULL,
  `printableForReport` tinyint(1) unsigned DEFAULT 1,
  `CRYSTALCLASS` varchar(20) DEFAULT NULL,
  `slitGapVertical` float DEFAULT NULL,
  `slitGapHorizontal` float DEFAULT NULL,
  `transmission` float DEFAULT NULL,
  `synchrotronMode` varchar(20) DEFAULT NULL,
  `xtalSnapshotFullPath1` varchar(255) DEFAULT NULL,
  `xtalSnapshotFullPath2` varchar(255) DEFAULT NULL,
  `xtalSnapshotFullPath3` varchar(255) DEFAULT NULL,
  `xtalSnapshotFullPath4` varchar(255) DEFAULT NULL,
  `rotationAxis` enum('Omega','Kappa','Phi') DEFAULT NULL,
  `phiStart` float DEFAULT NULL,
  `kappaStart` float DEFAULT NULL,
  `omegaStart` float DEFAULT NULL,
  `chiStart` float DEFAULT NULL,
  `resolutionAtCorner` float DEFAULT NULL,
  `detector2Theta` float DEFAULT NULL,
  `DETECTORMODE` varchar(255) DEFAULT NULL,
  `undulatorGap1` float DEFAULT NULL,
  `undulatorGap2` float DEFAULT NULL,
  `undulatorGap3` float DEFAULT NULL,
  `beamSizeAtSampleX` float DEFAULT NULL,
  `beamSizeAtSampleY` float DEFAULT NULL,
  `centeringMethod` varchar(255) DEFAULT NULL,
  `averageTemperature` float DEFAULT NULL,
  `ACTUALSAMPLEBARCODE` varchar(45) DEFAULT NULL,
  `ACTUALSAMPLESLOTINCONTAINER` int(11) unsigned DEFAULT NULL,
  `ACTUALCONTAINERBARCODE` varchar(45) DEFAULT NULL,
  `ACTUALCONTAINERSLOTINSC` int(11) unsigned DEFAULT NULL,
  `actualCenteringPosition` varchar(255) DEFAULT NULL,
  `beamShape` varchar(45) DEFAULT NULL,
  `dataCollectionGroupId` int(11) NOT NULL COMMENT 'references DataCollectionGroup table',
  `POSITIONID` int(11) unsigned DEFAULT NULL,
  `detectorId` int(11) DEFAULT NULL COMMENT 'references Detector table',
  `FOCALSPOTSIZEATSAMPLEX` float DEFAULT NULL,
  `POLARISATION` float DEFAULT NULL,
  `FOCALSPOTSIZEATSAMPLEY` float DEFAULT NULL,
  `APERTUREID` int(11) unsigned DEFAULT NULL,
  `screeningOrigId` int(11) unsigned DEFAULT NULL,
  `startPositionId` int(11) unsigned DEFAULT NULL,
  `endPositionId` int(11) unsigned DEFAULT NULL,
  `flux` double DEFAULT NULL,
  `strategySubWedgeOrigId` int(10) unsigned DEFAULT NULL COMMENT 'references ScreeningStrategySubWedge table',
  `blSubSampleId` int(11) unsigned DEFAULT NULL,
  `flux_end` double DEFAULT NULL COMMENT 'flux measured after the collect',
  `bestWilsonPlotPath` varchar(255) DEFAULT NULL,
  `processedDataFile` varchar(255) DEFAULT NULL,
  `datFullPath` varchar(255) DEFAULT NULL,
  `magnification` float unsigned DEFAULT NULL COMMENT 'Calibrated magnification, Units: dimensionless',
  `totalAbsorbedDose` float DEFAULT NULL COMMENT 'Unit: e-/A^2 for EM',
  `binning` tinyint(1) DEFAULT 1 COMMENT '1 or 2. Number of pixels to process as 1. (Use mean value.)',
  `particleDiameter` float DEFAULT NULL COMMENT 'Unit: nm',
  `boxSize_CTF` float DEFAULT NULL COMMENT 'Unit: pixels',
  `minResolution` float DEFAULT NULL COMMENT 'Unit: A',
  `minDefocus` float DEFAULT NULL COMMENT 'Unit: A',
  `maxDefocus` float DEFAULT NULL COMMENT 'Unit: A',
  `defocusStepSize` float DEFAULT NULL COMMENT 'Unit: A',
  `amountAstigmatism` float DEFAULT NULL COMMENT 'Unit: A',
  `extractSize` float DEFAULT NULL COMMENT 'Unit: pixels',
  `bgRadius` float DEFAULT NULL COMMENT 'Unit: nm',
  `voltage` float DEFAULT NULL COMMENT 'Unit: kV',
  `objAperture` float DEFAULT NULL COMMENT 'Unit: um',
  `c1aperture` float DEFAULT NULL COMMENT 'Unit: um',
  `c2aperture` float DEFAULT NULL COMMENT 'Unit: um',
  `c3aperture` float DEFAULT NULL COMMENT 'Unit: um',
  `c1lens` float DEFAULT NULL COMMENT 'Unit: %',
  `c2lens` float DEFAULT NULL COMMENT 'Unit: %',
  `c3lens` float DEFAULT NULL COMMENT 'Unit: %',
  `totalExposedDose` float DEFAULT NULL COMMENT 'Units: e-/A^2',
  `nominalMagnification` float unsigned DEFAULT NULL COMMENT 'Nominal magnification: Units: dimensionless',
  `nominalDefocus` float unsigned DEFAULT NULL COMMENT 'Nominal defocus, Units: A',
  `imageSizeX` mediumint(8) unsigned DEFAULT NULL COMMENT 'Image size in x, incase crop has been used, Units: pixels',
  `imageSizeY` mediumint(8) unsigned DEFAULT NULL COMMENT 'Image size in y, Units: pixels',
  `pixelSizeOnImage` float DEFAULT NULL COMMENT 'Pixel size on image, calculated from magnification, duplicate? Units: um?',
  `phasePlate` tinyint(1) DEFAULT NULL COMMENT 'Whether the phase plate was used',
  `dataCollectionPlanId` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`dataCollectionId`),
  KEY `blSubSampleId` (`blSubSampleId`),
  KEY `DataCollection_FKIndex1` (`dataCollectionGroupId`),
  KEY `DataCollection_FKIndex2` (`strategySubWedgeOrigId`),
  KEY `DataCollection_FKIndex3` (`detectorId`),
  KEY `DataCollection_FKIndexDCNumber` (`dataCollectionNumber`),
  KEY `DataCollection_FKIndexImageDirectory` (`imageDirectory`),
  KEY `DataCollection_FKIndexImagePrefix` (`imagePrefix`),
  KEY `DataCollection_FKIndexStartTime` (`startTime`),
  KEY `endPositionId` (`endPositionId`),
  KEY `startPositionId` (`startPositionId`),
  KEY `DataCollection_FKIndex0` (`BLSAMPLEID`),
  KEY `DataCollection_FKIndex00` (`SESSIONID`),
  KEY `DataCollection_dataCollectionGroupId_startTime` (`dataCollectionGroupId`,`startTime`),
  KEY `DataCollection_dataCollectionPlanId` (`dataCollectionPlanId`),
  CONSTRAINT `DataCollection_dataCollectionPlanId` FOREIGN KEY (`dataCollectionPlanId`) REFERENCES `DiffractionPlan` (`diffractionPlanId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `DataCollection_ibfk_1` FOREIGN KEY (`strategySubWedgeOrigId`) REFERENCES `ScreeningStrategySubWedge` (`screeningStrategySubWedgeId`),
  CONSTRAINT `DataCollection_ibfk_2` FOREIGN KEY (`detectorId`) REFERENCES `Detector` (`detectorId`),
  CONSTRAINT `DataCollection_ibfk_3` FOREIGN KEY (`dataCollectionGroupId`) REFERENCES `DataCollectionGroup` (`dataCollectionGroupId`),
  CONSTRAINT `DataCollection_ibfk_6` FOREIGN KEY (`startPositionId`) REFERENCES `MotorPosition` (`motorPositionId`),
  CONSTRAINT `DataCollection_ibfk_7` FOREIGN KEY (`endPositionId`) REFERENCES `MotorPosition` (`motorPositionId`),
  CONSTRAINT `DataCollection_ibfk_8` FOREIGN KEY (`blSubSampleId`) REFERENCES `BLSubSample` (`blSubSampleId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `DataCollectionComment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DataCollectionComment` (
  `dataCollectionCommentId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `dataCollectionId` int(11) unsigned NOT NULL,
  `personId` int(10) unsigned NOT NULL,
  `comments` varchar(4000) DEFAULT NULL,
  `createTime` datetime NOT NULL DEFAULT current_timestamp(),
  `modTime` date DEFAULT NULL,
  PRIMARY KEY (`dataCollectionCommentId`),
  KEY `dataCollectionComment_fk1` (`dataCollectionId`),
  KEY `dataCollectionComment_fk2` (`personId`),
  CONSTRAINT `dataCollectionComment_fk1` FOREIGN KEY (`dataCollectionId`) REFERENCES `DataCollection` (`dataCollectionId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dataCollectionComment_fk2` FOREIGN KEY (`personId`) REFERENCES `Person` (`personId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `DataCollectionFileAttachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DataCollectionFileAttachment` (
  `dataCollectionFileAttachmentId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `dataCollectionId` int(11) unsigned NOT NULL,
  `fileFullPath` varchar(255) NOT NULL,
  `fileType` enum('snapshot','log','xy','recip','pia','warning','params') DEFAULT NULL,
  `createTime` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`dataCollectionFileAttachmentId`),
  KEY `_dataCollectionFileAttachmentId_fk1` (`dataCollectionId`),
  CONSTRAINT `_dataCollectionFileAttachmentId_fk1` FOREIGN KEY (`dataCollectionId`) REFERENCES `DataCollection` (`dataCollectionId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `DataCollectionGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DataCollectionGroup` (
  `dataCollectionGroupId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key (auto-incremented)',
  `sessionId` int(10) unsigned NOT NULL COMMENT 'references Session table',
  `comments` varchar(1024) DEFAULT NULL COMMENT 'comments',
  `blSampleId` int(10) unsigned DEFAULT NULL COMMENT 'references BLSample table',
  `experimentType` enum('SAD','SAD - Inverse Beam','OSC','Collect - Multiwedge','MAD','Helical','Multi-positional','Mesh','Burn','MAD - Inverse Beam','Characterization','Dehydration','tomo','experiment','EM','PDF','PDF+Bragg','Bragg','single particle','Serial Fixed','Serial Jet','Standard','Time Resolved','Diamond Anvil High Pressure','Custom','XRF map','Energy scan','XRF spectrum','XRF map xas','Mesh3D','Screening','Still','SSX-Chip','SSX-Jet') DEFAULT NULL COMMENT 'Standard: Routine structure determination experiment. Time Resolved: Investigate the change of a system over time. Custom: Special or non-standard data collection.',
  `startTime` datetime DEFAULT NULL COMMENT 'Start time of the dataCollectionGroup',
  `endTime` datetime DEFAULT NULL COMMENT 'end time of the dataCollectionGroup',
  `crystalClass` varchar(20) DEFAULT NULL COMMENT 'Crystal Class for industrials users',
  `detectorMode` varchar(255) DEFAULT NULL COMMENT 'Detector mode',
  `actualSampleBarcode` varchar(45) DEFAULT NULL COMMENT 'Actual sample barcode',
  `actualSampleSlotInContainer` int(10) unsigned DEFAULT NULL COMMENT 'Actual sample slot number in container',
  `actualContainerBarcode` varchar(45) DEFAULT NULL COMMENT 'Actual container barcode',
  `actualContainerSlotInSC` int(10) unsigned DEFAULT NULL COMMENT 'Actual container slot number in sample changer',
  `xtalSnapshotFullPath` varchar(255) DEFAULT NULL,
  `scanParameters` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`scanParameters`)),
  `experimentTypeId` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`dataCollectionGroupId`),
  KEY `DataCollectionGroup_FKIndex1` (`blSampleId`),
  KEY `DataCollectionGroup_FKIndex2` (`sessionId`),
  KEY `DataCollectionGroup_ibfk_4` (`experimentTypeId`),
  CONSTRAINT `DataCollectionGroup_ibfk_1` FOREIGN KEY (`blSampleId`) REFERENCES `BLSample` (`blSampleId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `DataCollectionGroup_ibfk_2` FOREIGN KEY (`sessionId`) REFERENCES `BLSession` (`sessionId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `DataCollectionGroup_ibfk_4` FOREIGN KEY (`experimentTypeId`) REFERENCES `ExperimentType` (`experimentTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='a dataCollectionGroup is a group of dataCollection for a spe';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `DataCollectionPlan_has_Detector`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DataCollectionPlan_has_Detector` (
  `dataCollectionPlanHasDetectorId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `dataCollectionPlanId` int(11) unsigned NOT NULL,
  `detectorId` int(11) NOT NULL,
  `exposureTime` double DEFAULT NULL,
  `distance` double DEFAULT NULL,
  `roll` double DEFAULT NULL,
  PRIMARY KEY (`dataCollectionPlanHasDetectorId`),
  UNIQUE KEY `dataCollectionPlanId` (`dataCollectionPlanId`,`detectorId`),
  KEY `DataCollectionPlan_has_Detector_ibfk2` (`detectorId`),
  CONSTRAINT `DataCollectionPlan_has_Detector_ibfk1` FOREIGN KEY (`dataCollectionPlanId`) REFERENCES `DiffractionPlan` (`diffractionPlanId`),
  CONSTRAINT `DataCollectionPlan_has_Detector_ibfk2` FOREIGN KEY (`detectorId`) REFERENCES `Detector` (`detectorId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Detector`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Detector` (
  `detectorId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key (auto-incremented)',
  `detectorType` varchar(255) DEFAULT NULL,
  `detectorManufacturer` varchar(255) DEFAULT NULL,
  `detectorModel` varchar(255) DEFAULT NULL,
  `detectorPixelSizeHorizontal` float DEFAULT NULL,
  `detectorPixelSizeVertical` float DEFAULT NULL,
  `DETECTORMAXRESOLUTION` float DEFAULT NULL,
  `DETECTORMINRESOLUTION` float DEFAULT NULL,
  `detectorSerialNumber` varchar(30) DEFAULT NULL,
  `detectorDistanceMin` double DEFAULT NULL,
  `detectorDistanceMax` double DEFAULT NULL,
  `trustedPixelValueRangeLower` double DEFAULT NULL,
  `trustedPixelValueRangeUpper` double DEFAULT NULL,
  `sensorThickness` float DEFAULT NULL,
  `overload` float DEFAULT NULL,
  `XGeoCorr` varchar(255) DEFAULT NULL,
  `YGeoCorr` varchar(255) DEFAULT NULL,
  `detectorMode` varchar(255) DEFAULT NULL,
  `density` float DEFAULT NULL,
  `composition` varchar(16) DEFAULT NULL,
  `numberOfPixelsX` mediumint(9) DEFAULT NULL COMMENT 'Detector number of pixels in x',
  `numberOfPixelsY` mediumint(9) DEFAULT NULL COMMENT 'Detector number of pixels in y',
  `detectorRollMin` double DEFAULT NULL COMMENT 'unit: degrees',
  `detectorRollMax` double DEFAULT NULL COMMENT 'unit: degrees',
  `localName` varchar(40) DEFAULT NULL COMMENT 'Colloquial name for the detector',
  `numberOfROIPixelsX` mediumint(9) DEFAULT NULL COMMENT 'Detector number of pixels in x in ROI mode',
  `numberOfROIPixelsY` mediumint(9) DEFAULT NULL COMMENT 'Detector number of pixels in y in ROI mode',
  PRIMARY KEY (`detectorId`),
  UNIQUE KEY `Detector_ibuk1` (`detectorSerialNumber`),
  KEY `Detector_FKIndex1` (`detectorType`,`detectorManufacturer`,`detectorModel`,`detectorPixelSizeHorizontal`,`detectorPixelSizeVertical`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='Detector table is linked to a dataCollection';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Dewar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Dewar` (
  `dewarId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `shippingId` int(10) unsigned NOT NULL,
  `code` varchar(45) DEFAULT NULL,
  `comments` varchar(1024) DEFAULT NULL,
  `storageLocation` varchar(45) DEFAULT NULL,
  `dewarStatus` varchar(45) DEFAULT NULL,
  `bltimeStamp` datetime DEFAULT NULL,
  `isStorageDewar` tinyint(1) DEFAULT 0,
  `barCode` varchar(45) DEFAULT NULL,
  `firstExperimentId` int(10) unsigned DEFAULT NULL,
  `customsValue` int(11) unsigned DEFAULT NULL,
  `transportValue` int(11) unsigned DEFAULT NULL,
  `trackingNumberToSynchrotron` varchar(30) DEFAULT NULL,
  `trackingNumberFromSynchrotron` varchar(30) DEFAULT NULL,
  `type` enum('Dewar','Toolbox','Parcel') NOT NULL DEFAULT 'Dewar',
  `facilityCode` varchar(20) DEFAULT NULL,
  `weight` float DEFAULT NULL COMMENT 'dewar weight in kg',
  `deliveryAgent_barcode` varchar(30) DEFAULT NULL COMMENT 'Courier piece barcode (not the airway bill)',
  `extra` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'JSON column for facility-specific or hard-to-define attributes, e.g. LN2 top-ups and contents checks' CHECK (json_valid(`extra`)),
  PRIMARY KEY (`dewarId`),
  UNIQUE KEY `barCode` (`barCode`),
  KEY `Dewar_FKIndex1` (`shippingId`),
  KEY `Dewar_FKIndex2` (`firstExperimentId`),
  KEY `Dewar_FKIndexCode` (`code`),
  KEY `Dewar_FKIndexStatus` (`dewarStatus`),
  CONSTRAINT `Dewar_fk_firstExperimentId` FOREIGN KEY (`firstExperimentId`) REFERENCES `BLSession` (`sessionId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Dewar_ibfk_1` FOREIGN KEY (`shippingId`) REFERENCES `Shipping` (`shippingId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `DewarLocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DewarLocation` (
  `eventId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dewarNumber` varchar(128) NOT NULL COMMENT 'Dewar number',
  `userId` varchar(128) DEFAULT NULL COMMENT 'User who locates the dewar',
  `dateTime` datetime DEFAULT NULL COMMENT 'Date and time of locatization',
  `locationName` varchar(128) DEFAULT NULL COMMENT 'Location of the dewar',
  `courierName` varchar(128) DEFAULT NULL COMMENT 'Carrier name who''s shipping back the dewar',
  `courierTrackingNumber` varchar(128) DEFAULT NULL COMMENT 'Tracking number of the shippment',
  PRIMARY KEY (`eventId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='ISPyB Dewar location table';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `DewarLocationList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DewarLocationList` (
  `locationId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `locationName` varchar(128) NOT NULL DEFAULT '' COMMENT 'Location',
  PRIMARY KEY (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='List of locations for dewars';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `DewarRegistry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DewarRegistry` (
  `dewarRegistryId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `facilityCode` varchar(20) NOT NULL,
  `proposalId` int(11) unsigned DEFAULT NULL,
  `labContactId` int(11) unsigned DEFAULT NULL,
  `purchaseDate` datetime DEFAULT NULL,
  `bltimestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `manufacturerSerialNumber` varchar(15) DEFAULT NULL COMMENT 'Dewar serial number as given by manufacturer. Used to be typically 5 or 6 digits, more likely to be 11 alphanumeric chars in future',
  PRIMARY KEY (`dewarRegistryId`),
  UNIQUE KEY `facilityCode` (`facilityCode`),
  KEY `DewarRegistry_ibfk_1` (`proposalId`),
  KEY `DewarRegistry_ibfk_2` (`labContactId`),
  CONSTRAINT `DewarRegistry_ibfk_1` FOREIGN KEY (`proposalId`) REFERENCES `Proposal` (`proposalId`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `DewarRegistry_ibfk_2` FOREIGN KEY (`labContactId`) REFERENCES `LabContact` (`labContactId`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `DewarRegistry_has_Proposal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DewarRegistry_has_Proposal` (
  `dewarRegistryHasProposalId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `dewarRegistryId` int(11) unsigned DEFAULT NULL,
  `proposalId` int(10) unsigned DEFAULT NULL,
  `personId` int(10) unsigned DEFAULT NULL COMMENT 'Person registering the dewar',
  `recordTimestamp` datetime DEFAULT current_timestamp(),
  `labContactId` int(11) unsigned DEFAULT NULL COMMENT 'Owner of the dewar',
  PRIMARY KEY (`dewarRegistryHasProposalId`),
  UNIQUE KEY `dewarRegistryId` (`dewarRegistryId`,`proposalId`),
  KEY `DewarRegistry_has_Proposal_ibfk2` (`proposalId`),
  KEY `DewarRegistry_has_Proposal_ibfk3` (`personId`),
  KEY `DewarRegistry_has_Proposal_ibfk4` (`labContactId`),
  CONSTRAINT `DewarRegistry_has_Proposal_ibfk1` FOREIGN KEY (`dewarRegistryId`) REFERENCES `DewarRegistry` (`dewarRegistryId`),
  CONSTRAINT `DewarRegistry_has_Proposal_ibfk2` FOREIGN KEY (`proposalId`) REFERENCES `Proposal` (`proposalId`),
  CONSTRAINT `DewarRegistry_has_Proposal_ibfk3` FOREIGN KEY (`personId`) REFERENCES `Person` (`personId`),
  CONSTRAINT `DewarRegistry_has_Proposal_ibfk4` FOREIGN KEY (`labContactId`) REFERENCES `LabContact` (`labContactId`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `DewarReport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DewarReport` (
  `dewarReportId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `facilityCode` varchar(20) NOT NULL,
  `report` text DEFAULT NULL,
  `attachment` varchar(255) DEFAULT NULL,
  `bltimestamp` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`dewarReportId`),
  KEY `DewarReportIdx1` (`facilityCode`),
  CONSTRAINT `DewarReport_ibfk_1` FOREIGN KEY (`facilityCode`) REFERENCES `DewarRegistry` (`facilityCode`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `DewarTransportHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DewarTransportHistory` (
  `DewarTransportHistoryId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dewarId` int(10) unsigned DEFAULT NULL,
  `dewarStatus` varchar(45) NOT NULL,
  `storageLocation` varchar(45) NOT NULL,
  `arrivalDate` datetime NOT NULL,
  PRIMARY KEY (`DewarTransportHistoryId`),
  KEY `DewarTransportHistory_FKIndex1` (`dewarId`),
  CONSTRAINT `DewarTransportHistory_ibfk_1` FOREIGN KEY (`dewarId`) REFERENCES `Dewar` (`dewarId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `DiffractionPlan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DiffractionPlan` (
  `diffractionPlanId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `experimentKind` enum('Default','MXPressE','MXPressO','MXPressE_SAD','MXScore','MXPressM','MAD','SAD','Fixed','Ligand binding','Refinement','OSC','MAD - Inverse Beam','SAD - Inverse Beam','MESH','XFE','Stepped transmission','XChem High Symmetry','XChem Low Symmetry','Commissioning') DEFAULT NULL,
  `observedResolution` float DEFAULT NULL,
  `minimalResolution` float DEFAULT NULL,
  `exposureTime` float DEFAULT NULL,
  `oscillationRange` float DEFAULT NULL,
  `maximalResolution` float DEFAULT NULL,
  `screeningResolution` float DEFAULT NULL,
  `radiationSensitivity` float DEFAULT NULL,
  `anomalousScatterer` varchar(255) DEFAULT NULL,
  `preferredBeamSizeX` float DEFAULT NULL,
  `preferredBeamSizeY` float DEFAULT NULL,
  `preferredBeamDiameter` float DEFAULT NULL,
  `comments` varchar(1024) DEFAULT NULL,
  `DIFFRACTIONPLANUUID` varchar(1000) DEFAULT NULL,
  `aimedCompleteness` double DEFAULT NULL,
  `aimedIOverSigmaAtHighestRes` double DEFAULT NULL,
  `aimedMultiplicity` double DEFAULT NULL,
  `aimedResolution` double DEFAULT NULL,
  `anomalousData` tinyint(1) DEFAULT 0,
  `complexity` varchar(45) DEFAULT NULL,
  `estimateRadiationDamage` tinyint(1) DEFAULT 0,
  `forcedSpaceGroup` varchar(45) DEFAULT NULL,
  `requiredCompleteness` double DEFAULT NULL,
  `requiredMultiplicity` double DEFAULT NULL,
  `requiredResolution` double DEFAULT NULL,
  `strategyOption` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`strategyOption`)),
  `kappaStrategyOption` varchar(45) DEFAULT NULL,
  `numberOfPositions` int(11) DEFAULT NULL,
  `minDimAccrossSpindleAxis` double DEFAULT NULL COMMENT 'minimum dimension accross the spindle axis',
  `maxDimAccrossSpindleAxis` double DEFAULT NULL COMMENT 'maximum dimension accross the spindle axis',
  `radiationSensitivityBeta` double DEFAULT NULL,
  `radiationSensitivityGamma` double DEFAULT NULL,
  `minOscWidth` float DEFAULT NULL,
  `recordTimeStamp` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Creation or last update date/time',
  `monochromator` varchar(8) DEFAULT NULL COMMENT 'DMM or DCM',
  `energy` float DEFAULT NULL COMMENT 'eV',
  `transmission` float DEFAULT NULL COMMENT 'Decimal fraction in range [0,1]',
  `boxSizeX` float DEFAULT NULL COMMENT 'microns',
  `boxSizeY` float DEFAULT NULL COMMENT 'microns',
  `kappaStart` float DEFAULT NULL COMMENT 'degrees',
  `axisStart` float DEFAULT NULL COMMENT 'degrees',
  `axisRange` float DEFAULT NULL COMMENT 'degrees',
  `numberOfImages` mediumint(9) DEFAULT NULL COMMENT 'The number of images requested',
  `presetForProposalId` int(10) unsigned DEFAULT NULL COMMENT 'Indicates this plan is available to all sessions on given proposal',
  `beamLineName` varchar(45) DEFAULT NULL COMMENT 'Indicates this plan is available to all sessions on given beamline',
  `detectorId` int(11) DEFAULT NULL,
  `distance` double DEFAULT NULL,
  `orientation` double DEFAULT NULL,
  `monoBandwidth` double DEFAULT NULL,
  `centringMethod` enum('xray','loop','diffraction','optical') DEFAULT NULL,
  `userPath` varchar(100) DEFAULT NULL COMMENT 'User-specified relative "root" path inside the session directory to be used for holding collected data',
  `robotPlateTemperature` float DEFAULT NULL COMMENT 'units: kelvin',
  `exposureTemperature` float DEFAULT NULL COMMENT 'units: kelvin',
  `experimentTypeId` int(10) unsigned DEFAULT NULL,
  `purificationColumnId` int(10) unsigned DEFAULT NULL,
  `collectionMode` enum('auto','manual') DEFAULT NULL COMMENT 'The requested collection mode, possible values are auto, manual',
  `priority` int(4) DEFAULT NULL COMMENT 'The priority of this sample relative to others in the shipment',
  `qMin` float DEFAULT NULL COMMENT 'minimum in qRange, unit: nm^-1, needed for SAXS',
  `qMax` float DEFAULT NULL COMMENT 'maximum in qRange, unit: nm^-1, needed for SAXS',
  `reductionParametersAveraging` enum('All','Fastest Dimension','1D') DEFAULT NULL COMMENT 'Post processing params for SAXS',
  `scanParameters` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'JSON serialised scan parameters, useful for parameters without designated columns' CHECK (json_valid(`scanParameters`)),
  PRIMARY KEY (`diffractionPlanId`),
  KEY `DiffractionPlan_ibfk1` (`presetForProposalId`),
  KEY `DataCollectionPlan_ibfk3` (`detectorId`),
  KEY `DiffractionPlan_ibfk3` (`experimentTypeId`),
  KEY `DiffractionPlan_ibfk2` (`purificationColumnId`),
  CONSTRAINT `DataCollectionPlan_ibfk3` FOREIGN KEY (`detectorId`) REFERENCES `Detector` (`detectorId`) ON UPDATE CASCADE,
  CONSTRAINT `DiffractionPlan_ibfk1` FOREIGN KEY (`presetForProposalId`) REFERENCES `Proposal` (`proposalId`),
  CONSTRAINT `DiffractionPlan_ibfk2` FOREIGN KEY (`purificationColumnId`) REFERENCES `PurificationColumn` (`purificationColumnId`),
  CONSTRAINT `DiffractionPlan_ibfk3` FOREIGN KEY (`experimentTypeId`) REFERENCES `ExperimentType` (`experimentTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `EnergyScan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EnergyScan` (
  `energyScanId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sessionId` int(10) unsigned NOT NULL,
  `blSampleId` int(10) unsigned DEFAULT NULL,
  `fluorescenceDetector` varchar(255) DEFAULT NULL,
  `scanFileFullPath` varchar(255) DEFAULT NULL,
  `jpegChoochFileFullPath` varchar(255) DEFAULT NULL,
  `element` varchar(45) DEFAULT NULL,
  `startEnergy` float DEFAULT NULL,
  `endEnergy` float DEFAULT NULL,
  `transmissionFactor` float DEFAULT NULL,
  `exposureTime` float DEFAULT NULL,
  `axisPosition` float DEFAULT NULL,
  `synchrotronCurrent` float DEFAULT NULL,
  `temperature` float DEFAULT NULL,
  `peakEnergy` float DEFAULT NULL,
  `peakFPrime` float DEFAULT NULL,
  `peakFDoublePrime` float DEFAULT NULL,
  `inflectionEnergy` float DEFAULT NULL,
  `inflectionFPrime` float DEFAULT NULL,
  `inflectionFDoublePrime` float DEFAULT NULL,
  `xrayDose` float DEFAULT NULL,
  `startTime` datetime DEFAULT NULL,
  `endTime` datetime DEFAULT NULL,
  `edgeEnergy` varchar(255) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `beamSizeVertical` float DEFAULT NULL,
  `beamSizeHorizontal` float DEFAULT NULL,
  `choochFileFullPath` varchar(255) DEFAULT NULL,
  `crystalClass` varchar(20) DEFAULT NULL,
  `comments` varchar(1024) DEFAULT NULL,
  `flux` double DEFAULT NULL COMMENT 'flux measured before the energyScan',
  `flux_end` double DEFAULT NULL COMMENT 'flux measured after the energyScan',
  `workingDirectory` varchar(45) DEFAULT NULL,
  `blSubSampleId` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`energyScanId`),
  KEY `EnergyScan_FKIndex2` (`sessionId`),
  KEY `ES_ibfk_2` (`blSampleId`),
  KEY `ES_ibfk_3` (`blSubSampleId`),
  CONSTRAINT `ES_ibfk_1` FOREIGN KEY (`sessionId`) REFERENCES `BLSession` (`sessionId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ES_ibfk_2` FOREIGN KEY (`blSampleId`) REFERENCES `BLSample` (`blSampleId`),
  CONSTRAINT `ES_ibfk_3` FOREIGN KEY (`blSubSampleId`) REFERENCES `BLSubSample` (`blSubSampleId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Event` (
  `eventId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `eventChainId` int(11) unsigned NOT NULL,
  `componentId` int(11) unsigned DEFAULT NULL,
  `eventTypeId` int(11) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `offset` float NOT NULL COMMENT 'Start of the event relative to data collection start time in seconds.',
  `duration` float DEFAULT NULL COMMENT 'Duration of the event if applicable.',
  `period` float DEFAULT NULL COMMENT 'Repetition period if applicable in seconds.',
  `repetition` float DEFAULT NULL COMMENT 'Number of repetitions if applicable.',
  PRIMARY KEY (`eventId`),
  KEY `eventChainId` (`eventChainId`),
  KEY `componentId` (`componentId`),
  KEY `eventTypeId` (`eventTypeId`),
  CONSTRAINT `Event_ibfk_1` FOREIGN KEY (`eventChainId`) REFERENCES `EventChain` (`eventChainId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Event_ibfk_2` FOREIGN KEY (`componentId`) REFERENCES `Component` (`componentId`),
  CONSTRAINT `Event_ibfk_3` FOREIGN KEY (`eventTypeId`) REFERENCES `EventType` (`eventTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Describes an event that occurred during a data collection and should be taken into account for data analysis. Can optionally be repeated at a specified frequency.';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `EventChain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EventChain` (
  `eventChainId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `dataCollectionId` int(11) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`eventChainId`),
  KEY `dataCollectionId` (`dataCollectionId`),
  CONSTRAINT `EventChain_ibfk_1` FOREIGN KEY (`dataCollectionId`) REFERENCES `DataCollection` (`dataCollectionId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Groups events together in a data collection.';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `EventType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EventType` (
  `eventTypeId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`eventTypeId`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Defines the list of event types which can occur during a data collection.';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ExperimentKindDetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ExperimentKindDetails` (
  `experimentKindId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `diffractionPlanId` int(10) unsigned NOT NULL,
  `exposureIndex` int(10) unsigned DEFAULT NULL,
  `dataCollectionType` varchar(45) DEFAULT NULL,
  `dataCollectionKind` varchar(45) DEFAULT NULL,
  `wedgeValue` float DEFAULT NULL,
  PRIMARY KEY (`experimentKindId`),
  KEY `ExperimentKindDetails_FKIndex1` (`diffractionPlanId`),
  CONSTRAINT `EKD_ibfk_1` FOREIGN KEY (`diffractionPlanId`) REFERENCES `DiffractionPlan` (`diffractionPlanId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ExperimentType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ExperimentType` (
  `experimentTypeId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `proposalType` varchar(10) DEFAULT NULL,
  `active` tinyint(1) DEFAULT 1 COMMENT '1=active, 0=inactive',
  PRIMARY KEY (`experimentTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='A lookup table for different types of experients';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `GeometryClassname`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GeometryClassname` (
  `geometryClassnameId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `geometryClassname` varchar(45) DEFAULT NULL,
  `geometryOrder` int(2) NOT NULL,
  PRIMARY KEY (`geometryClassnameId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `GridImageMap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GridImageMap` (
  `gridImageMapId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `dataCollectionId` int(11) unsigned DEFAULT NULL,
  `imageNumber` int(11) unsigned DEFAULT NULL COMMENT 'Movie number, sequential 1-n in time order',
  `outputFileId` varchar(80) DEFAULT NULL COMMENT 'File number, file 1 may not be movie 1',
  `positionX` float DEFAULT NULL COMMENT 'X position of stage, Units: um',
  `positionY` float DEFAULT NULL COMMENT 'Y position of stage, Units: um',
  PRIMARY KEY (`gridImageMapId`),
  KEY `_GridImageMap_ibfk1` (`dataCollectionId`),
  CONSTRAINT `_GridImageMap_ibfk1` FOREIGN KEY (`dataCollectionId`) REFERENCES `DataCollection` (`dataCollectionId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `GridInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GridInfo` (
  `gridInfoId` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key (auto-incremented)',
  `xOffset` double DEFAULT NULL,
  `yOffset` double DEFAULT NULL,
  `dx_mm` double DEFAULT NULL,
  `dy_mm` double DEFAULT NULL,
  `steps_x` double DEFAULT NULL,
  `steps_y` double DEFAULT NULL,
  `meshAngle` double DEFAULT NULL,
  `recordTimeStamp` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Creation or last update date/time',
  `workflowMeshId` int(11) unsigned DEFAULT NULL,
  `orientation` enum('vertical','horizontal') DEFAULT 'horizontal',
  `dataCollectionGroupId` int(11) DEFAULT NULL,
  `pixelsPerMicronX` float DEFAULT NULL,
  `pixelsPerMicronY` float DEFAULT NULL,
  `snapshot_offsetXPixel` float DEFAULT NULL,
  `snapshot_offsetYPixel` float DEFAULT NULL,
  `snaked` tinyint(1) DEFAULT 0 COMMENT 'True: The images associated with the DCG were collected in a snaked pattern',
  `dataCollectionId` int(11) unsigned DEFAULT NULL,
  `patchesX` int(10) DEFAULT 1 COMMENT 'Number of patches the grid is made up of in the X direction',
  `patchesY` int(10) DEFAULT 1 COMMENT 'Number of patches the grid is made up of in the Y direction',
  `micronsPerPixelX` float DEFAULT NULL,
  `micronsPerPixelY` float DEFAULT NULL,
  PRIMARY KEY (`gridInfoId`),
  KEY `workflowMeshId` (`workflowMeshId`),
  KEY `GridInfo_ibfk_2` (`dataCollectionGroupId`),
  KEY `GridInfo_fk_dataCollectionId` (`dataCollectionId`),
  CONSTRAINT `GridInfo_fk_dataCollectionId` FOREIGN KEY (`dataCollectionId`) REFERENCES `DataCollection` (`dataCollectionId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `GridInfo_ibfk_2` FOREIGN KEY (`dataCollectionGroupId`) REFERENCES `DataCollectionGroup` (`dataCollectionGroupId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Image` (
  `imageId` int(12) unsigned NOT NULL AUTO_INCREMENT,
  `dataCollectionId` int(11) unsigned NOT NULL DEFAULT 0,
  `imageNumber` int(10) unsigned DEFAULT NULL,
  `fileName` varchar(255) DEFAULT NULL,
  `fileLocation` varchar(255) DEFAULT NULL,
  `measuredIntensity` float DEFAULT NULL,
  `jpegFileFullPath` varchar(255) DEFAULT NULL,
  `jpegThumbnailFileFullPath` varchar(255) DEFAULT NULL,
  `temperature` float DEFAULT NULL,
  `cumulativeIntensity` float DEFAULT NULL,
  `synchrotronCurrent` float DEFAULT NULL,
  `comments` varchar(1024) DEFAULT NULL,
  `machineMessage` varchar(1024) DEFAULT NULL,
  `BLTIMESTAMP` timestamp NOT NULL DEFAULT current_timestamp(),
  `motorPositionId` int(11) unsigned DEFAULT NULL,
  `recordTimeStamp` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Creation or last update date/time',
  PRIMARY KEY (`imageId`),
  KEY `Image_FKIndex1` (`dataCollectionId`),
  KEY `Image_FKIndex2` (`imageNumber`),
  KEY `Image_Index3` (`fileLocation`,`fileName`),
  KEY `motorPositionId` (`motorPositionId`),
  CONSTRAINT `Image_ibfk_1` FOREIGN KEY (`dataCollectionId`) REFERENCES `DataCollection` (`dataCollectionId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Image_ibfk_2` FOREIGN KEY (`motorPositionId`) REFERENCES `MotorPosition` (`motorPositionId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ImageQualityIndicators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ImageQualityIndicators` (
  `dataCollectionId` int(11) unsigned NOT NULL,
  `imageNumber` mediumint(8) unsigned NOT NULL,
  `imageId` int(12) DEFAULT NULL,
  `autoProcProgramId` int(10) unsigned DEFAULT NULL COMMENT 'Foreign key to the AutoProcProgram table',
  `spotTotal` int(10) DEFAULT NULL COMMENT 'Total number of spots',
  `inResTotal` int(10) DEFAULT NULL COMMENT 'Total number of spots in resolution range',
  `goodBraggCandidates` int(10) DEFAULT NULL COMMENT 'Total number of Bragg diffraction spots',
  `iceRings` int(10) DEFAULT NULL COMMENT 'Number of ice rings identified',
  `method1Res` float DEFAULT NULL COMMENT 'Resolution estimate 1 (see publication)',
  `method2Res` float DEFAULT NULL COMMENT 'Resolution estimate 2 (see publication)',
  `maxUnitCell` float DEFAULT NULL COMMENT 'Estimation of the largest possible unit cell edge',
  `pctSaturationTop50Peaks` float DEFAULT NULL COMMENT 'The fraction of the dynamic range being used',
  `inResolutionOvrlSpots` int(10) DEFAULT NULL COMMENT 'Number of spots overloaded',
  `binPopCutOffMethod2Res` float DEFAULT NULL COMMENT 'Cut off used in resolution limit calculation',
  `recordTimeStamp` datetime DEFAULT NULL COMMENT 'Creation or last update date/time',
  `totalIntegratedSignal` double DEFAULT NULL,
  `dozor_score` double DEFAULT NULL COMMENT 'dozor_score',
  `driftFactor` float DEFAULT NULL COMMENT 'EM movie drift factor',
  PRIMARY KEY (`dataCollectionId`,`imageNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Imager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Imager` (
  `imagerId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `temperature` float DEFAULT NULL,
  `serial` varchar(45) DEFAULT NULL,
  `capacity` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`imagerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `InspectionType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `InspectionType` (
  `inspectionTypeId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`inspectionTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `IspybCrystalClass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `IspybCrystalClass` (
  `crystalClassId` int(11) NOT NULL AUTO_INCREMENT,
  `crystalClass_code` varchar(20) NOT NULL,
  `crystalClass_name` varchar(255) NOT NULL,
  PRIMARY KEY (`crystalClassId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='ISPyB crystal class values';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `IspybReference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `IspybReference` (
  `referenceId` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key (auto-incremented)',
  `referenceName` varchar(255) DEFAULT NULL COMMENT 'reference name',
  `referenceUrl` varchar(1024) DEFAULT NULL COMMENT 'url of the reference',
  `referenceBibtext` blob DEFAULT NULL COMMENT 'bibtext value of the reference',
  `beamline` enum('All','ID14-4','ID23-1','ID23-2','ID29','XRF','AllXRF','Mesh') DEFAULT NULL COMMENT 'beamline involved',
  PRIMARY KEY (`referenceId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `LDAPSearchBase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LDAPSearchBase` (
  `ldapSearchBaseId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ldapSearchParametersId` int(11) unsigned NOT NULL COMMENT 'The other LDAP search parameters to be used with this search base',
  `searchBase` varchar(200) NOT NULL COMMENT 'Name of the object we search for',
  `sequenceNumber` tinyint(3) unsigned NOT NULL COMMENT 'The number in the sequence of searches where this search base should be attempted',
  PRIMARY KEY (`ldapSearchBaseId`),
  KEY `LDAPSearchBase_fk_ldapSearchParametersId` (`ldapSearchParametersId`),
  CONSTRAINT `LDAPSearchBase_fk_ldapSearchParametersId` FOREIGN KEY (`ldapSearchParametersId`) REFERENCES `LDAPSearchParameters` (`ldapSearchParametersId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='LDAP search base and the sequence number in which it should be attempted';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `LDAPSearchParameters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LDAPSearchParameters` (
  `ldapSearchParametersId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `accountType` enum('group_member','staff_account','functional_account') NOT NULL COMMENT 'The entity type returned by the search',
  `accountTypeGroupName` varchar(100) DEFAULT NULL COMMENT 'all accounts of this type must be members of this group',
  `oneOrMany` enum('one','many') NOT NULL COMMENT 'Expected number of search results',
  `hostURL` varchar(200) NOT NULL COMMENT 'URL for the LDAP host',
  `filter` varchar(200) DEFAULT NULL COMMENT 'A filter string for the search',
  `attributes` varchar(255) NOT NULL COMMENT 'Comma-separated list of search attributes',
  PRIMARY KEY (`ldapSearchParametersId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='All necessary parameters to run an LDAP search, except the search base';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `LabContact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LabContact` (
  `labContactId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `personId` int(10) unsigned NOT NULL,
  `cardName` varchar(40) NOT NULL,
  `proposalId` int(10) unsigned NOT NULL,
  `defaultCourrierCompany` varchar(45) DEFAULT NULL,
  `courierAccount` varchar(45) DEFAULT NULL,
  `billingReference` varchar(45) DEFAULT NULL,
  `dewarAvgCustomsValue` int(10) unsigned NOT NULL DEFAULT 0,
  `dewarAvgTransportValue` int(10) unsigned NOT NULL DEFAULT 0,
  `recordTimeStamp` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Creation or last update date/time',
  PRIMARY KEY (`labContactId`),
  UNIQUE KEY `cardNameAndProposal` (`cardName`,`proposalId`),
  UNIQUE KEY `personAndProposal` (`personId`,`proposalId`),
  KEY `LabContact_FKIndex1` (`proposalId`),
  CONSTRAINT `LabContact_ibfk_1` FOREIGN KEY (`personId`) REFERENCES `Person` (`personId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `LabContact_ibfk_2` FOREIGN KEY (`proposalId`) REFERENCES `Proposal` (`proposalId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Laboratory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Laboratory` (
  `laboratoryId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `laboratoryUUID` varchar(45) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `organization` varchar(45) DEFAULT NULL,
  `recordTimeStamp` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Creation or last update date/time',
  `laboratoryPk` int(10) DEFAULT NULL,
  `postcode` varchar(15) DEFAULT NULL,
  `EORINumber` varchar(17) DEFAULT NULL COMMENT 'An EORI number consists of an ISO Country code from an EU Member State  (2 characters) + a maximum of 15 characters',
  PRIMARY KEY (`laboratoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `MXMRRun`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MXMRRun` (
  `mxMRRunId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `autoProcScalingId` int(11) unsigned NOT NULL,
  `rValueStart` float DEFAULT NULL,
  `rValueEnd` float DEFAULT NULL,
  `rFreeValueStart` float DEFAULT NULL,
  `rFreeValueEnd` float DEFAULT NULL,
  `LLG` float DEFAULT NULL COMMENT 'Log Likelihood Gain',
  `TFZ` float DEFAULT NULL COMMENT 'Translation Function Z-score',
  `spaceGroup` varchar(45) DEFAULT NULL COMMENT 'Space group of the MR solution',
  `autoProcProgramId` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`mxMRRunId`),
  KEY `mxMRRun_FK1` (`autoProcScalingId`),
  KEY `mxMRRun_FK2` (`autoProcProgramId`),
  CONSTRAINT `mxMRRun_FK1` FOREIGN KEY (`autoProcScalingId`) REFERENCES `AutoProcScaling` (`autoProcScalingId`),
  CONSTRAINT `mxMRRun_FK2` FOREIGN KEY (`autoProcProgramId`) REFERENCES `AutoProcProgram` (`autoProcProgramId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `MXMRRunBlob`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MXMRRunBlob` (
  `mxMRRunBlobId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mxMRRunId` int(11) unsigned NOT NULL,
  `view1` varchar(255) DEFAULT NULL,
  `view2` varchar(255) DEFAULT NULL,
  `view3` varchar(255) DEFAULT NULL,
  `filePath` varchar(255) DEFAULT NULL COMMENT 'File path corresponding to the filenames in the view* columns',
  `x` float DEFAULT NULL COMMENT 'Fractional x coordinate of blob in range [-1, 1]',
  `y` float DEFAULT NULL COMMENT 'Fractional y coordinate of blob in range [-1, 1]',
  `z` float DEFAULT NULL COMMENT 'Fractional z coordinate of blob in range [-1, 1]',
  `height` float DEFAULT NULL COMMENT 'Blob height (sigmas)',
  `occupancy` float DEFAULT NULL COMMENT 'Site occupancy factor in range [0, 1]',
  `nearestAtomName` varchar(4) DEFAULT NULL COMMENT 'Name of nearest atom',
  `nearestAtomChainId` varchar(2) DEFAULT NULL COMMENT 'Chain identifier of nearest atom',
  `nearestAtomResName` varchar(4) DEFAULT NULL COMMENT 'Residue name of nearest atom',
  `nearestAtomResSeq` mediumint(8) unsigned DEFAULT NULL COMMENT 'Residue sequence number of nearest atom',
  `nearestAtomDistance` float DEFAULT NULL COMMENT 'Distance in Angstrom to nearest atom',
  `mapType` enum('anomalous','difference') DEFAULT NULL COMMENT 'Type of electron density map corresponding to this blob',
  PRIMARY KEY (`mxMRRunBlobId`),
  KEY `mxMRRunBlob_FK1` (`mxMRRunId`),
  CONSTRAINT `mxMRRunBlob_FK1` FOREIGN KEY (`mxMRRunId`) REFERENCES `MXMRRun` (`mxMRRunId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ModelBuilding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ModelBuilding` (
  `modelBuildingId` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key (auto-incremented)',
  `phasingAnalysisId` int(11) unsigned NOT NULL COMMENT 'Related phasing analysis item',
  `phasingProgramRunId` int(11) unsigned NOT NULL COMMENT 'Related program item',
  `spaceGroupId` int(10) unsigned DEFAULT NULL COMMENT 'Related spaceGroup',
  `lowRes` double DEFAULT NULL,
  `highRes` double DEFAULT NULL,
  `recordTimeStamp` datetime DEFAULT NULL COMMENT 'Creation or last update date/time',
  PRIMARY KEY (`modelBuildingId`),
  KEY `ModelBuilding_FKIndex1` (`phasingAnalysisId`),
  KEY `ModelBuilding_FKIndex2` (`phasingProgramRunId`),
  KEY `ModelBuilding_FKIndex3` (`spaceGroupId`),
  CONSTRAINT `ModelBuilding_phasingAnalysisfk_1` FOREIGN KEY (`phasingAnalysisId`) REFERENCES `PhasingAnalysis` (`phasingAnalysisId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ModelBuilding_phasingProgramRunfk_1` FOREIGN KEY (`phasingProgramRunId`) REFERENCES `PhasingProgramRun` (`phasingProgramRunId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ModelBuilding_spaceGroupfk_1` FOREIGN KEY (`spaceGroupId`) REFERENCES `SpaceGroup` (`spaceGroupId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `MotionCorrection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MotionCorrection` (
  `motionCorrectionId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `dataCollectionId` int(11) unsigned DEFAULT NULL,
  `autoProcProgramId` int(11) unsigned DEFAULT NULL,
  `imageNumber` smallint(5) unsigned DEFAULT NULL COMMENT 'Movie number, sequential in time 1-n',
  `firstFrame` smallint(5) unsigned DEFAULT NULL COMMENT 'First frame of movie used',
  `lastFrame` smallint(5) unsigned DEFAULT NULL COMMENT 'Last frame of movie used',
  `dosePerFrame` float DEFAULT NULL COMMENT 'Dose per frame, Units: e-/A^2',
  `doseWeight` float DEFAULT NULL COMMENT 'Dose weight, Units: dimensionless',
  `totalMotion` float DEFAULT NULL COMMENT 'Total motion, Units: A',
  `averageMotionPerFrame` float DEFAULT NULL COMMENT 'Average motion per frame, Units: A',
  `driftPlotFullPath` varchar(255) DEFAULT NULL COMMENT 'Full path to the drift plot',
  `micrographFullPath` varchar(255) DEFAULT NULL COMMENT 'Full path to the micrograph',
  `micrographSnapshotFullPath` varchar(255) DEFAULT NULL COMMENT 'Full path to a snapshot (jpg) of the micrograph',
  `patchesUsedX` mediumint(8) unsigned DEFAULT NULL COMMENT 'Number of patches used in x (for motioncor2)',
  `patchesUsedY` mediumint(8) unsigned DEFAULT NULL COMMENT 'Number of patches used in y (for motioncor2)',
  `fftFullPath` varchar(255) DEFAULT NULL COMMENT 'Full path to the jpg image of the raw micrograph FFT',
  `fftCorrectedFullPath` varchar(255) DEFAULT NULL COMMENT 'Full path to the jpg image of the drift corrected micrograph FFT',
  `comments` varchar(255) DEFAULT NULL,
  `movieId` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`motionCorrectionId`),
  KEY `MotionCorrection_ibfk2` (`autoProcProgramId`),
  KEY `MotionCorrection_ibfk3` (`movieId`),
  KEY `_MotionCorrection_ibfk1` (`dataCollectionId`),
  CONSTRAINT `MotionCorrection_ibfk2` FOREIGN KEY (`autoProcProgramId`) REFERENCES `AutoProcProgram` (`autoProcProgramId`),
  CONSTRAINT `MotionCorrection_ibfk3` FOREIGN KEY (`movieId`) REFERENCES `Movie` (`movieId`),
  CONSTRAINT `_MotionCorrection_ibfk1` FOREIGN KEY (`dataCollectionId`) REFERENCES `DataCollection` (`dataCollectionId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `MotorPosition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MotorPosition` (
  `motorPositionId` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key (auto-incremented)',
  `phiX` double DEFAULT NULL,
  `phiY` double DEFAULT NULL,
  `phiZ` double DEFAULT NULL,
  `sampX` double DEFAULT NULL,
  `sampY` double DEFAULT NULL,
  `omega` double DEFAULT NULL,
  `kappa` double DEFAULT NULL,
  `phi` double DEFAULT NULL,
  `chi` double DEFAULT NULL,
  `gridIndexY` int(11) DEFAULT NULL,
  `gridIndexZ` int(11) DEFAULT NULL,
  `recordTimeStamp` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Creation or last update date/time',
  PRIMARY KEY (`motorPositionId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Movie` (
  `movieId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `dataCollectionId` int(11) unsigned DEFAULT NULL,
  `movieNumber` mediumint(8) unsigned DEFAULT NULL,
  `movieFullPath` varchar(255) DEFAULT NULL,
  `createdTimeStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `positionX` float DEFAULT NULL,
  `positionY` float DEFAULT NULL,
  `nominalDefocus` float unsigned DEFAULT NULL COMMENT 'Nominal defocus, Units: A',
  `angle` float DEFAULT NULL COMMENT 'unit: degrees relative to perpendicular to beam',
  `fluence` float DEFAULT NULL COMMENT 'accumulated electron fluence from start to end of acquisition of this movie (commonly, but incorrectly, referred to as ‘dose’)',
  `numberOfFrames` int(11) unsigned DEFAULT NULL COMMENT 'number of frames per movie. This should be equivalent to the number of MotionCorrectionDrift entries, but the latter is a property of data analysis, whereas the number of frames is an intrinsic property of acquisition.',
  PRIMARY KEY (`movieId`),
  KEY `Movie_ibfk1` (`dataCollectionId`),
  CONSTRAINT `Movie_ibfk1` FOREIGN KEY (`dataCollectionId`) REFERENCES `DataCollection` (`dataCollectionId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `PDB`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PDB` (
  `pdbId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `contents` mediumtext /*!100301 COMPRESSED*/ CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `code` varchar(4) DEFAULT NULL,
  `source` varchar(30) DEFAULT NULL COMMENT 'Could be e.g. AlphaFold or RoseTTAFold',
  PRIMARY KEY (`pdbId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `PDBEntry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PDBEntry` (
  `pdbEntryId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `autoProcProgramId` int(11) unsigned NOT NULL,
  `code` varchar(4) DEFAULT NULL,
  `cell_a` float DEFAULT NULL,
  `cell_b` float DEFAULT NULL,
  `cell_c` float DEFAULT NULL,
  `cell_alpha` float DEFAULT NULL,
  `cell_beta` float DEFAULT NULL,
  `cell_gamma` float DEFAULT NULL,
  `resolution` float DEFAULT NULL,
  `pdbTitle` varchar(255) DEFAULT NULL,
  `pdbAuthors` varchar(600) DEFAULT NULL,
  `pdbDate` datetime DEFAULT NULL,
  `pdbBeamlineName` varchar(50) DEFAULT NULL,
  `beamlines` varchar(100) DEFAULT NULL,
  `distance` float DEFAULT NULL,
  `autoProcCount` smallint(6) DEFAULT NULL,
  `dataCollectionCount` smallint(6) DEFAULT NULL,
  `beamlineMatch` tinyint(1) DEFAULT NULL,
  `authorMatch` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`pdbEntryId`),
  KEY `pdbEntryIdx1` (`autoProcProgramId`),
  CONSTRAINT `pdbEntry_FK1` FOREIGN KEY (`autoProcProgramId`) REFERENCES `AutoProcProgram` (`autoProcProgramId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `PDBEntry_has_AutoProcProgram`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PDBEntry_has_AutoProcProgram` (
  `pdbEntryHasAutoProcId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pdbEntryId` int(11) unsigned NOT NULL,
  `autoProcProgramId` int(11) unsigned NOT NULL,
  `distance` float DEFAULT NULL,
  PRIMARY KEY (`pdbEntryHasAutoProcId`),
  KEY `pdbEntry_AutoProcProgramIdx1` (`pdbEntryId`),
  KEY `pdbEntry_AutoProcProgramIdx2` (`autoProcProgramId`),
  CONSTRAINT `pdbEntry_AutoProcProgram_FK1` FOREIGN KEY (`pdbEntryId`) REFERENCES `PDBEntry` (`pdbEntryId`) ON DELETE CASCADE,
  CONSTRAINT `pdbEntry_AutoProcProgram_FK2` FOREIGN KEY (`autoProcProgramId`) REFERENCES `AutoProcProgram` (`autoProcProgramId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ParticleClassification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ParticleClassification` (
  `particleClassificationId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `classNumber` int(10) unsigned DEFAULT NULL COMMENT 'Identified of the class. A unique ID given by Relion',
  `classImageFullPath` varchar(255) DEFAULT NULL COMMENT 'The PNG of the class',
  `particlesPerClass` int(10) unsigned DEFAULT NULL COMMENT 'Number of particles within the selected class, can then be used together with the total number above to calculate the percentage',
  `rotationAccuracy` float DEFAULT NULL COMMENT '???',
  `translationAccuracy` float DEFAULT NULL COMMENT 'Unit: Angstroms',
  `estimatedResolution` float DEFAULT NULL COMMENT '???, Unit: Angstroms',
  `overallFourierCompleteness` float DEFAULT NULL,
  `particleClassificationGroupId` int(10) unsigned DEFAULT NULL,
  `classDistribution` float DEFAULT NULL COMMENT 'Provides a figure of merit for the class, higher number is better',
  `selected` tinyint(1) DEFAULT 0 COMMENT 'Indicates whether the class is selected for further processing or not',
  `bFactorFitIntercept` float DEFAULT NULL COMMENT 'Intercept of quadratic fit to refinement resolution against the logarithm of the number of particles',
  `bFactorFitLinear` float DEFAULT NULL COMMENT 'Linear coefficient of quadratic fit to refinement resolution against the logarithm of the number of particles, equal to half of the B factor',
  `bFactorFitQuadratic` float DEFAULT NULL COMMENT 'Quadratic coefficient of quadratic fit to refinement resolution against the logarithm of the number of particles',
  PRIMARY KEY (`particleClassificationId`),
  KEY `ParticleClassification_fk_particleClassificationGroupId` (`particleClassificationGroupId`),
  CONSTRAINT `ParticleClassification_fk_particleClassificationGroupId` FOREIGN KEY (`particleClassificationGroupId`) REFERENCES `ParticleClassificationGroup` (`particleClassificationGroupId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='Results of 2D or 2D classification';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ParticleClassificationGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ParticleClassificationGroup` (
  `particleClassificationGroupId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `particlePickerId` int(10) unsigned DEFAULT NULL,
  `programId` int(10) unsigned DEFAULT NULL,
  `type` enum('2D','3D') DEFAULT NULL COMMENT 'Indicates the type of particle classification',
  `batchNumber` int(10) unsigned DEFAULT NULL COMMENT 'Corresponding to batch number',
  `numberOfParticlesPerBatch` int(10) unsigned DEFAULT NULL COMMENT 'total number of particles per batch (a large integer)',
  `numberOfClassesPerBatch` int(10) unsigned DEFAULT NULL,
  `symmetry` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`particleClassificationGroupId`),
  KEY `ParticleClassificationGroup_fk_particlePickerId` (`particlePickerId`),
  KEY `ParticleClassificationGroup_fk_programId` (`programId`),
  CONSTRAINT `ParticleClassificationGroup_fk_particlePickerId` FOREIGN KEY (`particlePickerId`) REFERENCES `ParticlePicker` (`particlePickerId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ParticleClassificationGroup_fk_programId` FOREIGN KEY (`programId`) REFERENCES `AutoProcProgram` (`autoProcProgramId`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ParticleClassification_has_CryoemInitialModel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ParticleClassification_has_CryoemInitialModel` (
  `particleClassificationId` int(10) unsigned NOT NULL,
  `cryoemInitialModelId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`particleClassificationId`,`cryoemInitialModelId`),
  KEY `ParticleClassification_has_InitialModel_fk2` (`cryoemInitialModelId`),
  CONSTRAINT `ParticleClassification_has_CryoemInitialModel_fk1` FOREIGN KEY (`particleClassificationId`) REFERENCES `ParticleClassification` (`particleClassificationId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ParticleClassification_has_InitialModel_fk2` FOREIGN KEY (`cryoemInitialModelId`) REFERENCES `CryoemInitialModel` (`cryoemInitialModelId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ParticlePicker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ParticlePicker` (
  `particlePickerId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `programId` int(10) unsigned DEFAULT NULL,
  `firstMotionCorrectionId` int(10) unsigned DEFAULT NULL,
  `particlePickingTemplate` varchar(255) DEFAULT NULL COMMENT 'Cryolo model',
  `particleDiameter` float DEFAULT NULL COMMENT 'Unit: nm',
  `numberOfParticles` int(10) unsigned DEFAULT NULL,
  `summaryImageFullPath` varchar(255) DEFAULT NULL COMMENT 'Generated summary micrograph image with highlighted particles',
  PRIMARY KEY (`particlePickerId`),
  KEY `ParticlePicker_fk_particlePickerProgramId` (`programId`),
  KEY `ParticlePicker_fk_motionCorrectionId` (`firstMotionCorrectionId`),
  CONSTRAINT `ParticlePicker_fk_motionCorrectionId` FOREIGN KEY (`firstMotionCorrectionId`) REFERENCES `MotionCorrection` (`motionCorrectionId`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `ParticlePicker_fk_programId` FOREIGN KEY (`programId`) REFERENCES `AutoProcProgram` (`autoProcProgramId`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='An instance of a particle picker program that was run';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Permission` (
  `permissionId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(15) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`permissionId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Person` (
  `personId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `laboratoryId` int(10) unsigned DEFAULT NULL,
  `siteId` int(11) DEFAULT NULL,
  `personUUID` varchar(45) DEFAULT NULL,
  `familyName` varchar(100) DEFAULT NULL,
  `givenName` varchar(45) DEFAULT NULL,
  `title` varchar(45) DEFAULT NULL,
  `emailAddress` varchar(60) DEFAULT NULL,
  `phoneNumber` varchar(45) DEFAULT NULL,
  `login` varchar(45) DEFAULT NULL,
  `faxNumber` varchar(45) DEFAULT NULL,
  `recordTimeStamp` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Creation or last update date/time',
  `cache` text DEFAULT NULL,
  `externalId` binary(16) DEFAULT NULL,
  PRIMARY KEY (`personId`),
  UNIQUE KEY `Person_FKIndex_Login` (`login`),
  KEY `Person_FKIndex1` (`laboratoryId`),
  KEY `Person_FKIndexFamilyName` (`familyName`),
  KEY `siteId` (`siteId`),
  CONSTRAINT `Person_ibfk_1` FOREIGN KEY (`laboratoryId`) REFERENCES `Laboratory` (`laboratoryId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Phasing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Phasing` (
  `phasingId` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key (auto-incremented)',
  `phasingAnalysisId` int(11) unsigned NOT NULL COMMENT 'Related phasing analysis item',
  `phasingProgramRunId` int(11) unsigned NOT NULL COMMENT 'Related program item',
  `spaceGroupId` int(10) unsigned DEFAULT NULL COMMENT 'Related spaceGroup',
  `method` enum('solvent flattening','solvent flipping','e','SAD','shelxe') DEFAULT NULL COMMENT 'phasing method',
  `solventContent` double DEFAULT NULL,
  `enantiomorph` tinyint(1) DEFAULT NULL COMMENT '0 or 1',
  `lowRes` double DEFAULT NULL,
  `highRes` double DEFAULT NULL,
  `recordTimeStamp` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`phasingId`),
  KEY `Phasing_FKIndex1` (`phasingAnalysisId`),
  KEY `Phasing_FKIndex2` (`phasingProgramRunId`),
  KEY `Phasing_FKIndex3` (`spaceGroupId`),
  CONSTRAINT `Phasing_phasingAnalysisfk_1` FOREIGN KEY (`phasingAnalysisId`) REFERENCES `PhasingAnalysis` (`phasingAnalysisId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Phasing_phasingProgramRunfk_1` FOREIGN KEY (`phasingProgramRunId`) REFERENCES `PhasingProgramRun` (`phasingProgramRunId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Phasing_spaceGroupfk_1` FOREIGN KEY (`spaceGroupId`) REFERENCES `SpaceGroup` (`spaceGroupId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `PhasingAnalysis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PhasingAnalysis` (
  `phasingAnalysisId` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key (auto-incremented)',
  `recordTimeStamp` datetime DEFAULT NULL COMMENT 'Creation or last update date/time',
  PRIMARY KEY (`phasingAnalysisId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `PhasingProgramAttachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PhasingProgramAttachment` (
  `phasingProgramAttachmentId` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key (auto-incremented)',
  `phasingProgramRunId` int(11) unsigned NOT NULL COMMENT 'Related program item',
  `fileType` enum('Map','Logfile','PDB','CSV','INS','RES','TXT') DEFAULT NULL COMMENT 'file type',
  `fileName` varchar(45) DEFAULT NULL COMMENT 'file name',
  `filePath` varchar(255) DEFAULT NULL COMMENT 'file path',
  `recordTimeStamp` datetime DEFAULT NULL COMMENT 'Creation or last update date/time',
  PRIMARY KEY (`phasingProgramAttachmentId`),
  KEY `PhasingProgramAttachment_FKIndex1` (`phasingProgramRunId`),
  CONSTRAINT `Phasing_phasingProgramAttachmentfk_1` FOREIGN KEY (`phasingProgramRunId`) REFERENCES `PhasingProgramRun` (`phasingProgramRunId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `PhasingProgramRun`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PhasingProgramRun` (
  `phasingProgramRunId` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key (auto-incremented)',
  `phasingCommandLine` varchar(255) DEFAULT NULL COMMENT 'Command line for phasing',
  `phasingPrograms` varchar(255) DEFAULT NULL COMMENT 'Phasing programs (comma separated)',
  `phasingStatus` tinyint(1) DEFAULT NULL COMMENT 'success (1) / fail (0)',
  `phasingMessage` varchar(255) DEFAULT NULL COMMENT 'warning, error,...',
  `phasingStartTime` datetime DEFAULT NULL COMMENT 'Processing start time',
  `phasingEndTime` datetime DEFAULT NULL COMMENT 'Processing end time',
  `phasingEnvironment` varchar(255) DEFAULT NULL COMMENT 'Cpus, Nodes,...',
  `recordTimeStamp` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`phasingProgramRunId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `PhasingStatistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PhasingStatistics` (
  `phasingStatisticsId` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key (auto-incremented)',
  `phasingHasScalingId1` int(11) unsigned NOT NULL COMMENT 'the dataset in question',
  `phasingHasScalingId2` int(11) unsigned DEFAULT NULL COMMENT 'if this is MIT or MAD, which scaling are being compared, null otherwise',
  `phasingStepId` int(10) unsigned DEFAULT NULL,
  `numberOfBins` int(11) DEFAULT NULL COMMENT 'the total number of bins',
  `binNumber` int(11) DEFAULT NULL COMMENT 'binNumber, 999 for overall',
  `lowRes` double DEFAULT NULL COMMENT 'low resolution cutoff of this binfloat',
  `highRes` double DEFAULT NULL COMMENT 'high resolution cutoff of this binfloat',
  `metric` enum('Rcullis','Average Fragment Length','Chain Count','Residues Count','CC','PhasingPower','FOM','<d"/sig>','Best CC','CC(1/2)','Weak CC','CFOM','Pseudo_free_CC','CC of partial model') DEFAULT NULL COMMENT 'metric',
  `statisticsValue` double DEFAULT NULL COMMENT 'the statistics value',
  `nReflections` int(11) DEFAULT NULL,
  `recordTimeStamp` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`phasingStatisticsId`),
  KEY `PhasingStatistics_FKIndex1` (`phasingHasScalingId1`),
  KEY `PhasingStatistics_FKIndex2` (`phasingHasScalingId2`),
  KEY `fk_PhasingStatistics_phasingStep_idx` (`phasingStepId`),
  CONSTRAINT `PhasingStatistics_phasingHasScalingfk_1` FOREIGN KEY (`phasingHasScalingId1`) REFERENCES `Phasing_has_Scaling` (`phasingHasScalingId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `PhasingStatistics_phasingHasScalingfk_2` FOREIGN KEY (`phasingHasScalingId2`) REFERENCES `Phasing_has_Scaling` (`phasingHasScalingId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_PhasingStatistics_phasingStep` FOREIGN KEY (`phasingStepId`) REFERENCES `PhasingStep` (`phasingStepId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `PhasingStep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PhasingStep` (
  `phasingStepId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `previousPhasingStepId` int(10) unsigned DEFAULT NULL,
  `programRunId` int(10) unsigned DEFAULT NULL,
  `spaceGroupId` int(10) unsigned DEFAULT NULL,
  `autoProcScalingId` int(10) unsigned DEFAULT NULL,
  `phasingAnalysisId` int(10) unsigned DEFAULT NULL,
  `phasingStepType` enum('PREPARE','SUBSTRUCTUREDETERMINATION','PHASING','MODELBUILDING') DEFAULT NULL,
  `method` varchar(45) DEFAULT NULL,
  `solventContent` varchar(45) DEFAULT NULL,
  `enantiomorph` varchar(45) DEFAULT NULL,
  `lowRes` varchar(45) DEFAULT NULL,
  `highRes` varchar(45) DEFAULT NULL,
  `recordTimeStamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`phasingStepId`),
  KEY `FK_programRun_id` (`programRunId`),
  KEY `FK_spacegroup_id` (`spaceGroupId`),
  KEY `FK_autoprocScaling_id` (`autoProcScalingId`),
  KEY `FK_phasingAnalysis_id` (`phasingAnalysisId`),
  CONSTRAINT `FK_autoprocScaling` FOREIGN KEY (`autoProcScalingId`) REFERENCES `AutoProcScaling` (`autoProcScalingId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_program` FOREIGN KEY (`programRunId`) REFERENCES `PhasingProgramRun` (`phasingProgramRunId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_spacegroup` FOREIGN KEY (`spaceGroupId`) REFERENCES `SpaceGroup` (`spaceGroupId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Phasing_has_Scaling`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Phasing_has_Scaling` (
  `phasingHasScalingId` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key (auto-incremented)',
  `phasingAnalysisId` int(11) unsigned NOT NULL COMMENT 'Related phasing analysis item',
  `autoProcScalingId` int(10) unsigned NOT NULL COMMENT 'Related autoProcScaling item',
  `datasetNumber` int(11) DEFAULT NULL COMMENT 'serial number of the dataset and always reserve 0 for the reference',
  `recordTimeStamp` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`phasingHasScalingId`),
  KEY `PhasingHasScaling_FKIndex1` (`phasingAnalysisId`),
  KEY `PhasingHasScaling_FKIndex2` (`autoProcScalingId`),
  CONSTRAINT `PhasingHasScaling_autoProcScalingfk_1` FOREIGN KEY (`autoProcScalingId`) REFERENCES `AutoProcScaling` (`autoProcScalingId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `PhasingHasScaling_phasingAnalysisfk_1` FOREIGN KEY (`phasingAnalysisId`) REFERENCES `PhasingAnalysis` (`phasingAnalysisId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Position` (
  `positionId` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key (auto-incremented)',
  `relativePositionId` int(11) unsigned DEFAULT NULL COMMENT 'relative position, null otherwise',
  `posX` double DEFAULT NULL,
  `posY` double DEFAULT NULL,
  `posZ` double DEFAULT NULL,
  `scale` double DEFAULT NULL,
  `recordTimeStamp` datetime DEFAULT NULL COMMENT 'Creation or last update date/time',
  `X` double GENERATED ALWAYS AS (`posX`) VIRTUAL,
  `Y` double GENERATED ALWAYS AS (`posY`) VIRTUAL,
  `Z` double GENERATED ALWAYS AS (`posZ`) VIRTUAL,
  PRIMARY KEY (`positionId`),
  KEY `Position_FKIndex1` (`relativePositionId`),
  CONSTRAINT `Position_relativePositionfk_1` FOREIGN KEY (`relativePositionId`) REFERENCES `Position` (`positionId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Positioner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Positioner` (
  `positionerId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `positioner` varchar(50) NOT NULL,
  `value` float NOT NULL,
  PRIMARY KEY (`positionerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='An arbitrary positioner and its value, could be e.g. a motor. Allows for instance to store some positions with a sample or subsample';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `PreparePhasingData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PreparePhasingData` (
  `preparePhasingDataId` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key (auto-incremented)',
  `phasingAnalysisId` int(11) unsigned NOT NULL COMMENT 'Related phasing analysis item',
  `phasingProgramRunId` int(11) unsigned NOT NULL COMMENT 'Related program item',
  `spaceGroupId` int(10) unsigned DEFAULT NULL COMMENT 'Related spaceGroup',
  `lowRes` double DEFAULT NULL,
  `highRes` double DEFAULT NULL,
  `recordTimeStamp` datetime DEFAULT NULL COMMENT 'Creation or last update date/time',
  PRIMARY KEY (`preparePhasingDataId`),
  KEY `PreparePhasingData_FKIndex1` (`phasingAnalysisId`),
  KEY `PreparePhasingData_FKIndex2` (`phasingProgramRunId`),
  KEY `PreparePhasingData_FKIndex3` (`spaceGroupId`),
  CONSTRAINT `PreparePhasingData_phasingAnalysisfk_1` FOREIGN KEY (`phasingAnalysisId`) REFERENCES `PhasingAnalysis` (`phasingAnalysisId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `PreparePhasingData_phasingProgramRunfk_1` FOREIGN KEY (`phasingProgramRunId`) REFERENCES `PhasingProgramRun` (`phasingProgramRunId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `PreparePhasingData_spaceGroupfk_1` FOREIGN KEY (`spaceGroupId`) REFERENCES `SpaceGroup` (`spaceGroupId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ProcessingJob`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProcessingJob` (
  `processingJobId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `dataCollectionId` int(11) unsigned DEFAULT NULL,
  `displayName` varchar(80) DEFAULT NULL COMMENT 'xia2, fast_dp, dimple, etc',
  `comments` varchar(255) DEFAULT NULL COMMENT 'For users to annotate the job and see the motivation for the job',
  `recordTimestamp` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'When job was submitted',
  `recipe` varchar(50) DEFAULT NULL COMMENT 'What we want to run (xia, dimple, etc).',
  `automatic` tinyint(1) DEFAULT NULL COMMENT 'Whether this processing job was triggered automatically or not',
  PRIMARY KEY (`processingJobId`),
  KEY `ProcessingJob_ibfk1` (`dataCollectionId`),
  CONSTRAINT `ProcessingJob_ibfk1` FOREIGN KEY (`dataCollectionId`) REFERENCES `DataCollection` (`dataCollectionId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='From this we get both job times and lag times';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ProcessingJobImageSweep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProcessingJobImageSweep` (
  `processingJobImageSweepId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `processingJobId` int(11) unsigned DEFAULT NULL,
  `dataCollectionId` int(11) unsigned DEFAULT NULL,
  `startImage` mediumint(8) unsigned DEFAULT NULL,
  `endImage` mediumint(8) unsigned DEFAULT NULL,
  PRIMARY KEY (`processingJobImageSweepId`),
  KEY `ProcessingJobImageSweep_ibfk1` (`processingJobId`),
  KEY `ProcessingJobImageSweep_ibfk2` (`dataCollectionId`),
  CONSTRAINT `ProcessingJobImageSweep_ibfk1` FOREIGN KEY (`processingJobId`) REFERENCES `ProcessingJob` (`processingJobId`),
  CONSTRAINT `ProcessingJobImageSweep_ibfk2` FOREIGN KEY (`dataCollectionId`) REFERENCES `DataCollection` (`dataCollectionId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='This allows multiple sweeps per processing job for multi-xia2';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ProcessingJobParameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProcessingJobParameter` (
  `processingJobParameterId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `processingJobId` int(11) unsigned DEFAULT NULL,
  `parameterKey` varchar(80) DEFAULT NULL COMMENT 'E.g. resolution, spacegroup, pipeline',
  `parameterValue` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`processingJobParameterId`),
  KEY `ProcessingJobParameter_ibfk1` (`processingJobId`),
  CONSTRAINT `ProcessingJobParameter_ibfk1` FOREIGN KEY (`processingJobId`) REFERENCES `ProcessingJob` (`processingJobId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ProcessingPipeline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProcessingPipeline` (
  `processingPipelineId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `processingPipelineCategoryId` int(11) unsigned DEFAULT NULL,
  `name` varchar(20) NOT NULL,
  `discipline` varchar(10) NOT NULL,
  `pipelineStatus` enum('automatic','optional','deprecated') DEFAULT NULL COMMENT 'Is the pipeline in operation or available',
  `reprocessing` tinyint(1) DEFAULT 1 COMMENT 'Pipeline is available for re-processing',
  PRIMARY KEY (`processingPipelineId`),
  KEY `ProcessingPipeline_fk1` (`processingPipelineCategoryId`),
  CONSTRAINT `ProcessingPipeline_fk1` FOREIGN KEY (`processingPipelineCategoryId`) REFERENCES `ProcessingPipelineCategory` (`processingPipelineCategoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='A lookup table for different processing pipelines and their categories';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ProcessingPipelineCategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProcessingPipelineCategory` (
  `processingPipelineCategoryId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`processingPipelineCategoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='A lookup table for the category of processing pipeline';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Project` (
  `projectId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `personId` int(11) unsigned DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `acronym` varchar(100) DEFAULT NULL,
  `owner` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`projectId`),
  KEY `Project_FK1` (`personId`),
  CONSTRAINT `Project_FK1` FOREIGN KEY (`personId`) REFERENCES `Person` (`personId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Project_has_BLSample`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Project_has_BLSample` (
  `projectId` int(11) unsigned NOT NULL,
  `blSampleId` int(11) unsigned NOT NULL,
  PRIMARY KEY (`projectId`,`blSampleId`),
  KEY `Project_has_BLSample_FK2` (`blSampleId`),
  CONSTRAINT `Project_has_BLSample_FK1` FOREIGN KEY (`projectId`) REFERENCES `Project` (`projectId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Project_has_BLSample_FK2` FOREIGN KEY (`blSampleId`) REFERENCES `BLSample` (`blSampleId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Project_has_DCGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Project_has_DCGroup` (
  `projectId` int(11) unsigned NOT NULL,
  `dataCollectionGroupId` int(11) NOT NULL,
  PRIMARY KEY (`projectId`,`dataCollectionGroupId`),
  KEY `Project_has_DCGroup_FK2` (`dataCollectionGroupId`),
  CONSTRAINT `Project_has_DCGroup_FK1` FOREIGN KEY (`projectId`) REFERENCES `Project` (`projectId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Project_has_DCGroup_FK2` FOREIGN KEY (`dataCollectionGroupId`) REFERENCES `DataCollectionGroup` (`dataCollectionGroupId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Project_has_EnergyScan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Project_has_EnergyScan` (
  `projectId` int(11) unsigned NOT NULL,
  `energyScanId` int(11) unsigned NOT NULL,
  PRIMARY KEY (`projectId`,`energyScanId`),
  KEY `project_has_energyscan_FK2` (`energyScanId`),
  CONSTRAINT `project_has_energyscan_FK1` FOREIGN KEY (`projectId`) REFERENCES `Project` (`projectId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `project_has_energyscan_FK2` FOREIGN KEY (`energyScanId`) REFERENCES `EnergyScan` (`energyScanId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Project_has_Person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Project_has_Person` (
  `projectId` int(11) unsigned NOT NULL,
  `personId` int(11) unsigned NOT NULL,
  PRIMARY KEY (`projectId`,`personId`),
  KEY `project_has_person_FK2` (`personId`),
  CONSTRAINT `project_has_person_FK1` FOREIGN KEY (`projectId`) REFERENCES `Project` (`projectId`) ON DELETE CASCADE,
  CONSTRAINT `project_has_person_FK2` FOREIGN KEY (`personId`) REFERENCES `Person` (`personId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Project_has_Protein`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Project_has_Protein` (
  `projectId` int(11) unsigned NOT NULL,
  `proteinId` int(11) unsigned NOT NULL,
  PRIMARY KEY (`projectId`,`proteinId`),
  KEY `project_has_protein_FK2` (`proteinId`),
  CONSTRAINT `project_has_protein_FK1` FOREIGN KEY (`projectId`) REFERENCES `Project` (`projectId`) ON DELETE CASCADE,
  CONSTRAINT `project_has_protein_FK2` FOREIGN KEY (`proteinId`) REFERENCES `Protein` (`proteinId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Project_has_Session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Project_has_Session` (
  `projectId` int(11) unsigned NOT NULL,
  `sessionId` int(11) unsigned NOT NULL,
  PRIMARY KEY (`projectId`,`sessionId`),
  KEY `project_has_session_FK2` (`sessionId`),
  CONSTRAINT `project_has_session_FK1` FOREIGN KEY (`projectId`) REFERENCES `Project` (`projectId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `project_has_session_FK2` FOREIGN KEY (`sessionId`) REFERENCES `BLSession` (`sessionId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Project_has_Shipping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Project_has_Shipping` (
  `projectId` int(11) unsigned NOT NULL,
  `shippingId` int(11) unsigned NOT NULL,
  PRIMARY KEY (`projectId`,`shippingId`),
  KEY `project_has_shipping_FK2` (`shippingId`),
  CONSTRAINT `project_has_shipping_FK1` FOREIGN KEY (`projectId`) REFERENCES `Project` (`projectId`) ON DELETE CASCADE,
  CONSTRAINT `project_has_shipping_FK2` FOREIGN KEY (`shippingId`) REFERENCES `Shipping` (`shippingId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Project_has_User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Project_has_User` (
  `projecthasuserid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `projectid` int(11) unsigned NOT NULL,
  `username` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`projecthasuserid`),
  KEY `Project_Has_user_FK1` (`projectid`),
  CONSTRAINT `Project_Has_user_FK1` FOREIGN KEY (`projectid`) REFERENCES `Project` (`projectId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Project_has_XFEFSpectrum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Project_has_XFEFSpectrum` (
  `projectId` int(11) unsigned NOT NULL,
  `xfeFluorescenceSpectrumId` int(11) unsigned NOT NULL,
  PRIMARY KEY (`projectId`,`xfeFluorescenceSpectrumId`),
  KEY `project_has_xfefspectrum_FK2` (`xfeFluorescenceSpectrumId`),
  CONSTRAINT `project_has_xfefspectrum_FK1` FOREIGN KEY (`projectId`) REFERENCES `Project` (`projectId`) ON DELETE CASCADE,
  CONSTRAINT `project_has_xfefspectrum_FK2` FOREIGN KEY (`xfeFluorescenceSpectrumId`) REFERENCES `XFEFluorescenceSpectrum` (`xfeFluorescenceSpectrumId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Proposal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Proposal` (
  `proposalId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `personId` int(10) unsigned NOT NULL DEFAULT 0,
  `title` varchar(200) DEFAULT NULL,
  `proposalCode` varchar(45) DEFAULT NULL,
  `proposalNumber` varchar(45) DEFAULT NULL,
  `bltimeStamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `proposalType` varchar(2) DEFAULT NULL COMMENT 'Proposal type: MX, BX',
  `externalId` binary(16) DEFAULT NULL,
  `state` enum('Open','Closed','Cancelled') DEFAULT 'Open',
  PRIMARY KEY (`proposalId`),
  UNIQUE KEY `Proposal_FKIndexCodeNumber` (`proposalCode`,`proposalNumber`),
  KEY `Proposal_FKIndex1` (`personId`),
  CONSTRAINT `Proposal_ibfk_1` FOREIGN KEY (`personId`) REFERENCES `Person` (`personId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ProposalHasPerson`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProposalHasPerson` (
  `proposalHasPersonId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `proposalId` int(10) unsigned NOT NULL,
  `personId` int(10) unsigned NOT NULL,
  `role` enum('Co-Investigator','Principal Investigator','Alternate Contact','ERA Admin','Associate') DEFAULT NULL,
  PRIMARY KEY (`proposalHasPersonId`),
  KEY `fk_ProposalHasPerson_Proposal` (`proposalId`),
  KEY `fk_ProposalHasPerson_Personal` (`personId`),
  CONSTRAINT `fk_ProposalHasPerson_Personal` FOREIGN KEY (`personId`) REFERENCES `Person` (`personId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProposalHasPerson_Proposal` FOREIGN KEY (`proposalId`) REFERENCES `Proposal` (`proposalId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Protein`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Protein` (
  `proteinId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `proposalId` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `acronym` varchar(45) DEFAULT NULL,
  `description` text DEFAULT NULL COMMENT 'A description/summary using words and sentences',
  `hazardGroup` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT 'A.k.a. risk group',
  `containmentLevel` tinyint(3) unsigned NOT NULL DEFAULT 1 COMMENT 'A.k.a. biosafety level, which indicates the level of containment required',
  `safetyLevel` enum('GREEN','YELLOW','RED') DEFAULT NULL,
  `molecularMass` double DEFAULT NULL,
  `proteinType` varchar(45) DEFAULT NULL,
  `personId` int(10) unsigned DEFAULT NULL,
  `bltimeStamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `isCreatedBySampleSheet` tinyint(1) DEFAULT 0,
  `sequence` text DEFAULT NULL,
  `MOD_ID` varchar(20) DEFAULT NULL,
  `componentTypeId` int(11) unsigned DEFAULT NULL,
  `concentrationTypeId` int(11) unsigned DEFAULT NULL,
  `global` tinyint(1) DEFAULT 0,
  `externalId` binary(16) DEFAULT NULL,
  `density` float DEFAULT NULL,
  `abundance` float DEFAULT NULL COMMENT 'Deprecated',
  `isotropy` enum('isotropic','anisotropic') DEFAULT NULL,
  PRIMARY KEY (`proteinId`),
  KEY `ProteinAcronym_Index` (`proposalId`,`acronym`),
  KEY `Protein_FKIndex2` (`personId`),
  KEY `Protein_Index2` (`acronym`),
  KEY `protein_fk3` (`componentTypeId`),
  KEY `protein_fk4` (`concentrationTypeId`),
  CONSTRAINT `Protein_ibfk_1` FOREIGN KEY (`proposalId`) REFERENCES `Proposal` (`proposalId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `protein_fk3` FOREIGN KEY (`componentTypeId`) REFERENCES `ComponentType` (`componentTypeId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `protein_fk4` FOREIGN KEY (`concentrationTypeId`) REFERENCES `ConcentrationType` (`concentrationTypeId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Protein_has_PDB`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Protein_has_PDB` (
  `proteinhaspdbid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `proteinid` int(11) unsigned NOT NULL,
  `pdbid` int(11) unsigned NOT NULL,
  PRIMARY KEY (`proteinhaspdbid`),
  KEY `Protein_Has_PDB_fk1` (`proteinid`),
  KEY `Protein_Has_PDB_fk2` (`pdbid`),
  CONSTRAINT `Protein_Has_PDB_fk1` FOREIGN KEY (`proteinid`) REFERENCES `Protein` (`proteinId`),
  CONSTRAINT `Protein_Has_PDB_fk2` FOREIGN KEY (`pdbid`) REFERENCES `PDB` (`pdbId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `PurificationColumn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PurificationColumn` (
  `purificationColumnId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `active` tinyint(1) DEFAULT 1 COMMENT '1=active, 0=inactive',
  PRIMARY KEY (`purificationColumnId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='Size exclusion chromotography (SEC) lookup table for BioSAXS';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `RelativeIceThickness`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RelativeIceThickness` (
  `relativeIceThicknessId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `motionCorrectionId` int(11) unsigned DEFAULT NULL,
  `autoProcProgramId` int(11) unsigned DEFAULT NULL,
  `minimum` float DEFAULT NULL COMMENT 'Minimum relative ice thickness, Unitless',
  `q1` float DEFAULT NULL COMMENT 'Quartile 1, unitless',
  `median` float DEFAULT NULL COMMENT 'Median relative ice thickness, Unitless',
  `q3` float DEFAULT NULL COMMENT 'Quartile 3, unitless',
  `maximum` float DEFAULT NULL COMMENT 'Minimum relative ice thickness, Unitless',
  PRIMARY KEY (`relativeIceThicknessId`),
  KEY `RelativeIceThickness_fk_programId` (`autoProcProgramId`),
  KEY `RelativeIceThickness_fk_motionCorrectionId` (`motionCorrectionId`),
  CONSTRAINT `RelativeIceThickness_fk_motionCorrectionId` FOREIGN KEY (`motionCorrectionId`) REFERENCES `MotionCorrection` (`motionCorrectionId`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `RelativeIceThickness_fk_programId` FOREIGN KEY (`autoProcProgramId`) REFERENCES `AutoProcProgram` (`autoProcProgramId`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `RobotAction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RobotAction` (
  `robotActionId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `blsessionId` int(11) unsigned NOT NULL,
  `blsampleId` int(11) unsigned DEFAULT NULL,
  `actionType` enum('LOAD','UNLOAD','DISPOSE','STORE','WASH','ANNEAL','MOSAIC') DEFAULT NULL,
  `startTimestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `endTimestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `status` enum('SUCCESS','ERROR','CRITICAL','WARNING','EPICSFAIL','COMMANDNOTSENT') DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `containerLocation` smallint(6) DEFAULT NULL,
  `dewarLocation` smallint(6) DEFAULT NULL,
  `sampleBarcode` varchar(45) DEFAULT NULL,
  `xtalSnapshotBefore` varchar(255) DEFAULT NULL,
  `xtalSnapshotAfter` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`robotActionId`),
  KEY `RobotAction_FK1` (`blsessionId`),
  KEY `RobotAction_FK2` (`blsampleId`),
  CONSTRAINT `RobotAction_FK1` FOREIGN KEY (`blsessionId`) REFERENCES `BLSession` (`sessionId`),
  CONSTRAINT `RobotAction_FK2` FOREIGN KEY (`blsampleId`) REFERENCES `BLSample` (`blSampleId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='Robot actions as reported by GDA';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `SSXDataCollection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SSXDataCollection` (
  `dataCollectionId` int(11) unsigned NOT NULL COMMENT 'Primary key is same as dataCollection (1 to 1).',
  `repetitionRate` float DEFAULT NULL,
  `energyBandwidth` float DEFAULT NULL,
  `monoStripe` varchar(255) DEFAULT NULL,
  `jetSpeed` float DEFAULT NULL COMMENT 'For jet experiments.',
  `jetSize` float DEFAULT NULL COMMENT 'For jet experiments.',
  `chipPattern` varchar(255) DEFAULT NULL COMMENT 'For chip experiments.',
  `chipModel` varchar(255) DEFAULT NULL COMMENT 'For chip experiments.',
  `reactionDuration` float DEFAULT NULL COMMENT 'When images are taken at constant time relative to reaction start.',
  `laserEnergy` float DEFAULT NULL,
  `experimentName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`dataCollectionId`),
  CONSTRAINT `SSXDataCollection_ibfk_1` FOREIGN KEY (`dataCollectionId`) REFERENCES `DataCollection` (`dataCollectionId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Extends DataCollection with SSX-specific fields.';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `SW_onceToken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SW_onceToken` (
  `onceTokenId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `token` varchar(128) DEFAULT NULL,
  `personId` int(10) unsigned DEFAULT NULL,
  `proposalId` int(10) unsigned DEFAULT NULL,
  `validity` varchar(200) DEFAULT NULL,
  `recordTimeStamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`onceTokenId`),
  KEY `SW_onceToken_fk1` (`personId`),
  KEY `SW_onceToken_fk2` (`proposalId`),
  KEY `SW_onceToken_recordTimeStamp_idx` (`recordTimeStamp`),
  CONSTRAINT `SW_onceToken_fk1` FOREIGN KEY (`personId`) REFERENCES `Person` (`personId`),
  CONSTRAINT `SW_onceToken_fk2` FOREIGN KEY (`proposalId`) REFERENCES `Proposal` (`proposalId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='One-time use tokens needed for token auth in order to grant access to file downloads and webcams (and some images)';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `SampleComposition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SampleComposition` (
  `sampleCompositionId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `componentId` int(11) unsigned NOT NULL,
  `blSampleId` int(11) unsigned NOT NULL,
  `concentrationTypeId` int(11) unsigned DEFAULT NULL,
  `abundance` float DEFAULT NULL COMMENT 'Abundance or concentration in the unit defined by concentrationTypeId.',
  `ratio` float DEFAULT NULL,
  `pH` float DEFAULT NULL,
  PRIMARY KEY (`sampleCompositionId`),
  KEY `componentId` (`componentId`),
  KEY `blSampleId` (`blSampleId`),
  KEY `concentrationTypeId` (`concentrationTypeId`),
  CONSTRAINT `SampleComposition_ibfk_1` FOREIGN KEY (`componentId`) REFERENCES `Component` (`componentId`),
  CONSTRAINT `SampleComposition_ibfk_2` FOREIGN KEY (`blSampleId`) REFERENCES `BLSample` (`blSampleId`),
  CONSTRAINT `SampleComposition_ibfk_3` FOREIGN KEY (`concentrationTypeId`) REFERENCES `ConcentrationType` (`concentrationTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Links a sample to its components with a specified abundance or ratio.';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ScanParametersModel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ScanParametersModel` (
  `scanParametersModelId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `scanParametersServiceId` int(10) unsigned DEFAULT NULL,
  `dataCollectionPlanId` int(11) unsigned DEFAULT NULL,
  `sequenceNumber` tinyint(3) unsigned DEFAULT NULL,
  `start` double DEFAULT NULL,
  `stop` double DEFAULT NULL,
  `step` double DEFAULT NULL,
  `array` text DEFAULT NULL,
  `duration` mediumint(8) unsigned DEFAULT NULL COMMENT 'Duration for parameter change in seconds',
  PRIMARY KEY (`scanParametersModelId`),
  KEY `PDF_Model_ibfk1` (`scanParametersServiceId`),
  KEY `PDF_Model_ibfk2` (`dataCollectionPlanId`),
  CONSTRAINT `PDF_Model_ibfk1` FOREIGN KEY (`scanParametersServiceId`) REFERENCES `ScanParametersService` (`scanParametersServiceId`) ON UPDATE CASCADE,
  CONSTRAINT `PDF_Model_ibfk2` FOREIGN KEY (`dataCollectionPlanId`) REFERENCES `DiffractionPlan` (`diffractionPlanId`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ScanParametersService`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ScanParametersService` (
  `scanParametersServiceId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `description` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`scanParametersServiceId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Schedule` (
  `scheduleId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`scheduleId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ScheduleComponent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ScheduleComponent` (
  `scheduleComponentId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `scheduleId` int(11) unsigned NOT NULL,
  `offset_hours` int(11) DEFAULT NULL,
  `inspectionTypeId` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`scheduleComponentId`),
  KEY `ScheduleComponent_idx1` (`scheduleId`),
  KEY `ScheduleComponent_fk2` (`inspectionTypeId`),
  CONSTRAINT `ScheduleComponent_fk1` FOREIGN KEY (`scheduleId`) REFERENCES `Schedule` (`scheduleId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ScheduleComponent_fk2` FOREIGN KEY (`inspectionTypeId`) REFERENCES `InspectionType` (`inspectionTypeId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `SchemaStatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SchemaStatus` (
  `schemaStatusId` int(11) NOT NULL AUTO_INCREMENT,
  `scriptName` varchar(100) NOT NULL,
  `schemaStatus` varchar(10) DEFAULT NULL,
  `recordTimeStamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`schemaStatusId`),
  UNIQUE KEY `scriptName` (`scriptName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Screen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Screen` (
  `screenId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `proposalId` int(10) unsigned DEFAULT NULL,
  `global` tinyint(1) DEFAULT NULL,
  `containerTypeId` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`screenId`),
  KEY `Screen_fk1` (`proposalId`),
  KEY `Screen_fk_containerTypeId` (`containerTypeId`),
  CONSTRAINT `Screen_fk1` FOREIGN KEY (`proposalId`) REFERENCES `Proposal` (`proposalId`),
  CONSTRAINT `Screen_fk_containerTypeId` FOREIGN KEY (`containerTypeId`) REFERENCES `ContainerType` (`containerTypeId`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ScreenComponent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ScreenComponent` (
  `screenComponentId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `screenComponentGroupId` int(11) unsigned NOT NULL,
  `componentId` int(11) unsigned DEFAULT NULL,
  `concentration` float DEFAULT NULL,
  `pH` float DEFAULT NULL,
  PRIMARY KEY (`screenComponentId`),
  KEY `ScreenComponent_fk1` (`screenComponentGroupId`),
  KEY `ScreenComponent_fk2` (`componentId`),
  CONSTRAINT `ScreenComponent_fk1` FOREIGN KEY (`screenComponentGroupId`) REFERENCES `ScreenComponentGroup` (`screenComponentGroupId`),
  CONSTRAINT `ScreenComponent_fk2` FOREIGN KEY (`componentId`) REFERENCES `Protein` (`proteinId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ScreenComponentGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ScreenComponentGroup` (
  `screenComponentGroupId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `screenId` int(11) unsigned NOT NULL,
  `position` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`screenComponentGroupId`),
  KEY `ScreenComponentGroup_fk1` (`screenId`),
  CONSTRAINT `ScreenComponentGroup_fk1` FOREIGN KEY (`screenId`) REFERENCES `Screen` (`screenId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Screening`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Screening` (
  `screeningId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dataCollectionId` int(11) unsigned DEFAULT NULL,
  `bltimeStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `programVersion` varchar(45) DEFAULT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `shortComments` varchar(20) DEFAULT NULL,
  `diffractionPlanId` int(10) unsigned DEFAULT NULL COMMENT 'references DiffractionPlan',
  `dataCollectionGroupId` int(11) DEFAULT NULL,
  `xmlSampleInformation` longblob DEFAULT NULL,
  `autoProcProgramId` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`screeningId`),
  KEY `Screening_FKIndexDiffractionPlanId` (`diffractionPlanId`),
  KEY `dcgroupId` (`dataCollectionGroupId`),
  KEY `_Screening_ibfk2` (`dataCollectionId`),
  KEY `Screening_fk_autoProcProgramId` (`autoProcProgramId`),
  CONSTRAINT `Screening_fk_autoProcProgramId` FOREIGN KEY (`autoProcProgramId`) REFERENCES `AutoProcProgram` (`autoProcProgramId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Screening_ibfk_1` FOREIGN KEY (`dataCollectionGroupId`) REFERENCES `DataCollectionGroup` (`dataCollectionGroupId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `_Screening_ibfk2` FOREIGN KEY (`dataCollectionId`) REFERENCES `DataCollection` (`dataCollectionId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ScreeningInput`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ScreeningInput` (
  `screeningInputId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `screeningId` int(10) unsigned NOT NULL DEFAULT 0,
  `beamX` float DEFAULT NULL,
  `beamY` float DEFAULT NULL,
  `rmsErrorLimits` float DEFAULT NULL,
  `minimumFractionIndexed` float DEFAULT NULL,
  `maximumFractionRejected` float DEFAULT NULL,
  `minimumSignalToNoise` float DEFAULT NULL,
  `diffractionPlanId` int(10) DEFAULT NULL COMMENT 'references DiffractionPlan table',
  `xmlSampleInformation` longblob DEFAULT NULL,
  PRIMARY KEY (`screeningInputId`),
  KEY `ScreeningInput_FKIndex1` (`screeningId`),
  CONSTRAINT `ScreeningInput_ibfk_1` FOREIGN KEY (`screeningId`) REFERENCES `Screening` (`screeningId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ScreeningOutput`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ScreeningOutput` (
  `screeningOutputId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `screeningId` int(10) unsigned NOT NULL DEFAULT 0,
  `statusDescription` varchar(1024) DEFAULT NULL,
  `rejectedReflections` int(10) unsigned DEFAULT NULL,
  `resolutionObtained` float DEFAULT NULL,
  `spotDeviationR` float DEFAULT NULL,
  `spotDeviationTheta` float DEFAULT NULL,
  `beamShiftX` float DEFAULT NULL,
  `beamShiftY` float DEFAULT NULL,
  `numSpotsFound` int(10) unsigned DEFAULT NULL,
  `numSpotsUsed` int(10) unsigned DEFAULT NULL,
  `numSpotsRejected` int(10) unsigned DEFAULT NULL,
  `mosaicity` float DEFAULT NULL,
  `iOverSigma` float DEFAULT NULL,
  `diffractionRings` tinyint(1) DEFAULT NULL,
  `SCREENINGSUCCESS` tinyint(1) DEFAULT 0 COMMENT 'Column to be deleted',
  `mosaicityEstimated` tinyint(1) NOT NULL DEFAULT 0,
  `rankingResolution` double DEFAULT NULL,
  `program` varchar(45) DEFAULT NULL,
  `doseTotal` double DEFAULT NULL,
  `totalExposureTime` double DEFAULT NULL,
  `totalRotationRange` double DEFAULT NULL,
  `totalNumberOfImages` int(11) DEFAULT NULL,
  `rFriedel` double DEFAULT NULL,
  `indexingSuccess` tinyint(1) NOT NULL DEFAULT 0,
  `strategySuccess` tinyint(1) NOT NULL DEFAULT 0,
  `alignmentSuccess` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`screeningOutputId`),
  KEY `ScreeningOutput_FKIndex1` (`screeningId`),
  CONSTRAINT `ScreeningOutput_ibfk_1` FOREIGN KEY (`screeningId`) REFERENCES `Screening` (`screeningId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ScreeningOutputLattice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ScreeningOutputLattice` (
  `screeningOutputLatticeId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `screeningOutputId` int(10) unsigned NOT NULL DEFAULT 0,
  `spaceGroup` varchar(45) DEFAULT NULL,
  `pointGroup` varchar(45) DEFAULT NULL,
  `bravaisLattice` varchar(45) DEFAULT NULL,
  `rawOrientationMatrix_a_x` float DEFAULT NULL,
  `rawOrientationMatrix_a_y` float DEFAULT NULL,
  `rawOrientationMatrix_a_z` float DEFAULT NULL,
  `rawOrientationMatrix_b_x` float DEFAULT NULL,
  `rawOrientationMatrix_b_y` float DEFAULT NULL,
  `rawOrientationMatrix_b_z` float DEFAULT NULL,
  `rawOrientationMatrix_c_x` float DEFAULT NULL,
  `rawOrientationMatrix_c_y` float DEFAULT NULL,
  `rawOrientationMatrix_c_z` float DEFAULT NULL,
  `unitCell_a` float DEFAULT NULL,
  `unitCell_b` float DEFAULT NULL,
  `unitCell_c` float DEFAULT NULL,
  `unitCell_alpha` float DEFAULT NULL,
  `unitCell_beta` float DEFAULT NULL,
  `unitCell_gamma` float DEFAULT NULL,
  `bltimeStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `labelitIndexing` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`screeningOutputLatticeId`),
  KEY `ScreeningOutputLattice_FKIndex1` (`screeningOutputId`),
  CONSTRAINT `ScreeningOutputLattice_ibfk_1` FOREIGN KEY (`screeningOutputId`) REFERENCES `ScreeningOutput` (`screeningOutputId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ScreeningRank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ScreeningRank` (
  `screeningRankId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `screeningRankSetId` int(10) unsigned NOT NULL DEFAULT 0,
  `screeningId` int(10) unsigned NOT NULL DEFAULT 0,
  `rankValue` float DEFAULT NULL,
  `rankInformation` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`screeningRankId`),
  KEY `ScreeningRank_FKIndex1` (`screeningId`),
  KEY `ScreeningRank_FKIndex2` (`screeningRankSetId`),
  CONSTRAINT `ScreeningRank_ibfk_1` FOREIGN KEY (`screeningId`) REFERENCES `Screening` (`screeningId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ScreeningRank_ibfk_2` FOREIGN KEY (`screeningRankSetId`) REFERENCES `ScreeningRankSet` (`screeningRankSetId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ScreeningRankSet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ScreeningRankSet` (
  `screeningRankSetId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rankEngine` varchar(255) DEFAULT NULL,
  `rankingProjectFileName` varchar(255) DEFAULT NULL,
  `rankingSummaryFileName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`screeningRankSetId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ScreeningStrategy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ScreeningStrategy` (
  `screeningStrategyId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `screeningOutputId` int(10) unsigned NOT NULL DEFAULT 0,
  `phiStart` float DEFAULT NULL,
  `phiEnd` float DEFAULT NULL,
  `rotation` float DEFAULT NULL,
  `exposureTime` float DEFAULT NULL,
  `resolution` float DEFAULT NULL,
  `completeness` float DEFAULT NULL,
  `multiplicity` float DEFAULT NULL,
  `anomalous` tinyint(1) NOT NULL DEFAULT 0,
  `program` varchar(45) DEFAULT NULL,
  `rankingResolution` float DEFAULT NULL,
  `transmission` float DEFAULT NULL COMMENT 'Transmission for the strategy as given by the strategy program.',
  PRIMARY KEY (`screeningStrategyId`),
  KEY `ScreeningStrategy_FKIndex1` (`screeningOutputId`),
  CONSTRAINT `ScreeningStrategy_ibfk_1` FOREIGN KEY (`screeningOutputId`) REFERENCES `ScreeningOutput` (`screeningOutputId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ScreeningStrategySubWedge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ScreeningStrategySubWedge` (
  `screeningStrategySubWedgeId` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `screeningStrategyWedgeId` int(10) unsigned DEFAULT NULL COMMENT 'Foreign key to parent table',
  `subWedgeNumber` int(10) unsigned DEFAULT NULL COMMENT 'The number of this subwedge within the wedge',
  `rotationAxis` varchar(45) DEFAULT NULL COMMENT 'Angle where subwedge starts',
  `axisStart` float DEFAULT NULL COMMENT 'Angle where subwedge ends',
  `axisEnd` float DEFAULT NULL COMMENT 'Exposure time for subwedge',
  `exposureTime` float DEFAULT NULL COMMENT 'Transmission for subwedge',
  `transmission` float DEFAULT NULL,
  `oscillationRange` float DEFAULT NULL,
  `completeness` float DEFAULT NULL,
  `multiplicity` float DEFAULT NULL,
  `RESOLUTION` float DEFAULT NULL,
  `doseTotal` float DEFAULT NULL COMMENT 'Total dose for this subwedge',
  `numberOfImages` int(10) unsigned DEFAULT NULL COMMENT 'Number of images for this subwedge',
  `comments` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`screeningStrategySubWedgeId`),
  KEY `ScreeningStrategySubWedge_FK1` (`screeningStrategyWedgeId`),
  CONSTRAINT `ScreeningStrategySubWedge_FK1` FOREIGN KEY (`screeningStrategyWedgeId`) REFERENCES `ScreeningStrategyWedge` (`screeningStrategyWedgeId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ScreeningStrategyWedge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ScreeningStrategyWedge` (
  `screeningStrategyWedgeId` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `screeningStrategyId` int(10) unsigned DEFAULT NULL COMMENT 'Foreign key to parent table',
  `wedgeNumber` int(10) unsigned DEFAULT NULL COMMENT 'The number of this wedge within the strategy',
  `resolution` float DEFAULT NULL,
  `completeness` float DEFAULT NULL,
  `multiplicity` float DEFAULT NULL,
  `doseTotal` float DEFAULT NULL COMMENT 'Total dose for this wedge',
  `numberOfImages` int(10) unsigned DEFAULT NULL COMMENT 'Number of images for this wedge',
  `phi` float DEFAULT NULL,
  `kappa` float DEFAULT NULL,
  `chi` float DEFAULT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `wavelength` double DEFAULT NULL,
  PRIMARY KEY (`screeningStrategyWedgeId`),
  KEY `ScreeningStrategyWedge_IBFK_1` (`screeningStrategyId`),
  CONSTRAINT `ScreeningStrategyWedge_IBFK_1` FOREIGN KEY (`screeningStrategyId`) REFERENCES `ScreeningStrategy` (`screeningStrategyId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `SessionType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SessionType` (
  `sessionTypeId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sessionId` int(10) unsigned NOT NULL,
  `typeName` varchar(31) NOT NULL,
  PRIMARY KEY (`sessionTypeId`),
  KEY `SessionType_FKIndex1` (`sessionId`),
  CONSTRAINT `SessionType_ibfk_1` FOREIGN KEY (`sessionId`) REFERENCES `BLSession` (`sessionId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Session_has_Person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Session_has_Person` (
  `sessionId` int(10) unsigned NOT NULL DEFAULT 0,
  `personId` int(10) unsigned NOT NULL DEFAULT 0,
  `role` enum('Local Contact','Local Contact 2','Staff','Team Leader','Co-Investigator','Principal Investigator','Alternate Contact','Data Access','Team Member','ERA Admin','Associate') DEFAULT NULL,
  `remote` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`sessionId`,`personId`),
  KEY `Session_has_Person_FKIndex2` (`personId`),
  CONSTRAINT `Session_has_Person_ibfk_1` FOREIGN KEY (`sessionId`) REFERENCES `BLSession` (`sessionId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Session_has_Person_ibfk_2` FOREIGN KEY (`personId`) REFERENCES `Person` (`personId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Shipping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Shipping` (
  `shippingId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `proposalId` int(10) unsigned NOT NULL DEFAULT 0,
  `shippingName` varchar(45) DEFAULT NULL,
  `deliveryAgent_agentName` varchar(45) DEFAULT NULL,
  `deliveryAgent_shippingDate` date DEFAULT NULL,
  `deliveryAgent_deliveryDate` date DEFAULT NULL,
  `deliveryAgent_agentCode` varchar(45) DEFAULT NULL,
  `deliveryAgent_flightCode` varchar(45) DEFAULT NULL,
  `shippingStatus` varchar(45) DEFAULT NULL,
  `bltimeStamp` datetime DEFAULT NULL,
  `laboratoryId` int(10) unsigned DEFAULT NULL,
  `isStorageShipping` tinyint(1) DEFAULT 0,
  `creationDate` datetime DEFAULT NULL,
  `comments` varchar(1000) DEFAULT NULL,
  `sendingLabContactId` int(10) unsigned DEFAULT NULL,
  `returnLabContactId` int(10) unsigned DEFAULT NULL,
  `returnCourier` varchar(45) DEFAULT NULL,
  `dateOfShippingToUser` datetime DEFAULT NULL,
  `shippingType` varchar(45) DEFAULT NULL,
  `SAFETYLEVEL` varchar(8) DEFAULT NULL,
  `deliveryAgent_flightCodeTimestamp` timestamp NULL DEFAULT NULL COMMENT 'Date flight code created, if automatic',
  `deliveryAgent_label` text DEFAULT NULL COMMENT 'Base64 encoded pdf of airway label',
  `readyByTime` time DEFAULT NULL COMMENT 'Time shipment will be ready',
  `closeTime` time DEFAULT NULL COMMENT 'Time after which shipment cannot be picked up',
  `physicalLocation` varchar(50) DEFAULT NULL COMMENT 'Where shipment can be picked up from: i.e. Stores',
  `deliveryAgent_pickupConfirmationTimestamp` timestamp NULL DEFAULT NULL COMMENT 'Date picked confirmed',
  `deliveryAgent_pickupConfirmation` varchar(10) DEFAULT NULL COMMENT 'Confirmation number of requested pickup',
  `deliveryAgent_readyByTime` time DEFAULT NULL COMMENT 'Confirmed ready-by time',
  `deliveryAgent_callinTime` time DEFAULT NULL COMMENT 'Confirmed courier call-in time',
  `deliveryAgent_productcode` varchar(10) DEFAULT NULL COMMENT 'A code that identifies which shipment service was used',
  `deliveryAgent_flightCodePersonId` int(10) unsigned DEFAULT NULL COMMENT 'The person who created the AWB (for auditing)',
  `extra` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'JSON column for facility-specific or hard-to-define attributes' CHECK (json_valid(`extra`)),
  PRIMARY KEY (`shippingId`),
  KEY `laboratoryId` (`laboratoryId`),
  KEY `Shipping_FKIndex1` (`proposalId`),
  KEY `Shipping_FKIndex2` (`sendingLabContactId`),
  KEY `Shipping_FKIndex3` (`returnLabContactId`),
  KEY `Shipping_FKIndexCreationDate` (`creationDate`),
  KEY `Shipping_FKIndexName` (`shippingName`),
  KEY `Shipping_FKIndexStatus` (`shippingStatus`),
  KEY `Shipping_ibfk_4` (`deliveryAgent_flightCodePersonId`),
  CONSTRAINT `Shipping_ibfk_1` FOREIGN KEY (`proposalId`) REFERENCES `Proposal` (`proposalId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Shipping_ibfk_2` FOREIGN KEY (`sendingLabContactId`) REFERENCES `LabContact` (`labContactId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Shipping_ibfk_3` FOREIGN KEY (`returnLabContactId`) REFERENCES `LabContact` (`labContactId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Shipping_ibfk_4` FOREIGN KEY (`deliveryAgent_flightCodePersonId`) REFERENCES `Person` (`personId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ShippingHasSession`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ShippingHasSession` (
  `shippingId` int(10) unsigned NOT NULL,
  `sessionId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`shippingId`,`sessionId`),
  KEY `ShippingHasSession_FKIndex2` (`sessionId`),
  CONSTRAINT `ShippingHasSession_ibfk_1` FOREIGN KEY (`shippingId`) REFERENCES `Shipping` (`shippingId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ShippingHasSession_ibfk_2` FOREIGN KEY (`sessionId`) REFERENCES `BLSession` (`sessionId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Sleeve`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Sleeve` (
  `sleeveId` tinyint(3) unsigned NOT NULL COMMENT 'The unique sleeve id 1...255 which also identifies its home location in the freezer',
  `location` tinyint(3) unsigned DEFAULT NULL COMMENT 'NULL == freezer, 1...255 for local storage locations',
  `lastMovedToFreezer` timestamp NOT NULL DEFAULT current_timestamp(),
  `lastMovedFromFreezer` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`sleeveId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='Registry of ice-filled sleeves used to cool plates whilst on the goniometer';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `SpaceGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SpaceGroup` (
  `spaceGroupId` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `spaceGroupNumber` int(10) unsigned DEFAULT NULL COMMENT 'ccp4 number pr IUCR',
  `spaceGroupShortName` varchar(45) DEFAULT NULL COMMENT 'short name without blank',
  `spaceGroupName` varchar(45) DEFAULT NULL COMMENT 'verbose name',
  `bravaisLattice` varchar(45) DEFAULT NULL COMMENT 'short name',
  `bravaisLatticeName` varchar(45) DEFAULT NULL COMMENT 'verbose name',
  `pointGroup` varchar(45) DEFAULT NULL COMMENT 'point group',
  `geometryClassnameId` int(11) unsigned DEFAULT NULL,
  `MX_used` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 if used in the crystal form',
  PRIMARY KEY (`spaceGroupId`),
  KEY `geometryClassnameId` (`geometryClassnameId`),
  KEY `SpaceGroup_FKShortName` (`spaceGroupShortName`),
  CONSTRAINT `SpaceGroup_ibfk_1` FOREIGN KEY (`geometryClassnameId`) REFERENCES `GeometryClassname` (`geometryClassnameId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `SubstructureDetermination`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SubstructureDetermination` (
  `substructureDeterminationId` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key (auto-incremented)',
  `phasingAnalysisId` int(11) unsigned NOT NULL COMMENT 'Related phasing analysis item',
  `phasingProgramRunId` int(11) unsigned NOT NULL COMMENT 'Related program item',
  `spaceGroupId` int(10) unsigned DEFAULT NULL COMMENT 'Related spaceGroup',
  `method` enum('SAD','MAD','SIR','SIRAS','MR','MIR','MIRAS','RIP','RIPAS') DEFAULT NULL COMMENT 'phasing method',
  `lowRes` double DEFAULT NULL,
  `highRes` double DEFAULT NULL,
  `recordTimeStamp` datetime DEFAULT NULL COMMENT 'Creation or last update date/time',
  PRIMARY KEY (`substructureDeterminationId`),
  KEY `SubstructureDetermination_FKIndex1` (`phasingAnalysisId`),
  KEY `SubstructureDetermination_FKIndex2` (`phasingProgramRunId`),
  KEY `SubstructureDetermination_FKIndex3` (`spaceGroupId`),
  CONSTRAINT `SubstructureDetermination_phasingAnalysisfk_1` FOREIGN KEY (`phasingAnalysisId`) REFERENCES `PhasingAnalysis` (`phasingAnalysisId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `SubstructureDetermination_phasingProgramRunfk_1` FOREIGN KEY (`phasingProgramRunId`) REFERENCES `PhasingProgramRun` (`phasingProgramRunId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `SubstructureDetermination_spaceGroupfk_1` FOREIGN KEY (`spaceGroupId`) REFERENCES `SpaceGroup` (`spaceGroupId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `TiltImageAlignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TiltImageAlignment` (
  `movieId` int(11) unsigned NOT NULL COMMENT 'FK to Movie table',
  `tomogramId` int(11) unsigned NOT NULL COMMENT 'FK to Tomogram table; tuple (movieID, tomogramID) is unique',
  `defocusU` float DEFAULT NULL COMMENT 'unit: Angstroms',
  `defocusV` float DEFAULT NULL COMMENT 'unit: Angstroms',
  `psdFile` varchar(255) DEFAULT NULL,
  `resolution` float DEFAULT NULL COMMENT 'unit: Angstroms',
  `fitQuality` float DEFAULT NULL,
  `refinedMagnification` float DEFAULT NULL COMMENT 'unitless',
  `refinedTiltAngle` float DEFAULT NULL COMMENT 'units: degrees',
  `refinedTiltAxis` float DEFAULT NULL COMMENT 'units: degrees',
  `residualError` float DEFAULT NULL COMMENT 'Residual error, unit: nm',
  PRIMARY KEY (`movieId`,`tomogramId`),
  KEY `TiltImageAlignment_fk_tomogramId` (`tomogramId`),
  CONSTRAINT `TiltImageAlignment_fk_movieId` FOREIGN KEY (`movieId`) REFERENCES `Movie` (`movieId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `TiltImageAlignment_fk_tomogramId` FOREIGN KEY (`tomogramId`) REFERENCES `Tomogram` (`tomogramId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='For storing per-movie analysis results (reconstruction)';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `Tomogram`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Tomogram` (
  `tomogramId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `dataCollectionId` int(11) unsigned DEFAULT NULL COMMENT 'FK to DataCollection table',
  `autoProcProgramId` int(10) unsigned DEFAULT NULL COMMENT 'FK, gives processing times/status and software information',
  `volumeFile` varchar(255) DEFAULT NULL COMMENT '.mrc file representing the reconstructed tomogram volume',
  `stackFile` varchar(255) DEFAULT NULL COMMENT '.mrc file containing the motion corrected images ordered by angle used as input for the reconstruction',
  `sizeX` int(11) unsigned DEFAULT NULL COMMENT 'unit: pixels',
  `sizeY` int(11) unsigned DEFAULT NULL COMMENT 'unit: pixels',
  `sizeZ` int(11) unsigned DEFAULT NULL COMMENT 'unit: pixels',
  `pixelSpacing` float DEFAULT NULL COMMENT 'Angstrom/pixel conversion factor',
  `residualErrorMean` float DEFAULT NULL COMMENT 'Alignment error, unit: nm',
  `residualErrorSD` float DEFAULT NULL COMMENT 'Standard deviation of the alignment error, unit: nm',
  `xAxisCorrection` float DEFAULT NULL COMMENT 'X axis angle (etomo), unit: degrees',
  `tiltAngleOffset` float DEFAULT NULL COMMENT 'tilt Axis offset (etomo), unit: degrees',
  `zShift` float DEFAULT NULL COMMENT 'shift to center volumen in Z (etomo)',
  `fileDirectory` varchar(255) DEFAULT NULL COMMENT 'Directory path for files referenced by this table',
  `centralSliceImage` varchar(255) DEFAULT NULL COMMENT 'Tomogram central slice file',
  `tomogramMovie` varchar(255) DEFAULT NULL COMMENT 'Movie traversing the tomogram across an axis',
  `xyShiftPlot` varchar(255) DEFAULT NULL COMMENT 'XY shift plot file',
  `projXY` varchar(255) DEFAULT NULL COMMENT 'XY projection file',
  `projXZ` varchar(255) DEFAULT NULL COMMENT 'XZ projection file',
  `recordTimeStamp` datetime DEFAULT current_timestamp() COMMENT 'Creation or last update date/time',
  `globalAlignmentQuality` float DEFAULT NULL COMMENT 'Quality of fit metric for the alignment of the tilt series corresponding to this tomogram',
  PRIMARY KEY (`tomogramId`),
  KEY `Tomogram_fk_dataCollectionId` (`dataCollectionId`),
  KEY `Tomogram_fk_autoProcProgramId` (`autoProcProgramId`),
  CONSTRAINT `Tomogram_fk_autoProcProgramId` FOREIGN KEY (`autoProcProgramId`) REFERENCES `AutoProcProgram` (`autoProcProgramId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `Tomogram_fk_dataCollectionId` FOREIGN KEY (`dataCollectionId`) REFERENCES `DataCollection` (`dataCollectionId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='For storing per-sample, per-position data analysis results (reconstruction)';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `UserGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserGroup` (
  `userGroupId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(31) NOT NULL,
  PRIMARY KEY (`userGroupId`),
  UNIQUE KEY `UserGroup_idx1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `UserGroup_has_LDAPSearchParameters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserGroup_has_LDAPSearchParameters` (
  `userGroupId` int(11) unsigned NOT NULL,
  `ldapSearchParametersId` int(11) unsigned NOT NULL,
  `name` varchar(200) NOT NULL COMMENT 'Name of the object we search for',
  PRIMARY KEY (`userGroupId`,`ldapSearchParametersId`,`name`),
  KEY `UserGroup_has_LDAPSearchParameters_fk2` (`ldapSearchParametersId`),
  CONSTRAINT `UserGroup_has_LDAPSearchParameters_fk1` FOREIGN KEY (`userGroupId`) REFERENCES `UserGroup` (`userGroupId`),
  CONSTRAINT `UserGroup_has_LDAPSearchParameters_fk2` FOREIGN KEY (`ldapSearchParametersId`) REFERENCES `LDAPSearchParameters` (`ldapSearchParametersId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Gives the LDAP search parameters needed to find a set of usergroup members';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `UserGroup_has_Permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserGroup_has_Permission` (
  `userGroupId` int(11) unsigned NOT NULL,
  `permissionId` int(11) unsigned NOT NULL,
  PRIMARY KEY (`userGroupId`,`permissionId`),
  KEY `UserGroup_has_Permission_fk2` (`permissionId`),
  CONSTRAINT `UserGroup_has_Permission_fk1` FOREIGN KEY (`userGroupId`) REFERENCES `UserGroup` (`userGroupId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `UserGroup_has_Permission_fk2` FOREIGN KEY (`permissionId`) REFERENCES `Permission` (`permissionId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `UserGroup_has_Person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserGroup_has_Person` (
  `userGroupId` int(11) unsigned NOT NULL,
  `personId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`userGroupId`,`personId`),
  KEY `userGroup_has_Person_fk2` (`personId`),
  CONSTRAINT `userGroup_has_Person_fk1` FOREIGN KEY (`userGroupId`) REFERENCES `UserGroup` (`userGroupId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `userGroup_has_Person_fk2` FOREIGN KEY (`personId`) REFERENCES `Person` (`personId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `XFEFluorescenceComposite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `XFEFluorescenceComposite` (
  `xfeFluorescenceCompositeId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `r` int(10) unsigned NOT NULL COMMENT 'Red layer',
  `g` int(10) unsigned NOT NULL COMMENT 'Green layer',
  `b` int(10) unsigned NOT NULL COMMENT 'Blue layer',
  `rOpacity` float NOT NULL DEFAULT 1 COMMENT 'Red layer opacity',
  `bOpacity` float NOT NULL DEFAULT 1 COMMENT 'Red layer opacity',
  `gOpacity` float NOT NULL DEFAULT 1 COMMENT 'Red layer opacity',
  `opacity` float NOT NULL DEFAULT 1 COMMENT 'Total map opacity',
  PRIMARY KEY (`xfeFluorescenceCompositeId`),
  KEY `XFEFluorescenceComposite_ibfk1` (`r`),
  KEY `XFEFluorescenceComposite_ibfk2` (`g`),
  KEY `XFEFluorescenceComposite_ibfk3` (`b`),
  CONSTRAINT `XFEFluorescenceComposite_ibfk1` FOREIGN KEY (`r`) REFERENCES `XRFFluorescenceMapping` (`xrfFluorescenceMappingId`),
  CONSTRAINT `XFEFluorescenceComposite_ibfk2` FOREIGN KEY (`g`) REFERENCES `XRFFluorescenceMapping` (`xrfFluorescenceMappingId`),
  CONSTRAINT `XFEFluorescenceComposite_ibfk3` FOREIGN KEY (`b`) REFERENCES `XRFFluorescenceMapping` (`xrfFluorescenceMappingId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='A composite XRF map composed of three XRFFluorescenceMapping entries creating r, g, b layers';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `XFEFluorescenceSpectrum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `XFEFluorescenceSpectrum` (
  `xfeFluorescenceSpectrumId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sessionId` int(10) unsigned NOT NULL,
  `blSampleId` int(10) unsigned DEFAULT NULL,
  `jpegScanFileFullPath` varchar(255) DEFAULT NULL,
  `startTime` datetime DEFAULT NULL,
  `endTime` datetime DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `exposureTime` float DEFAULT NULL,
  `axisPosition` float DEFAULT NULL,
  `beamTransmission` float DEFAULT NULL,
  `annotatedPymcaXfeSpectrum` varchar(255) DEFAULT NULL,
  `fittedDataFileFullPath` varchar(255) DEFAULT NULL,
  `scanFileFullPath` varchar(255) DEFAULT NULL,
  `energy` float DEFAULT NULL,
  `beamSizeVertical` float DEFAULT NULL,
  `beamSizeHorizontal` float DEFAULT NULL,
  `crystalClass` varchar(20) DEFAULT NULL,
  `comments` varchar(1024) DEFAULT NULL,
  `blSubSampleId` int(11) unsigned DEFAULT NULL,
  `flux` double DEFAULT NULL COMMENT 'flux measured before the xrfSpectra',
  `flux_end` double DEFAULT NULL COMMENT 'flux measured after the xrfSpectra',
  `workingDirectory` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`xfeFluorescenceSpectrumId`),
  KEY `XFEFluorescnceSpectrum_FKIndex1` (`blSampleId`),
  KEY `XFEFluorescnceSpectrum_FKIndex2` (`sessionId`),
  KEY `XFE_ibfk_3` (`blSubSampleId`),
  CONSTRAINT `XFE_ibfk_1` FOREIGN KEY (`sessionId`) REFERENCES `BLSession` (`sessionId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `XFE_ibfk_2` FOREIGN KEY (`blSampleId`) REFERENCES `BLSample` (`blSampleId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `XFE_ibfk_3` FOREIGN KEY (`blSubSampleId`) REFERENCES `BLSubSample` (`blSubSampleId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `XRFFluorescenceMapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `XRFFluorescenceMapping` (
  `xrfFluorescenceMappingId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `xrfFluorescenceMappingROIId` int(11) unsigned NOT NULL,
  `gridInfoId` int(11) unsigned NOT NULL,
  `dataFormat` varchar(15) NOT NULL COMMENT 'Description of format and any compression, i.e. json+gzip for gzipped json',
  `data` longblob NOT NULL COMMENT 'The actual data',
  `points` int(11) unsigned DEFAULT NULL COMMENT 'The number of points available, for realtime feedback',
  `opacity` float NOT NULL DEFAULT 1 COMMENT 'Display opacity',
  `colourMap` varchar(20) DEFAULT NULL COMMENT 'Colour map for displaying the data',
  `min` int(3) DEFAULT NULL COMMENT 'Min value in the data for histogramming',
  `max` int(3) DEFAULT NULL COMMENT 'Max value in the data for histogramming',
  `autoProcProgramId` int(10) unsigned DEFAULT NULL COMMENT 'Related autoproc programid',
  PRIMARY KEY (`xrfFluorescenceMappingId`),
  KEY `XRFFluorescenceMapping_ibfk1` (`xrfFluorescenceMappingROIId`),
  KEY `XRFFluorescenceMapping_ibfk2` (`gridInfoId`),
  KEY `XRFFluorescenceMapping_ibfk3` (`autoProcProgramId`),
  CONSTRAINT `XRFFluorescenceMapping_ibfk1` FOREIGN KEY (`xrfFluorescenceMappingROIId`) REFERENCES `XRFFluorescenceMappingROI` (`xrfFluorescenceMappingROIId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `XRFFluorescenceMapping_ibfk2` FOREIGN KEY (`gridInfoId`) REFERENCES `GridInfo` (`gridInfoId`),
  CONSTRAINT `XRFFluorescenceMapping_ibfk3` FOREIGN KEY (`autoProcProgramId`) REFERENCES `AutoProcProgram` (`autoProcProgramId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci COMMENT='An XRF map generated from an XRF Mapping ROI based on data from a gridscan of a sample';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `XRFFluorescenceMappingROI`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `XRFFluorescenceMappingROI` (
  `xrfFluorescenceMappingROIId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `startEnergy` float NOT NULL,
  `endEnergy` float NOT NULL,
  `element` varchar(2) DEFAULT NULL,
  `edge` varchar(15) DEFAULT NULL COMMENT 'Edge type i.e. Ka1, could be a custom edge in case of overlap Ka1-noCa',
  `r` tinyint(3) unsigned DEFAULT NULL COMMENT 'R colour component',
  `g` tinyint(3) unsigned DEFAULT NULL COMMENT 'G colour component',
  `b` tinyint(3) unsigned DEFAULT NULL COMMENT 'B colour component',
  `blSampleId` int(10) unsigned DEFAULT NULL COMMENT 'ROIs can be created within the context of a sample',
  `scalar` varchar(50) DEFAULT NULL COMMENT 'For ROIs that are not an element, i.e. could be a scan counter instead',
  PRIMARY KEY (`xrfFluorescenceMappingROIId`),
  KEY `XRFFluorescenceMappingROI_FKblSampleId` (`blSampleId`),
  CONSTRAINT `XRFFluorescenceMappingROI_FKblSampleId` FOREIGN KEY (`blSampleId`) REFERENCES `BLSample` (`blSampleId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `XrayCentring`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `XrayCentring` (
  `xrayCentringId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `dataCollectionGroupId` int(11) NOT NULL COMMENT 'references DataCollectionGroup table',
  `status` enum('success','failed','pending') DEFAULT NULL,
  `xrayCentringType` enum('2d','3d') DEFAULT NULL,
  PRIMARY KEY (`xrayCentringId`),
  KEY `dataCollectionGroupId` (`dataCollectionGroupId`),
  CONSTRAINT `XrayCentring_ibfk_1` FOREIGN KEY (`dataCollectionGroupId`) REFERENCES `DataCollectionGroup` (`dataCollectionGroupId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Xray Centring analysis associated with one or more grid scans.';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `XrayCentringResult`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `XrayCentringResult` (
  `xrayCentringResultId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `xrayCentringId` int(11) unsigned NOT NULL COMMENT 'references XrayCentring table',
  `centreOfMassX` float DEFAULT NULL COMMENT 'x-coordinate corresponding to the centre of mass of the crystal (in voxels)',
  `centreOfMassY` float DEFAULT NULL COMMENT 'y-coordinate corresponding to the centre of mass of the crystal (in voxels)',
  `centreOfMassZ` float DEFAULT NULL COMMENT 'z-coordinate corresponding to the centre of mass of the crystal (in voxels)',
  `maxVoxelX` int(11) DEFAULT NULL COMMENT 'x-coordinate of the voxel with the maximum value within this crystal volume',
  `maxVoxelY` int(11) DEFAULT NULL COMMENT 'y-coordinate of the voxel with the maximum value within this crystal volume',
  `maxVoxelZ` int(11) DEFAULT NULL COMMENT 'z-coordinate of the voxel with the maximum value within this crystal volume',
  `numberOfVoxels` int(11) DEFAULT NULL COMMENT 'Number of voxels within the specified bounding box',
  `totalCount` float DEFAULT NULL COMMENT 'The sum of the values of all the voxels within the specified bounding box',
  `boundingBoxMinX` float DEFAULT NULL COMMENT 'Minimum x-coordinate of the bounding box containing the crystal (in voxels)',
  `boundingBoxMaxX` float DEFAULT NULL COMMENT 'Maximum x-coordinate of the bounding box containing the crystal (in voxels)',
  `boundingBoxMinY` float DEFAULT NULL COMMENT 'Minimum y-coordinate of the bounding box containing the crystal (in voxels)',
  `boundingBoxMaxY` float DEFAULT NULL COMMENT 'Maximum y-coordinate of the bounding box containing the crystal (in voxels)',
  `boundingBoxMinZ` float DEFAULT NULL COMMENT 'Minimum z-coordinate of the bounding box containing the crystal (in voxels)',
  `boundingBoxMaxZ` float DEFAULT NULL COMMENT 'Maximum z-coordinate of the bounding box containing the crystal (in voxels)',
  `status` enum('success','failure','pending') DEFAULT NULL COMMENT 'to be removed',
  `gridInfoId` int(11) unsigned DEFAULT NULL COMMENT 'to be removed',
  PRIMARY KEY (`xrayCentringResultId`),
  KEY `xrayCentringId` (`xrayCentringId`),
  CONSTRAINT `XrayCentringResult_ibfk_1` FOREIGN KEY (`xrayCentringId`) REFERENCES `XrayCentring` (`xrayCentringId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Xray Centring result.';
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `v_run`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `v_run` (
  `runId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `run` varchar(7) NOT NULL DEFAULT '',
  `startDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  PRIMARY KEY (`runId`),
  KEY `v_run_idx1` (`startDate`,`endDate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `zc_ZocaloBuffer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zc_ZocaloBuffer` (
  `AutoProcProgramID` int(10) unsigned NOT NULL COMMENT 'Reference to an existing AutoProcProgram',
  `UUID` int(10) unsigned NOT NULL COMMENT 'AutoProcProgram-specific unique identifier',
  `Reference` int(10) unsigned DEFAULT NULL COMMENT 'Context-dependent reference to primary key IDs in other ISPyB tables',
  PRIMARY KEY (`AutoProcProgramID`,`UUID`),
  CONSTRAINT `AutoProcProgram_fk_AutoProcProgramId` FOREIGN KEY (`AutoProcProgramID`) REFERENCES `AutoProcProgram` (`autoProcProgramId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

