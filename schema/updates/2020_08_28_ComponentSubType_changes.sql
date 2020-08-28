INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus)
  VALUES ('2020_08_28_ComponentSubType_changes.sql', 'ONGOING');

ALTER TABLE ComponentSubType
  ADD proposalType varchar(10),
  ADD active boolean DEFAULT 1 COMMENT '1=active, 0=inactive';

INSERT INTO ComponentSubType (componentSubTypeId, name, hasPh, proposalType)
  VALUES 
    (4, 'Cell', 0, 'scm'),
    (5, 'Matrix', 0, 'scm'),
    (6, 'Powder', 0, 'scm'),
    (7, 'Solution', 1, 'scm'),
    (8, 'Powder', 0, 'cy');

UPDATE SchemaStatus SET schemaStatus = 'DONE' 
  WHERE scriptName = '2020_08_28_ComponentSubType_changes.sql';