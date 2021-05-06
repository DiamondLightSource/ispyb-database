DELIMITER ;;
CREATE OR REPLACE DEFINER= `ispyb_root`@`%` PROCEDURE `retrieve_screenings_for_sample`(p_id int unsigned)
COMMENT 'Returns multi-row result set with the screening for the given sampleId'
BEGIN
	IF p_id IS NOT NULL THEN
		SELECT DISTINCT
		  scr.screeningId "screeningId",
		  scr.dataCollectionId "dataCollectionId",
		  scr.bltimeStamp "bltimeStamp",
		  scr.programVersion "programVersion",
		  scr.comments "comments",
		  scr.shortComments "shortComments",
		  scr.diffractionPlanId "diffractionPlanId",
		  scr.dataCollectionGroupId "dataCollectionGroupId",
		  scr.xmlSampleInformation "xmlSampleInformation"
		FROM BLSample bls
		  INNER JOIN DataCollection dc ON bls.blSubSampleId = dc.BLSAMPLEID
		  INNER JOIN Screening scr ON dc.dataCollectionId = scr.dataCollectionId
		WHERE bls.blSampleId = p_id;
	ELSE
		SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644,
		  MESSAGE_TEXT='Mandatory arguments p_id can not be NULL';
	END IF;
END;;
DELIMITER ;
