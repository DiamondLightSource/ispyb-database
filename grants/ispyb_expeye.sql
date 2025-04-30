-- Create the Exp-eye Core API role.
CREATE ROLE IF NOT EXISTS ispyb_expeye_core_role;

-- You must also create a database user and grant this role to them, e.g.
-- CREATE USER ispyb_expeye_core@'%' IDENTIFIED BY 'the_password';
-- GRANT ispyb_expeye_core_role to ispyb_expeye_core@'%';
-- SET DEFAULT ROLE ispyb_expeye_core_role FOR ispyb_expeye_core@'%';

GRANT ispyb_propagation TO ispyb_expeye_core_role;

CREATE ROLE ispyb_expeye_acquisition_role;

GRANT SELECT, INSERT, UPDATE, DELETE ON Proposal TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON BLSession TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE ON DataCollectionGroup TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE ON DataCollection TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE ON Position TO ispyb_expeye_acquisition_role;

GRANT SELECT, INSERT, UPDATE, DELETE ON Shipping TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON ShippingHasSession TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON Project_has_Shipping TO ispyb_expeye_acquisition_role;

GRANT SELECT, INSERT, UPDATE, DELETE ON LabContact TO ispyb_expeye_acquisition_role;

GRANT SELECT, INSERT, UPDATE, DELETE ON Dewar TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON DewarLocation TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON DewarLocationList TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON DewarRegistry TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON DewarRegistry_has_Proposal TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON DewarReport TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE ON DewarTransportHistory TO ispyb_expeye_acquisition_role;

GRANT SELECT, INSERT, UPDATE, DELETE ON Container TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON ContainerInspection TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON ContainerQueue TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON ContainerQueueSample TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON ContainerRegistry TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON ContainerRegistry_has_Proposal TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON ContainerReport TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON ContainerType TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE ON ContainerHistory TO ispyb_expeye_acquisition_role;

GRANT SELECT ON ProcessingPipeline TO ispyb_expeye_acquisition_role;
GRANT SELECT ON ProcessingPipelineCategory TO ispyb_expeye_acquisition_role;

GRANT SELECT, INSERT, UPDATE, DELETE ON BLSample TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON BLSampleGroup TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON BLSampleGroup_has_BLSample TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON BLSubSample TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON Project_has_BLSample TO ispyb_expeye_acquisition_role;

GRANT SELECT ON Protein TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE ON Crystal TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON XFEFluorescenceSpectrum TO ispyb_expeye_acquisition_role;

GRANT SELECT, INSERT, UPDATE, DELETE ON DiffractionPlan TO ispyb_expeye_acquisition_role;

GRANT SELECT ON ComponentType TO ispyb_expeye_acquisition_role;
GRANT SELECT ON ComponentSubType TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON Component_has_SubType TO ispyb_expeye_acquisition_role;

GRANT SELECT, INSERT, UPDATE ON RobotAction TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE ON GridInfo TO ispyb_expeye_acquisition_role;

GRANT ispyb_expeye_acquisition_role TO ispyb_expeye_core_role;

GRANT SELECT ON AutoProcProgram TO ispyb_expeye_core_role;
GRANT SELECT, INSERT, UPDATE ON AutoProcProgramAttachment TO ispyb_expeye_core_role;
GRANT SELECT ON AutoProcIntegration TO ispyb_expeye_core_role;

GRANT SELECT ON ProcessingJob TO ispyb_expeye_core_role;
