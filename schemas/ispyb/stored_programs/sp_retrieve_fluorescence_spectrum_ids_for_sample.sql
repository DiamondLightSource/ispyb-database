DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_fluorescence_spectrum_ids_for_sample`(p_id int unsigned)
READS SQL DATA
COMMENT 'Returns a multi-row result-set with the fluorescence spectrum ids for the given sample id.'
BEGIN
	IF p_id IS NOT NULL THEN

	SELECT DISTINCT
	  xfe.xfeFluorescenceSpectrumId
	FROM BLSample bls
	  INNER JOIN XFEFluorescenceSpectrum xfe ON bls.blSampleId = xfe.blSampleId
	WHERE bls.blSampleId = p_id;
	
	ELSE
	  SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644,
	    MESSAGE_TEXT='Mandatory argument p_id can not be NULL';
	END IF;
END;;
DELIMITER ;
