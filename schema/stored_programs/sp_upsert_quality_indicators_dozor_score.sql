DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE upsert_quality_indicators_dozor_score (
  OUT p_id int(11) unsigned,
  p_dataCollectionId int(11) unsigned,
  p_imageNumber mediumint(8) unsigned,
  p_dozorScore double
)
    MODIFIES SQL DATA
    COMMENT 'Inserts into or updates a row in the image quality indicators table'
BEGIN
  DECLARE row_DataCollectionId int(11) unsigned DEFAULT NULL;
  DECLARE row_imageNumber mediumint(8) unsigned DEFAULT NULL;
  
  SELECT dataCollectionId, imageNumber INTO row_DataCollectionId, row_imageNumber FROM ImageQualityIndicators WHERE dataCollectionId = p_dataCollectionId AND imageNumber = p_imageNumber;

  IF dataCollectionId IS NULL THEN
        INSERT INTO ImageQualityIndicators (dataCollectionId, imageNumber, dozor_score)
          VALUES (p_dataCollectionId, p_imageNumber, p_dozorScore);
        SET p_id = 1;
  ELSE
        UPDATE ImageQualityIndicators
          SET dozor_score = p_dozorScore
        WHERE dataCollectionId = p_dataCollectionId AND imageNumber = p_imageNumber;
        SET p_id = 1;
  END IF;
END;;
DELIMITER ;


