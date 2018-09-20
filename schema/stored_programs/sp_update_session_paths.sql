
-- 
-- NOTE:
-- We assume that p_oldRootPath and p_newRootPath both contain a trailing "/"
-- TODO:
-- Need to make sure I'm only updating the matching columns -- I think perhaps I am now?
-- Tests:
-- call update_session_paths('zz', 999991000, 497, '/dls/x91/data/2016/', '/dls/x91/data/2017/');
-- ERROR 1643 (45000): Corresponding rows for p_proposalCode + p_proposalNumber + p_sessionNumber not found


DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` FUNCTION `root_replace`(p_str varchar(255), p_oldroot varchar(255), p_newroot varchar(255)) 
RETURNS varchar(255) 
CONTAINS SQL 
COMMENT 'Returns a varchar where the old root p_oldroot (the leftmost part) of p_str has been replaced with a new root p_newroot'
BEGIN
 DECLARE path_len smallint unsigned DEFAULT LENGTH(p_oldroot);
 RETURN CASE WHEN LEFT(p_str, path_len) = BINARY p_oldroot THEN CONCAT(p_newroot, SUBSTRING(p_str, path_len + 1)) ELSE p_str END; 
END;;
DELIMITER ;


DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `update_session_paths` (
  p_proposalCode varchar(3),
  p_proposalNumber int(10),
  p_sessionNumber int(10),
  p_oldRoot varchar(255),
  p_newRoot varchar(255)
) 
MODIFIES SQL DATA
COMMENT 'Attempts to update the root (the leftmost part) of all paths related to session 
p_proposalCode + p_proposalNumber + p_sessionNumber from p_oldRoot to p_newRoot.
NOTE:
We assume that p_oldRoot and p_newRoot both contain a trailing "/"'
BEGIN
  DECLARE row_session_id int(10) unsigned DEFAULT NULL;
  DECLARE row_proposal_id int(10) unsigned DEFAULT NULL;
  DECLARE row_sample_id int(10) unsigned DEFAULT NULL;
        
  IF p_proposalCode IS NOT NULL AND p_proposalNumber IS NOT NULL AND p_sessionNumber IS NOT NULL THEN
      SELECT max(bs.sessionid), p.proposalId INTO row_session_id, row_proposal_id 
      FROM Proposal p INNER JOIN BLSession bs ON p.proposalid = bs.proposalid 
      WHERE p.proposalCode = p_proposalCode AND p.proposalNumber = p_proposalNumber AND bs.visit_number = p_sessionNumber;

      IF row_session_id IS NOT NULL AND row_proposal_id IS NOT NULL THEN

-- DataCollection
        UPDATE DataCollection dc
          INNER JOIN DataCollectionGroup dcg on dcg.dataCollectionGroupId = dc.dataCollectionGroupId 
        SET 
          imageDirectory = root_replace(imageDirectory, p_oldRoot, p_newRoot),
          xtalSnapshotFullPath1 = root_replace(xtalSnapshotFullPath1, p_oldRoot, p_newRoot), 
          xtalSnapshotFullPath2 = root_replace(xtalSnapshotFullPath2, p_oldRoot, p_newRoot), 
          xtalSnapshotFullPath3 = root_replace(xtalSnapshotFullPath3, p_oldRoot, p_newRoot),
          xtalSnapshotFullPath4 = root_replace(xtalSnapshotFullPath4, p_oldRoot, p_newRoot),
          datFullPath = root_replace(datFullPath, p_oldRoot, p_newRoot)
        WHERE 
          dcg.sessionId = row_session_id;

-- DataCollectionFileAttachment
        UPDATE DataCollectionFileAttachment dcfa
		  INNER JOIN DataCollection dc on dc.dataCollectionId = dcfa.datacollectionId
          INNER JOIN DataCollectionGroup dcg on dcg.dataCollectionGroupId = dc.dataCollectionGroupId 
        SET 
          fileFullPath = root_replace(fileFullPath, p_oldRoot, p_newRoot)
        WHERE 
          dcg.sessionId = row_session_id;
          
-- XFEFluorescenceSpectrum 
	UPDATE XFEFluorescenceSpectrum 
	SET 
          jpegScanFileFullPath = root_replace(jpegScanFileFullPath, p_oldRoot, p_newRoot), 
          annotatedPymcaXfeSpectrum = root_replace(annotatedPymcaXfeSpectrum, p_oldRoot, p_newRoot),
          fittedDataFileFullPath = root_replace(fittedDataFileFullPath, p_oldRoot, p_newRoot),
          scanFileFullPath = root_replace(scanFileFullPath, p_oldRoot, p_newRoot),
          workingDirectory = root_replace(workingDirectory, p_oldRoot, p_newRoot)
	WHERE 
          sessionId = row_session_id;
          
-- EnergyScan
	UPDATE EnergyScan
	SET 
          scanFileFullPath = root_replace(scanFileFullPath, p_oldRoot, p_newRoot), 
          jpegChoochFileFullPath = root_replace(jpegChoochFileFullPath, p_oldRoot, p_newRoot),
          filename = root_replace(filename, p_oldRoot, p_newRoot),
          choochFileFullPath = root_replace(choochFileFullPath, p_oldRoot, p_newRoot),
          workingDirectory = root_replace(workingDirectory, p_oldRoot, p_newRoot)
	WHERE 
          sessionId = row_session_id;

-- PhasingProgramAttachment
	UPDATE PhasingProgramAttachment ppa
          INNER JOIN Phasing p on p.phasingProgramRunId = ppa.phasingProgramRunId
          INNER JOIN Phasing_has_Scaling phs on phs.phasingAnalysisId = p.phasingAnalysisId
          INNER JOIN AutoProcScaling_has_Int apshi on apshi.autoProcScalingId = phs.autoProcScalingId
          INNER JOIN AutoProcIntegration api on api.autoProcIntegrationId = apshi.autoProcIntegrationId
          INNER JOIN DataCollection dc on dc.dataCollectionId = api.dataCollectionId
          INNER JOIN DataCollectionGroup dcg on dcg.dataCollectionGroupId = dc.dataCollectionGroupId 
	SET
          filePath = root_replace(filePath, p_oldRoot, p_newRoot)
        WHERE
          dcg.sessionId = row_session_id;  

-- AutoProcProgramAttachment
        UPDATE AutoProcProgramAttachment appa
          INNER JOIN AutoProcIntegration api on api.autoProcProgramId = appa.autoProcProgramId
          INNER JOIN DataCollection dc on dc.dataCollectionId = api.dataCollectionId
          INNER JOIN DataCollectionGroup dcg on dcg.dataCollectionGroupId = dc.dataCollectionGroupId
        SET
          filePath = root_replace(filePath, p_oldRoot, p_newRoot)
        WHERE
          dcg.sessionId = row_session_id;

-- MXMRRun
        UPDATE MXMRRun mr
          INNER JOIN AutoProcScaling_has_Int apshi on mr.autoProcScalingId = apshi.autoProcScalingId 
          INNER JOIN AutoProcIntegration api on api.autoProcIntegrationId = apshi.autoProcIntegrationId 
          INNER JOIN DataCollection dc on dc.dataCollectionId = api.datacollectionId
          INNER JOIN DataCollectionGroup dcg on dcg.dataCollectionGroupId = dc.dataCollectionGroupId
        SET
          inputCoordFile = root_replace(inputCoordFile, p_oldRoot, p_newRoot),
          outputCoordFile = root_replace(outputCoordFile, p_oldRoot, p_newRoot),
          inputMTZFile = root_replace(inputMTZFile, p_oldRoot, p_newRoot),
          outputMTZFile = root_replace(outputMTZFile, p_oldRoot, p_newRoot),
          runDirectory = root_replace(runDirectory, p_oldRoot, p_newRoot),
          logFile = root_replace(logFile, p_oldRoot, p_newRoot)
        WHERE
          dcg.sessionId = row_session_id;

-- MXMRRunBlob
        UPDATE MXMRRunBlob mrb
          INNER JOIN MXMRRun mr on mrb.mxMRRunId = mr.mxMRRunId
          INNER JOIN AutoProcScaling_has_Int apshi on mr.autoProcScalingId = apshi.autoProcScalingId 
          INNER JOIN AutoProcIntegration api on api.autoProcIntegrationId = apshi.autoProcIntegrationId 
          INNER JOIN DataCollection dc on dc.dataCollectionId = api.datacollectionId
          INNER JOIN DataCollectionGroup dcg on dcg.dataCollectionGroupId = dc.dataCollectionGroupId
        SET
          view1 = root_replace(view1, p_oldRoot, p_newRoot),
          view2 = root_replace(view2, p_oldRoot, p_newRoot),
          view3 = root_replace(view3, p_oldRoot, p_newRoot)
        WHERE
          dcg.sessionId = row_session_id;

-- BLSampleImage
        UPDATE BLSampleImage blsi
          INNER JOIN BLSample bls on blsi.blsampleId = bls.blsampleId
          INNER JOIN Container c on c.containerId = bls.containerId
		SET
          imageFullPath = root_replace(imageFullPath, p_oldRoot, p_newRoot)
        WHERE 
          c.sessionId = row_session_id;

-- BLSampleImageAnalysis
        UPDATE BLSampleImageAnalysis blsia
          INNER JOIN BLSampleImage blsi on blsia.blSampleImageId = blsi.blSampleImageId
          INNER JOIN BLSample bls on blsi.blsampleId = bls.blsampleId
          INNER JOIN Container c on c.containerId = bls.containerId
		SET
          imageFullPath = root_replace(imageFullPath, p_oldRoot, p_newRoot)
        WHERE 
          c.sessionId = row_session_id;

      ELSE
        -- MYSQL_ERRNO=1643: ER_SIGNAL_NOT_FOUND: Unhandled user-defined not found condition
		SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1643, MESSAGE_TEXT='Corresponding rows for p_proposalCode + p_proposalNumber + p_sessionNumber not found';
      END IF;
  END IF;
END;;
DELIMITER ;
