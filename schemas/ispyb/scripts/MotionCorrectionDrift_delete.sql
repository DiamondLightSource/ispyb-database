-- Delete rows from table in batches

DELIMITER ;;

BEGIN NOT ATOMIC

  SET @step := 1000000;
  SET @id := @step;
  SET @max := 1200000000;

  REPEAT
    SELECT @id AS '@id';
    DELETE FROM MotionCorrectionDrift WHERE motionCorrectionDriftId < @id;
    SET @id := @id + @step;
    UNTIL @id > @max
  END REPEAT;

END;;

DELIMITER ;

-- Rebuild table to reclaim space - assumes InnoDB and requires innodb_file_per_table=ON:
-- Can take a long time for large tables, should probably run in RSU (or NBO) mode on Galera

SET GLOBAL wsrep_OSU_method:='RSU';
ALTER TABLE MotionCorrectionDrift FORCE;
SET GLOBAL wsrep_OSU_method:='TOI';
