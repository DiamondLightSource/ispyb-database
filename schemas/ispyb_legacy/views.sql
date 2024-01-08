DROP TABLE IF EXISTS `v_Log4Stat`;
/*!50001 DROP VIEW IF EXISTS `v_Log4Stat`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_Log4Stat` AS SELECT
 1 AS `id`,
  1 AS `priority`,
  1 AS `timestamp`,
  1 AS `msg`,
  1 AS `detail`,
  1 AS `value` */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `v_dewar`;
/*!50001 DROP VIEW IF EXISTS `v_dewar`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_dewar` AS SELECT
 1 AS `proposalId`,
  1 AS `shippingId`,
  1 AS `shippingName`,
  1 AS `dewarId`,
  1 AS `dewarName`,
  1 AS `dewarStatus`,
  1 AS `proposalCode`,
  1 AS `proposalNumber`,
  1 AS `creationDate`,
  1 AS `shippingType`,
  1 AS `barCode`,
  1 AS `shippingStatus`,
  1 AS `beamLineName`,
  1 AS `nbEvents`,
  1 AS `storesin`,
  1 AS `nbSamples` */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `v_dewarBeamline`;
/*!50001 DROP VIEW IF EXISTS `v_dewarBeamline`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_dewarBeamline` AS SELECT
 1 AS `beamLineName`,
  1 AS `COUNT(*)` */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `v_dewarBeamlineByWeek`;
/*!50001 DROP VIEW IF EXISTS `v_dewarBeamlineByWeek`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_dewarBeamlineByWeek` AS SELECT
 1 AS `Week`,
  1 AS `ID14`,
  1 AS `ID23`,
  1 AS `ID29`,
  1 AS `BM14` */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `v_dewarByWeek`;
/*!50001 DROP VIEW IF EXISTS `v_dewarByWeek`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_dewarByWeek` AS SELECT
 1 AS `Week`,
  1 AS `Dewars Tracked`,
  1 AS `Dewars Non-Tracked` */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `v_dewarByWeekTotal`;
/*!50001 DROP VIEW IF EXISTS `v_dewarByWeekTotal`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_dewarByWeekTotal` AS SELECT
 1 AS `Week`,
  1 AS `Dewars Tracked`,
  1 AS `Dewars Non-Tracked`,
  1 AS `Total` */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `v_dewarList`;
/*!50001 DROP VIEW IF EXISTS `v_dewarList`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_dewarList` AS SELECT
 1 AS `proposal`,
  1 AS `shippingName`,
  1 AS `dewarName`,
  1 AS `barCode`,
  1 AS `creationDate`,
  1 AS `shippingType`,
  1 AS `nbEvents`,
  1 AS `dewarStatus`,
  1 AS `shippingStatus`,
  1 AS `nbSamples` */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `v_dewarProposalCode`;
/*!50001 DROP VIEW IF EXISTS `v_dewarProposalCode`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_dewarProposalCode` AS SELECT
 1 AS `proposalCode`,
  1 AS `COUNT(*)` */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `v_dewarProposalCodeByWeek`;
/*!50001 DROP VIEW IF EXISTS `v_dewarProposalCodeByWeek`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_dewarProposalCodeByWeek` AS SELECT
 1 AS `Week`,
  1 AS `MX`,
  1 AS `FX`,
  1 AS `BM14U`,
  1 AS `BM161`,
  1 AS `BM162`,
  1 AS `Others` */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `v_hour`;
/*!50001 DROP VIEW IF EXISTS `v_hour`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_hour` AS SELECT
 1 AS `num` */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `v_logonByHour`;
/*!50001 DROP VIEW IF EXISTS `v_logonByHour`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_logonByHour` AS SELECT
 1 AS `Hour`,
  1 AS `Distinct logins`,
  1 AS `Total logins` */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `v_logonByHour2`;
/*!50001 DROP VIEW IF EXISTS `v_logonByHour2`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_logonByHour2` AS SELECT
 1 AS `Hour`,
  1 AS `Distinct logins`,
  1 AS `Total logins` */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `v_logonByMonthDay`;
/*!50001 DROP VIEW IF EXISTS `v_logonByMonthDay`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_logonByMonthDay` AS SELECT
 1 AS `Day`,
  1 AS `Distinct logins`,
  1 AS `Total logins` */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `v_logonByMonthDay2`;
/*!50001 DROP VIEW IF EXISTS `v_logonByMonthDay2`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_logonByMonthDay2` AS SELECT
 1 AS `Day`,
  1 AS `Distinct logins`,
  1 AS `Total logins` */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `v_logonByWeek`;
/*!50001 DROP VIEW IF EXISTS `v_logonByWeek`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_logonByWeek` AS SELECT
 1 AS `Week`,
  1 AS `Distinct logins`,
  1 AS `Total logins` */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `v_logonByWeek2`;
/*!50001 DROP VIEW IF EXISTS `v_logonByWeek2`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_logonByWeek2` AS SELECT
 1 AS `Week`,
  1 AS `Distinct logins`,
  1 AS `Total logins` */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `v_logonByWeekDay`;
/*!50001 DROP VIEW IF EXISTS `v_logonByWeekDay`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_logonByWeekDay` AS SELECT
 1 AS `Day`,
  1 AS `Distinct logins`,
  1 AS `Total logins` */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `v_logonByWeekDay2`;
/*!50001 DROP VIEW IF EXISTS `v_logonByWeekDay2`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_logonByWeekDay2` AS SELECT
 1 AS `Day`,
  1 AS `Distinct logins`,
  1 AS `Total logins` */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `v_monthDay`;
/*!50001 DROP VIEW IF EXISTS `v_monthDay`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_monthDay` AS SELECT
 1 AS `num` */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `v_sample`;
/*!50001 DROP VIEW IF EXISTS `v_sample`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_sample` AS SELECT
 1 AS `proposalId`,
  1 AS `shippingId`,
  1 AS `dewarId`,
  1 AS `containerId`,
  1 AS `blSampleId`,
  1 AS `proposalCode`,
  1 AS `proposalNumber`,
  1 AS `creationDate`,
  1 AS `shippingType`,
  1 AS `barCode`,
  1 AS `shippingStatus` */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `v_sampleByWeek`;
/*!50001 DROP VIEW IF EXISTS `v_sampleByWeek`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_sampleByWeek` AS SELECT
 1 AS `Week`,
  1 AS `Samples` */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `v_week`;
/*!50001 DROP VIEW IF EXISTS `v_week`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_week` AS SELECT
 1 AS `num` */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `v_weekDay`;
/*!50001 DROP VIEW IF EXISTS `v_weekDay`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_weekDay` AS SELECT
 1 AS `day` */;
SET character_set_client = @saved_cs_client;
