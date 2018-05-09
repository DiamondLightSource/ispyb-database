.. csv-table:: AbInitioModel,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   abInitioModelId,int,
   modelListId,int,
   averagedModelId,int,
   rapidShapeDeterminationModelId,int,
   shapeDeterminationModelId,int,
   comments,varchar,
   creationTime,datetime,
.. csv-table:: Additive,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   additiveId,int,
   name,varchar,
   additiveType,varchar,
   comments,varchar,
.. csv-table:: AdminActivity,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   adminActivityId,int,
   username,varchar,
   action,varchar,
   comments,varchar,
   dateTime,datetime,
.. csv-table:: AdminVar,,ISPyB administration values
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   varId,int,
   name,varchar,
   value,varchar,
.. csv-table:: Aperture,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   apertureId,int,
   sizeX,float,
.. csv-table:: Assembly,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   assemblyId,int,
   macromoleculeId,int,
   creationDate,datetime,
   comments,varchar,
.. csv-table:: AssemblyHasMacromolecule,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   AssemblyHasMacromoleculeId,int,
   assemblyId,int,
   macromoleculeId,int,
.. csv-table:: AssemblyRegion,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   assemblyRegionId,int,
   assemblyHasMacromoleculeId,int,
   assemblyRegionType,varchar,
   name,varchar,
   fromResiduesBases,varchar,
   toResiduesBases,varchar,
.. csv-table:: AutoProc,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   autoProcId,int,Primary key (auto-incremented)
   autoProcProgramId,int,Related program item
   spaceGroup,varchar,Space group
   refinedCell_a,float,Refined cell
   refinedCell_b,float,Refined cell
   refinedCell_c,float,Refined cell
   refinedCell_alpha,float,Refined cell
   refinedCell_beta,float,Refined cell
   refinedCell_gamma,float,Refined cell
   recordTimeStamp,datetime,Creation or last update date/time
.. csv-table:: AutoProcIntegration,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   autoProcIntegrationId,int,Primary key (auto-incremented)
   dataCollectionId,int,DataCollection item
   autoProcProgramId,int,Related program item
   startImageNumber,int,start image number
   endImageNumber,int,end image number
   refinedDetectorDistance,float,Refined DataCollection.detectorDistance
   refinedXBeam,float,Refined DataCollection.xBeam
   refinedYBeam,float,Refined DataCollection.yBeam
   rotationAxisX,float,Rotation axis
   rotationAxisY,float,Rotation axis
   rotationAxisZ,float,Rotation axis
   beamVectorX,float,Beam vector
   beamVectorY,float,Beam vector
   beamVectorZ,float,Beam vector
   cell_a,float,Unit cell
   cell_b,float,Unit cell
   cell_c,float,Unit cell
   cell_alpha,float,Unit cell
   cell_beta,float,Unit cell
   cell_gamma,float,Unit cell
   recordTimeStamp,datetime,Creation or last update date/time
   anomalous,tinyint,boolean type:0 noanoum - 1 anoum
.. csv-table:: AutoProcProgram,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   autoProcProgramId,int,Primary key (auto-incremented)
   processingCommandLine,varchar,Command line for running the automatic processing
   processingPrograms,varchar,Processing programs (comma separated)
   processingStatus,tinyint,success (1) / fail (0)
   processingMessage,varchar,warning, error,...
   processingStartTime,datetime,Processing start time
   processingEndTime,datetime,Processing end time
   processingEnvironment,varchar,Cpus, Nodes,...
   recordTimeStamp,datetime,Creation or last update date/time
   processingJobId,int,
.. csv-table:: AutoProcProgramAttachment,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   autoProcProgramAttachmentId,int,Primary key (auto-incremented)
   autoProcProgramId,int,Related autoProcProgram item
   fileType,enum,Type of file Attachment
   fileName,varchar,Attachment filename
   filePath,varchar,Attachment filepath to disk storage
   recordTimeStamp,datetime,Creation or last update date/time
.. csv-table:: AutoProcScaling,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   autoProcScalingId,int,Primary key (auto-incremented)
   autoProcId,int,Related autoProc item (used by foreign key)
   recordTimeStamp,datetime,Creation or last update date/time
.. csv-table:: AutoProcScalingStatistics,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   autoProcScalingStatisticsId,int,Primary key (auto-incremented)
   autoProcScalingId,int,Related autoProcScaling item (used by foreign key)
   scalingStatisticsType,enum,Scaling statistics type
   comments,varchar,Comments...
   resolutionLimitLow,float,Low resolution limit
   resolutionLimitHigh,float,High resolution limit
   rMerge,float,Rmerge
   rMeasWithinIPlusIMinus,float,Rmeas (within I+/I-)
   rMeasAllIPlusIMinus,float,Rmeas (all I+ & I-)
   rPimWithinIPlusIMinus,float,Rpim (within I+/I-)
   rPimAllIPlusIMinus,float,Rpim (all I+ & I-)
   fractionalPartialBias,float,Fractional partial bias
   nTotalObservations,int,Total number of observations
   nTotalUniqueObservations,int,Total number unique
   meanIOverSigI,float,Mean((I)/sd(I))
   completeness,float,Completeness
   multiplicity,float,Multiplicity
   anomalousCompleteness,float,Anomalous completeness
   anomalousMultiplicity,float,Anomalous multiplicity
   recordTimeStamp,datetime,Creation or last update date/time
   anomalous,tinyint,boolean type:0 noanoum - 1 anoum
   ccHalf,float,information from XDS
   ccAnomalous,float,
.. csv-table:: AutoProcScaling_has_Int,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   autoProcScaling_has_IntId,int,Primary key (auto-incremented)
   autoProcScalingId,int,AutoProcScaling item
   autoProcIntegrationId,int,AutoProcIntegration item
   recordTimeStamp,datetime,Creation or last update date/time
.. csv-table:: AutoProcStatus,,AutoProcStatus table is linked to AutoProcIntegration
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   autoProcStatusId,int,Primary key (auto-incremented)
   autoProcIntegrationId,int,
   step,enum,autoprocessing step
   status,enum,autoprocessing status
   comments,varchar,comments
   bltimeStamp,timestamp,
.. csv-table:: BeamApertures,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   beamAperturesid,int,
   beamlineStatsId,int,
   flux,double,
   x,float,
   y,float,
   apertureSize,smallint,
.. csv-table:: BeamCalendar,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   beamCalendarId,int,
   run,varchar,
   beamStatus,varchar,
   startDate,datetime,
   endDate,datetime,
.. csv-table:: BeamCentres,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   beamCentresid,int,
   beamlineStatsId,int,
   x,float,
   y,float,
   zoom,tinyint,
.. csv-table:: BeamlineAction,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   beamlineActionId,int,
   sessionId,int,
   startTimestamp,timestamp,
   endTimestamp,timestamp,
   message,varchar,
   parameter,varchar,
   value,varchar,
   loglevel,enum,
   status,enum,
.. csv-table:: BeamLineSetup,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   beamLineSetupId,int,
   detectorId,int,
   synchrotronMode,varchar,
   undulatorType1,varchar,
   undulatorType2,varchar,
   undulatorType3,varchar,
   focalSpotSizeAtSample,float,
   focusingOptic,varchar,
   beamDivergenceHorizontal,float,
   beamDivergenceVertical,float,
   polarisation,float,
   monochromatorType,varchar,
   setupDate,datetime,
   synchrotronName,varchar,
   maxExpTimePerDataCollection,double,
   maxExposureTimePerImage,float,unit: seconds
   minExposureTimePerImage,double,
   goniostatMaxOscillationSpeed,double,
   goniostatMaxOscillationWidth,double,unit: degrees
   goniostatMinOscillationWidth,double,
   maxTransmission,double,unit: percentage
   minTransmission,double,
   recordTimeStamp,timestamp,Creation or last update date/time
   CS,float,Spherical Aberration, Units: mm?
   beamlineName,varchar,Beamline that this setup relates to
   beamSizeXMin,float,unit: um
   beamSizeXMax,float,unit: um
   beamSizeYMin,float,unit: um
   beamSizeYMax,float,unit: um
   energyMin,float,unit: eV
   energyMax,float,unit: eV
   omegaMin,float,unit: degrees
   omegaMax,float,unit: degrees
   kappaMin,float,unit: degrees
   kappaMax,float,unit: degrees
   phiMin,float,unit: degrees
   phiMax,float,unit: degrees
   active,tinyint,
   numberOfImagesMax,mediumint,
   numberOfImagesMin,mediumint,
   boxSizeXMin,double,For gridscans, unit: um
   boxSizeXMax,double,For gridscans, unit: um
   boxSizeYMin,double,For gridscans, unit: um
   boxSizeYMax,double,For gridscans, unit: um
   monoBandwidthMin,double,unit: percentage
   monoBandwidthMax,double,unit: percentage
.. csv-table:: BeamlineStats,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   beamlineStatsId,int,
   beamline,varchar,
   recordTimeStamp,datetime,
   ringCurrent,float,
   energy,float,
   gony,float,
   beamW,float,
   beamH,float,
   flux,double,
   scanFileW,varchar,
   scanFileH,varchar,
.. csv-table:: BF_component,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   componentId,int,
   systemId,int,
   name,varchar,
   description,varchar,
.. csv-table:: BF_component_beamline,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   component_beamlineId,int,
   componentId,int,
   beamlinename,varchar,
.. csv-table:: BF_fault,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   faultId,int,
   sessionId,int,
   owner,varchar,
   subcomponentId,int,
   starttime,datetime,
   endtime,datetime,
   beamtimelost,tinyint,
   beamtimelost_starttime,datetime,
   beamtimelost_endtime,datetime,
   title,varchar,
   description,text,
   resolved,tinyint,
   resolution,text,
   attachment,varchar,
   eLogId,int,
   assignee,varchar,
   personId,int,
   assigneeId,int,
.. csv-table:: BF_subcomponent,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   subcomponentId,int,
   componentId,int,
   name,varchar,
   description,varchar,
.. csv-table:: BF_subcomponent_beamline,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   subcomponent_beamlineId,int,
   subcomponentId,int,
   beamlinename,varchar,
.. csv-table:: BF_system,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   systemId,int,
   name,varchar,
   description,varchar,
.. csv-table:: BF_system_beamline,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   system_beamlineId,int,
   systemId,int,
   beamlineName,varchar,
.. csv-table:: BLSample,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   blSampleId,int,
   diffractionPlanId,int,
   crystalId,int,
   containerId,int,
   name,varchar,
   code,varchar,
   location,varchar,
   holderLength,double,
   loopLength,double,
   loopType,varchar,
   wireWidth,double,
   comments,varchar,
   completionStage,varchar,
   structureStage,varchar,
   publicationStage,varchar,
   publicationComments,varchar,
   blSampleStatus,varchar,
   isInSampleChanger,tinyint,
   lastKnownCenteringPosition,varchar,
   POSITIONID,int,
   recordTimeStamp,timestamp,Creation or last update date/time
   SMILES,varchar,the symbolic description of the structure of a chemical compound
   blSubSampleId,int,
   lastImageURL,varchar,
   screenComponentGroupId,int,
   volume,float,
   dimension1,double,
   dimension2,double,
   dimension3,double,
   shape,varchar,
   packingFraction,float,
   preparationTemeprature,mediumint,Sample preparation temperature, Units: kelvin
   preparationHumidity,float,Sample preparation humidity, Units: %
   blottingTime,int,Blotting time, Units: sec
   blottingForce,float,Force used when blotting sample, Units: N?
   blottingDrainTime,int,Time sample left to drain after blotting, Units: sec
   support,varchar,Sample support material
   subLocation,smallint,Indicates the sample's location on a multi-sample pin, where 1 is closest to the pin base
.. csv-table:: BLSampleGroup,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   blSampleGroupId,int,
.. csv-table:: BLSampleGroup_has_BLSample,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   blSampleGroupId,int,
   blSampleId,int,
   groupOrder,mediumint,
   type,enum,
.. csv-table:: BLSampleImage,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   blSampleImageId,int,
   blSampleId,int,
   micronsPerPixelX,float,
   micronsPerPixelY,float,
   imageFullPath,varchar,
   blSampleImageScoreId,int,
   comments,varchar,
   blTimeStamp,datetime,
   containerInspectionId,int,
   modifiedTimeStamp,datetime,
.. csv-table:: BLSampleImageAnalysis,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   blSampleImageAnalysisId,int,
   blSampleImageId,int,
   oavSnapshotBefore,varchar,
   oavSnapshotAfter,varchar,
   deltaX,int,
   deltaY,int,
   goodnessOfFit,float,
   scaleFactor,float,
   resultCode,varchar,
   matchStartTimeStamp,timestamp,
   matchEndTimeStamp,timestamp,
.. csv-table:: BLSampleImageMeasurement,,For measuring crystal growth over time
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   blSampleImageMeasurementId,int,
   blSampleImageId,int,
   blSubSampleId,int,
   startPosX,double,
   startPosY,double,
   endPosX,double,
   endPosY,double,
   blTimeStamp,datetime,
.. csv-table:: BLSampleImageScore,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   blSampleImageScoreId,int,
   name,varchar,
   score,float,
   colour,varchar,
.. csv-table:: BLSampleType_has_Component,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   blSampleTypeId,int,
   componentId,int,
   abundance,float,
.. csv-table:: BLSample_has_DataCollectionPlan,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   blSampleId,int,
   dataCollectionPlanId,int,
   planOrder,tinyint,
.. csv-table:: BLSample_has_EnergyScan,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   blSampleId,int,
   energyScanId,int,
   blSampleHasEnergyScanId,int,
.. csv-table:: BLSession,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   sessionId,int,
   beamLineSetupId,int,
   proposalId,int,
   projectCode,varchar,
   startDate,datetime,
   endDate,datetime,
   beamLineName,varchar,
   scheduled,tinyint,
   nbShifts,int,
   comments,varchar,
   beamLineOperator,varchar,
   bltimeStamp,timestamp,
   visit_number,int,
   usedFlag,tinyint,indicates if session has Datacollections or XFE or EnergyScans attached
   sessionTitle,varchar,fx accounts only
   structureDeterminations,float,
   dewarTransport,float,
   databackupFrance,float,data backup and express delivery France
   databackupEurope,float,data backup and express delivery Europe
   expSessionPk,int,smis session Pk
   operatorSiteNumber,varchar,matricule site
   lastUpdate,timestamp,last update timestamp: by default the end of the session, the last collect...
   protectedData,varchar,indicates if the data are protected or not
   externalId,binary,
.. csv-table:: BLSession_has_SCPosition,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   blsessionhasscpositionid,int,
   blsessionid,int,
   scContainer,smallint,Position of container within sample changer
   containerPosition,smallint,Position of sample within container
.. csv-table:: BLSubSample,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   blSubSampleId,int,Primary key (auto-incremented)
   blSampleId,int,sample
   diffractionPlanId,int,eventually diffractionPlan
   blSampleImageId,int,
   positionId,int,position of the subsample
   position2Id,int,
   motorPositionId,int,motor position
   blSubSampleUUID,varchar,uuid of the blsubsample
   imgFileName,varchar,image filename
   imgFilePath,varchar,url image
   comments,varchar,comments
   recordTimeStamp,timestamp,Creation or last update date/time
.. csv-table:: Buffer,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   bufferId,int,
   BLSESSIONID,int,
   safetyLevelId,int,
   name,varchar,
   acronym,varchar,
   pH,varchar,
   composition,varchar,
   comments,varchar,
   proposalId,int,
.. csv-table:: BufferHasAdditive,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   bufferHasAdditiveId,int,
   bufferId,int,
   additiveId,int,
   measurementUnitId,int,
   quantity,varchar,
.. csv-table:: CalendarHash,,Lets people get to their calendars without logging in using a private (hash) url
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   calendarHashId,int,
   ckey,varchar,
   hash,varchar,
   beamline,tinyint,
.. csv-table:: ComponentLattice,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   componentLatticeId,int,
   componentId,int,
   spaceGroup,varchar,
   cell_a,double,
   cell_b,double,
   cell_c,double,
   cell_alpha,double,
   cell_beta,double,
   cell_gamma,double,
.. csv-table:: ComponentSubType,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   componentSubTypeId,int,
   name,varchar,
   hasPh,tinyint,
.. csv-table:: ComponentType,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   componentTypeId,int,
   name,varchar,
.. csv-table:: Component_has_SubType,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   componentId,int,
   componentSubTypeId,int,
.. csv-table:: ConcentrationType,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   concentrationTypeId,int,
   name,varchar,
   symbol,varchar,
.. csv-table:: Container,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   containerId,int,
   dewarId,int,
   code,varchar,
   containerType,varchar,
   capacity,int,
   sampleChangerLocation,varchar,
   containerStatus,varchar,
   bltimeStamp,datetime,
   beamlineLocation,varchar,
   screenId,int,
   scheduleId,int,
   barcode,varchar,
   imagerId,int,
   sessionId,int,
   ownerId,int,
   requestedImagerId,int,
   requestedReturn,tinyint,True for requesting return, False means container will be disposed
   comments,varchar,
   experimentType,varchar,
   storageTemperature,float,
   containerRegistryId,int,
.. csv-table:: ContainerHistory,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   containerHistoryId,int,
   containerId,int,
   location,varchar,
   blTimeStamp,timestamp,
   status,varchar,
   beamlineName,varchar,
.. csv-table:: ContainerInspection,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   containerInspectionId,int,
   containerId,int,
   inspectionTypeId,int,
   imagerId,int,
   temperature,float,
   blTimeStamp,datetime,
   scheduleComponentid,int,
   state,varchar,
   priority,smallint,
   manual,tinyint,
   scheduledTimeStamp,datetime,
   completedTimeStamp,datetime,
.. csv-table:: ContainerQueue,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   containerQueueId,int,
   containerId,int,
   personId,int,
   createdTimeStamp,timestamp,
   completedTimeStamp,timestamp,
.. csv-table:: ContainerQueueSample,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   containerQueueSampleId,int,
   containerQueueId,int,
   blSubSampleId,int,
.. csv-table:: ContainerRegistry,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   containerRegistryId,int,
   barcode,varchar,
   comments,varchar,
   recordTimestamp,datetime,
.. csv-table:: ContainerRegistry_has_Proposal,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   containerRegistryHasProposalId,int,
   containerRegistryId,int,
   proposalId,int,
   personId,int,Person registering the container
   recordTimestamp,datetime,
.. csv-table:: ContainerReport,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   containerReportId,int,
   containerRegistryId,int,
   personId,int,Person making report
   report,text,
   attachmentFilePath,varchar,
   recordTimestamp,datetime,
.. csv-table:: CourierTermsAccepted,,Records acceptances of the courier T and C
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   courierTermsAcceptedId,int,
   proposalId,int,
   personId,int,
   shippingName,varchar,
   timestamp,datetime,
   shippingId,int,
.. csv-table:: Crystal,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   crystalId,int,
   diffractionPlanId,int,
   proteinId,int,
   crystalUUID,varchar,
   name,varchar,
   spaceGroup,varchar,
   morphology,varchar,
   color,varchar,
   size_X,double,
   size_Y,double,
   size_Z,double,
   cell_a,double,
   cell_b,double,
   cell_c,double,
   cell_alpha,double,
   cell_beta,double,
   cell_gamma,double,
   comments,varchar,
   pdbFileName,varchar,pdb file name
   pdbFilePath,varchar,pdb file path
   recordTimeStamp,timestamp,Creation or last update date/time
   abundance,float,
   theoreticalDensity,float,
.. csv-table:: Crystal_has_UUID,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   crystal_has_UUID_Id,int,
   crystalId,int,
   UUID,varchar,
   imageURL,varchar,
.. csv-table:: CTF,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   ctfId,int,
   motionCorrectionId,int,
   autoProcProgramId,int,
   boxSizeX,float,Box size in x, Units: pixels
   boxSizeY,float,Box size in y, Units: pixels
   minResolution,float,Minimum resolution for CTF, Units: A
   maxResolution,float,Units: A
   minDefocus,float,Units: A
   maxDefocus,float,Units: A
   defocusStepSize,float,Units: A
   astigmatism,float,Units: A
   astigmatismAngle,float,Units: deg?
   estimatedResolution,float,Units: A
   estimatedDefocus,float,Units: A
   amplitudeContrast,float,Units: %?
   ccValue,float,Correlation value
   fftTheoreticalFullPath,varchar,Full path to the jpg image of the simulated FFT
   comments,varchar,
.. csv-table:: DataAcquisition,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   dataAcquisitionId,int,
   sampleCellId,int,
   framesCount,varchar,
   energy,varchar,
   waitTime,varchar,
   detectorDistance,varchar,
.. csv-table:: DataCollection,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   dataCollectionId,int,Primary key (auto-incremented)
   BLSAMPLEID,int,
   SESSIONID,int,
   experimenttype,varchar,
   dataCollectionNumber,int,
   startTime,datetime,Start time of the dataCollection
   endTime,datetime,end time of the dataCollection
   runStatus,varchar,
   axisStart,float,
   axisEnd,float,
   axisRange,float,
   overlap,float,
   numberOfImages,int,
   startImageNumber,int,
   numberOfPasses,int,
   exposureTime,float,
   imageDirectory,varchar,
   imagePrefix,varchar,
   imageSuffix,varchar,
   fileTemplate,varchar,
   wavelength,float,
   resolution,float,
   detectorDistance,float,
   xBeam,float,
   yBeam,float,
   comments,varchar,
   printableForReport,tinyint,
   CRYSTALCLASS,varchar,
   slitGapVertical,float,
   slitGapHorizontal,float,
   transmission,float,
   synchrotronMode,varchar,
   xtalSnapshotFullPath1,varchar,
   xtalSnapshotFullPath2,varchar,
   xtalSnapshotFullPath3,varchar,
   xtalSnapshotFullPath4,varchar,
   rotationAxis,enum,
   phiStart,float,
   kappaStart,float,
   omegaStart,float,
   chiStart,float,
   resolutionAtCorner,float,
   detector2Theta,float,
   DETECTORMODE,varchar,
   undulatorGap1,float,
   undulatorGap2,float,
   undulatorGap3,float,
   beamSizeAtSampleX,float,
   beamSizeAtSampleY,float,
   centeringMethod,varchar,
   averageTemperature,float,
   ACTUALSAMPLEBARCODE,varchar,
   ACTUALSAMPLESLOTINCONTAINER,int,
   ACTUALCONTAINERBARCODE,varchar,
   ACTUALCONTAINERSLOTINSC,int,
   actualCenteringPosition,varchar,
   beamShape,varchar,
   dataCollectionGroupId,int,references DataCollectionGroup table
   POSITIONID,int,
   detectorId,int,references Detector table
   FOCALSPOTSIZEATSAMPLEX,float,
   POLARISATION,float,
   FOCALSPOTSIZEATSAMPLEY,float,
   APERTUREID,int,
   screeningOrigId,int,
   startPositionId,int,
   endPositionId,int,
   flux,double,
   strategySubWedgeOrigId,int,references ScreeningStrategySubWedge table
   blSubSampleId,int,
   flux_end,double,flux measured after the collect
   bestWilsonPlotPath,varchar,
   processedDataFile,varchar,
   datFullPath,varchar,
   magnification,float,Calibrated magnification, Units: dimensionless
   totalAbsorbedDose,float,Unit: e-/A^2 for EM
   binning,tinyint,1 or 2. Number of pixels to process as 1. (Use mean value.)
   particleDiameter,float,Unit: nm
   boxSize_CTF,float,Unit: pixels
   minResolution,float,Unit: A
   minDefocus,float,Unit: A
   maxDefocus,float,Unit: A
   defocusStepSize,float,Unit: A
   amountAstigmatism,float,Unit: A
   extractSize,float,Unit: pixels
   bgRadius,float,Unit: nm
   voltage,float,Unit: kV
   objAperture,float,Unit: um
   c1aperture,float,Unit: um
   c2aperture,float,Unit: um
   c3aperture,float,Unit: um
   c1lens,float,Unit: %
   c2lens,float,Unit: %
   c3lens,float,Unit: %
   totalExposedDose,float,Units: e-/A^2
   nominalMagnification,float,Nominal magnification: Units: dimensionless
   nominalDefocus,float,Nominal defocus, Units: A
   imageSizeX,mediumint,Image size in x, incase crop has been used, Units: pixels
   imageSizeY,mediumint,Image size in y, Units: pixels
   pixelSizeOnImage,float,Pixel size on image, calculated from magnification, duplicate? Units: um?
   phasePlate,tinyint,Whether the phase plate was used
.. csv-table:: DataCollectionComment,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   dataCollectionCommentId,int,
   dataCollectionId,int,
   personId,int,
   comments,varchar,
   createTime,datetime,
   modTime,date,
.. csv-table:: DataCollectionFileAttachment,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   dataCollectionFileAttachmentId,int,
   dataCollectionId,int,
   fileFullPath,varchar,
   fileType,enum,snapshot: image file, usually of the sample. log: a text file with logging info. xy: x and y data in text format. recip: a reciprocal space viewer file. pia: per image analysis
   createTime,timestamp,
.. csv-table:: DataCollectionGroup,,a dataCollectionGroup is a group of dataCollection for a spe
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   dataCollectionGroupId,int,Primary key (auto-incremented)
   sessionId,int,references Session table
   comments,varchar,comments
   blSampleId,int,references BLSample table
   experimentType,enum,
   startTime,datetime,Start time of the dataCollectionGroup
   endTime,datetime,end time of the dataCollectionGroup
   crystalClass,varchar,Crystal Class for industrials users
   detectorMode,varchar,Detector mode
   actualSampleBarcode,varchar,Actual sample barcode
   actualSampleSlotInContainer,int,Actual sample slot number in container
   actualContainerBarcode,varchar,Actual container barcode
   actualContainerSlotInSC,int,Actual container slot number in sample changer
   workflowId,int,
   xtalSnapshotFullPath,varchar,
.. csv-table:: DataCollectionPlan_has_Detector,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   dataCollectionPlanHasDetectorId,int,
   dataCollectionPlanId,int,
   detectorId,int,
   exposureTime,double,
   distance,double,
   roll,double,
.. csv-table:: DataReductionStatus,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   dataReductionStatusId,int,
   dataCollectionId,int,
   status,varchar,
   filename,varchar,
   message,varchar,
.. csv-table:: Detector,,Detector table is linked to a dataCollection
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   detectorId,int,Primary key (auto-incremented)
   detectorType,varchar,
   detectorManufacturer,varchar,
   detectorModel,varchar,
   detectorPixelSizeHorizontal,float,
   detectorPixelSizeVertical,float,
   DETECTORMAXRESOLUTION,float,
   DETECTORMINRESOLUTION,float,
   detectorSerialNumber,varchar,
   detectorDistanceMin,double,
   detectorDistanceMax,double,
   trustedPixelValueRangeLower,double,
   trustedPixelValueRangeUpper,double,
   sensorThickness,float,
   overload,float,
   XGeoCorr,varchar,
   YGeoCorr,varchar,
   detectorMode,varchar,
   density,float,
   composition,varchar,
   numberOfPixelsX,mediumint,Detector number of pixels in x
   numberOfPixelsY,mediumint,Detector number of pixels in y
   detectorRollMin,double,unit: degrees
   detectorRollMax,double,unit: degrees
.. csv-table:: Dewar,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   dewarId,int,
   shippingId,int,
   code,varchar,
   comments,tinytext,
   storageLocation,varchar,
   dewarStatus,varchar,
   bltimeStamp,datetime,
   isStorageDewar,tinyint,
   barCode,varchar,
   firstExperimentId,int,
   customsValue,int,
   transportValue,int,
   trackingNumberToSynchrotron,varchar,
   trackingNumberFromSynchrotron,varchar,
   type,enum,
   FACILITYCODE,varchar,
   weight,float,dewar weight in kg
   deliveryAgent_barcode,varchar,Courier piece barcode (not the airway bill)
.. csv-table:: DewarLocation,,ISPyB Dewar location table
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   eventId,int,
   dewarNumber,varchar,Dewar number
   userId,varchar,User who locates the dewar
   dateTime,datetime,Date and time of locatization
   locationName,varchar,Location of the dewar
   courierName,varchar,Carrier name who's shipping back the dewar
   courierTrackingNumber,varchar,Tracking number of the shippment
.. csv-table:: DewarLocationList,,List of locations for dewars
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   locationId,int,
   locationName,varchar,Location
.. csv-table:: DewarRegistry,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   facilityCode,varchar,
   proposalId,int,
   labContactId,int,
   purchaseDate,datetime,
   bltimestamp,datetime,
.. csv-table:: DewarReport,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   dewarReportId,int,
   facilityCode,varchar,
   report,text,
   attachment,varchar,
   bltimestamp,datetime,
.. csv-table:: DewarTransportHistory,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   DewarTransportHistoryId,int,
   dewarId,int,
   dewarStatus,varchar,
   storageLocation,varchar,
   arrivalDate,datetime,
.. csv-table:: DiffractionPlan,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   diffractionPlanId,int,
   name,varchar,
   experimentKind,enum,
   observedResolution,float,
   minimalResolution,float,
   exposureTime,float,
   oscillationRange,float,
   maximalResolution,float,
   screeningResolution,float,
   radiationSensitivity,float,
   anomalousScatterer,varchar,
   preferredBeamSizeX,float,
   preferredBeamSizeY,float,
   preferredBeamDiameter,float,
   comments,varchar,
   DIFFRACTIONPLANUUID,varchar,
   aimedCompleteness,double,
   aimedIOverSigmaAtHighestRes,double,
   aimedMultiplicity,double,
   aimedResolution,double,
   anomalousData,tinyint,
   complexity,varchar,
   estimateRadiationDamage,tinyint,
   forcedSpaceGroup,varchar,
   requiredCompleteness,double,
   requiredMultiplicity,double,
   requiredResolution,double,
   strategyOption,varchar,
   kappaStrategyOption,varchar,
   numberOfPositions,int,
   minDimAccrossSpindleAxis,double,minimum dimension accross the spindle axis
   maxDimAccrossSpindleAxis,double,maximum dimension accross the spindle axis
   radiationSensitivityBeta,double,
   radiationSensitivityGamma,double,
   minOscWidth,float,
   recordTimeStamp,timestamp,Creation or last update date/time
   monochromator,varchar,DMM or DCM
   energy,float,eV
   transmission,float,Decimal fraction in range [0,1]
   boxSizeX,float,microns
   boxSizeY,float,microns
   kappaStart,float,degrees
   axisStart,float,degrees
   axisRange,float,degrees
   numberOfImages,mediumint,The number of images requested
   presetForProposalId,int,Indicates this plan is available to all sessions on given proposal
   beamLineName,varchar,Indicates this plan is available to all sessions on given beamline
   detectorId,int,
   distance,double,
   orientation,double,
   monoBandwidth,double,
.. csv-table:: EMMicroscope,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   emMicroscopeId,int,
   instrumentName,varchar,
   voltage,float,
   CS,float,
   detectorPixelSize,float,
   C2aperture,float,
   ObjAperture,float,
   C2lens,float,
.. csv-table:: EnergyScan,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   energyScanId,int,
   sessionId,int,
   blSampleId,int,
   fluorescenceDetector,varchar,
   scanFileFullPath,varchar,
   jpegChoochFileFullPath,varchar,
   element,varchar,
   startEnergy,float,
   endEnergy,float,
   transmissionFactor,float,
   exposureTime,float,
   synchrotronCurrent,float,
   temperature,float,
   peakEnergy,float,
   peakFPrime,float,
   peakFDoublePrime,float,
   inflectionEnergy,float,
   inflectionFPrime,float,
   inflectionFDoublePrime,float,
   xrayDose,float,
   startTime,datetime,
   endTime,datetime,
   edgeEnergy,varchar,
   filename,varchar,
   beamSizeVertical,float,
   beamSizeHorizontal,float,
   choochFileFullPath,varchar,
   crystalClass,varchar,
   comments,varchar,
   flux,double,flux measured before the energyScan
   flux_end,double,flux measured after the energyScan
   workingDirectory,varchar,
   blSubSampleId,int,
.. csv-table:: Experiment,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   experimentId,int,
   proposalId,int,
   name,varchar,
   creationDate,datetime,
   comments,varchar,
   experimentType,varchar,
   sourceFilePath,varchar,
   dataAcquisitionFilePath,varchar,The file path pointing to the data acquisition. Eventually it may be a compressed file with all the files or just the folder
   status,varchar,
   sessionId,int,
.. csv-table:: ExperimentKindDetails,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   experimentKindId,int,
   diffractionPlanId,int,
   exposureIndex,int,
   dataCollectionType,varchar,
   dataCollectionKind,varchar,
   wedgeValue,float,
.. csv-table:: Frame,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   frameId,int,
   FRAMESETID,int,
   filePath,varchar,
   comments,varchar,
.. csv-table:: FrameList,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   frameListId,int,
   comments,int,
.. csv-table:: FrameSet,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   frameSetId,int,
   runId,int,
   FILEPATH,varchar,
   INTERNALPATH,varchar,
   frameListId,int,
   detectorId,int,
   detectorDistance,varchar,
.. csv-table:: FrameToList,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   frameToListId,int,
   frameListId,int,
   frameId,int,
.. csv-table:: GeometryClassname,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   geometryClassnameId,int,
   geometryClassname,varchar,
   geometryOrder,int,
.. csv-table:: GridImageMap,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   gridImageMapId,int,
   dataCollectionId,int,
   imageNumber,int,Movie number, sequential 1-n in time order
   outputFileId,varchar,File number, file 1 may not be movie 1
   positionX,float,X position of stage, Units: um
   positionY,float,Y position of stage, Units: um
.. csv-table:: GridInfo,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   gridInfoId,int,Primary key (auto-incremented)
   xOffset,double,
   yOffset,double,
   dx_mm,double,
   dy_mm,double,
   steps_x,double,
   steps_y,double,
   meshAngle,double,
   recordTimeStamp,timestamp,Creation or last update date/time
   workflowMeshId,int,
   orientation,enum,
   dataCollectionGroupId,int,
   pixelsPerMicronX,float,
   pixelsPerMicronY,float,
   snapshot_offsetXPixel,float,
   snapshot_offsetYPixel,float,
   snaked,tinyint,True: The images associated with the DCG were collected in a snaked pattern
.. csv-table:: Image,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   imageId,int,
   dataCollectionId,int,
   imageNumber,int,
   fileName,varchar,
   fileLocation,varchar,
   measuredIntensity,float,
   jpegFileFullPath,varchar,
   jpegThumbnailFileFullPath,varchar,
   temperature,float,
   cumulativeIntensity,float,
   synchrotronCurrent,float,
   comments,varchar,
   machineMessage,varchar,
   BLTIMESTAMP,timestamp,
   motorPositionId,int,
   recordTimeStamp,timestamp,Creation or last update date/time
.. csv-table:: ImageQualityIndicators,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   dataCollectionId,int,
   imageNumber,mediumint,
   imageId,int,
   autoProcProgramId,int,Foreign key to the AutoProcProgram table
   spotTotal,int,Total number of spots
   inResTotal,int,Total number of spots in resolution range
   goodBraggCandidates,int,Total number of Bragg diffraction spots
   iceRings,int,Number of ice rings identified
   method1Res,float,Resolution estimate 1 (see publication)
   method2Res,float,Resolution estimate 2 (see publication)
   maxUnitCell,float,Estimation of the largest possible unit cell edge
   pctSaturationTop50Peaks,float,The fraction of the dynamic range being used
   inResolutionOvrlSpots,int,Number of spots overloaded
   binPopCutOffMethod2Res,float,Cut off used in resolution limit calculation
   recordTimeStamp,datetime,Creation or last update date/time
   totalIntegratedSignal,double,
   dozor_score,double,dozor_score
   driftFactor,float,EM movie drift factor
.. csv-table:: Imager,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   imagerId,int,
   name,varchar,
   temperature,float,
   serial,varchar,
   capacity,smallint,
.. csv-table:: InspectionType,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   inspectionTypeId,int,
   name,varchar,
.. csv-table:: Instruction,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   instructionId,int,
   instructionSetId,int,
   INSTRUCTIONORDER,int,
   comments,varchar,
   order,int,
.. csv-table:: InstructionSet,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   instructionSetId,int,
   type,varchar,
.. csv-table:: IspybCrystalClass,,ISPyB crystal class values
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   crystalClassId,int,
   crystalClass_code,varchar,
   crystalClass_name,varchar,
.. csv-table:: IspybReference,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   referenceId,int,Primary key (auto-incremented)
   referenceName,varchar,reference name
   referenceUrl,varchar,url of the reference
   referenceBibtext,blob,bibtext value of the reference
   beamline,enum,beamline involved
.. csv-table:: LabContact,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   labContactId,int,
   personId,int,
   cardName,varchar,
   proposalId,int,
   defaultCourrierCompany,varchar,
   courierAccount,varchar,
   billingReference,varchar,
   dewarAvgCustomsValue,int,
   dewarAvgTransportValue,int,
   recordTimeStamp,timestamp,Creation or last update date/time
.. csv-table:: Laboratory,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   laboratoryId,int,
   laboratoryUUID,varchar,
   name,varchar,
   address,varchar,
   city,varchar,
   country,varchar,
   url,varchar,
   organization,varchar,
   recordTimeStamp,timestamp,Creation or last update date/time
   laboratoryPk,int,
   postcode,varchar,
.. csv-table:: Log4Stat,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   id,int,
   priority,varchar,
   LOG4JTIMESTAMP,datetime,
   msg,varchar,
   detail,varchar,
   value,varchar,
   timestamp,datetime,
.. csv-table:: Macromolecule,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   macromoleculeId,int,
   proposalId,int,
   safetyLevelId,int,
   name,varchar,
   acronym,varchar,
   molecularMass,varchar,
   extintionCoefficient,varchar,
   sequence,varchar,
   creationDate,datetime,
   comments,varchar,
.. csv-table:: MacromoleculeRegion,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   macromoleculeRegionId,int,
   macromoleculeId,int,
   regionType,varchar,
   id,varchar,
   count,varchar,
   sequence,varchar,
.. csv-table:: Measurement,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   specimenId,int,
   runId,int,
   code,varchar,
   priorityLevelId,int,
   exposureTemperature,varchar,
   viscosity,varchar,
   flow,tinyint,
   extraFlowTime,varchar,
   volumeToLoad,varchar,
   waitTime,varchar,
   transmission,varchar,
   comments,varchar,
   measurementId,int,
.. csv-table:: MeasurementToDataCollection,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   measurementToDataCollectionId,int,
   dataCollectionId,int,
   measurementId,int,
   dataCollectionOrder,int,
.. csv-table:: MeasurementUnit,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   measurementUnitId,int,
   name,varchar,
   unitType,varchar,
.. csv-table:: Merge,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   mergeId,int,
   measurementId,int,
   frameListId,int,
   discardedFrameNameList,varchar,
   averageFilePath,varchar,
   framesCount,varchar,
   framesMerge,varchar,
.. csv-table:: Model,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   modelId,int,
   name,varchar,
   pdbFile,varchar,
   fitFile,varchar,
   firFile,varchar,
   logFile,varchar,
   rFactor,varchar,
   chiSqrt,varchar,
   volume,varchar,
   rg,varchar,
   dMax,varchar,
.. csv-table:: ModelBuilding,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   modelBuildingId,int,Primary key (auto-incremented)
   phasingAnalysisId,int,Related phasing analysis item
   phasingProgramRunId,int,Related program item
   spaceGroupId,int,Related spaceGroup
   lowRes,double,
   highRes,double,
   recordTimeStamp,datetime,Creation or last update date/time
.. csv-table:: ModelList,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   modelListId,int,
   nsdFilePath,varchar,
   chi2RgFilePath,varchar,
.. csv-table:: ModelToList,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   modelToListId,int,
   modelId,int,
   modelListId,int,
.. csv-table:: MotionCorrection,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   motionCorrectionId,int,
   dataCollectionId,int,
   autoProcProgramId,int,
   imageNumber,smallint,Movie number, sequential in time 1-n
   firstFrame,smallint,First frame of movie used
   lastFrame,smallint,Last frame of movie used
   dosePerFrame,float,Dose per frame, Units: e-/A^2
   doseWeight,float,Dose weight, Units: dimensionless
   totalMotion,float,Total motion, Units: A
   averageMotionPerFrame,float,Average motion per frame, Units: A
   driftPlotFullPath,varchar,Full path to the drift plot
   micrographFullPath,varchar,Full path to the micrograph
   micrographSnapshotFullPath,varchar,Full path to a snapshot (jpg) of the micrograph
   patchesUsedX,mediumint,Number of patches used in x (for motioncor2)
   patchesUsedY,mediumint,Number of patches used in y (for motioncor2)
   fftFullPath,varchar,Full path to the jpg image of the raw micrograph FFT
   fftCorrectedFullPath,varchar,Full path to the jpg image of the drift corrected micrograph FFT
   comments,varchar,
   movieId,int,
.. csv-table:: MotionCorrectionDrift,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   motionCorrectionDriftId,int,
   motionCorrectionId,int,
   frameNumber,smallint,Frame number of the movie these drift values relate to
   deltaX,float,Drift in x, Units: A
   deltaY,float,Drift in y, Units: A
.. csv-table:: MotorPosition,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   motorPositionId,int,Primary key (auto-incremented)
   phiX,double,
   phiY,double,
   phiZ,double,
   sampX,double,
   sampY,double,
   omega,double,
   kappa,double,
   phi,double,
   chi,double,
   gridIndexY,int,
   gridIndexZ,int,
   recordTimeStamp,timestamp,Creation or last update date/time
.. csv-table:: Movie,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   movieId,int,
   dataCollectionId,int,
   movieNumber,mediumint,
   movieFullPath,varchar,
   createdTimeStamp,timestamp,
   positionX,float,
   positionY,float,
   nominalDefocus,float,Nominal defocus, Units: A
.. csv-table:: MXMRRun,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   mxMRRunId,int,
   autoProcScalingId,int,
   success,tinyint,Indicates whether the program completed. 1 for success, 0 for failure.
   message,varchar,A short summary of the findings, success or failure.
   pipeline,varchar,
   inputCoordFile,varchar,
   outputCoordFile,varchar,
   inputMTZFile,varchar,
   outputMTZFile,varchar,
   runDirectory,varchar,
   logFile,varchar,
   commandLine,varchar,
   rValueStart,float,
   rValueEnd,float,
   rFreeValueStart,float,
   rFreeValueEnd,float,
   starttime,datetime,
   endtime,datetime,
.. csv-table:: MXMRRunBlob,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   mxMRRunBlobId,int,
   mxMRRunId,int,
   view1,varchar,
   view2,varchar,
   view3,varchar,
.. csv-table:: Particle,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   particleId,int,
   dataCollectionId,int,
   x,float,
   y,float,
.. csv-table:: PDB,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   pdbId,int,
   name,varchar,
   contents,mediumtext,
   code,varchar,
.. csv-table:: PDBEntry,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   pdbEntryId,int,
   autoProcProgramId,int,
   code,varchar,
   cell_a,float,
   cell_b,float,
   cell_c,float,
   cell_alpha,float,
   cell_beta,float,
   cell_gamma,float,
   resolution,float,
   pdbTitle,varchar,
   pdbAuthors,varchar,
   pdbDate,datetime,
   pdbBeamlineName,varchar,
   beamlines,varchar,
   distance,float,
   autoProcCount,smallint,
   dataCollectionCount,smallint,
   beamlineMatch,tinyint,
   authorMatch,tinyint,
.. csv-table:: PDBEntry_has_AutoProcProgram,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   pdbEntryHasAutoProcId,int,
   pdbEntryId,int,
   autoProcProgramId,int,
   distance,float,
.. csv-table:: Permission,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   permissionId,int,
   type,varchar,
   description,varchar,
.. csv-table:: Person,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   personId,int,
   laboratoryId,int,
   siteId,int,
   personUUID,varchar,
   familyName,varchar,
   givenName,varchar,
   title,varchar,
   emailAddress,varchar,
   phoneNumber,varchar,
   login,varchar,
   faxNumber,varchar,
   recordTimeStamp,timestamp,Creation or last update date/time
   cache,text,
   externalId,binary,
.. csv-table:: Phasing,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   phasingId,int,Primary key (auto-incremented)
   phasingAnalysisId,int,Related phasing analysis item
   phasingProgramRunId,int,Related program item
   spaceGroupId,int,Related spaceGroup
   method,enum,phasing method
   solventContent,double,
   enantiomorph,tinyint,0 or 1
   lowRes,double,
   highRes,double,
   recordTimeStamp,datetime,
.. csv-table:: PhasingAnalysis,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   phasingAnalysisId,int,Primary key (auto-incremented)
   recordTimeStamp,datetime,Creation or last update date/time
.. csv-table:: PhasingProgramAttachment,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   phasingProgramAttachmentId,int,Primary key (auto-incremented)
   phasingProgramRunId,int,Related program item
   fileType,enum,file type
   fileName,varchar,file name
   filePath,varchar,file path
   recordTimeStamp,datetime,Creation or last update date/time
.. csv-table:: PhasingProgramRun,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   phasingProgramRunId,int,Primary key (auto-incremented)
   phasingCommandLine,varchar,Command line for phasing
   phasingPrograms,varchar,Phasing programs (comma separated)
   phasingStatus,tinyint,success (1) / fail (0)
   phasingMessage,varchar,warning, error,...
   phasingStartTime,datetime,Processing start time
   phasingEndTime,datetime,Processing end time
   phasingEnvironment,varchar,Cpus, Nodes,...
   recordTimeStamp,datetime,
.. csv-table:: PhasingStatistics,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   phasingStatisticsId,int,Primary key (auto-incremented)
   phasingHasScalingId1,int,the dataset in question
   phasingHasScalingId2,int,if this is MIT or MAD, which scaling are being compared, null otherwise
   phasingStepId,int,
   numberOfBins,int,the total number of bins
   binNumber,int,binNumber, 999 for overall
   lowRes,double,low resolution cutoff of this binfloat
   highRes,double,high resolution cutoff of this binfloat
   metric,enum,metric
   statisticsValue,double,the statistics value
   nReflections,int,
   recordTimeStamp,datetime,
.. csv-table:: PhasingStep,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   phasingStepId,int,
   previousPhasingStepId,int,
   programRunId,int,
   spaceGroupId,int,
   autoProcScalingId,int,
   phasingAnalysisId,int,
   phasingStepType,enum,
   method,varchar,
   solventContent,varchar,
   enantiomorph,varchar,
   lowRes,varchar,
   highRes,varchar,
   recordTimeStamp,timestamp,
.. csv-table:: Phasing_has_Scaling,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   phasingHasScalingId,int,Primary key (auto-incremented)
   phasingAnalysisId,int,Related phasing analysis item
   autoProcScalingId,int,Related autoProcScaling item
   datasetNumber,int,serial number of the dataset and always reserve 0 for the reference
   recordTimeStamp,datetime,
.. csv-table:: PHPSession,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   id,varchar,
   accessDate,datetime,
   data,varchar,
.. csv-table:: PlateGroup,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   plateGroupId,int,
   name,varchar,
   storageTemperature,varchar,
.. csv-table:: PlateType,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   PlateTypeId,int,
   name,varchar,
   description,varchar,
   shape,varchar,
   rowCount,int,
   columnCount,int,
   experimentId,int,
.. csv-table:: Position,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   positionId,int,Primary key (auto-incremented)
   relativePositionId,int,relative position, null otherwise
   posX,double,
   posY,double,
   posZ,double,
   scale,double,
   recordTimeStamp,datetime,Creation or last update date/time
   X,double,
   Y,double,
   Z,double,
.. csv-table:: PreparePhasingData,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   preparePhasingDataId,int,Primary key (auto-incremented)
   phasingAnalysisId,int,Related phasing analysis item
   phasingProgramRunId,int,Related program item
   spaceGroupId,int,Related spaceGroup
   lowRes,double,
   highRes,double,
   recordTimeStamp,datetime,Creation or last update date/time
.. csv-table:: ProcessingJob,,From this we get both job times and lag times
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   processingJobId,int,
   dataCollectionId,int,
   displayName,varchar,xia2, fast_dp, dimple, etc
   comments,varchar,For users to annotate the job and see the motivation for the job
   recordTimestamp,timestamp,When job was submitted
   recipe,varchar,What we want to run (xia, dimple, etc).
   automatic,tinyint,Whether this processing job was triggered automatically or not
.. csv-table:: ProcessingJobImageSweep,,This allows multiple sweeps per processing job for multi-xia2
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   processingJobImageSweepId,int,
   processingJobId,int,
   dataCollectionId,int,
   startImage,mediumint,
   endImage,mediumint,
.. csv-table:: ProcessingJobParameter,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   processingJobParameterId,int,
   processingJobId,int,
   parameterKey,varchar,E.g. resolution, spacegroup, pipeline
   parameterValue,varchar,
.. csv-table:: Project,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   projectId,int,
   personId,int,
   title,varchar,
   acronym,varchar,
   owner,varchar,
.. csv-table:: Project_has_BLSample,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   projectId,int,
   blSampleId,int,
.. csv-table:: Project_has_DCGroup,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   projectId,int,
   dataCollectionGroupId,int,
.. csv-table:: Project_has_EnergyScan,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   projectId,int,
   energyScanId,int,
.. csv-table:: Project_has_Person,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   projectId,int,
   personId,int,
.. csv-table:: Project_has_Protein,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   projectId,int,
   proteinId,int,
.. csv-table:: Project_has_Session,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   projectId,int,
   sessionId,int,
.. csv-table:: Project_has_Shipping,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   projectId,int,
   shippingId,int,
.. csv-table:: Project_has_User,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   projecthasuserid,int,
   projectid,int,
   username,varchar,
.. csv-table:: Project_has_XFEFSpectrum,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   projectId,int,
   xfeFluorescenceSpectrumId,int,
.. csv-table:: Proposal,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   proposalId,int,
   personId,int,
   title,varchar,
   proposalCode,varchar,
   proposalNumber,varchar,
   bltimeStamp,timestamp,
   proposalType,varchar,Proposal type: MX, BX
   externalId,binary,
.. csv-table:: ProposalHasPerson,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   proposalHasPersonId,int,
   proposalId,int,
   personId,int,
   role,enum,
.. csv-table:: Protein,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   proteinId,int,
   proposalId,int,
   name,varchar,
   acronym,varchar,
   molecularMass,double,
   proteinType,varchar,
   personId,int,
   bltimeStamp,timestamp,
   isCreatedBySampleSheet,tinyint,
   sequence,text,
   MOD_ID,varchar,
   componentTypeId,int,
   concentrationTypeId,int,
   global,tinyint,
   externalId,binary,
   density,float,
   abundance,float,Deprecated
.. csv-table:: Protein_has_PDB,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   proteinhaspdbid,int,
   proteinid,int,
   pdbid,int,
.. csv-table:: Reprocessing,,From this we get both job times and lag times
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   reprocessingId,int,
   dataCollectionId,int,
   displayName,varchar,xia2, fast_dp, dimple, etc
   comments,varchar,For users to annotate the job and see the motivation for the job
   recordTimestamp,timestamp,When job was submitted
   recipe,varchar,What we want to run (xia, dimple, etc)
   automatic,tinyint,Whether this processing was triggered automatically or not
.. csv-table:: ReprocessingImageSweep,,This allows multiple sweeps per reprocessing for multi-xia2
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   reprocessingImageSweepId,int,
   reprocessingId,int,
   dataCollectionId,int,
   startImage,mediumint,
   endImage,mediumint,
.. csv-table:: ReprocessingParameter,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   reprocessingParameterId,int,
   reprocessingId,int,
   parameterKey,varchar,E.g. resolution, spacegroup, pipeline
   parameterValue,varchar,
.. csv-table:: RobotAction,,Robot actions as reported by GDA
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   robotActionId,int,
   blsessionId,int,
   blsampleId,int,
   actionType,enum,
   startTimestamp,timestamp,
   endTimestamp,timestamp,
   status,enum,
   message,varchar,
   containerLocation,smallint,
   dewarLocation,smallint,
   sampleBarcode,varchar,
   xtalSnapshotBefore,varchar,
   xtalSnapshotAfter,varchar,
.. csv-table:: Run,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   runId,int,
   timePerFrame,varchar,
   timeStart,varchar,
   timeEnd,varchar,
   storageTemperature,varchar,
   exposureTemperature,varchar,
   spectrophotometer,varchar,
   energy,varchar,
   creationDate,datetime,
   frameAverage,varchar,
   frameCount,varchar,
   transmission,varchar,
   beamCenterX,varchar,
   beamCenterY,varchar,
   pixelSizeX,varchar,
   pixelSizeY,varchar,
   radiationRelative,varchar,
   radiationAbsolute,varchar,
   normalization,varchar,
.. csv-table:: SafetyLevel,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   safetyLevelId,int,
   code,varchar,
   description,varchar,
.. csv-table:: SAFETYREQUEST,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   SAFETYREQUESTID,decimal,
   XMLDOCUMENTID,decimal,
   PROTEINID,decimal,
   PROJECTCODE,varchar,
   SUBMISSIONDATE,datetime,
   RESPONSE,decimal,
   REPONSEDATE,datetime,
   RESPONSEDETAILS,varchar,
.. csv-table:: SAMPLECELL,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   SAMPLECELLID,int,
   SAMPLEEXPOSUREUNITID,int,
   ID,varchar,
   NAME,varchar,
   DIAMETER,varchar,
   MATERIAL,varchar,
.. csv-table:: SAMPLEEXPOSUREUNIT,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   SAMPLEEXPOSUREUNITID,int,
   ID,varchar,
   PATHLENGTH,varchar,
   VOLUME,varchar,
.. csv-table:: SamplePlate,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   samplePlateId,int,
   BLSESSIONID,int,
   plateGroupId,int,
   plateTypeId,int,
   instructionSetId,int,
   boxId,int,
   name,varchar,
   slotPositionRow,varchar,
   slotPositionColumn,varchar,
   storageTemperature,varchar,
   experimentId,int,
.. csv-table:: SamplePlatePosition,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   samplePlatePositionId,int,
   samplePlateId,int,
   rowNumber,int,
   columnNumber,int,
   volume,varchar,
.. csv-table:: SaxsDataCollection,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   dataCollectionId,int,
   BLSESSIONID,int,
   experimentId,int,
   comments,varchar,
.. csv-table:: SAXSDATACOLLECTIONGROUP,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   DATACOLLECTIONGROUPID,int,
   DEFAULTDATAACQUISITIONID,int,
   SAXSDATACOLLECTIONARRAYID,int,
.. csv-table:: ScanParametersModel,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   scanParametersModelId,int,
   scanParametersServiceId,int,
   dataCollectionPlanId,int,
   sequenceNumber,tinyint,
   start,double,
   stop,double,
   step,double,
   array,text,
   duration,mediumint,Duration for parameter change in seconds
.. csv-table:: ScanParametersService,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   scanParametersServiceId,int,
   name,varchar,
   description,varchar,
.. csv-table:: Schedule,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   scheduleId,int,
   name,varchar,
.. csv-table:: ScheduleComponent,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   scheduleComponentId,int,
   scheduleId,int,
   offset_hours,int,
   inspectionTypeId,int,
.. csv-table:: SchemaStatus,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   schemaStatusId,int,
   scriptName,varchar,
   schemaStatus,varchar,
   recordTimeStamp,timestamp,
.. csv-table:: Screen,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   screenId,int,
   name,varchar,
   proposalId,int,
   global,tinyint,
.. csv-table:: ScreenComponent,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   screenComponentId,int,
   screenComponentGroupId,int,
   componentId,int,
   concentration,float,
   pH,float,
.. csv-table:: ScreenComponentGroup,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   screenComponentGroupId,int,
   screenId,int,
   position,smallint,
.. csv-table:: Screening,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   screeningId,int,
   dataCollectionId,int,
   bltimeStamp,timestamp,
   programVersion,varchar,
   comments,varchar,
   shortComments,varchar,
   diffractionPlanId,int,references DiffractionPlan
   dataCollectionGroupId,int,
   xmlSampleInformation,longblob,
.. csv-table:: ScreeningInput,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   screeningInputId,int,
   screeningId,int,
   beamX,float,
   beamY,float,
   rmsErrorLimits,float,
   minimumFractionIndexed,float,
   maximumFractionRejected,float,
   minimumSignalToNoise,float,
   diffractionPlanId,int,references DiffractionPlan table
   xmlSampleInformation,longblob,
.. csv-table:: ScreeningOutput,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   screeningOutputId,int,
   screeningId,int,
   statusDescription,varchar,
   rejectedReflections,int,
   resolutionObtained,float,
   spotDeviationR,float,
   spotDeviationTheta,float,
   beamShiftX,float,
   beamShiftY,float,
   numSpotsFound,int,
   numSpotsUsed,int,
   numSpotsRejected,int,
   mosaicity,float,
   iOverSigma,float,
   diffractionRings,tinyint,
   SCREENINGSUCCESS,tinyint,Column to be deleted
   mosaicityEstimated,tinyint,
   rankingResolution,double,
   program,varchar,
   doseTotal,double,
   totalExposureTime,double,
   totalRotationRange,double,
   totalNumberOfImages,int,
   rFriedel,double,
   indexingSuccess,tinyint,
   strategySuccess,tinyint,
.. csv-table:: ScreeningOutputLattice,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   screeningOutputLatticeId,int,
   screeningOutputId,int,
   spaceGroup,varchar,
   pointGroup,varchar,
   bravaisLattice,varchar,
   rawOrientationMatrix_a_x,float,
   rawOrientationMatrix_a_y,float,
   rawOrientationMatrix_a_z,float,
   rawOrientationMatrix_b_x,float,
   rawOrientationMatrix_b_y,float,
   rawOrientationMatrix_b_z,float,
   rawOrientationMatrix_c_x,float,
   rawOrientationMatrix_c_y,float,
   rawOrientationMatrix_c_z,float,
   unitCell_a,float,
   unitCell_b,float,
   unitCell_c,float,
   unitCell_alpha,float,
   unitCell_beta,float,
   unitCell_gamma,float,
   bltimeStamp,timestamp,
   labelitIndexing,tinyint,
.. csv-table:: ScreeningRank,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   screeningRankId,int,
   screeningRankSetId,int,
   screeningId,int,
   rankValue,float,
   rankInformation,varchar,
.. csv-table:: ScreeningRankSet,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   screeningRankSetId,int,
   rankEngine,varchar,
   rankingProjectFileName,varchar,
   rankingSummaryFileName,varchar,
.. csv-table:: ScreeningStrategy,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   screeningStrategyId,int,
   screeningOutputId,int,
   phiStart,float,
   phiEnd,float,
   rotation,float,
   exposureTime,float,
   resolution,float,
   completeness,float,
   multiplicity,float,
   anomalous,tinyint,
   program,varchar,
   rankingResolution,float,
   transmission,float,Transmission for the strategy as given by the strategy program.
.. csv-table:: ScreeningStrategySubWedge,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   screeningStrategySubWedgeId,int,Primary key
   screeningStrategyWedgeId,int,Foreign key to parent table
   subWedgeNumber,int,The number of this subwedge within the wedge
   rotationAxis,varchar,Angle where subwedge starts
   axisStart,float,Angle where subwedge ends
   axisEnd,float,Exposure time for subwedge
   exposureTime,float,Transmission for subwedge
   transmission,float,
   oscillationRange,float,
   completeness,float,
   multiplicity,float,
   RESOLUTION,float,
   doseTotal,float,Total dose for this subwedge
   numberOfImages,int,Number of images for this subwedge
   comments,varchar,
.. csv-table:: ScreeningStrategyWedge,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   screeningStrategyWedgeId,int,Primary key
   screeningStrategyId,int,Foreign key to parent table
   wedgeNumber,int,The number of this wedge within the strategy
   resolution,float,
   completeness,float,
   multiplicity,float,
   doseTotal,float,Total dose for this wedge
   numberOfImages,int,Number of images for this wedge
   phi,float,
   kappa,float,
   chi,float,
   comments,varchar,
   wavelength,double,
.. csv-table:: SessionType,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   sessionTypeId,int,
   sessionId,int,
   typeName,varchar,
.. csv-table:: Session_has_Person,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   sessionId,int,
   personId,int,
   role,enum,
   remote,tinyint,
.. csv-table:: Shipping,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   shippingId,int,
   proposalId,int,
   shippingName,varchar,
   deliveryAgent_agentName,varchar,
   deliveryAgent_shippingDate,date,
   deliveryAgent_deliveryDate,date,
   deliveryAgent_agentCode,varchar,
   deliveryAgent_flightCode,varchar,
   shippingStatus,varchar,
   bltimeStamp,datetime,
   laboratoryId,int,
   isStorageShipping,tinyint,
   creationDate,datetime,
   comments,varchar,
   sendingLabContactId,int,
   returnLabContactId,int,
   returnCourier,varchar,
   dateOfShippingToUser,datetime,
   shippingType,varchar,
   SAFETYLEVEL,varchar,
   deliveryAgent_flightCodeTimestamp,timestamp,Date flight code created, if automatic
   deliveryAgent_label,text,Base64 encoded pdf of airway label
   readyByTime,time,Time shipment will be ready
   closeTime,time,Time after which shipment cannot be picked up
   physicalLocation,varchar,Where shipment can be picked up from: i.e. Stores
   deliveryAgent_pickupConfirmationTimestamp,timestamp,Date picked confirmed
   deliveryAgent_pickupConfirmation,varchar,Confirmation number of requested pickup
   deliveryAgent_readyByTime,time,Confirmed ready-by time
   deliveryAgent_callinTime,time,Confirmed courier call-in time
   deliveryAgent_productcode,varchar,A code that identifies which shipment service was used
   deliveryAgent_flightCodePersonId,int,The person who created the AWB (for auditing)
.. csv-table:: ShippingHasSession,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   shippingId,int,
   sessionId,int,
.. csv-table:: SpaceGroup,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   spaceGroupId,int,Primary key
   spaceGroupNumber,int,ccp4 number pr IUCR
   spaceGroupShortName,varchar,short name without blank
   spaceGroupName,varchar,verbose name
   bravaisLattice,varchar,short name
   bravaisLatticeName,varchar,verbose name
   pointGroup,varchar,point group
   geometryClassnameId,int,
   MX_used,tinyint,1 if used in the crystal form
.. csv-table:: Specimen,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   specimenId,int,
   BLSESSIONID,int,
   bufferId,int,
   macromoleculeId,int,
   samplePlatePositionId,int,
   safetyLevelId,int,
   stockSolutionId,int,
   code,varchar,
   concentration,varchar,
   volume,varchar,
   experimentId,int,
   comments,varchar,
.. csv-table:: StockSolution,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   stockSolutionId,int,
   BLSESSIONID,int,
   bufferId,int,
   macromoleculeId,int,
   instructionSetId,int,
   boxId,int,
   name,varchar,
   storageTemperature,varchar,
   volume,varchar,
   concentration,varchar,
   comments,varchar,
   proposalId,int,
.. csv-table:: Stoichiometry,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   stoichiometryId,int,
   hostMacromoleculeId,int,
   macromoleculeId,int,
   ratio,varchar,
.. csv-table:: Structure,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   structureId,int,
   macromoleculeId,int,
   PDB,varchar,
   structureType,varchar,
   fromResiduesBases,varchar,
   toResiduesBases,varchar,
   sequence,varchar,
.. csv-table:: SubstructureDetermination,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   substructureDeterminationId,int,Primary key (auto-incremented)
   phasingAnalysisId,int,Related phasing analysis item
   phasingProgramRunId,int,Related program item
   spaceGroupId,int,Related spaceGroup
   method,enum,phasing method
   lowRes,double,
   highRes,double,
   recordTimeStamp,datetime,Creation or last update date/time
.. csv-table:: Subtraction,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   subtractionId,int,
   dataCollectionId,int,
   rg,varchar,
   rgStdev,varchar,
   I0,varchar,
   I0Stdev,varchar,
   firstPointUsed,varchar,
   lastPointUsed,varchar,
   quality,varchar,
   isagregated,varchar,
   concentration,varchar,
   gnomFilePath,varchar,
   rgGuinier,varchar,
   rgGnom,varchar,
   dmax,varchar,
   total,varchar,
   volume,varchar,
   creationTime,datetime,
   kratkyFilePath,varchar,
   scatteringFilePath,varchar,
   guinierFilePath,varchar,
   SUBTRACTEDFILEPATH,varchar,
   gnomFilePathOutput,varchar,
   substractedFilePath,varchar,
.. csv-table:: SubtractionToAbInitioModel,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   subtractionToAbInitioModelId,int,
   abInitioId,int,
   subtractionId,int,
.. csv-table:: SW_onceToken,,One-time use tokens needed for token auth in order to grant access to file downloads and webcams (and some images)
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   onceTokenId,int,
   token,varchar,
   personId,int,
   proposalId,int,
   validity,varchar,
   recordTimeStamp,timestamp,
.. csv-table:: UserGroup,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   userGroupId,int,
   name,varchar,
.. csv-table:: UserGroup_has_Permission,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   userGroupId,int,
   permissionId,int,
.. csv-table:: UserGroup_has_Person,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   userGroupId,int,
   personId,int,
.. csv-table:: v_dewar,,VIEW
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   proposalId,int,
   shippingId,int,
   shippingName,varchar,
   dewarId,int,
   dewarName,varchar,
   dewarStatus,varchar,
   proposalCode,varchar,
   proposalNumber,varchar,
   creationDate,datetime,
   shippingType,varchar,
   barCode,varchar,
   shippingStatus,varchar,
   beamLineName,varchar,
   nbEvents,bigint,
   storesin,bigint,
   nbSamples,bigint,
.. csv-table:: v_dewarBeamline,,VIEW
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   beamLineName,varchar,
   COUNT(*),bigint,
.. csv-table:: v_dewarBeamlineByWeek,,VIEW
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   Week,varchar,
   ID14,bigint,
   ID23,bigint,
   ID29,bigint,
   BM14,bigint,
.. csv-table:: v_dewarByWeek,,VIEW
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   Week,varchar,
   Dewars Tracked,bigint,
   Dewars Non-Tracked,bigint,
.. csv-table:: v_dewarByWeekTotal,,VIEW
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   Week,varchar,
   Dewars Tracked,bigint,
   Dewars Non-Tracked,bigint,
   Total,bigint,
.. csv-table:: v_dewarList,,VIEW
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   proposal,varchar,
   shippingName,varchar,
   dewarName,varchar,
   barCode,varchar,
   creationDate,varchar,
   shippingType,varchar,
   nbEvents,bigint,
   dewarStatus,varchar,
   shippingStatus,varchar,
   nbSamples,bigint,
.. csv-table:: v_dewarProposalCode,,VIEW
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   proposalCode,varchar,
   COUNT(*),bigint,
.. csv-table:: v_dewarProposalCodeByWeek,,VIEW
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   Week,varchar,
   MX,bigint,
   FX,bigint,
   BM14U,bigint,
   BM161,bigint,
   BM162,bigint,
   Others,bigint,
.. csv-table:: v_hour,,VIEW
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   num,varchar,
.. csv-table:: v_Log4Stat,,VIEW
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   id,int,
   priority,varchar,
   timestamp,datetime,
   msg,varchar,
   detail,varchar,
   value,varchar,
.. csv-table:: v_logonByHour,,VIEW
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   Hour,varchar,
   Distinct logins,bigint,
   Total logins,bigint,
.. csv-table:: v_logonByHour2,,VIEW
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   Hour,varchar,
   Distinct logins,bigint,
   Total logins,bigint,
.. csv-table:: v_logonByMonthDay,,VIEW
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   Day,varchar,
   Distinct logins,bigint,
   Total logins,bigint,
.. csv-table:: v_logonByMonthDay2,,VIEW
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   Day,varchar,
   Distinct logins,bigint,
   Total logins,bigint,
.. csv-table:: v_logonByWeek,,VIEW
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   Week,varchar,
   Distinct logins,bigint,
   Total logins,bigint,
.. csv-table:: v_logonByWeek2,,VIEW
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   Week,varchar,
   Distinct logins,bigint,
   Total logins,bigint,
.. csv-table:: v_logonByWeekDay,,VIEW
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   Day,varchar,
   Distinct logins,bigint,
   Total logins,bigint,
.. csv-table:: v_logonByWeekDay2,,VIEW
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   Day,varchar,
   Distinct logins,bigint,
   Total logins,bigint,
.. csv-table:: v_monthDay,,VIEW
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   num,varchar,
.. csv-table:: v_run,,VIEW
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   runId,int,
   run,varchar,
   startDate,datetime,
   endDate,datetime,
.. csv-table:: v_sample,,VIEW
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   proposalId,int,
   shippingId,int,
   dewarId,int,
   containerId,int,
   blSampleId,int,
   proposalCode,varchar,
   proposalNumber,varchar,
   creationDate,datetime,
   shippingType,varchar,
   barCode,varchar,
   shippingStatus,varchar,
.. csv-table:: v_sampleByWeek,,VIEW
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   Week,varchar,
   Samples,bigint,
.. csv-table:: v_week,,VIEW
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   num,varchar,
.. csv-table:: v_weekDay,,VIEW
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   day,varchar,
.. csv-table:: Workflow,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   workflowId,int,Primary key (auto-incremented)
   workflowTitle,varchar,
   workflowType,enum,
   workflowTypeId,int,
   comments,varchar,
   status,varchar,
   resultFilePath,varchar,
   logFilePath,varchar,
   recordTimeStamp,datetime,Creation or last update date/time
   workflowDescriptionFullPath,varchar,Full file path to a json description of the workflow
.. csv-table:: WorkflowMesh,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   workflowMeshId,int,Primary key (auto-incremented)
   workflowId,int,Related workflow
   bestPositionId,int,
   bestImageId,int,
   value1,double,
   value2,double,
   value3,double,N value
   value4,double,
   cartographyPath,varchar,
   recordTimeStamp,timestamp,Creation or last update date/time
.. csv-table:: WorkflowStep,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   workflowStepId,int,
   workflowId,int,
   type,varchar,
   status,varchar,
   folderPath,varchar,
   imageResultFilePath,varchar,
   htmlResultFilePath,varchar,
   resultFilePath,varchar,
   comments,varchar,
   crystalSizeX,varchar,
   crystalSizeY,varchar,
   crystalSizeZ,varchar,
   maxDozorScore,varchar,
   recordTimeStamp,timestamp,
.. csv-table:: WorkflowType,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   workflowTypeId,int,
   workflowTypeName,varchar,
   comments,varchar,
   recordTimeStamp,timestamp,
.. csv-table:: XFEFluorescenceSpectrum,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   xfeFluorescenceSpectrumId,int,
   sessionId,int,
   blSampleId,int,
   jpegScanFileFullPath,varchar,
   startTime,datetime,
   endTime,datetime,
   filename,varchar,
   exposureTime,float,
   beamTransmission,float,
   annotatedPymcaXfeSpectrum,varchar,
   fittedDataFileFullPath,varchar,
   scanFileFullPath,varchar,
   energy,float,
   beamSizeVertical,float,
   beamSizeHorizontal,float,
   crystalClass,varchar,
   comments,varchar,
   blSubSampleId,int,
   flux,double,flux measured before the xrfSpectra
   flux_end,double,flux measured after the xrfSpectra
   workingDirectory,varchar,
.. csv-table:: XRFFluorescenceMapping,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   xrfFluorescenceMappingId,int,
   xrfFluorescenceMappingROIId,int,
   dataCollectionId,int,
   imageNumber,int,
   counts,int,
.. csv-table:: XRFFluorescenceMappingROI,,
   :header: "Column", "Type", "Comment"
   :widths: 20, 10, 30

   xrfFluorescenceMappingROIId,int,
   startEnergy,float,
   endEnergy,float,
   element,varchar,
   edge,varchar,In future may be changed to enum(K, L)
   r,tinyint,R colour component
   g,tinyint,G colour component
   b,tinyint,B colour component
