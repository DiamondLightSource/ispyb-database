-- This is a script to delete a given DataCollectionGroup (by
-- dataCollectionGroupId) and all associated rows in other tables except
-- DataCollection.
-- To delete DataCollections, run the DataCollection_delete.sql script first
-- before you run this.
-- Change the value of @dcgId and @sessionId to the values of
-- dataCollectionGroupId and sessionId you would like to delete.
-- Disclaimer:
-- This script is not extensively tested.
-- Run this at your own risk and beware of cascading deletes.

SET @dcgId := 1000;
SET @sessionId = 999;

DELETE XrayCentringResult
FROM XrayCentringResult
  JOIN XrayCentring
WHERE XrayCentring.xrayCentringId = XrayCentringResult.xrayCentringId AND
  XrayCentring.dataCollectionGroupId = @dcgId;

DELETE
FROM XrayCentring
WHERE dataCollectionGroupId = @dcgId;

DELETE
FROM DataCollectionGroup
WHERE dataCollectionGroupId = @dcgId;

DELETE RobotAction
FROM RobotAction
  JOIN DataCollectionGroup
WHERE RobotAction.blsessionId = @sessionId AND
  DataCollectionGroup.blSampleId = RobotAction.blSampleId AND
  DataCollectionGroup.dataCollectionGroupId = @dcgId;
