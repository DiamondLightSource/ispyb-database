INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus)
  VALUES ('2020_08_28_PurificationColumn.sql', 'ONGOING');
  
CREATE TABLE PurificationColumn (
  purificationColumnId int unsigned auto_increment PRIMARY KEY,
  name varchar(100),
  active boolean DEFAULT 1 COMMENT '1=active, 0=inactive' 
)
COMMENT 'Size exclusion chromotography (SEC) lookup table for BioSAXS';

INSERT INTO PurificationColumn (purificationColumnId, name)
  VALUES
    (1, 'user supplied'),
    (2, 's75'),
    (3, 's200'),
    (4, 'superose6'),
    (5, 'kw402.5'),
    (6, 'kw403'),
    (7, 'kw404'),
    (8, 'kw405');

ALTER TABLE DiffractionPlan
  ADD purificationColumnId int unsigned,
  ADD CONSTRAINT `DiffractionPlan_ibfk2` FOREIGN KEY (`purificationColumnId`)
    REFERENCES `PurificationColumn` (`purificationColumnId`);

UPDATE SchemaStatus SET schemaStatus = 'DONE' 
  WHERE scriptName = '2020_08_28_PurificationColumn.sql';