-- Use a curson to hold the result set from a complex SELECT query to get the
-- blSampleIds of rows that duplicate the combination of (containerId, location, subLocation).
-- Then get the rows one by one and run an UPDATE statement against each row in
-- an effort to make the combination of (containerId, location, subLocation) unique.

DELIMITER //

BEGIN NOT ATOMIC

  DECLARE done INT DEFAULT FALSE;
  DECLARE ids, jpath TEXT;
  DECLARE i, id INT;
  DECLARE cur CURSOR FOR
    SELECT q.blSampleIds
    FROM (
        SELECT containerId, location, subLocation, count(*) cnt, JSON_ARRAYAGG(blSampleId) blSampleIds
        FROM BLSample
        WHERE location IS NOT NULL
        GROUP BY containerId, location, subLocation
        HAVING cnt > 1
        ORDER BY containerId, location, subLocation
    ) q;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur;

  read_loop: LOOP
    FETCH cur INTO ids;
    IF done THEN
      LEAVE read_loop;
    END IF;

    FOR i IN 0..JSON_LENGTH(ids)-1
    DO

      SET jpath := CONCAT('$[', i, ']');
      SET id := CAST(JSON_EXTRACT(ids, jpath) AS INT);

      UPDATE BLSample SET subLocation = i+1 WHERE blSampleId = id; -- AND subLocation IS NULL;

    END FOR;

  END LOOP;

  CLOSE cur;
END; //

DELIMITER ;
