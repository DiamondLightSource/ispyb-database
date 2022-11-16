CREATE ROLE IF NOT EXISTS ispyb_web_verify_tests;

-- You must also create a database user and grant this role to them, e.g.
-- CREATE USER sqlalchemy_tests@'%' IDENTIFIED BY 'the_password';
-- GRANT ispyb_web_verify_tests to sqlalchemy_tests@'%';
-- SET DEFAULT ROLE ispyb_web_verify_tests FOR sqlalchemy_tests@'%';

GRANT SELECT ON AdminActivity TO ispyb_web_verify_tests;
GRANT SELECT ON AdminVar TO ispyb_web_verify_tests;

GRANT SELECT ON BeamLineSetup TO ispyb_web_verify_tests;

GRANT SELECT ON BF_fault TO ispyb_web_verify_tests;
GRANT SELECT ON BF_component TO ispyb_web_verify_tests;
GRANT SELECT ON BF_component_beamline TO ispyb_web_verify_tests;
GRANT SELECT ON BF_subcomponent TO ispyb_web_verify_tests;
GRANT SELECT ON BF_subcomponent_beamline TO ispyb_web_verify_tests;
GRANT SELECT ON BF_system TO ispyb_web_verify_tests;
GRANT SELECT ON BF_system_beamline TO ispyb_web_verify_tests;

GRANT SELECT ON BLSample TO ispyb_web_verify_tests;
GRANT SELECT ON BLSampleImageScore TO ispyb_web_verify_tests;
GRANT SELECT ON BLSampleImageMeasurement TO ispyb_web_verify_tests;
GRANT SELECT ON BLSampleType_has_Component TO ispyb_web_verify_tests;
GRANT SELECT ON BLSampleImage TO ispyb_web_verify_tests;
GRANT SELECT ON BLSampleGroup TO ispyb_web_verify_tests;
GRANT SELECT ON BLSampleGroup_has_BLSample TO ispyb_web_verify_tests;
GRANT SELECT ON BLSample_has_DataCollectionPlan TO ispyb_web_verify_tests;

GRANT SELECT ON BLSession TO ispyb_web_verify_tests;

GRANT SELECT ON BLSubSample TO ispyb_web_verify_tests;

GRANT SELECT ON CTF TO ispyb_web_verify_tests;
GRANT SELECT ON CourierTermsAccepted TO ispyb_web_verify_tests;
GRANT SELECT ON CalendarHash TO ispyb_web_verify_tests;
GRANT SELECT ON ConcentrationType TO ispyb_web_verify_tests;

GRANT SELECT ON ComponentSubType TO ispyb_web_verify_tests;
GRANT SELECT ON ComponentType TO ispyb_web_verify_tests;
GRANT SELECT ON Component_has_SubType TO ispyb_web_verify_tests;
GRANT SELECT ON ComponentLattice TO ispyb_web_verify_tests;

GRANT SELECT ON Container TO ispyb_web_verify_tests;
GRANT SELECT ON ContainerHistory TO ispyb_web_verify_tests;
GRANT SELECT ON ContainerInspection TO ispyb_web_verify_tests;
GRANT SELECT ON ContainerQueue TO ispyb_web_verify_tests;
GRANT SELECT ON ContainerQueueSample TO ispyb_web_verify_tests;
GRANT SELECT ON ContainerRegistry TO ispyb_web_verify_tests;
GRANT SELECT ON ContainerRegistry_has_Proposal TO ispyb_web_verify_tests;
GRANT SELECT ON ContainerReport TO ispyb_web_verify_tests;

GRANT SELECT ON Crystal TO ispyb_web_verify_tests;
GRANT SELECT ON Crystal_has_UUID TO ispyb_web_verify_tests;

GRANT SELECT ON DataCollection TO ispyb_web_verify_tests;
GRANT SELECT ON DataCollectionPlan_has_Detector TO ispyb_web_verify_tests;
GRANT SELECT ON DataCollectionComment TO ispyb_web_verify_tests;
GRANT SELECT ON DataCollectionGroup TO ispyb_web_verify_tests;

GRANT SELECT ON Detector TO ispyb_web_verify_tests;

GRANT SELECT ON Dewar TO ispyb_web_verify_tests;
GRANT SELECT ON DewarRegistry TO ispyb_web_verify_tests;
GRANT SELECT ON DewarRegistry_has_Proposal TO ispyb_web_verify_tests;
GRANT SELECT ON DewarReport TO ispyb_web_verify_tests;
GRANT SELECT ON DewarTransportHistory TO ispyb_web_verify_tests;
GRANT SELECT ON DewarLocation TO ispyb_web_verify_tests;

GRANT SELECT ON DiffractionPlan TO ispyb_web_verify_tests;

GRANT SELECT ON EnergyScan TO ispyb_web_verify_tests;
GRANT SELECT ON ExperimentKindDetails TO ispyb_web_verify_tests;

GRANT SELECT ON LabContact TO ispyb_web_verify_tests;
GRANT SELECT ON Laboratory TO ispyb_web_verify_tests;

GRANT SELECT ON MotionCorrection TO ispyb_web_verify_tests;
GRANT SELECT ON MotionCorrectionDrift TO ispyb_web_verify_tests;
GRANT SELECT ON Movie TO ispyb_web_verify_tests;

GRANT SELECT ON PHPSession TO ispyb_web_verify_tests;
GRANT SELECT ON Person TO ispyb_web_verify_tests;

GRANT SELECT ON PDB TO ispyb_web_verify_tests;
GRANT SELECT ON PDBEntry TO ispyb_web_verify_tests;
GRANT SELECT ON Permission TO ispyb_web_verify_tests;
GRANT SELECT ON Pod TO ispyb_web_verify_tests;
GRANT SELECT ON Position TO ispyb_web_verify_tests;

GRANT SELECT ON ProcessingJob TO ispyb_web_verify_tests;
GRANT SELECT ON ProcessingJobParameter TO ispyb_web_verify_tests;
GRANT SELECT ON ProcessingJobImageSweep TO ispyb_web_verify_tests;

GRANT SELECT ON Project TO ispyb_web_verify_tests;
GRANT SELECT ON Project_has_BLSample TO ispyb_web_verify_tests;
GRANT SELECT ON Project_has_DCGroup TO ispyb_web_verify_tests;
GRANT SELECT ON Project_has_Person TO ispyb_web_verify_tests;
GRANT SELECT ON Project_has_Protein TO ispyb_web_verify_tests;
GRANT SELECT ON Project_has_Shipping TO ispyb_web_verify_tests;
GRANT SELECT ON Project_has_User TO ispyb_web_verify_tests;
GRANT SELECT ON Project_has_XFEFSpectrum TO ispyb_web_verify_tests;
GRANT SELECT ON Project_has_EnergyScan TO ispyb_web_verify_tests;
GRANT SELECT ON Project_has_Session TO ispyb_web_verify_tests;

GRANT SELECT ON Protein TO ispyb_web_verify_tests;
GRANT SELECT ON Protein_has_PDB TO ispyb_web_verify_tests;

GRANT SELECT ON SW_onceToken TO ispyb_web_verify_tests;

GRANT SELECT ON ScanParametersModel TO ispyb_web_verify_tests;
GRANT SELECT ON ScanParametersService TO ispyb_web_verify_tests;

GRANT SELECT ON Schedule TO ispyb_web_verify_tests;
GRANT SELECT ON ScheduleComponent TO ispyb_web_verify_tests;

GRANT SELECT ON Screen TO ispyb_web_verify_tests;
GRANT SELECT ON ScreenComponentGroup TO ispyb_web_verify_tests;
GRANT SELECT ON ScreenComponent TO ispyb_web_verify_tests;

GRANT SELECT ON SessionType TO ispyb_web_verify_tests;
GRANT SELECT ON Session_has_Person TO ispyb_web_verify_tests;

GRANT SELECT ON Shipping TO ispyb_web_verify_tests;
GRANT SELECT ON ShippingHasSession TO ispyb_web_verify_tests;

GRANT SELECT ON UserGroup TO ispyb_web_verify_tests;
GRANT SELECT ON UserGroup_has_Person TO ispyb_web_verify_tests;
GRANT SELECT ON UserGroup_has_Permission TO ispyb_web_verify_tests;

GRANT SELECT ON XFEFluorescenceSpectrum TO ispyb_web_verify_tests;
GRANT SELECT ON XRFFluorescenceMapping TO ispyb_web_verify_tests;
GRANT SELECT ON XRFFluorescenceMappingROI TO ispyb_web_verify_tests;
