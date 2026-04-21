INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2026_04_22_GridInfo_pixelsPerMicron.sql', 'ONGOING');

UPDATE GridInfo SET micronsPerPixelX = pixelsPerMicronX WHERE micronsPerPixelX IS NULL;
UPDATE GridInfo SET micronsPerPixelY = pixelsPerMicronY WHERE micronsPerPixelY IS NULL;

ALTER TABLE GridInfo
	DROP COLUMN pixelsPerMicronX,
	DROP COLUMN pixelsPerMicronY;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2026_04_22_GridInfo_pixelsPerMicron.sql';
