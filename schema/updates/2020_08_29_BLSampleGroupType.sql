INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus)
  VALUES ('2020_08_29_BLSampleGroupType.sql', 'ONGOING');
  
CREATE TABLE BLSampleGroupType (
  blSampleGroupTypeId int unsigned auto_increment PRIMARY KEY,
  name varchar(100),
  proposalType varchar(10),
  active boolean DEFAULT 1 COMMENT '1=active, 0=inactive' 
);

INSERT INTO BLSampleGroupType (blSampleGroupTypeId, name, proposalType)
  VALUES
    (1, 'background', 'xpdf'),
    (2, 'container', 'xpdf'),
    (3, 'sample', 'xpdf'),
    (4, 'calibrant', 'xpdf'),
    (5, 'buffer', 'scm'),
    (6, 'sample', 'scm'),
    (7, 'sample', 'mx');

ALTER TABLE BLSampleGroup_has_BLSample
  ADD blSampleGroupTypeId int unsigned,
  ADD CONSTRAINT `BLSampleGroup_has_BLSample_ibfk3` FOREIGN KEY (`blSampleGroupTypeId`) REFERENCES `BLSampleGroupType` (`blSampleGroupTypeId`);

UPDATE SchemaStatus SET schemaStatus = 'DONE' 
  WHERE scriptName = '2020_08_29_BLSampleGroupType.sql';