DELIMITER ;;

CREATE OR REPLACE PROCEDURE update_processing_program_for_id_range(p_startId int unsigned, p_endId int unsigned)
MODIFIES SQL DATA
COMMENT 'Maintenance procedure to update processingPrograms based on contents of processingCommandLine'
BEGIN
  UPDATE AutoProcProgram
  SET AutoProcProgram.processingPrograms = CONCAT(
    'xia2 ',
    REGEXP_REPLACE(
      processingCommandLine,
      '^xia2.*?(-|pipeline=)(2d[[:alnum:]]*|3d[[:alnum:]]*|dials)[[:space:]]*.*',
      '\\2'
    )
  )
  WHERE autoProcProgramId BETWEEN p_startId AND p_endId AND
          AutoProcProgram.processingPrograms = 'xia2';
END;;

DELIMITER ;
