-- add and modify summary results table

CREATE TABLE SummaryResult AS (
SELECT p.proposalId, b.visit_number, b.beamLineName, b.startDate, b.endDate,
app.processingPrograms, app.processingMessage, ap.spaceGroup, apss.scalingStatisticsType,
ap.refinedCell_a, ap.refinedCell_b, ap.refinedCell_c, ap.refinedCell_alpha, ap.refinedCell_beta, ap.refinedCell_gamma,
apss.resolutionLimitLow, apss.resolutionLimitHigh, apss.rMeasWithinIPlusIMinus, apss.ccAnomalous,
m.rFreeValueStart, m.rFreeValueEnd
FROM ispyb.Proposal p
LEFT JOIN ispyb.BLSession b ON b.proposalId = p.proposalId 
LEFT JOIN ispyb.DataCollectionGroup dcg on dcg.sessionId = b.sessionId 
LEFT JOIN ispyb.DataCollection dc on dc.dataCollectionGroupId = dcg.dataCollectionGroupId
LEFT JOIN ispyb.ProcessingJob pj on pj.dataCollectionId = dc.dataCollectionId 
LEFT JOIN ispyb.AutoProcProgram app on app.processingJobId = pj.processingJobId 
LEFT JOIN ispyb.AutoProc ap on ap.autoProcProgramId = app.autoProcProgramId 
LEFT JOIN ispyb.AutoProcScaling aps on aps.autoProcId = ap.autoProcId 
LEFT JOIN ispyb.AutoProcScalingStatistics apss on apss.autoProcScalingId = aps.autoProcScalingId  
LEFT JOIN ispyb.MXMRRun m on m.autoProcScalingId = apss.autoProcScalingId
LEFT JOIN ispyb.MXMRRunBlob mb on mb.mxMRRunId = m.mxMRRunId 
);
ALTER TABLE SummaryResult ADD summaryId INT PRIMARY KEY AUTO_INCREMENT;

CREATE INDEX SummaryResults_FK1 
ON SummaryResults(proposalId);

CREATE INDEX startDate_Index
ON SummaryResults(startDate);

CREATE INDEX endDate_Index
ON SummaryResults(endDate);