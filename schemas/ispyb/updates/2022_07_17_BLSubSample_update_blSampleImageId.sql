INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2022_07_17_BLSubSample_update_blSampleImageId.sql', 'ONGOING');

UPDATE BLSubSample ss
SET ss.blSampleImageId = (
    SELECT max(si.blSampleImageId)
    FROM BLSampleImage si
    WHERE si.blSampleId = ss.blSampleId AND
        si.blTimeStamp < ss.recordTimeStamp
)
WHERE ss.blSampleImageId IS NULL;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2022_07_17_BLSubSample_update_blSampleImageId.sql';
