INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2022_06_28_sampleimage_positioner.sql', 'ONGOING');

CREATE TABLE `BLSampleImage_has_Positioner` (
    `blSampleImageHasPositionerId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `blSampleImageId` INT UNSIGNED NOT NULL,
    `positionerId` INT UNSIGNED NOT NULL,
    `value` float COMMENT 'The position of this positioner for this blsampleimage',
    PRIMARY KEY (`blSampleImageHasPositionerId`),
    CONSTRAINT `BLSampleImageHasPositioner_ibfk1`
        FOREIGN KEY (`blSampleImageId`)
            REFERENCES `BLSampleImage`(`blSampleImageId`),
    CONSTRAINT `BLSampleImageHasPositioner_ibfk2`
        FOREIGN KEY (`positionerId`)
            REFERENCES `Positioner`(`positionerId`)
    ) ENGINE=InnoDB COMMENT='Allows a BLSampleImage to store motor positions along with the image';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2022_06_28_sampleimage_positioner.sql';
