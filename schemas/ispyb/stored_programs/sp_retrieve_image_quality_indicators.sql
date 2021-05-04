DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `retrieve_image_quality_indicators`(p_dataCollectionId int unsigned,
p_imageNumber int unsigned)
READS SQL DATA
COMMENT 'Returns a single-row result set with the image quality indicators for a given data collection id and image number.'
BEGIN
	IF dataCollectionId IS NOT NULL THEN
		IF imageNumber IS NOT NULL THEN

			SELECT * FROM ImageQualityIndicators iqi
			WHERE iqi.dataCollectionId = p_dataCollectionId
			  AND iqi.imageNumber = p_imageNumber;

		ELSE
		  SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644,
		    MESSAGE_TEXT='Mandatory arguments imageNumber can not be NULL';
		END IF;

	ELSE
	  SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644,
	  MESSAGE_TEXT='Mandatory arguments dataCollectionId can not be NULL';
	END IF;
END;;
DELIMITER ;
