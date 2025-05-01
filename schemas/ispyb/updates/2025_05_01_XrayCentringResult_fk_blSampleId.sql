INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2025_05_01_XrayCentringResult_fk_blSampleId.sql', 'ONGOING');

ALTER TABLE XrayCentringResult
  ADD blSampleId int(11) unsigned COMMENT 'The BLSample attributed for this x-ray centring result, i.e. the actual sample even for multi-pins',
  ADD CONSTRAINT XrayCentringResult_fk_blSampleId
  FOREIGN KEY (blSampleId)
      REFERENCES BLSample(blSampleId)
          ON DELETE SET NULL
          ON UPDATE CASCADE;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2025_05_01_XrayCentringResult_fk_blSampleId.sql';
