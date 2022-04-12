INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2022_04_12_BLSession_fk_beamCalendarId_set_null.sql', 'ONGOING');

ALTER TABLE BLSession
  DROP CONSTRAINT IF EXISTS BLSession_ibfk_3,
  DROP INDEX IF EXISTS BLSession_ibfk_3,
  ADD CONSTRAINT FOREIGN KEY IF NOT EXISTS BLSession_fk_beamCalendarId (beamCalendarId) REFERENCES BeamCalendar (beamCalendarId) ON DELETE SET NULL ON UPDATE CASCADE;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2022_04_12_BLSession_fk_beamCalendarId_set_null.sql';
