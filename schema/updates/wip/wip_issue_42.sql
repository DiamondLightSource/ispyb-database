ALTER TABLE Protein
  RENAME TO Component,
  CHANGE proteinId componentId int(10) unsigned NOT NULL AUTO_INCREMENT,
  CHANGE `sequence` content text DEFAULT NULL,
  COMMENT 'Components provide info about the type of sample material. It could be e.g. a protein, RNA, DNA or small molecule, or virus.';

ALTER TABLE Crystal
  RENAME TO BLSampleType,
  CHANGE crystalId blSampleTypeId int(10) unsigned NOT NULL AUTO_INCREMENT,
  CHANGE proteinId componentId int(10) unsigned DEFAULT NULL;
  CHANGE diffractionPlanId dataCollectionPlanId int(10) unsigned DEFAULT NULL,
  COMMENT 'The shared params. for this type of sample';

ALTER TABLE BLSample
  CHANGE diffractionPlanId dataCollectionPlanId int(10) unsigned DEFAULT NULL,
  COMMENT 'The instance of the sample to be used at the instrument/beamline';

ALTER TABLE DiffractionPlan
  RENAME TO DataCollectionPlan,
  CHANGE diffractionPlanId dataCollectionPlanId int(10) unsigned DEFAULT NULL,
  COMMENT 'The desired params. for collecting the data';
