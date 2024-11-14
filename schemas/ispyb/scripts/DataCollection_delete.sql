-- This is a script to delete a given DataCollection (by dataCollectionId) and
-- all associated rows in other tables.
-- Change the value of @dcId to the dataCollectionId you would like to delete.
-- Disclaimer:
-- This script is not extensively tested. It also currently will leave behind
-- some orphaned rows.
-- Run this at your own risk and beware of cascading deletes.

SET @dcId := 1000;

DELETE
FROM ImageQualityIndicators
WHERE dataCollectionId = @dcId;

DELETE ProcessingJobParameter
FROM ProcessingJobParameter
  JOIN ProcessingJob
WHERE ProcessingJob.processingJobId = ProcessingJobParameter.processingJobId AND
  ProcessingJob.dataCollectionId = @dcId;

DELETE ProcessingJobImageSweep
FROM ProcessingJobImageSweep
  JOIN ProcessingJob
WHERE ProcessingJob.processingJobId = ProcessingJobImageSweep.processingJobId AND
  ProcessingJob.dataCollectionId = @dcId;

DELETE AutoProcProgramMessage
FROM AutoProcProgramMessage
  JOIN ProcessingJob
  JOIN AutoProcProgram
WHERE ProcessingJob.processingJobId = AutoProcProgram.processingJobId AND
  AutoProcProgramMessage.autoProcProgramId = AutoProcProgram.autoProcProgramId AND
  ProcessingJob.dataCollectionId = @dcId;

DELETE AutoProcProgram
FROM AutoProcProgram
  JOIN ProcessingJob
WHERE ProcessingJob.processingJobId = AutoProcProgram.processingJobId AND
  ProcessingJob.dataCollectionId = @dcId;

DELETE
FROM ProcessingJob
WHERE dataCollectionId = @dcId;

DELETE AutoProcProgramMessage
FROM AutoProcProgramMessage
  JOIN AutoProcProgram
  JOIN AutoProcIntegration
WHERE AutoProcIntegration.autoProcProgramId = AutoProcProgram.autoProcProgramId AND
  AutoProcProgramMessage.autoProcProgramId = AutoProcProgram.autoProcProgramId AND
  AutoProcIntegration.dataCollectionId = @dcId;

DELETE AutoProcProgram
FROM AutoProcProgram
  JOIN AutoProcIntegration
WHERE AutoProcIntegration.autoProcProgramId = AutoProcProgram.autoProcProgramId AND
  AutoProcIntegration.dataCollectionId = @dcId;

DELETE
FROM AutoProcIntegration
WHERE dataCollectionId = @dcId;

DELETE
FROM GridInfo
WHERE dataCollectionId = @dcId;

DELETE
FROM DataCollection
WHERE dataCollectionId = @dcId;
