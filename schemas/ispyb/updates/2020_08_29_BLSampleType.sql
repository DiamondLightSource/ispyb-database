INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus)
  VALUES ('2020_08_29_BLSampleType.sql', 'ONGOING');
  
CREATE TABLE BLSampleType (
  blSampleTypeId int unsigned auto_increment PRIMARY KEY,
  name varchar(100),
  proposalType varchar(10),
  active boolean DEFAULT 1 COMMENT '1=active, 0=inactive' 
);

INSERT INTO BLSampleType (blSampleTypeId, name, proposalType)
  VALUES
    (1, 'background', 'xpdf'),
    (2, 'container', 'xpdf'),
    (3, 'sample', 'xpdf'),
    (4, 'calibrant', 'xpdf'),
    (5, 'buffer', 'scm'),
    (6, 'sample', 'scm'),
    (7, 'sample', 'mx');

ALTER TABLE BLSampleGroup_has_BLSample
  ADD blSampleTypeId int unsigned,
  ADD CONSTRAINT `BLSampleGroup_has_BLSample_ibfk3` FOREIGN KEY (`blSampleTypeId`) REFERENCES `BLSampleType` (`blSampleTypeId`);

UPDATE SchemaStatus SET schemaStatus = 'DONE' 
  WHERE scriptName = '2020_08_29_BLSampleType.sql';