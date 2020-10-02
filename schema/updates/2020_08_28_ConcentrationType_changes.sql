INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus)
  VALUES ('2020_08_28_ConcentrationType_changes.sql', 'ONGOING');

ALTER TABLE ConcentrationType
  ADD proposalType varchar(10),
  ADD active boolean DEFAULT 1 COMMENT '1=active, 0=inactive';

INSERT INTO ConcentrationType (concentrationTypeId, name, symbol, proposalType)
  VALUES 
    (6, 'Microlitre', 'uL', 'scm'),
    (7, 'Millilitre', 'ml', 'scm');

UPDATE SchemaStatus SET schemaStatus = 'DONE' 
  WHERE scriptName = '2020_08_28_ConcentrationType_changes.sql';
  

