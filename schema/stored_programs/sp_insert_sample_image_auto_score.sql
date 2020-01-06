DELIMITER ;;
CREATE OR REPLACE PROCEDURE `insert_sample_image_auto_score`(
     OUT p_id int(11) unsigned,
     p_imageFullPath varchar(255),
     p_schemaName varchar(25),
     p_scoreClass varchar(15),
     p_probability float
)
MODIFIES SQL DATA
COMMENT 'Insert a row with the auto scored probability for a given sample image using a certain class and schema. Returns the ID in p_id.'
BEGIN
    DECLARE l_blSampleImageId int(11) unsigned;
    DECLARE l_blSampleImageAutoScoreClassId tinyint(3) unsigned;

	  IF p_imageFullPath IS NOT NULL AND p_schemaName IS NOT NULL AND p_scoreClass IS NOT NULL THEN

        SELECT max(blSampleImageId) INTO l_blSampleImageId FROM BLSampleImage WHERE imageFullPath = p_imageFullPath;

        SELECT blSampleImageAutoScoreClassId INTO l_blSampleImageAutoScoreClassId FROM BLSampleImageAutoScoreClass bsiasc INNER JOIN BLSampleImageAutoScoreSchema bsiass USING(blSampleImageAutoScoreSchemaId)
        WHERE bsiasc.scoreClass = p_scoreClass AND bsiass.schemaName = p_schemaName AND bsiass.enabled > 0;

        INSERT INTO BLSampleImage_has_AutoScoreClass (blSampleImageId, blSampleImageAutoScoreClassId, probability)
          VALUES (l_blSampleImageId, l_blSampleImageAutoScoreClassId, p_probability);

        SET p_id = LAST_INSERT_ID();

	  END IF;
END;;
DELIMITER ;
