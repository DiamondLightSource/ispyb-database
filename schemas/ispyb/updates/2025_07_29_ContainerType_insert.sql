INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2025_07_29_ContainerType_insert.sql', 'ONGOING');

INSERT
	INTO
	ContainerType (containerTypeId,
	name,
	capacity,
	wellPerRow,
	dropPerWellX,
	dropPerWellY,
	dropHeight,
	dropWidth,
	dropOffsetX,
	dropOffsetY,
	wellDrop,
	proposalType,
	active)
VALUES
    (39,
'SWISSCI 2 Drop',
192,
12,
1,
2,
1,
1,
0,
0,
1,
'mx',
1);

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2025_07_29_ContainerType_insert.sql';
