-- Create the read-only, no PII role.
CREATE ROLE IF NOT EXISTS ispyb_ro_nopii;

/*
-- Query to get grant statements for each table in the database:

SELECT CONCAT('GRANT SELECT ON ', table_name, ' TO ispyb_ro_nopii;') INTO OUTFILE '/tmp/ispyb_ro_nopii-2.sql'
FROM information_schema.TABLES
WHERE table_schema = 'ispyb' AND table_name <> 'Person' AND table_type = 'BASE TABLE'
ORDER BY table_name;

*/

GRANT SELECT ON AbInitioModel TO ispyb_ro_nopii;
GRANT SELECT ON Additive TO ispyb_ro_nopii;
GRANT SELECT ON AdminActivity TO ispyb_ro_nopii;
GRANT SELECT ON AdminVar TO ispyb_ro_nopii;
GRANT SELECT ON Aperture TO ispyb_ro_nopii;
GRANT SELECT ON Assembly TO ispyb_ro_nopii;
GRANT SELECT ON AssemblyHasMacromolecule TO ispyb_ro_nopii;
GRANT SELECT ON AssemblyRegion TO ispyb_ro_nopii;
GRANT SELECT ON AutoProc TO ispyb_ro_nopii;
GRANT SELECT ON AutoProcIntegration TO ispyb_ro_nopii;
GRANT SELECT ON AutoProcProgram TO ispyb_ro_nopii;
GRANT SELECT ON AutoProcProgramAttachment TO ispyb_ro_nopii;
GRANT SELECT ON AutoProcProgramMessage TO ispyb_ro_nopii;
GRANT SELECT ON AutoProcScaling TO ispyb_ro_nopii;
GRANT SELECT ON AutoProcScalingStatistics TO ispyb_ro_nopii;
GRANT SELECT ON AutoProcScaling_has_Int TO ispyb_ro_nopii;
GRANT SELECT ON AutoProcStatus TO ispyb_ro_nopii;
GRANT SELECT ON BeamApertures TO ispyb_ro_nopii;
GRANT SELECT ON BeamCalendar TO ispyb_ro_nopii;
GRANT SELECT ON BeamCentres TO ispyb_ro_nopii;
GRANT SELECT ON BeamlineAction TO ispyb_ro_nopii;
GRANT SELECT ON BeamLineSetup TO ispyb_ro_nopii;
GRANT SELECT ON BeamlineStats TO ispyb_ro_nopii;
GRANT SELECT ON BF_automationError TO ispyb_ro_nopii;
GRANT SELECT ON BF_automationFault TO ispyb_ro_nopii;
GRANT SELECT ON BF_component TO ispyb_ro_nopii;
GRANT SELECT ON BF_component_beamline TO ispyb_ro_nopii;
GRANT SELECT ON BF_fault TO ispyb_ro_nopii;
GRANT SELECT ON BF_subcomponent TO ispyb_ro_nopii;
GRANT SELECT ON BF_subcomponent_beamline TO ispyb_ro_nopii;
GRANT SELECT ON BF_system TO ispyb_ro_nopii;
GRANT SELECT ON BF_system_beamline TO ispyb_ro_nopii;
GRANT SELECT ON BLSample TO ispyb_ro_nopii;
GRANT SELECT ON BLSampleGroup TO ispyb_ro_nopii;
GRANT SELECT ON BLSampleGroup_has_BLSample TO ispyb_ro_nopii;
GRANT SELECT ON BLSampleImage TO ispyb_ro_nopii;
GRANT SELECT ON BLSampleImageAnalysis TO ispyb_ro_nopii;
GRANT SELECT ON BLSampleImageAutoScoreClass TO ispyb_ro_nopii;
GRANT SELECT ON BLSampleImageAutoScoreSchema TO ispyb_ro_nopii;
GRANT SELECT ON BLSampleImageScore TO ispyb_ro_nopii;
GRANT SELECT ON BLSampleImage_has_AutoScoreClass TO ispyb_ro_nopii;
GRANT SELECT ON BLSampleType TO ispyb_ro_nopii;
GRANT SELECT ON BLSampleType_has_Component TO ispyb_ro_nopii;
GRANT SELECT ON BLSample_has_DataCollectionPlan TO ispyb_ro_nopii;
GRANT SELECT ON BLSample_has_EnergyScan TO ispyb_ro_nopii;
GRANT SELECT ON BLSession TO ispyb_ro_nopii;
GRANT SELECT ON BLSession_has_SCPosition TO ispyb_ro_nopii;
GRANT SELECT ON BLSubSample TO ispyb_ro_nopii;
GRANT SELECT ON Buffer TO ispyb_ro_nopii;
GRANT SELECT ON BufferHasAdditive TO ispyb_ro_nopii;
GRANT SELECT ON CalendarHash TO ispyb_ro_nopii;
GRANT SELECT ON ComponentLattice TO ispyb_ro_nopii;
GRANT SELECT ON ComponentSubType TO ispyb_ro_nopii;
GRANT SELECT ON ComponentType TO ispyb_ro_nopii;
GRANT SELECT ON Component_has_SubType TO ispyb_ro_nopii;
GRANT SELECT ON ConcentrationType TO ispyb_ro_nopii;
GRANT SELECT ON Container TO ispyb_ro_nopii;
GRANT SELECT ON ContainerType TO ispyb_ro_nopii;
GRANT SELECT ON ContainerHistory TO ispyb_ro_nopii;
GRANT SELECT ON ContainerInspection TO ispyb_ro_nopii;
GRANT SELECT ON ContainerQueue TO ispyb_ro_nopii;
GRANT SELECT ON ContainerQueueSample TO ispyb_ro_nopii;
GRANT SELECT ON ContainerRegistry TO ispyb_ro_nopii;
GRANT SELECT ON ContainerRegistry_has_Proposal TO ispyb_ro_nopii;
GRANT SELECT ON ContainerReport TO ispyb_ro_nopii;
GRANT SELECT ON CourierTermsAccepted TO ispyb_ro_nopii;
GRANT SELECT ON Crystal TO ispyb_ro_nopii;
GRANT SELECT ON Crystal_has_UUID TO ispyb_ro_nopii;
GRANT SELECT ON CTF TO ispyb_ro_nopii;
GRANT SELECT ON DataAcquisition TO ispyb_ro_nopii;
GRANT SELECT ON DataCollection TO ispyb_ro_nopii;
GRANT SELECT ON DataCollectionComment TO ispyb_ro_nopii;
GRANT SELECT ON DataCollectionFileAttachment TO ispyb_ro_nopii;
GRANT SELECT ON DataCollectionGroup TO ispyb_ro_nopii;
GRANT SELECT ON DataCollectionPlan_has_Detector TO ispyb_ro_nopii;
GRANT SELECT ON DataReductionStatus TO ispyb_ro_nopii;
GRANT SELECT ON Detector TO ispyb_ro_nopii;
GRANT SELECT ON Dewar TO ispyb_ro_nopii;
GRANT SELECT ON DewarLocation TO ispyb_ro_nopii;
GRANT SELECT ON DewarLocationList TO ispyb_ro_nopii;
GRANT SELECT ON DewarRegistry TO ispyb_ro_nopii;
GRANT SELECT ON DewarRegistry_has_Proposal TO ispyb_ro_nopii;
GRANT SELECT ON DewarReport TO ispyb_ro_nopii;
GRANT SELECT ON DewarTransportHistory TO ispyb_ro_nopii;
GRANT SELECT ON DiffractionPlan TO ispyb_ro_nopii;
GRANT SELECT ON EMMicroscope TO ispyb_ro_nopii;
GRANT SELECT ON EnergyScan TO ispyb_ro_nopii;
GRANT SELECT ON Experiment TO ispyb_ro_nopii;
GRANT SELECT ON ExperimentKindDetails TO ispyb_ro_nopii;
GRANT SELECT ON ExperimentType TO ispyb_ro_nopii;
GRANT SELECT ON Frame TO ispyb_ro_nopii;
GRANT SELECT ON FrameList TO ispyb_ro_nopii;
GRANT SELECT ON FrameSet TO ispyb_ro_nopii;
GRANT SELECT ON FrameToList TO ispyb_ro_nopii;
GRANT SELECT ON GeometryClassname TO ispyb_ro_nopii;
GRANT SELECT ON GridImageMap TO ispyb_ro_nopii;
GRANT SELECT ON GridInfo TO ispyb_ro_nopii;
GRANT SELECT ON Image TO ispyb_ro_nopii;
GRANT SELECT ON ImageQualityIndicators TO ispyb_ro_nopii;
GRANT SELECT ON Imager TO ispyb_ro_nopii;
GRANT SELECT ON InspectionType TO ispyb_ro_nopii;
GRANT SELECT ON Instruction TO ispyb_ro_nopii;
GRANT SELECT ON InstructionSet TO ispyb_ro_nopii;
GRANT SELECT ON IspybCrystalClass TO ispyb_ro_nopii;
GRANT SELECT ON IspybReference TO ispyb_ro_nopii;
GRANT SELECT ON Laboratory TO ispyb_ro_nopii;
GRANT SELECT ON Macromolecule TO ispyb_ro_nopii;
GRANT SELECT ON MacromoleculeRegion TO ispyb_ro_nopii;
GRANT SELECT ON Measurement TO ispyb_ro_nopii;
GRANT SELECT ON MeasurementToDataCollection TO ispyb_ro_nopii;
GRANT SELECT ON MeasurementUnit TO ispyb_ro_nopii;
GRANT SELECT ON Merge TO ispyb_ro_nopii;
GRANT SELECT ON Model TO ispyb_ro_nopii;
GRANT SELECT ON ModelBuilding TO ispyb_ro_nopii;
GRANT SELECT ON ModelList TO ispyb_ro_nopii;
GRANT SELECT ON ModelToList TO ispyb_ro_nopii;
GRANT SELECT ON MotionCorrection TO ispyb_ro_nopii;
GRANT SELECT ON MotionCorrectionDrift TO ispyb_ro_nopii;
GRANT SELECT ON MotorPosition TO ispyb_ro_nopii;
GRANT SELECT ON Movie TO ispyb_ro_nopii;
GRANT SELECT ON MXMRRun TO ispyb_ro_nopii;
GRANT SELECT ON MXMRRunBlob TO ispyb_ro_nopii;
GRANT SELECT ON Particle TO ispyb_ro_nopii;
GRANT SELECT ON PDB TO ispyb_ro_nopii;
GRANT SELECT ON PDBEntry TO ispyb_ro_nopii;
GRANT SELECT ON PDBEntry_has_AutoProcProgram TO ispyb_ro_nopii;
GRANT SELECT ON Permission TO ispyb_ro_nopii;
GRANT SELECT ON Phasing TO ispyb_ro_nopii;
GRANT SELECT ON PhasingAnalysis TO ispyb_ro_nopii;
GRANT SELECT ON PhasingProgramAttachment TO ispyb_ro_nopii;
GRANT SELECT ON PhasingProgramRun TO ispyb_ro_nopii;
GRANT SELECT ON PhasingStatistics TO ispyb_ro_nopii;
GRANT SELECT ON PhasingStep TO ispyb_ro_nopii;
GRANT SELECT ON Phasing_has_Scaling TO ispyb_ro_nopii;
GRANT SELECT ON PlateGroup TO ispyb_ro_nopii;
GRANT SELECT ON PlateType TO ispyb_ro_nopii;
GRANT SELECT ON Position TO ispyb_ro_nopii;
GRANT SELECT ON PreparePhasingData TO ispyb_ro_nopii;
GRANT SELECT ON ProcessingJob TO ispyb_ro_nopii;
GRANT SELECT ON ProcessingJobImageSweep TO ispyb_ro_nopii;
GRANT SELECT ON ProcessingJobParameter TO ispyb_ro_nopii;
GRANT SELECT ON ProcessingPipeline TO ispyb_ro_nopii;
GRANT SELECT ON ProcessingPipelineCategory TO ispyb_ro_nopii;
GRANT SELECT ON Project TO ispyb_ro_nopii;
GRANT SELECT ON Project_has_BLSample TO ispyb_ro_nopii;
GRANT SELECT ON Project_has_DCGroup TO ispyb_ro_nopii;
GRANT SELECT ON Project_has_EnergyScan TO ispyb_ro_nopii;
GRANT SELECT ON Project_has_Person TO ispyb_ro_nopii;
GRANT SELECT ON Project_has_Protein TO ispyb_ro_nopii;
GRANT SELECT ON Project_has_Session TO ispyb_ro_nopii;
GRANT SELECT ON Project_has_Shipping TO ispyb_ro_nopii;
GRANT SELECT ON Project_has_User TO ispyb_ro_nopii;
GRANT SELECT ON Project_has_XFEFSpectrum TO ispyb_ro_nopii;
GRANT SELECT ON Proposal TO ispyb_ro_nopii;
GRANT SELECT ON ProposalHasPerson TO ispyb_ro_nopii;
GRANT SELECT ON Protein TO ispyb_ro_nopii;
GRANT SELECT ON Protein_has_PDB TO ispyb_ro_nopii;
GRANT SELECT ON PurificationColumn TO ispyb_ro_nopii;
GRANT SELECT ON RobotAction TO ispyb_ro_nopii;
GRANT SELECT ON Run TO ispyb_ro_nopii;
GRANT SELECT ON SafetyLevel TO ispyb_ro_nopii;
GRANT SELECT ON SamplePlate TO ispyb_ro_nopii;
GRANT SELECT ON SamplePlatePosition TO ispyb_ro_nopii;
GRANT SELECT ON SaxsDataCollection TO ispyb_ro_nopii;
GRANT SELECT ON ScanParametersModel TO ispyb_ro_nopii;
GRANT SELECT ON ScanParametersService TO ispyb_ro_nopii;
GRANT SELECT ON Schedule TO ispyb_ro_nopii;
GRANT SELECT ON ScheduleComponent TO ispyb_ro_nopii;
GRANT SELECT ON SchemaStatus TO ispyb_ro_nopii;
GRANT SELECT ON Screen TO ispyb_ro_nopii;
GRANT SELECT ON ScreenComponent TO ispyb_ro_nopii;
GRANT SELECT ON ScreenComponentGroup TO ispyb_ro_nopii;
GRANT SELECT ON Screening TO ispyb_ro_nopii;
GRANT SELECT ON ScreeningInput TO ispyb_ro_nopii;
GRANT SELECT ON ScreeningOutput TO ispyb_ro_nopii;
GRANT SELECT ON ScreeningOutputLattice TO ispyb_ro_nopii;
GRANT SELECT ON ScreeningRank TO ispyb_ro_nopii;
GRANT SELECT ON ScreeningRankSet TO ispyb_ro_nopii;
GRANT SELECT ON ScreeningStrategy TO ispyb_ro_nopii;
GRANT SELECT ON ScreeningStrategySubWedge TO ispyb_ro_nopii;
GRANT SELECT ON ScreeningStrategyWedge TO ispyb_ro_nopii;
GRANT SELECT ON SessionType TO ispyb_ro_nopii;
GRANT SELECT ON Session_has_Person TO ispyb_ro_nopii;
GRANT SELECT ON Shipping TO ispyb_ro_nopii;
GRANT SELECT ON ShippingHasSession TO ispyb_ro_nopii;
GRANT SELECT ON Sleeve TO ispyb_ro_nopii;
GRANT SELECT ON SpaceGroup TO ispyb_ro_nopii;
GRANT SELECT ON Specimen TO ispyb_ro_nopii;
GRANT SELECT ON StockSolution TO ispyb_ro_nopii;
GRANT SELECT ON Stoichiometry TO ispyb_ro_nopii;
GRANT SELECT ON Structure TO ispyb_ro_nopii;
GRANT SELECT ON SubstructureDetermination TO ispyb_ro_nopii;
GRANT SELECT ON Subtraction TO ispyb_ro_nopii;
GRANT SELECT ON SubtractionToAbInitioModel TO ispyb_ro_nopii;
GRANT SELECT ON UserGroup TO ispyb_ro_nopii;
GRANT SELECT ON UserGroup_has_Permission TO ispyb_ro_nopii;
GRANT SELECT ON UserGroup_has_Person TO ispyb_ro_nopii;
GRANT SELECT ON v_run TO ispyb_ro_nopii;
GRANT SELECT ON Workflow TO ispyb_ro_nopii;
GRANT SELECT ON WorkflowMesh TO ispyb_ro_nopii;
GRANT SELECT ON WorkflowStep TO ispyb_ro_nopii;
GRANT SELECT ON WorkflowType TO ispyb_ro_nopii;
GRANT SELECT ON XFEFluorescenceComposite TO ispyb_ro_nopii;
GRANT SELECT ON XFEFluorescenceSpectrum TO ispyb_ro_nopii;
GRANT SELECT ON XrayCentring TO ispyb_ro_nopii;
GRANT SELECT ON XrayCentringResult TO ispyb_ro_nopii;
GRANT SELECT ON XRFFluorescenceMapping TO ispyb_ro_nopii;
GRANT SELECT ON XRFFluorescenceMappingROI TO ispyb_ro_nopii;
GRANT SELECT ON ParticleClassificationGroup TO ispyb_ro_nopii;
GRANT SELECT ON ParticleClassification TO ispyb_ro_nopii;
GRANT SELECT ON ParticlePicker TO ispyb_ro_nopii;
GRANT SELECT ON CryoemInitialModel TO ispyb_ro_nopii;
GRANT SELECT ON ParticleClassification_has_CryoemInitialModel TO ispyb_ro_nopii;
GRANT SELECT ON RelativeIceThickness TO ispyb_ro_nopii;
GRANT SELECT ON Tomogram TO ispyb_ro_nopii;
GRANT SELECT ON TiltImageAlignment TO ispyb_ro_nopii;
GRANT SELECT ON SSXDataCollection TO ispyb_ro_nopii;
GRANT SELECT ON Component TO ispyb_ro_nopii;
GRANT SELECT ON SampleComposition TO ispyb_ro_nopii;
GRANT SELECT ON CrystalComposition TO ispyb_ro_nopii;
GRANT SELECT ON EventChain TO ispyb_ro_nopii;
GRANT SELECT ON EventType TO ispyb_ro_nopii;
GRANT SELECT ON Event TO ispyb_ro_nopii;
