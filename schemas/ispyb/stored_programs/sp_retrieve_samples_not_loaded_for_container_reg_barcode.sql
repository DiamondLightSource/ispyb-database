DELIMITER ;;

CREATE OR REPLACE PROCEDURE retrieve_samples_not_loaded_for_container_reg_barcode(p_barcode varchar(20))
BEGIN
  IF NOT (p_barcode IS NULL) THEN

    WITH most_recent_container AS (
      SELECT max(c.containerId) as containerId
      FROM Container c
        INNER JOIN ContainerRegistry cr USING(containerRegistryId)
      WHERE cr.barcode=p_barcode
    )
    SELECT bls.blSampleId "sampleId",
      bls.containerId "containerId",
      bls.name "sampleName",
      bls.code "sampleCode",
      bls.comments "sampleComments",
      bls.location "sampleLocation",
      max(ra.robotActionId) as rId
    FROM BLSample bls
      INNER JOIN most_recent_container mrc ON bls.containerId = mrc.containerId
      LEFT OUTER JOIN RobotAction ra ON bls.blSampleId = ra.blSampleId
    GROUP BY bls.blSampleId,
      bls.containerId,
      bls.name,
      bls.code,
      bls.comments,
      bls.location
    HAVING rId IS NULL
    ORDER BY bls.blSampleId;
  ELSE
    SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO=1644, MESSAGE_TEXT='Mandatory argument is NULL: p_barcode';
  END IF;

END;;

DELIMITER ;
