INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2023_04_04_XrayCentring.sql', 'ONGOING');

CREATE TABLE `XrayCentring`(
    `xrayCentringId` int(11) unsigned PRIMARY KEY AUTO_INCREMENT,
    `dataCollectionGroupId` int(11) NOT NULL COMMENT 'references DataCollectionGroup table',
    `status` enum ('success', 'failed', 'pending'),
    `xrayCentringType` enum ('2d', '3d'),
    FOREIGN KEY (`dataCollectionGroupId`) REFERENCES `DataCollectionGroup`(`dataCollectionGroupId`) ON DELETE CASCADE ON UPDATE CASCADE
) DEFAULT CHARSET = utf8mb4 COMMENT = 'Xray Centring analysis associated with one or more grid scans.';

DROP TABLE IF EXISTS `XrayCentringResult`;

CREATE TABLE `XrayCentringResult`(
    `xrayCentringResultId` int(11) unsigned PRIMARY KEY AUTO_INCREMENT,
    `xrayCentringId` int(11) unsigned NOT NULL COMMENT 'references XrayCentring table',
    `centreOfMassX` float DEFAULT NULL COMMENT 'x-coordinate corresponding to the centre of mass of the crystal (in voxels)',
    `centreOfMassY` float DEFAULT NULL COMMENT 'y-coordinate corresponding to the centre of mass of the crystal (in voxels)',
    `centreOfMassZ` float DEFAULT NULL COMMENT 'z-coordinate corresponding to the centre of mass of the crystal (in voxels)',
    `maxVoxelX` int DEFAULT NULL COMMENT 'x-coordinate of the voxel with the maximum value within this crystal volume',
    `maxVoxelY` int DEFAULT NULL COMMENT 'y-coordinate of the voxel with the maximum value within this crystal volume',
    `maxVoxelZ` int DEFAULT NULL COMMENT 'z-coordinate of the voxel with the maximum value within this crystal volume',
    `numberOfVoxels` int DEFAULT NULL COMMENT 'Number of voxels within the specified bounding box',
    `totalCount` float DEFAULT NULL COMMENT 'The sum of the values of all the voxels within the specified bounding box',
    `boundingBoxMinX` float DEFAULT NULL COMMENT 'Minimum x-coordinate of the bounding box containing the crystal (in voxels)',
    `boundingBoxMaxX` float DEFAULT NULL COMMENT 'Maximum x-coordinate of the bounding box containing the crystal (in voxels)',
    `boundingBoxMinY` float DEFAULT NULL COMMENT 'Minimum y-coordinate of the bounding box containing the crystal (in voxels)',
    `boundingBoxMaxY` float DEFAULT NULL COMMENT 'Maximum y-coordinate of the bounding box containing the crystal (in voxels)',
    `boundingBoxMinZ` float DEFAULT NULL COMMENT 'Minimum z-coordinate of the bounding box containing the crystal (in voxels)',
    `boundingBoxMaxZ` float DEFAULT NULL COMMENT 'Maximum z-coordinate of the bounding box containing the crystal (in voxels)',
    FOREIGN KEY (`xrayCentringId`) REFERENCES `XrayCentring`(`xrayCentringId`) ON DELETE CASCADE ON UPDATE CASCADE
) DEFAULT CHARSET = utf8mb4 COMMENT = 'Xray Centring result.';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2023_04_04_XrayCentring.sql';
