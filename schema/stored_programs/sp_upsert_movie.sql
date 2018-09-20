DELIMITER ;;
CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE `upsert_movie`(
  INOUT p_movieId int(11) unsigned,
  p_dataCollectionId int(11) unsigned,
  p_movieNumber mediumint unsigned,
  p_movieFullPath varchar(255),
  p_createdTimeStamp timestamp,
  p_positionX float,
  p_positionY float,
  p_nominalDefocus float unsigned
) 
    MODIFIES SQL DATA
BEGIN
    INSERT INTO Movie (movieId, dataCollectionId, movieNumber, movieFullPath, createdTimeStamp, positionX, positionY, nominalDefocus) 
      VALUES (p_movieId, p_dataCollectionId, p_movieNumber, p_movieFullPath, p_createdTimeStamp, p_positionX, p_positionY, p_nominalDefocus)
      ON DUPLICATE KEY UPDATE
        dataCollectionId = IFNULL(p_dataCollectionId, dataCollectionId),
        movieNumber = IFNULL(p_movieNumber, movieNumber),
        movieFullPath = IFNULL(p_movieFullPath, movieFullPath),
        createdTimeStamp = IFNULL(p_createdTimeStamp, createdTimeStamp),
        positionX = IFNULL(p_positionX, positionX),
        positionY = IFNULL(p_positionY, positionY),
        nominalDefocus = IFNULL(p_nominalDefocus, nominalDefocus);

	IF p_movieId IS NULL THEN
	    SET p_movieId = LAST_INSERT_ID();
	END IF;
END ;;
DELIMITER ;
