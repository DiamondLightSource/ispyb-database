DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_dc`(p_id int unsigned, p_authLogin varchar(45)) 
READS SQL DATA
COMMENT 'Returns a single-row result-set with the data collection for the given ID'
BEGIN
    IF p_id IS NOT NULL THEN

    	IF p_authLogin IS NOT NULL THEN
    	-- Authorise only if the person (p_authLogin) is a member of a session on the proposal.

				SELECT dc.dataCollectionId "id",
					dc.dataCollectionGroupId "groupId",
					dc.detectorId "detectorId",
					dc.blSubSampleId "blSubSampleId",
					dc.dataCollectionNumber "dcNumber",
					dc.startTime "startTime",
					dc.endTime "endTime",
					dc.runStatus "status",
					dc.numberOfImages "noImages",
					dc.startImageNumber "startImgNumber",
					dc.numberOfPasses "noPasses",
					dc.imageDirectory "imgDir",
					dc.imagePrefix "imgPrefix",
					dc.imageSuffix "imgSuffix",
					dc.imageContainerSubPath "imgContainerSubPath",
					dc.fileTemplate "fileTemplate",
					dc.xtalSnapshotFullPath1 "snapshot1",
					dc.xtalSnapshotFullPath2 "snapshot2",
					dc.xtalSnapshotFullPath3 "snapshot3",
					dc.xtalSnapshotFullPath4 "snapshot4",
					dc.comments "comments",
					dc.slitGapVertical "slitGapVertical",
					dc.slitGapHorizontal "slitGapHorizontal",
					dc.transmission "transmission",
					dc.exposureTime "exposureTime",
					dc.xBeam "xBeam",
					dc.yBeam "yBeam",
					dc.axisStart "axisStart",
					dc.axisEnd "axisEnd",
					dc.axisRange "axisRange",
					dc.overlap "overlap",
					dc.flux "flux",
					dc.flux_end "fluxEnd",
					dc.rotationAxis "rotationAxis",
					dc.phiStart "phiStart",
					dc.kappaStart "kappaStart",
					dc.omegaStart "omegaStart",
					dc.chiStart "chiStart",
					dc.wavelength "wavelength",
					dc.resolution "resolution",
					dc.resolutionAtCorner "resolutionAtCorner",
					dc.detectorDistance "detectorDistance",
					dc.detector2Theta "detector2Theta",
					dc.bestWilsonPlotPath "bestWilsonPlotPath",
					dc.beamSizeAtSampleX "beamSizeAtSampleX",
					dc.beamSizeAtSampleY "beamSizeAtSampleY",
					dc.focalSpotSizeAtSampleX "focalSpotSizeAtSampleX",
					dc.focalSpotSizeAtSampleY "focalSpotSizeAtSampleY",
					a.sizeX "apertureSizeX",
					dc.synchrotronMode "synchrotronMode",
					dc.undulatorGap1 "undulatorGap1",
					dc.undulatorGap2 "undulatorGap2",
					dc.undulatorGap3 "undulatorGap3"
				FROM DataCollection dc
					INNER JOIN DataCollectionGroup dcg ON dc.dataCollectionGroupId = dcg.dataCollectionGroupId
        	INNER JOIN BLSession bs ON dcg.sessionId = bs.sessionId 
        	INNER JOIN Session_has_Person shp ON bs.sessionId = shp.sessionId
        	INNER JOIN Person p ON p.personId = shp.personId
					LEFT OUTER JOIN Aperture a ON dc.apertureId = a.apertureId
	  		WHERE p.login = p_authLogin AND	dc.dataCollectionId = p_id;

    	ELSE 

				SELECT dc.dataCollectionGroupId "groupId",
					dc.detectorId "detectorId",
					dc.blSubSampleId "blSubSampleId",
					dc.dataCollectionNumber "dcNumber",
					dc.startTime "startTime",
					dc.endTime "endTime",
					dc.runStatus "status",
					dc.numberOfImages "noImages",
					dc.startImageNumber "startImgNumber",
					dc.numberOfPasses "noPasses",
					dc.imageDirectory "imgDir",
					dc.imagePrefix "imgPrefix",
					dc.imageSuffix "imgSuffix",
					dc.imageContainerSubPath "imgContainerSubPath",
					dc.fileTemplate "fileTemplate",
					dc.xtalSnapshotFullPath1 "snapshot1",
					dc.xtalSnapshotFullPath2 "snapshot2",
					dc.xtalSnapshotFullPath3 "snapshot3",
					dc.xtalSnapshotFullPath4 "snapshot4",
					dc.comments "comments",
					dc.slitGapVertical "slitGapVertical",
					dc.slitGapHorizontal "slitGapHorizontal",
					dc.transmission "transmission",
					dc.exposureTime "exposureTime",
					dc.xBeam "xBeam",
					dc.yBeam "yBeam",
					dc.axisStart "axisStart",
					dc.axisEnd "axisEnd",
					dc.axisRange "axisRange",
					dc.overlap "overlap",
					dc.flux "flux",
					dc.flux_end "fluxEnd",
					dc.rotationAxis "rotationAxis",
					dc.phiStart "phiStart",
					dc.kappaStart "kappaStart",
					dc.omegaStart "omegaStart",
					dc.chiStart "chiStart",
					dc.wavelength "wavelength",
					dc.resolution "resolution",
					dc.resolutionAtCorner "resolutionAtCorner",
					dc.detectorDistance "detectorDistance",
					dc.detector2Theta "detector2Theta",
					dc.bestWilsonPlotPath "bestWilsonPlotPath",
					dc.beamSizeAtSampleX "beamSizeAtSampleX",
					dc.beamSizeAtSampleY "beamSizeAtSampleY",
					dc.focalSpotSizeAtSampleX "focalSpotSizeAtSampleX",
					dc.focalSpotSizeAtSampleY "focalSpotSizeAtSampleY",
					a.sizeX "apertureSizeX",
					dc.synchrotronMode "synchrotronMode",
					dc.undulatorGap1 "undulatorGap1",
					dc.undulatorGap2 "undulatorGap2",
					dc.undulatorGap3 "undulatorGap3"
				FROM DataCollection dc
					LEFT OUTER JOIN Aperture a ON dc.apertureId = a.apertureId
				WHERE dc.dataCollectionId = p_id;

    	END IF;

    ELSE
	  SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory arguments p_id can not be NULL';
	END IF;
END;;
DELIMITER ;

