INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2025_07_25_Container_parentContainerLocation.sql', 'ONGOING');

ALTER TABLE Container
  ADD parentContainerLocation int unsigned
    COMMENT 'Indicates where inside the parent container this container is located', ALGORITHM=INSTANT;

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2025_07_25_Container_parentContainerLocation.sql';
