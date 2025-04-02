-- Create the processing scripts role
CREATE ROLE IF NOT EXISTS ispyb_scripts_processing;

-- You must also create a database user and grant this role to them, e.g.
-- CREATE USER ispyb_mx_scripts@'%' IDENTIFIED BY 'the_password';
-- GRANT ispyb_scripts_processing to ispyb_mx_scripts@'%';
-- SET DEFAULT ROLE ispyb_scripts_processing FOR ispyb_mx_scripts@'%';

GRANT SELECT ON AutoProc TO ispyb_scripts_processing;
GRANT SELECT ON AutoProcIntegration TO ispyb_scripts_processing;
GRANT SELECT ON AutoProcProgram TO ispyb_scripts_processing;
GRANT SELECT ON AutoProcProgramAttachment TO ispyb_scripts_processing;
GRANT SELECT ON AutoProcProgramMessage TO ispyb_scripts_processing;
GRANT SELECT ON AutoProcScaling TO ispyb_scripts_processing;
GRANT SELECT ON AutoProcScaling_has_Int TO ispyb_scripts_processing;
GRANT SELECT ON AutoProc TO ispyb_scripts_processing;
GRANT SELECT ON AutoProcScalingStatistics TO ispyb_scripts_processing;
GRANT SELECT ON BLSession TO ispyb_scripts_processing;
GRANT SELECT ON DataCollection TO ispyb_scripts_processing;
GRANT SELECT ON Proposal TO ispyb_scripts_processing;
GRANT SELECT ON ProcessingJob TO ispyb_scripts_processing;
GRANT SELECT ON ProcessingJobImageSweep TO ispyb_scripts_processing;
GRANT SELECT ON Container TO ispyb_scripts_processing;
GRANT SELECT ON BLSample TO ispyb_scripts_processing;
GRANT SELECT ON BLSampleImage TO ispyb_scripts_processing;
