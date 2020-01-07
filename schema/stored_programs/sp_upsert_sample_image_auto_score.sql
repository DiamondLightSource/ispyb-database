DELIMITER ;;
CREATE OR REPLACE PROCEDURE `upsert_sample_image_auto_score`(
     p_imageFullPath varchar(255),
     p_schemaName varchar(25),
     p_scoreClass varchar(15),
     p_probability float
)
MODIFIES SQL DATA
COMMENT 'Insert or update a row with the auto scored probability for a given sample image with a certain class and schema. Returns nothing.'
BEGIN
    DECLARE l_blSampleImageId int(11) unsigned;
    DECLARE l_blSampleImageAutoScoreClassId tinyint(3) unsigned;

	  IF p_imageFullPath IS NOT NULL AND p_schemaName IS NOT NULL AND p_scoreClass IS NOT NULL THEN

        SELECT max(blSampleImageId) INTO l_blSampleImageId FROM BLSampleImage WHERE imageFullPath = p_imageFullPath;

        SELECT blSampleImageAutoScoreClassId INTO l_blSampleImageAutoScoreClassId FROM BLSampleImageAutoScoreClass bsiasc INNER JOIN BLSampleImageAutoScoreSchema bsiass USING(blSampleImageAutoScoreSchemaId)
        WHERE bsiasc.scoreClass = p_scoreClass AND bsiass.schemaName = p_schemaName AND bsiass.enabled > 0;

        INSERT INTO BLSampleImage_has_AutoScoreClass (blSampleImageId, blSampleImageAutoScoreClassId, probability)
          VALUES (l_blSampleImageId, l_blSampleImageAutoScoreClassId, p_probability) ON DUPLICATE KEY UPDATE
              blSampleImageId = IFNULL(l_blSampleImageId, blSampleImageId),
              blSampleImageAutoScoreClassId = IFNULL(l_blSampleImageAutoScoreClassId, blSampleImageAutoScoreClassId),
              probability = IFNULL(p_probability, probability);
    ELSE
        SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Arguments p_imageFullPath, p_schemaName and p_scoreClass cannot be NULL';
	  END IF;
END;;
DELIMITER ;
