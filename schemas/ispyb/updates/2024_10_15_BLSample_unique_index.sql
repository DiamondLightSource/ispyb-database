-- This update might require some clean-up of the BLSample table in advance to
-- remove rows that would violate the unique index being created here. Some
-- example statements that might help:
--
-- UPDATE BLSample SET location = NULL WHERE location = '';
-- UPDATE BLSample SET location = NULL WHERE location = 'null';
-- UPDATE BLSample SET location = CAST(location AS INT) WHERE location LIKE '0%';
--
-- Note that in SQL, NULL != NULL, so therefore you will not violate a unique
-- index if you have multiple rows where a field used in the index is NULL.

INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2024_10_15_BLSample_unique_index.sql', 'ONGOING');

CREATE UNIQUE INDEX IF NOT EXISTS BLSample_uidx_containerId_location_subLocation ON BLSample(containerId, location, subLocation);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2024_10_15_BLSample_unique_index.sql';
