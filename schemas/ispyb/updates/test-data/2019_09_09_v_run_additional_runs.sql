-- This script contains Diamond test data only.
-- Do not run this on a production database as
-- other synchrotrons/facilities will have their own
-- run schedule.

/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;

INSERT IGNORE INTO v_run (runId, run, startDate, endDate) VALUES (68, '2019-04', '2019-08-09 09:00:00', '2019-10-25 08:59:59');
INSERT IGNORE INTO v_run (runId, run, startDate, endDate) VALUES (69, '2019-05', '2019-10-25 09:00:00', '2019-12-17 08:59:59');
INSERT IGNORE INTO v_run (runId, run, startDate, endDate) VALUES (70, '2020-01', '2019-12-17 09:00:00', '2020-03-06 08:59:59');
INSERT IGNORE INTO v_run (runId, run, startDate, endDate) VALUES (71, '2020-02', '2020-03-06 09:00:00', '2020-05-22 08:59:59');
INSERT IGNORE INTO v_run (runId, run, startDate, endDate) VALUES (72, '2020-03', '2020-05-22 09:00:00', '2020-08-14 08:59:59');

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
