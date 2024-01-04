INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2024_01_02_drop_views.sql', 'ONGOING');

DROP VIEW IF EXISTS `v_Log4Stat`;
DROP VIEW IF EXISTS `v_dewar`;
DROP VIEW IF EXISTS `v_dewarBeamline`;
DROP VIEW IF EXISTS `v_dewarBeamlineByWeek`;
DROP VIEW IF EXISTS `v_dewarByWeek`;
DROP VIEW IF EXISTS `v_dewarByWeekTotal`;
DROP VIEW IF EXISTS `v_dewarList`;
DROP VIEW IF EXISTS `v_dewarProposalCode`;
DROP VIEW IF EXISTS `v_dewarProposalCodeByWeek`;
DROP VIEW IF EXISTS `v_hour`;
DROP VIEW IF EXISTS `v_logonByHour`;
DROP VIEW IF EXISTS `v_logonByHour2`;
DROP VIEW IF EXISTS `v_logonByMonthDay`;
DROP VIEW IF EXISTS `v_logonByMonthDay2`;
DROP VIEW IF EXISTS `v_logonByWeek`;
DROP VIEW IF EXISTS `v_logonByWeek2`;
DROP VIEW IF EXISTS `v_logonByWeekDay`;
DROP VIEW IF EXISTS `v_logonByWeekDay2`;
DROP VIEW IF EXISTS `v_monthDay`;
DROP VIEW IF EXISTS `v_sample`;
DROP VIEW IF EXISTS `v_sampleByWeek`;
DROP VIEW IF EXISTS `v_week`;
DROP VIEW IF EXISTS `v_weekDay`;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2024_01_02_drop_views.sql';
