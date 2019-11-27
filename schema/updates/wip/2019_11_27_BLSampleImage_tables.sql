INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2019_11_27_BLSampleImage_tables.sql', 'ONGOING');

CREATE TABLE BLSampleImageAutoScoreSchema (
  blSampleImageAutoScoreSchemaId tinyint(3) unsigned auto_increment PRIMARY KEY,
  schemaName varchar(25) COMMENT 'Name of the schema e.g. Hampton, MARCO',
  enabled tinyint(1) COMMENT 'Whether this schema is enabled (could be configurable in the UI)'
);

INSERT INTO BLSampleImageAutoScoreSchema (
  blSampleImageAutoScoreSchemaId, schemaName, enabled)
  VALUES (1, 'MARCO', 1);

CREATE TABLE BLSampleImageAutoScoreClass (
  blSampleImageAutoScoreClassId tinyint(3) unsigned auto_increment PRIMARY KEY,
  scoreClass varchar(15) COMMENT 'Thing being scored e.g. crystal, precipitant'
) COMMENT 'The automated scoring classes';

INSERT INTO BLSampleImageAutoScoreClass (
  blSampleImageAutoScoreClassId, scoreClass)
VALUES
  (1, 'clear'),
  (2, 'crystal'),
  (3, 'precipitant'),
  (4, 'other');

CREATE TABLE BLSampleImage_has_AutoScore (
  blSampleImageId int(11) unsigned,
  blSampleImageAutoScoreSchemaId tinyint(3) unsigned,
  blSampleImageAutoScoreClassId tinyint(3) unsigned,
  probability float,
  PRIMARY KEY (blSampleImageId, blSampleImageAutoScoreSchemaId, blSampleImageAutoScoreClassId),
  CONSTRAINT BLSampleImage_has_AutoScore_fk1 FOREIGN KEY (blSampleImageId) REFERENCES BLSampleImage(blSampleImageId) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT BLSampleImage_has_AutoScore_fk2 FOREIGN KEY (blSampleImageAutoScoreSchemaId) REFERENCES BLSampleImageAutoScoreSchema(blSampleImageAutoScoreSchemaId) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT BLSampleImage_has_AutoScore_fk3 FOREIGN KEY (blSampleImageAutoScoreClassId) REFERENCES BLSampleImageAutoScoreClass(blSampleImageAutoScoreClassId) ON DELETE NO ACTION ON UPDATE CASCADE
);


UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2019_11_27_BLSampleImage_tables.sql';
