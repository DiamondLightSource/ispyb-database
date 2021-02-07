DELIMITER ;;

-- Assumptions: 
-- * spaceGroupId is actually spaceGroupId!

CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE insert_phasing_analysis_results(OUT p_id int(11) unsigned, IN p_phasing_result JSON, IN p_autoProcScalingId int(10) unsigned)
MODIFIES SQL DATA
COMMENT 'Insert all the results from a phasing into the relevant database tables. Returns the top-level phasing ID in p_id.'
`proc_body`:
BEGIN

  DECLARE v_phasingAnalysisId int(11) unsigned DEFAULT NULL;
  DECLARE v_phasingProgramRunId int(11) unsigned DEFAULT NULL;
  DECLARE v_phasingHasScalingId int(11) unsigned DEFAULT NULL;
  DECLARE v_no_stats int unsigned DEFAULT 0;
  DECLARE v_no_attachments int unsigned DEFAULT 0;
  DECLARE i int unsigned DEFAULT 0;

  -- Validation and sanity checks:
  IF NOT json_valid(p_phasing_result) THEN
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, 
      MESSAGE_TEXT='JSON document is invalid.';
    LEAVE `proc_body`;
  END IF;
  
  IF NOT json_exists(p_phasing_result,'$.PhasingContainer') THEN
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, 
      MESSAGE_TEXT='JSON document must have a PhasingContainer element.';
    LEAVE `proc_body`;
  END IF;

  IF NOT json_exists(p_phasing_result,
    '$.PhasingContainer.PhasingAnalysis[0].recordTimeStamp') THEN
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, 
      MESSAGE_TEXT='JSON document must have a PhasingContainer.PhasingAnalysis[0].recordTimeStamp element.';
    LEAVE `proc_body`;
  END IF;

  START TRANSACTION;

  INSERT INTO PhasingAnalysis (recordTimeStamp) VALUES (JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, '$.PhasingContainer.PhasingAnalysis[0].recordTimeStamp')));
  SET v_phasingAnalysisId := last_insert_id();

  INSERT INTO Phasing_has_Scaling (phasingAnalysisId, autoProcScalingId) 
    VALUES (v_phasingAnalysisId, p_autoProcScalingId);
  SET v_phasingHasScalingId := last_insert_id(); 

  SET v_no_stats := JSON_LENGTH(p_phasing_result, '$.PhasingContainer.Phasing_has_ScalingContainer.PhasingStatistics');
  SET i := 0;
  WHILE i < v_no_stats DO
    INSERT INTO PhasingStatistics (phasingHasScalingId1, numberOfBins, binNumber, lowRes, highRes, metric, statisticsValue, nReflections) 
      VALUES (
        v_phasingHasScalingId,
        JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, concat('$.PhasingContainer.Phasing_has_ScalingContainer.PhasingStatistics[', i, '].numberOfBins'))),
        JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, concat('$.PhasingContainer.Phasing_has_ScalingContainer.PhasingStatistics[', i, '].binNumber'))),
        JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, concat('$.PhasingContainer.Phasing_has_ScalingContainer.PhasingStatistics[', i, '].lowRes'))),
        JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, concat('$.PhasingContainer.Phasing_has_ScalingContainer.PhasingStatistics[', i, '].highRes'))),
        JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, concat('$.PhasingContainer.Phasing_has_ScalingContainer.PhasingStatistics[', i, '].metric'))),
        JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, concat('$.PhasingContainer.Phasing_has_ScalingContainer.PhasingStatistics[', i, '].statisticsValue'))),
        JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, concat('$.PhasingContainer.Phasing_has_ScalingContainer.PhasingStatistics[', i, '].nReflections')))        
      );
    SET i := i + 1;
  END WHILE;
  
  INSERT INTO PhasingProgramRun (
    phasingCommandLine, phasingPrograms, phasingStatus, phasingMessage, phasingStartTime, phasingEndTime) 
    VALUES (
      substr(JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, '$.PhasingContainer.PhasingProgramRun[0].phasingCommandLine')), 1, 255),
      JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, '$.PhasingContainer.PhasingProgramRun[0].phasingPrograms')),
      JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, '$.PhasingContainer.PhasingProgramRun[0].phasingStatus')),
      JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, '$.PhasingContainer.PhasingProgramRun[0].phasingMessage')),
      JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, '$.PhasingContainer.PhasingProgramRun[0].phasingStartTime')),
      JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, '$.PhasingContainer.PhasingProgramRun[0].phasingEndTime'))
    );
  SET v_phasingProgramRunId := last_insert_id(); 

  IF json_exists(p_phasing_result,
    '$.PhasingContainer.PreparePhasingData') THEN
    INSERT INTO PreparePhasingData (phasingAnalysisId, phasingProgramRunId, spaceGroupId, lowRes, highRes) 
      VALUES (
        v_phasingAnalysisId,
        v_phasingProgramRunId,
        JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, '$.PhasingContainer.PreparePhasingData[0].spaceGroupId')),
        JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, '$.PhasingContainer.PreparePhasingData[0].lowRes')),
        JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, '$.PhasingContainer.PreparePhasingData[0].highRes'))
      );
  END IF;
    
  IF json_exists(p_phasing_result,
    '$.PhasingContainer.Phasing') THEN
    INSERT INTO Phasing (phasingAnalysisId, phasingProgramRunId, spaceGroupId, method, solventContent, enantiomorph, lowRes, highRes) 
      VALUES (
        v_phasingAnalysisId,
        v_phasingProgramRunId,
        JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, '$.PhasingContainer.Phasing[0].spaceGroupId')),
        JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, '$.PhasingContainer.Phasing[0].method')),
        JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, '$.PhasingContainer.Phasing[0].solventContent')),
        JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, '$.PhasingContainer.Phasing[0].enantiomorph')),
        JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, '$.PhasingContainer.Phasing[0].lowRes')),
        JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, '$.PhasingContainer.Phasing[0].highRes'))
      );
  END IF;

  IF json_exists(p_phasing_result,
    '$.PhasingContainer.ModelBuilding') THEN
    INSERT INTO ModelBuilding (phasingAnalysisId, phasingProgramRunId, spaceGroupId, lowRes, highRes)
      VALUES (
        v_phasingAnalysisId,
        v_phasingProgramRunId,
        JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, '$.PhasingContainer.ModelBuilding[0].spaceGroupId')),
        JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, '$.PhasingContainer.ModelBuilding[0].lowRes')),
        JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, '$.PhasingContainer.ModelBuilding[0].highRes'))
      ); -- guessing, not seen in example 
  END IF;
  
  IF json_exists(p_phasing_result,
    '$.PhasingContainer.SubstructureDetermination') THEN  
    INSERT INTO SubstructureDetermination (phasingAnalysisId, phasingProgramRunId, spaceGroupId, method, lowRes, highRes)
      VALUES (
        v_phasingAnalysisId,
        v_phasingProgramRunId,
        JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, '$.PhasingContainer.SubstructureDetermination[0].spaceGroupId')),
        JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, '$.PhasingContainer.SubstructureDetermination[0].method')),
        JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, '$.PhasingContainer.SubstructureDetermination[0].lowRes')),
        JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, '$.PhasingContainer.SubstructureDetermination[0].highRes'))
      );
  END IF;

  IF json_exists(p_phasing_result,
    '$.PhasingContainer.PhasingProgramAttachment') THEN
    SET v_no_attachments := JSON_LENGTH(p_phasing_result, '$.PhasingContainer.PhasingProgramAttachment');
    SET i := 0;
    WHILE i < v_no_attachments DO
    INSERT INTO PhasingProgramAttachment (phasingProgramRunId, fileType, fileName, filePath, recordTimeStamp)
      VALUES (
        v_phasingProgramRunId,
        JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, concat('$.PhasingContainer.PhasingProgramAttachment[', i, '].fileType'))),
        JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, concat('$.PhasingContainer.PhasingProgramAttachment[', i, '].fileName'))),
        JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, concat('$.PhasingContainer.PhasingProgramAttachment[', i, '].filePath'))),
        JSON_UNQUOTE(JSON_EXTRACT(p_phasing_result, concat('$.PhasingContainer.PhasingProgramAttachment[', i, '].recordTimeStamp')))
      );
      SET i := i + 1;
    END WHILE;
  END IF;

/*
  Need to roll-back and send signal if errors. May need a handler for this.
  Need to have checks before the inserts to ensure the corresponding element exists in the json.
*/
  SET p_id := v_phasingAnalysisId;
  COMMIT;
END `proc_body`;;
DELIMITER ;