-- Example call:
-- select upsert_image(NULL,  );
-- NOT tested

DELIMITER $$
CREATE OR REPLACE FUNCTION `upsert_image` (
     p_Id int(11) unsigned,
     p_parentId int(11) unsigned,
     p_imageNumber int(10) unsigned, 
     p_filename varchar(255),
     p_fileLocation varchar(255),
     p_measuredIntensity float,
     p_jpegFileFullPath varchar(255),
     p_jpegThumbnailFileFullPath varchar(255),
     p_temperature float,
     p_cumulativeIntensity float,
     p_synchrotronCurrent float,
     p_comments varchar(1024),
     p_machineMessage varchar(1024) 
)
     RETURNS int
     MODIFIES SQL DATA
  BEGIN
    INSERT INTO Image (imageId, datacollectionId, imageNumber, filename, fileLocation, measuredIntensity, jpegFileFullPath, jpegThumbnailFileFullPath, temperature, cumulativeIntensity, 
      synchrotronCurrent, comments, machineMessage)
      VALUES (p_Id, p_parentId, p_imageNumber, p_filename, p_fileLocation, p_measuredIntensity, p_jpegFileFullPath, p_jpegThumbnailFileFullPath, p_temperature, p_cumulativeIntensity, 
      p_synchrotronCurrent, p_comments, p_machineMessage)
	  ON DUPLICATE KEY UPDATE
		datacollectionId = IFNULL(p_parentId, datacollectionId),
        imageNumber = IFNULL(p_imageNumber, imageNumber), 
        filename = IFNULL(p_filename, filename), 
        fileLocation = IFNULL(p_fileLocation, fileLocation), 
        measuredIntensity = IFNULL(p_measuredIntensity, measuredIntensity), 
        jpegFileFullPath = IFNULL(p_jpegFileFullPath, jpegFileFullPath), 
        jpegThumbnailFileFullPath = IFNULL(p_jpegThumbnailFileFullPath, jpegThumbnailFileFullPath), 
        temperature = IFNULL(p_temperature, temperature), 
        cumulativeIntensity = IFNULL(p_cumulativeIntensity, cumulativeIntensity), 
        synchrotronCurrent = IFNULL(p_synchrotronCurrent, synchrotronCurrent), 
        comments = IFNULL(p_comments, comments), 
        machineMessage = IFNULL(p_machineMessage, machineMessage);

	IF p_id IS NULL THEN 
		RETURN LAST_INSERT_ID();
    ELSE 
		RETURN p_id;
    END IF;
  END$$
DELIMITER ;
