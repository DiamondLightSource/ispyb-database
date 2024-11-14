-- Create the fragment screening application role.
CREATE ROLE IF NOT EXISTS ispyb_fragment_screening;

-- You must also create a database user and grant this role to them, e.g.
-- CREATE USER fragment_screening_user@'%' IDENTIFIED BY 'the_password';
-- GRANT ispyb_fragment_screening to fragment_screening_user@'%';
-- SET DEFAULT ROLE ispyb_fragment_screening FOR fragment_screening_user@'%';

-- Grants for ispyb_fragment_screening
GRANT SELECT ON AutoProcIntegration TO 'ispyb_fragment_screening';
GRANT SELECT ON AutoProcProgram TO 'ispyb_fragment_screening';
GRANT SELECT ON AutoProcProgramAttachment TO 'ispyb_fragment_screening';
GRANT SELECT ON AutoProcScaling TO 'ispyb_fragment_screening';
GRANT SELECT ON AutoProcScalingStatistics TO 'ispyb_fragment_screening';
GRANT SELECT ON AutoProcScaling_has_Int TO 'ispyb_fragment_screening';
GRANT SELECT ON BLSampleImage TO 'ispyb_fragment_screening';
GRANT SELECT ON BLSampleImageAutoScoreClass TO 'ispyb_fragment_screening';
GRANT SELECT ON BLSampleImageScore TO 'ispyb_fragment_screening';
GRANT SELECT ON BLSampleImage_has_AutoScoreClass TO 'ispyb_fragment_screening';
GRANT SELECT ON BLSession TO 'ispyb_fragment_screening';
GRANT SELECT ON BLSubSample TO 'ispyb_fragment_screening';
GRANT SELECT ON Container TO 'ispyb_fragment_screening';
GRANT SELECT ON ContainerInspection TO 'ispyb_fragment_screening';
GRANT SELECT ON Crystal TO 'ispyb_fragment_screening';
GRANT SELECT ON DataCollection TO 'ispyb_fragment_screening';
GRANT SELECT ON ProcessingJob TO 'ispyb_fragment_screening';
GRANT SELECT ON ProcessingJobParameter TO 'ispyb_fragment_screening';
GRANT SELECT ON Proposal TO 'ispyb_fragment_screening';
GRANT SELECT ON Protein TO 'ispyb_fragment_screening';
GRANT SELECT, INSERT, UPDATE ON BLSample TO 'ispyb_fragment_screening';
GRANT SELECT, INSERT, UPDATE ON BLSampleGroup TO 'ispyb_fragment_screening';
GRANT SELECT, INSERT, UPDATE ON BLSampleGroup_has_BLSample TO 'ispyb_fragment_screening';
