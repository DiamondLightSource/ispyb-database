INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2020_09_02_AutoProcScalingStatistics_new_index.sql', 'ONGOING');

ALTER TABLE AutoProcScalingStatistics
  DROP INDEX AutoProcScalingStatisticsIdx1,
  ADD INDEX AutoProcScalingStatistics_scalingId_statisticsType (autoProcScalingId, scalingStatisticsType);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2020_09_02_AutoProcScalingStatistics_new_index.sql';
