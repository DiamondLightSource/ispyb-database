-- add and modify summary results table

CREATE TABLE SummaryResult AS (
SELECT p.proposalId, b.visit_number, b.beamLineName, b.startDate, b.endDate,
app.processingPrograms, app.processingMessage, ap.spaceGroup, apss.scalingStatisticsType,
ap.refinedCell_a, ap.refinedCell_b, ap.refinedCell_c, ap.refinedCell_alpha, ap.refinedCell_beta, ap.refinedCell_gamma,
apss.resolutionLimitLow, apss.resolutionLimitHigh, apss.rMeasWithinIPlusIMinus, apss.ccAnomalous,
m.rFreeValueStart, m.rFreeValueEnd
FROM Proposal p
LEFT JOIN BLSession b ON b.proposalId = p.proposalId 
LEFT JOIN DataCollectionGroup dcg ON dcg.sessionId = b.sessionId 
LEFT JOIN DataCollection dc ON dc.dataCollectionGroupId = dcg.dataCollectionGroupId
LEFT JOIN AutoProcIntegration api ON api.dataCollectionId = dc.dataCollectionId
LEFT JOIN AutoProcProgram app ON app.autoProcProgramId = api.autoProcProgramId
LEFT JOIN ProcessingJob pj ON pj.processingJobId = app.processingJobId 
LEFT JOIN AutoProc ap ON ap.autoProcProgramId = app.autoProcProgramId 
LEFT JOIN AutoProcScaling aps ON aps.autoProcId = ap.autoProcId 
LEFT JOIN AutoProcScalingStatistics apss ON apss.autoProcScalingId = aps.autoProcScalingId 
LEFT JOIN MXMRRun m ON m.autoProcScalingId = apss.autoProcScalingId
LEFT JOIN MXMRRunBlob mb on mb.mxMRRunId = m.mxMRRunId
WHERE b.beamLineName IN ('i02', 'i02-1', 'i02-2', 'i03', 'i04-1', 'i23', 'i24', 'i19-1' 'i19-2')
);
ALTER TABLE SummaryResult ADD summaryId INT PRIMARY KEY AUTO_INCREMENT;

CREATE INDEX SummaryResults_proposalId_startDate_endDate
ON SummaryResults(proposalId, startDate, endDate);