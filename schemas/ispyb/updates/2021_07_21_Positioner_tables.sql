INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_07_21_Positioner_tables.sql', 'ONGOING');

CREATE TABLE `Positioner` (
    `positionerId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `positioner` VARCHAR(50) NOT NULL,
    `value` FLOAT NOT NULL, -- debatable, varchar?
    PRIMARY KEY (`positionerId`)
    )
    COMMENT 'An arbitrary positioner and its value, could be e.g. a motor. Allows for instance to store some positions with a sample or subsample';


CREATE TABLE `BLSample_has_Positioner` (
    `blSampleHasPositioner` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `blSampleId` INT UNSIGNED NOT NULL,
    `positionerId` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`blSampleHasPositioner`),
    CONSTRAINT `BLSampleHasPositioner_ibfk1`
        FOREIGN KEY (`blSampleId`)
            REFERENCES `BLSample`(`blSampleId`)
                ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `BLSampleHasPositioner_ibfk2`
        FOREIGN KEY (`positionerId`)
            REFERENCES `Positioner`(`positionerId`)
    );


CREATE TABLE `BLSubSample_has_Positioner` (
    `blSubSampleHasPositioner` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `blSubSampleId` INT UNSIGNED NOT NULL,
    `positionerId` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`blSubSampleHasPositioner`),
    CONSTRAINT `BLSubSampleHasPositioner_ibfk1`
        FOREIGN KEY (`blSubSampleId`)
            REFERENCES `BLSubSample`(`blSubSampleId`)
                ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `BLSubSampleHasPositioner_ibfk2`
        FOREIGN KEY (`positionerId`)
            REFERENCES `Positioner`(`positionerId`)
                ON DELETE RESTRICT ON UPDATE RESTRICT
    );

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_07_21_Positioner_tables.sql';