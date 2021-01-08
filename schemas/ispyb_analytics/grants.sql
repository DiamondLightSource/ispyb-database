-- Create role
CREATE ROLE data_scientist;

-- Grant select on views
GRANT SELECT ON BLSession TO data_scientist;
GRANT SELECT ON DataCollectionGroup TO data_scientist;
GRANT SELECT ON DataCollection TO data_scientist;
GRANT SELECT ON EnergyScan TO data_scientist;
GRANT SELECT ON XFEFluorescenceSpectrum TO data_scientist;
GRANT SELECT ON AutoProcIntegration TO data_scientist;
GRANT SELECT ON AutoProcProgram TO data_scientist;
GRANT SELECT ON AutoProcProgramAttachment TO data_scientist;
GRANT SELECT ON AutoProcProgramMessage TO data_scientist;
GRANT SELECT ON AutoProcScaling_has_Int TO data_scientist;
GRANT SELECT ON AutoProcScaling TO data_scientist;
GRANT SELECT ON AutoProcScalingStatistics TO data_scientist;
GRANT SELECT ON AutoProc TO data_scientist;
