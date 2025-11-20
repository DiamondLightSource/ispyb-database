-- To undo:
-- drop table LaserPoint;
-- drop table LaserParameters;
-- delete from SchemaStatus where scriptName = '2025_11_03_LaserParameters_tables.sql';


INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2025_11_03_LaserParameters_tables.sql', 'ONGOING');

CREATE TABLE LaserParameters (
    laserParametersId int(11) unsigned PRIMARY KEY AUTO_INCREMENT,
    robotActionId int(11) unsigned,
    laserRepetitionRate float COMMENT 'Laser repetition rate, in kHz',
    scanheadMoveSpeed float COMMENT 'Scanhead move speed, in m/s',
    laserTransmission float COMMENT 'Laser transmission, in %',
    numberOfPasses int(10) unsigned,
    gonioRotationSpeed int(10) COMMENT 'Goniometer rotation speed, in deg/s',
    totalMarkingTime float COMMENT 'Total marking time, in s',
    CONSTRAINT `LaserParameters_fk_robotActionId`
      FOREIGN KEY (robotActionId)
        REFERENCES RobotAction (robotActionId)
          ON DELETE CASCADE
          ON UPDATE CASCADE
) COMMENT = 'Laser parameters';

CREATE TABLE LaserPoint (
    laserPointId int(11) unsigned PRIMARY KEY AUTO_INCREMENT,
    laserParametersId int(11) unsigned,
    x int(10) unsigned NOT NULL COMMENT 'X coordinate of point, in microns',
    y int(10) unsigned NOT NULL COMMENT 'Y coordinate of point, in microns',
    pointIndex int(10) NOT NULL COMMENT 'Index of point, expresses ordinality',
    radius int(10) unsigned COMMENT 'Radius of point, in microns',
    laserOn tinyint(1) DEFAULT 0,
    CONSTRAINT LaserPoint_fk_laserParametersId
      FOREIGN KEY (laserParametersId)
        REFERENCES LaserParameters (laserParametersId)
          ON DELETE CASCADE
          ON UPDATE CASCADE
) COMMENT = 'Laser points';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2025_11_03_LaserParameters_tables.sql';
