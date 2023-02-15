INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2023_02_14_SSX_experiment.sql', 'ONGOING');

CREATE TABLE `SSXDataCollection`(
    `dataCollectionId` int(11) unsigned PRIMARY KEY COMMENT 'Primary key is same as dataCollection (1 to 1).',
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
    FOREIGN KEY (`dataCollectionId`) REFERENCES `DataCollection`(`dataCollectionId`) ON DELETE CASCADE ON UPDATE CASCADE
) DEFAULT CHARSET = utf8mb4 COMMENT = 'Extends DataCollection with SSX-specific fields.';

ALTER TABLE
    `DataCollectionGroup`
MODIFY
    `experimentType` enum(
        'SAD',
        'SAD - Inverse Beam',
        'OSC',
        'Collect - Multiwedge',
        'MAD',
        'Helical',
        'Multi-positional',
        'Mesh',
        'Burn',
        'MAD - Inverse Beam',
        'Characterization',
        'Dehydration',
        'tomo',
        'experiment',
        'EM',
        'PDF',
        'PDF+Bragg',
        'Bragg',
        'single particle',
        'Serial Fixed',
        'Serial Jet',
        'Standard',
        'Time Resolved',
        'Diamond Anvil High Pressure',
        'Custom',
        'XRF map',
        'Energy scan',
        'XRF spectrum',
        'XRF map xas',
        'Mesh3D',
        'Screening',
        'Still',
        'SSX-Chip',
        'SSX-Jet'
      ) 
      DEFAULT NULL COMMENT 'Standard: Routine structure determination experiment. Time Resolved: Investigate the change of a system over time. Custom: Special or non-standard data collection.';

INSERT INTO ExperimentType (experimentTypeId, name, proposalType, active)
VALUES 
  (38, 'Still','mx', 1),
  (39, 'SSX-Chip','mx', 1),
  (40, 'SSX-Jet','mx', 1);

ALTER TABLE
    `ComponentType`
ADD
    UNIQUE (`name`);

INSERT INTO
    ComponentType (componentTypeId, name)
VALUES
    (5, 'Ligand'),
    (6, 'Buffer'),
    (7, 'JetMaterial');

CREATE TABLE `Component` (
    `componentId` int(11) unsigned PRIMARY KEY AUTO_INCREMENT,
    `componentTypeId` int(11) unsigned NOT NULL,
    `proposalId` int(10) unsigned DEFAULT NULL,
    `name` varchar (255) NOT NULL,
    `composition` varchar(255) DEFAULT NULL,
    FOREIGN KEY (`componentTypeId`) REFERENCES `ComponentType`(`componentTypeId`),
    FOREIGN KEY (`proposalId`) REFERENCES `Proposal`(`proposalId`) ON DELETE CASCADE ON UPDATE CASCADE
) DEFAULT CHARSET = utf8mb4 COMMENT = 'Description of a component that can be used inside a crystal or a sample.';

CREATE TABLE `SampleComposition` (
    `sampleCompositionId` int(11) unsigned PRIMARY KEY AUTO_INCREMENT,
    `componentId` int(11) unsigned NOT NULL,
    `blSampleId` int(11) unsigned NOT NULL,
    `concentrationTypeId` int(11) unsigned DEFAULT NULL,
    `abundance` float DEFAULT NULL COMMENT 'Abundance or concentration in the unit defined by concentrationTypeId.',
    `ratio` float DEFAULT NULL,
    `ph` float DEFAULT NULL,
    FOREIGN KEY (`componentId`) REFERENCES `Component`(`componentId`),
    FOREIGN KEY (`blSampleId`) REFERENCES `BLSample`(`blSampleId`),
    FOREIGN KEY (`concentrationTypeId`) REFERENCES `ConcentrationType`(`concentrationTypeId`)
) DEFAULT CHARSET = utf8mb4 COMMENT = "Links a sample to its components with a specified abundance or ratio.";

CREATE TABLE `CrystalComposition` (
    `crystalCompositionId` int(11) unsigned PRIMARY KEY AUTO_INCREMENT,
    `componentId` int(11) unsigned NOT NULL,
    `crystalId` int(11) unsigned NOT NULL,
    `concentrationTypeId` int(10) unsigned DEFAULT NULL,
    `abundance` float DEFAULT NULL COMMENT 'Abundance or concentration in the unit defined by concentrationTypeId.',
    `ratio` float DEFAULT NULL,
    `ph` float DEFAULT NULL,
    FOREIGN KEY (`componentId`) REFERENCES `Component`(`componentId`),
    FOREIGN KEY (`crystalId`) REFERENCES `Crystal`(`crystalId`),
    FOREIGN KEY (`concentrationTypeId`) REFERENCES `ConcentrationType`(`concentrationTypeId`)
) DEFAULT CHARSET = utf8mb4 COMMENT = "Links a crystal to its components with a specified abundance or ratio.";

CREATE TABLE `EventChain` (
    `eventChainId` int(11) unsigned PRIMARY KEY AUTO_INCREMENT,
    `dataCollectionId` int(11) unsigned NOT NULL,
    `name` varchar(255) DEFAULT NULL,
    FOREIGN KEY (`dataCollectionId`) REFERENCES `DataCollection`(`dataCollectionId`) ON DELETE CASCADE ON UPDATE CASCADE
) DEFAULT CHARSET = utf8mb4 COMMENT = 'Groups events together in a data collection.';

CREATE TABLE `EventType` (
    `eventTypeId` int(11) unsigned PRIMARY KEY AUTO_INCREMENT,
    `name` varchar(30) UNIQUE NOT NULL
) DEFAULT CHARSET = utf8mb4 COMMENT = 'Defines the list of event types which can occur during a data collection.';

INSERT INTO
    `EventType` (`name`)
values
    ('XrayDetection'),
    ('XrayExposure'),
    ('LaserExcitation'),
    ('ReactionTrigger');

CREATE TABLE `Event` (
    `eventId` int(11) unsigned PRIMARY KEY AUTO_INCREMENT,
    `eventChainId` int(11) unsigned NOT NULL,
    `componentId` int(11) unsigned DEFAULT NULL,
    `eventTypeId` int(11) unsigned NOT NULL,
    `name` varchar(255) DEFAULT NULL,
    `offset` float NOT NULL COMMENT 'Start of the event relative to data collection start time in seconds.',
    `duration` float DEFAULT NULL COMMENT 'Duration of the event if applicable.',
    `period` float DEFAULT NULL COMMENT 'Repetition period if applicable in seconds.',
    `repetition` float DEFAULT NULL COMMENT 'Number of repetition if applicable.',
    FOREIGN KEY (`eventChainId`) REFERENCES `EventChain`(`eventChainId`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`componentId`) REFERENCES `Component`(`componentId`),
    FOREIGN KEY (`eventTypeId`) REFERENCES `EventType`(`eventTypeId`)
) DEFAULT CHARSET = utf8mb4 COMMENT = "Describes something that happend during a data collection and should be taken into account for data analysis. Can be reapeted at a specified frequency or not.";

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2023_02_14_SSX_experiment.sql';
