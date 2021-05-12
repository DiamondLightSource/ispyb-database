DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `insert_dc_plan`(
	OUT p_id int(11) unsigned,
	p_name varchar(20),
	p_experimentKind enum('Default','MXPressE','MXPressO','MXPressE_SAD','MXScore','MXPressM','MAD','SAD','Fixed','Ligand binding','Refinement','OSC','MAD - Inverse Beam','SAD - Inverse Beam','MESH','XFE','Stepped transmission','XChem High Symmetry','XChem Low Symmetry','Commissioning'),
	p_observedResolution float,
	p_minimalResolution float,
	p_exposuretime float,
	p_oscillationRange float,
	p_maximalResolution float,
	p_screeningResolution float,
	p_radiationSensitivity float,
	p_anomalousScatterer varchar(255),
	p_preferredBeamSizeX float,
	p_preferredBeamSizeY float,
	p_preferredBeamDiameter float,
	p_comments varchar(1024),
	p_DIFFRACTIONPLANUUID varchar(1000),
	p_aimedCompleteness double,
	p_aimedIOverSigmaAtHighestRes double,
	p_aimedMultiplicity double,
	p_aimedResolution double,
	p_anomalousData tinyint(1),
	p_complexity varchar(45),
	p_estimateRadiationDamage tinyint(1),
	p_forcedSpaceGroup varchar(45),
	p_requiredCompleteness double,
	p_requiredMultiplicity double,
	p_requiredResolution double,
	p_strategyOption varchar(200),
	p_kappaStrategyOption varchar(45),
	p_numberOfPositions int(11),
	p_minDimAccrossSpindleAxis double,
	p_maxDimAccrossSpindleAxis double,
	p_radiationSensitivityBeta double,
	p_radiationSensitivityGamma double,
	p_minOscWidth float,
	p_recordTimeStamp timestamp,
	p_monochromator varchar(8),
	p_energy float,
	p_transmission float,
	p_boxSizeX float,
	p_boxSizeY float,
	p_kappaStart float,
	p_axisStart float,
	p_axisRange float,
	p_numberOfImages mediumint(9),
	p_presetForProposalId int(10) unsigned,
	p_beamLineName varchar(45),
	p_detectorId int(11),
	p_distance double,
	p_orientation double,
	p_monoBandwidth double,
	p_centringMethod enum('xray','loop','diffraction','optical'),
	p_userPath varchar(100),
	p_robotPlateTemperature float,
	p_exposureTemperature float,
	p_experimentTypeId int(10) unsigned,
	p_purificationColumnId int(10) unsigned,
	p_collectionMode enum('auto', 'manual'),
	p_priority int(4))
MODIFIES SQL DATA
COMMENT 'Inserts a row into the DiffractionPlan table.\nReturns Record ID in p_id.'
BEGIN

	INSERT INTO DiffractionPlan
		(name, experimentKind, observedResolution, minimalResolution, exposureTime,
		oscillationRange, maximalResolution, screeningResolution, radiationSensitivity,
		anomalousScatterer, preferredBeamSizeX, preferredBeamSizeY, preferredBeamDiameter,
		comments, DIFFRACTIONPLANUUID, aimedCompleteness, aimedIOverSigmaAtHighestRes,
		aimedMultiplicity, aimedResolution, anomalousData, complexity,
		estimateRadiationDamage, forcedSpaceGroup, requiredCompleteness,
		requiredMultiplicity, requiredResolution, strategyOption, kappaStrategyOption,
		numberOfPositions, minDimAccrossSpindleAxis, maxDimAccrossSpindleAxis,
		radiationSensitivityBeta, radiationSensitivityGamma, minOscWidth,
		recordTimeStamp, monochromator, energy, transmission, boxSizeX, boxSizeY,
		kappaStart, axisStart, axisRange, numberOfImages, presetForProposalId,
		beamLineName, detectorId, distance, orientation, monoBandwidth, centringMethod,
		userPath, robotPlateTemperature, exposureTemperature, experimentTypeId,
		purificationColumnId, collectionMode, priority)
	VALUES
	    (p_name, p_experimentKind, p_observedResolution, p_minimalResolution, p_exposureTime,
	    p_oscillationRange, p_maximalResolution, p_screeningResolution, p_radiationSensitivity,
	    p_anomalousScatterer, p_preferredBeamSizeX, p_preferredBeamSizeY, p_preferredBeamDiameter,
	    p_comments, p_DIFFRACTIONPLANUUID, p_aimedCompleteness, p_aimedIOverSigmaAtHighestRes,
	    p_aimedMultiplicity, p_aimedResolution, p_anomalousData, p_complexity,
	    p_estimateRadiationDamage, p_forcedSpaceGroup, p_requiredCompleteness,
	    p_requiredMultiplicity, p_requiredResolution, p_strategyOption, p_kappaStrategyOption,
	    p_numberOfPositions, p_minDimAccrossSpindleAxis, p_maxDimAccrossSpindleAxis,
	    p_radiationSensitivityBeta, p_radiationSensitivityGamma, p_minOscWidth,
	    p_recordTimeStamp, p_monochromator, p_energy, p_transmission, p_boxSizeX, p_boxSizeY,
	    p_kappaStart, p_axisStart, p_axisRange, p_numberOfImages, p_presetForProposalId,
	    p_beamLineName, p_detectorId, p_distance, p_orientation, p_monoBandwidth,
	    p_centringMethod, p_userPath, p_robotPlateTemperature, p_exposureTemperature,
	    p_experimentTypeId, p_purificationColumnId, p_collectionMode, p_priority);

	SET p_id = LAST_INSERT_ID();
END;;
DELIMITER ;
