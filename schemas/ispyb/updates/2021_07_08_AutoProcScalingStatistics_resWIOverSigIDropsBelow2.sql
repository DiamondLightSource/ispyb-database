INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2021_07_08_AutoProcScalingStatistics_resWIOverSigIDropsBelow2.sql', 'ONGOING');

ALTER TABLE AutoProcScalingStatistics
  ADD resWIOverSigIDropsBelow2 float COMMENT 'The resolution where (I)/sd(I) drops below 2';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2021_07_08_AutoProcScalingStatistics_resWIOverSigIDropsBelow2.sql';
