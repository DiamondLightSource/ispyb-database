=======
History
=======

Unreleased / master
-------------------

4.7.0 (2025-05-12)
-------------------

New or modified tables, columns, lookup values:

- New table ``BLSamplePosition``
- Add a ``blSampleId`` FK to the ``XrayCentringResult`` table
- Add ``angularEfficiency`` and ``suggestedTilt`` columns to ``ParticleClassification``
- Recreate FK constraints referencing ``LabContact(labContactId)`` with 'on delete set null
- Make ``Shipping`` FK ``deliveryAgent_flightCodePersonId`` "on delete set null"

Roles and permissions:

- Add new grants for Expeye 
- Add new permissions for ``ispyb_propagation``
- Add new permissions for ``ispyb_scripts_processing.sql``

Stored procedures:

- Also return sample locations for ``update_container_assign``

4.6.0 (2025-03-06)
-------------------

New columns:

- Add a ``dewarRegistryId`` FK to the ``Dewar`` table

Data in lookup tables:

- Add 'Atlas' experiment type

Stored procedures:

- Remove superfluous commit in procedure ``upsert_processing_program``
- New procedure ``upsert_processing_program_v2`` with additional param for pipeline ID

Permissions:

- Add ``SELECT`` grant for Expeye role on table ``AutoProcIntegration``
- Add ``EXECUTE`` grant for processing role on new procedure ``upsert_processing_program_v2``

4.5.0 (2025-02-25)
-------------------

New or modified tables and columns:

- Add ``purgedProcessedData`` boolean column to the ``BLSession`` table. This is
a flag to indicate whether the ``processed`` folder in the associated visit
directory has been purged.

4.4.0 (2025-01-29)
-------------------

New or modified tables and columns:

- Add ``binnedPixelSize`` column to the ``ParticleClassificationGroup`` table
- Add ``gridSquareId`` column to the ``Tomogram`` table

4.3.0 (2024-12-05)
-------------------

Note: The schema files now include a command in the first line to set the sanbox
mode which is incompatible with older clients. For more info and to disable, see:
https://mariadb.org/mariadb-dump-file-compatibility-change/

Admin: Changes to GitHub workflows as 'main' is now the default branch (previously 'master')

New or modified tables and columns:

- Add ``processingPipelineId`` column to the ``AutoProcProgram`` table
- Add new boolean column ``deleted`` to the ``AutoProcProgramAttachment`` table
- Add unique index on ``BLSample(containerId, location, subLocation)``
- Update the ``ProcessedTomogram`` table comment

Roles and permissions:

- Add new grants for Expeye and combine grants into two roles instead of three
- Add roles and grants for MaxScale
- Add role with grants for fragment screening

Scripts and data changes:

- Trim trailing '1' in the ``SpaceGroup`` table's ``spaceGroupShortName`` column
- Add scripts that can delete ``DataCollection`` and ``DataCollectionGroup`` rows and referenced rows in other tables

4.2.1 (2024-08-19)
-------------------

Roles and permissions: Granted ``SELECT``, ``INSERT``, ``UPDATE`` on ``ProcessedTomogram``
for ``ispyb_processing``

4.2.0 (2024-08-14)
-------------------

Roles and permissions:  grants files for new ispyb expeye roles

New or modified tables, columns, lookup values:

- New table ``ProcessedTomogram``
- New rows for 'VMXm-Cartridge' and 'VMXm-Cartridge' in the ``ContainerType`` table
- New FK column ``ownerId`` (references ``Person.personId``) in the ``BLSampleGroup`` table
- New 'Metal ID' enum item in ``DiffractionPlan.experimentKind``
- New 'Metal ID' enum item in ``DataCollectionGroup.experimentType``
- New row for 'Metal ID' (for MX) in ``ExperimentType`` table

Stored procedures: ``upsert_dc_group_v3`` now populates ``DataCollectionGroup.experimentTypeId`` based on ``p_experimenttype``

New script to perform LVM snapshot-based backup

4.1.0 (2024-03-26)
-------------------

New or modified tables and columns:

- New table ``Atlas``
- New table ``GridSquare``
- New Table ``FoilHole``
- In table ``Movie``: New columns ``foilHoleId`` and ``templateLabel``
- In table ``Shipping``: New column ``source`` and ``externalShippingIdToSynchrotron``
- In table ``Dewar``: New column ``source`` and ``externalShippingIdFromSynchrotron``
- In table ``Container``: New column ``source``
- In table ``BLSample``: New column ``source``
- In table ``AutoProcProgramMessage``: Make column ``severity`` not nullable
- In table ``ContainerQueue``: Make column ``containerId`` not nullable

Indexes:

- In table ``BLSubSample``: Replace ``blSampleId`` FK index with compound index ``(blSampleId, source)``
- In table ``ProcessingJobParameter``: Add compund index (parameterKey, processingJobId)
- In table ``AutoProc``: Remove ``spaceGroup`` from compound index ``(refinedCell_a, refinedCell_b, refinedCell_c, refinedCell_alpha, refinedCell_beta, refinedCell_gamma)``

Roles and permissions:

- Granted SELECT, INSERT, UPDATE on ``BFactorFit``, ``Atlas``, ``GridSquare``, ``FoilHole`` for ``ispyb_processing``
- Added new role ``ispyb_propagation`` and granted SELECT, UPDATE, INSERT, DELETE on relevant tables

4.0.1 (2024-01-09)
-------------------

* Modify stored procedure ``upsert_session_for_proposal_code_number`` to remove
  references in queries to previously removed ``BLSession`` columns.

4.0.0 (2024-01-08)
-------------------

* Add stored procedure ``retrieve_grid_info_for_dc_v2`` similar to
  ``retrieve_grid_info_for_dc``, but with micronsPerPixelX,Y columns instead of
  pixelsPerMicronX,Y.

* Removed columns in ``BLSession``: projectCode, sessionTitle,
  structureDeterminations, dewarTransport, databackupFrance, databackupEurope,
  expSessionPk, operatorSiteNumber, protectedData

* Remove columns in ``DataCollectionGroup``: ``workflowId``

* Remove tables: Pod, PHPSession, Log4Stat, Particle, EMMicroscope, DataReductionStatus,
  SAFETYREQUEST, SAMPLECELL, SAMPLEEXPOSUREUNIT, SAXSDATACOLLECTIONGROUP,
  WorkflowStep, WorkflowType, WorkflowMesh, Workflow, AssemblyRegion,
  AssemblyHasMacromolecule, Assembly, Structure, SubtractionToAbInitioModel,
  MeasurementToDataCollection, Instruction, Merge, Measurement, AbInitioModel,
  ModelToList, Model, ModelList, FrameSet, Run, FrameToList, Frame, FrameList,
  BufferHasAdditive, MeasurementUnit, MacromoleculeRegion, Subtraction,
  Stoichiometry, Additive, Specimen, StockSolution, Buffer, Macromolecule,
  SafetyLevel, SamplePlatePosition, SamplePlate, PlateGroup, InstructionSet,
  PlateType, SaxsDataCollection, Experiment.

3.0.0 (2023-11-16)
-------------------

* Tables:

  * Drop: ``MotionCorrectionDrift`` and remove it from schema files
  * Add: ``BFactorFit`` with foreign key referencing ``ParticleClassification``

* Columns and keys:

  * Make ``Dewar.shippingId`` not nullable
  * Add: bFactorFit-related columns in ``ParticleClassification``
  * Add: self-referenting foreign key column ``parentContainerId`` in ``Container`` to allow hierarchy of ``Container``s
  * Add: ``containerTypeId`` foreign key column for the ``Screen`` table
  * Add: ``manufacturerSerialNumber`` in ``DewarRegistry`` table
  * Add: ``EORINumber`` column in ``Laboratory`` table to help with international shipping
  * Add: ``riskRating`` enum column to the ``BLSession`` table to hold the ERA status
  * Add: ``globalAlignmentQuality`` in ``Tomogram``
  * Add unique key for ``ContainerRegistry.barcode`` and make it not nullable
  * Extend ``BLSession.beamLineOperator`` to 255 characters

* Stored procedures:

  * Drop: ``upsert_motion_correction_drift``, remove procedure file and remove it from the schema files
  * Add: ``upsert_adminvar`` to upsert rows in the ``AdminVar`` table
  * Add: ``update_reg_container_barcode``
  * Add: ``update_session_enddate``

* Misc:

  * Add: maintenance script to delete a given number of rows from a table, and then rebuild the table to reclaim the space for the OS
  * Add: maintenance script to update BLSample.subLocation via a cursor in order to remove rows with duplications of (containerId, location, subLocation)
  * Add: ``SELECT`` grants on ``ProcessingJob``, ``ProcessingJobImageSweep`` tables for role ``ispyb_scripts_processing``

2.1.0 (2023-06-05)
-------------------

* New stored procedure ``upsert_dc_grid_v2`` and ``EXECUTE`` permission on it for the relevant role

2.0.0 (2023-05-15)
-------------------

Removed procedures relating to old ``XrayCentringResult`` table removed in 1.36.0 (contributed by @DominicOram)

New and modified columns:

* In the ``Dewar`` table: ``extra`` JSON column for facility-specific or hard-to-define attributes.
* In the ``ParticleClassification`` table: ``selected`` boolean to indicate that the class has been selected for further processing.

1.36.1 (2023-04-17)
-------------------

Bug fix: The file name of an update .sql file didn't correspond with the name it inserted into the ``SchemaStatus`` table.

1.36.0 (2023-04-17)
-------------------

* New tables for storing X-ray centring results (contributed by @rjgildea):

  * ``XrayCentring``
  * ``XrayCentringResult`` (replaces unused/legacy ``XrayCentringResult`` table)

* New columns:

  * In ``Detector`` table: ``numberOfROIPixelsX`` + ``numberOfROIPixelsY`` (for ROI mode)
  * In ``GridInfo`` table: ``micronsPerPixelX`` + ``micronsPerPixelY`` (these will eventually replace ``pixelsPerMicronX`` and ``pixelsPerMicronY``)

* New tables to hold configuration parameters for searching LDAP:

  * ``LDAPSearchParameters``
  * ``LDAPSearchBase``
  * ``UserGroup_has_LDAPGroup``

* Stored procedures:

  * New procedure ``update_sample_append_staff_comments``
  * Modified procedure ``retrieve_dc_group`` now also returns ``proposalCode``, ``proposalNumber`` and ``sessionNumber``
  * Modified procedures ``upsert_dcg_grid`` and ``upsert_dc_grid`` so they additionally write to the new ``GridInfo`` columns

* Build (contributed by @garryod):

  * Added Dockerfile to create container image
  * Tagged releases are now published to the Github Container Registry

* Tools (contributed by @gfrn):

  * Script ``bin/export_session.sh`` now also exports tables relatd to EM SPA and EM tomography

1.35.0 (2023-02-28)
-------------------

* New tables, rows and enum options for SSX (serial crystallography):

  * Table ``SSXDataCollection``
  * Table ``Component``
  * Table ``SampleComposition``
  * Table ``CrystalComposition``
  * Table ``EventChain``
  * Table ``EventType``
  * Table ``Event``
  * Rows for ``EventType``, ``ComponentType``, ``ExperimentType``
  * Enum options in ``DataCollectionGroup.experimentType``: 'Still' (not for SSX), 'SSX-Chip', 'SSX-Jet'

* Turn on column compression for ``PDB.contents``. (This is a slow operation which takes several minutes on a table with thousands of rows.)
* Drop unneccessary column ``Tomogram.processingJobId``.

1.34.1 (2023-01-19)
-------------------

* Add ``EXECUTE`` perm on procedure ``update_dc_append_comments`` to 'ispyb_processing' role.

1.34.0 (2023-01-16)
-------------------

Table/column changes:

* Table ``Tomogram``: Extra path and file columns

Stored procedures:

* New procedure ``update_container_dispose`` to mark a container as disposed
* New procedure ``update_dc_append_comments`` to append text to the comments column in a data collection

Grants & roles:

* Add ``EXECUTE`` perms on new procedures to relevant roles
* Create role ispyb_web_verify_tests + grants for verifying data written by with ispyb_web
* Add missing grant for ispyb_web role

Scripts:

* Add new script ``mdb_cluster_health.sh`` to display info about MariaDB Galera cluster health
* ``mdb_cluster_backup.sh``: Misc tweaks
* ``build.sh``: Add import of new grants + document in README

1.33.0 (2022-11-02)
-------------------

Table/column changes:

* Table ``Shipping``: Add column ``extra`` (JSON)
* Table ``BLSample_has_DataCollectionPlan``: Change datatype of ``planOrder`` to smallint unsigned
* Table ``BLSession``: Drop left-behind constraint

Data:

* Table ``ExperimentType``: Insert rows for 'em' proposalTypes 'Tomography' and 'Single Particle'
* Table ``ContainerType``: Set correct capacity for Block-4

Stored procedures:

* Procedure ``update_container_assign``: Add ``proposalCode``, ``proposalNumber`` to returned result

* Grants:

  * Add ``SELECT``, ``INSERT``, ``UPDATE`` perms on ``ProcessingJob`` + ``ProcessingJobParameter`` tables for ``ispyb_processing`` role

Other:

* Scripts: Add extra mariabackup options to ``mdb_cluster_backup.sh``
* Analysis schema: Create and populate ``SummaryResults`` table

1.32.0 (2022-08-25)
-------------------

* More grants files with new roles
* Stored procedure: Changed datatype from float to double for parameter ``p_flux`` in ``upsert_dc``
* Tables and columns:

  * ``DiffractionPlan``: Add JSON column ``scanParameters``
  * ``GridInfo``: Add columns patchesX and patchesY
  * New table ``BLSampleImage_has_Positioner`` linking ``BLSampleImage`` and ``Positioner``


1.31.0 (2022-08-08)
-------------------

Stored procedures:

* Existing proc ``insert_subsample_for_image_full_path`` now also populates ``BLSubSample.blSampleImageId``. (Existing ``BLSubSample`` rows can be back-populated with values for the column through the ``2022_07_17_BLSubSample_update_blSampleImageId.sql`` script.)
* New proc ``insert_subsample_for_image_full_path_v2`` has an additional parameter ``p_experiment_type`` used to create a ``DiffractionPlan`` for the ``BLSubSample``.

Views:

* New analytics views: ``Protein``, ``Crystal``, ``PDBEntry``

Roles and grants:

* New role ``ispyb_scripts_processing`` for processing scripts
* Grants for new tables ``Tomogram`` and ``TiltImageAlignment``
* Grants for above new analytics views


1.30.0 (2022-06-22)
-------------------

New tables (for cryo-ET and electrin diffraction):

* ``Tomogram``: For storing per-sample, per-position data analysis results (reconstruction)
* ``TiltImageAlignment``: For storing per-movie analysis results (reconstruction)

New columns (for cryo-ET and electron diffraction):

* angle
* fluence
* numberOfFrames

Other changes:

* Add JNB (Jupyter Notebook) option to ``app`` enum in ``Pod`` table
* Add execute privilege to ``ispyb_acquisition`` role on:
  * procedure ``upsert_dc``
  * function ``retrieve_visit_id``

* Make it possible to delete from ``BeamCalendar`` without deleting ``BLSessions`` (no longer cascading delete)
* Add index on ``recordTimeStamp`` in ``SW_onceToken``


1.29.0 (2022-02-14)
-------------------

Tables and columns:

* New column ``currentDewarId`` in ``Container`` and ``ContainerHistory`` (and modified relevant stored procedures to populate this)
* ``Container`` table: Made xia2/DIALS the default pipeline
* New table ``Pod``: Status tracker for k8s pods launched from SynchWeb
* Updated ``XChemDB`` schema

Stored procedures:

* ``insert_subsample_for_image_full_path``: Abort if missing mandatory arguments or ``p_imageFullPath`` not found
* New sproc ``update_container_current_dewar_id`` to set the ``currentDewarId`` for a ``Container``
* New sproc ``update_container_unqueue`` to un-queue a container while allowing its samples/points to be re-queued later
* New sproc ``upsert_container_report`` to upsert container reports

Grants:

* Write permissions on ``MXMRRun*`` tables for ``ispyb_processing``
* Execute grant on ``update_container_current_dewar_id`` for ``ispyb_touchscreen`` role
* Execute grant on new sproc ``update_container_unqueue`` for ``ispyb_acquisition``


1.28.0 (2021-11-23)
-------------------

Table/data changes:

* Added unique index on ``BLSampleImage.imageFullPath`` to improve perf. of proedure ``upsert_sample_image_auto_score``
* Changes to ``MXMRRun``, ``MXMRRunBlob``: allow storing Anode results + more relevant molecular replacement output
* Back populate ``BLSampleGroup.proposalId`` where this is NULL

Stored procedure changes:

* New procedure ``finish_container_for_id`` to set the ``ContainerQueue`` ``completedTimeStamp``
* Updated ``retrieve_scm_containers_for_session`` so its param ``p_status`` matches on NULL
* Updated comment for procedure ``finish_container``
* Updated procedure ``upsert_mr_run`` and function ``upsert_mrrun`` to work with changes to ``MXMRRun`` tables
* New procedure ``upsert_session_has_person_for_session_and_login``
* New procedure ``insert_usergroup_has_person_for_ug_and_login``
* New procedure ``delete_usergroup_has_person_for_login``

Other misc. changes:

* Exec grants for new procedure
* Role and grants for 'touchscreen' role
* Removed doc files which are not needed in the repo
* Modified ``build.sh`` so it writes table + sproc docs to ``/tmp/`` and converts to HTML
* Add previously missed admin procedures to ``routines.sql``


1.27.0 (2021-09-15)
-------------------

Added cryoEM table ``RelativeIceThickness`` to record relative ice thickness values per micrograph.

Grants for this table have been added to the relevant scripts.


1.26.0 (2021-08-31)
-------------------

Column changes:

* Add a source column to the PDB table

Stored procedure changes:

* New stored procedure ``update_dewar_comments_json_merge`` to JSON merge the Dewar comments with a parameter
* Add 'plan' prefix to new DCPlan column aliases in ``retrieve_scm_sample*`` stored procedures (bug)

Lookup table data changes:

* Fill in some missing properties for container types


1.25.1 (2021-07-28)
-------------------

Return additional columns in the ``retrieve_scm_sample*`` stored procedures:

* qMin
* qMax
* reductionParametersAveraging

1.25.0 (2021-07-26)
-------------------

New versions of stored procedures:

* ``upsert_particle_picker_v2`` - new parameter ``p_summaryImageFullPath``
* ``upsert_particle_classification_v2`` - new parameter ``p_classDistribution``


1.24.0 (2021-07-23)
-------------------

Column changes:

* In ``Screening``: new column ``autoProcProgramId``
* In ``AutoProcScalingStatistics``: new column ``resIOverSigI2`` (resolution where I/Sigma(I) equals 2)
* In ``AutoProcProgram``: removed column ``dataCollectionId`` and its foreign key constraint
* In ``ProposalHasPerson``: added enum option 'Associate' to the role column
* In ``Session_has_Person``: added enum option 'Associate' to the role column

Added tables:

* ``Positioner``: An arbitrary positioner and its value, could be e.g. a motor. Allows for instance to store some positions with a sample or subsample
* ``BLSample_has_Positioner``
* ``BLSubSample_has_Positioner``

Stored procedure changes:

* ``upsert_session_for_proposal_code_number``: This is now truly an "upsert" procedure, as it allows specifying an existing session either through p_id OR through p_proposalCode + p_proposalNumber + p_visitNumber.
* ``insert_processing_scaling_v2``: Version 2 of ``insert_processing_scaling`` which allows writing to the new ``AutoProcScalingStatistics.resIOverSigI2`` column.

Grants for the new stored procedure and some table grants have also been added.

1.23.0 (2021-07-07)
-------------------

New columns:

* ``DiffractionPlan``: ``qMin``, ``qMax``, ``reductionParametersAveraging``
* ``ParticleClassification``: ``classDistribution``
* ``ParticlePicker``: ``summaryImageFullPath``
* ``BLSampleGroup``: ``proposalId`` (and populate it based on ``BLSampleGroup_has_BLSample -> BLSample -> Crystal -> Protein.proposalId``)

New tables:

* ``zc_ZocaloBuffer``: A table for temporary Zocalo data.

Lookup table data changes:

* ``SpaceGroup``: Changed a few ``spaceGroupShortName`` values for common spacegroups, and set ``MX_used = 0`` for less commonly used spacegroups.
* ``UserGroup``: Add groups ``detector_admin``, ``prop_admin``, ``goods_handling``, ``imaging_admin``, ``spectroscopy_admin``, ``mm_admin``.

Additionally, new enum options have been added to DataCollectionGroup.experimentType: Mesh3D, Screening.

1.22.0 (2021-05-28)
-------------------

New stored programs:

* Function retrieve_proposal_title_v2
* Procedure upsert_mx_sample

1.21.2 (2021-05-20)
-------------------

* Updated ``schemas/ispyb/routines.sql`` with the changes to stored procedure ``retrieve_sample sproc``.

1.21.1 (2021-05-19)
-------------------

* Stored procedure changes:

  * Additional ``DataCollection`` columns are returned by the ``retrieve_dc`` procedure.

1.21.0 (2021-05-14)
-------------------

* Table changes:

  * The FK constraint for Dewar.firstExperimentId has been changed to ``ON DELETE SET NULL ON UPDATE CASCADE``.
  * The data type of the ``ParticleClassification.rotationAccuracy`` column has been changed from ``int unsigned`` to ``float``.
  * In ``DataCollection``: Added new column ``dataCollectionPlanId`` with FK constraint referencing the table currently known as ``DiffractionPlan``.
  * In ``ContainerQueueSample``: Added new columns ``status``, ``startTime``, ``endTime``, ``dataCollectionPlanId`` and ``blSampleId`` with FK constraints for the two latter ones.

* New stored procedures for cryo EM:

  * ``upsert_particle_picker``
  * ``upsert_particle_classification_group``
  * ``upsert_particle_classification``
  * ``insert_cryoem_initial_model``
  * Grants for these have been added to the ``grants/ispyb_processing.sql`` file.

* New stored procedures for MX and other disciplines:

  * ``insert_aperture``
  * ``insert_crystal``
  * ``insert_dc_plan``
  * ``insert_position``
  * ``retrieve_apertures_using_size``
  * ``retrieve_container``
  * ``retrieve_dcs_for_sample``
  * ``retrieve_quality_indicators``
  * ``retrieve_robot_actions_for_sample``
  * ``retrieve_screenings_for_sample``
  * ``retrieve_xfe_fluo_ids_for_sample``
  * A new role ispyb_gda_mxcx has been created with execute grants on these procedures.

* Modified stored procedures:

  * ``retrieve_dc``: Added extra column ``id`` (which is an alias for the primary key).
  * ``retrieve_scm_samples_for_container_id``: Only indentation changes, no real changes.

1.20.1 (2021-04-20)
-------------------

- ``xchem_db`` schema is now part of the release archive file
- ``retrieve_dc_plans_for_sample`` sproc: add ``sampleOrderInPlan`` field to result-set
- Redefined which tables are lookup tables
- Code refactoring of ``bin/backup.sh`` and ``bin/export_session.sh``
- ``schemas/ispyb/data.sql``: Set ``planOrder`` for rows in ``BLSample_has_DataCollectionPlan`` table

1.20.0 (2021-04-13)
-------------------

* Tables, views and indices:

  * New cryoEM table ``ParticleClassificationGroup``. Some columns were moved to this table from ``ParticlePicker`` and ``ParticleClassification``.
  * Add ``capillary`` as enum option to ``BLSampleGroup_has_BLSample.type``
  * XChem DB: First version of schema for production (not part of release)
  * Analytics schema: Add access to all lookup tables, ``RobotAction``, ``ProcessingJob*``, ``Protein`` tables through views
  * Drop duplicate indices, add missing indices that existed only in DLS prod

* Data in lookup tables:

  * Add additional container types: some historical, some new
  * Update ``ExperimentType.proposalType``: Change scm to saxs, MX to mx
  * Update ``ContainerType.proposalType``: Change scm to saxs
  * Add two XPDF and five MX container types
  * Update ``SpaceGroup`` table: Remove newlines in names. Set ``MX_used`` = 1 for all SGs.

* Stored procedures:

  * ``retrieve_scm_*``: Preferentially get experiement type and container type+capacity from new lookup tables ``ExperimentType`` and ``ContainerType``, otherwise fall-back to ``experimentType`` and ``containerType``+``capacity`` columns in the ``Container`` table.
  * ``upsert_sample_image``: set ``BLSampleImage.modifiedTimeStamp`` if the upsert is an update

* Tools and documentation:

  * New script ``bin/missed_updates.sh`` to identify update .sql files that haven't been run
  * ``bin/backup.sh``: Use ``--add-drop-trigger`` flag to drop trigger if exists before creation
  * ``CONTRIBUTING.md``: Simplify pull request procedure for table changes
  * Updated simplified MX database diagram files
  * Move list + string with lookup tables to separate file so it can be reused
  * All bash scripts have been given new shebang lines to run on systems where bash is not at ``/bin/bash``.

* Users, roles and grants:

  * More ``INSERT`` grants for ``ispyb_web`` role: DC, DCG, ``ProcessingJob``, ``ProcessingJobParameter``
  * New ``ispyb_ro_nopii`` role (read-only-except-PII)

1.19.0 (2021-03-05)
-------------------

* Add new tables for CryoEM - note that these are still subject to potentially significant change:

  * ``ParticlePicker``
  * ``ParticleClassification``: Results of 2D or 2D classification
  * ``CryoemInitialModel``: Initial cryo-EM model generation results
  * ``ParticleClassification_has_CryoemInitialModel``
* Add old tables that exist in prod database, but not yet in repo:

  * ``BF_automationFault``: Software faults, stacktrace, severity etc.
  * ``BF_automationError``: Lookup table used by ``BF_automationFault``
* Add ``ContainerType`` table and foreign key referencing it in ``Container`` table

1.18.0 (2021-02-22)
-------------------

* Add ``upsert_dc_grid`` and ``retrieve_grid_info_for_dc`` stored procedures for
  inserting/retrieving ``GridInfo`` entries via a ``dataCollectionId`` rather than
  ``dataCollectionGroupId``.
* Add ``staffComments`` to ``BLSample`` table.
* Add ``offsetX`` and ``offsetY`` to ``BLSampleImage`` table.
* Add ``type`` to ``BLSubSample`` table.
* Add ``preferredDataCentre`` to ``BeamLineSetup`` table.
* Add ``params`` option to ``fileType`` enum in ``DataCollectionFileAttachment`` table.
* Add ``XRF map``, ``Energy scan``, ``XRF spectrum`` and ``XRF map xas`` options to ``experimentType`` enum in ``DataCollectionGroup`` table.
* Modify ``strategyOption`` column in ``DiffractionPlan`` table to make it a varchar(200) with json_valid check.
* Add ``MOSAIC`` option to ``actionType`` enum in ``RobotAction`` table.
* Re-design unused tables ``XRFFluorescenceMapping`` and ``XRFFluorescenceMappingROI``.
* Add new table ``XFEFluorescenceComposite``.
* Re-create ``upsert_fluo_mapping`` and ``upsert_fluo_mapping_roi`` to work with the re-designed tables.
* Modify ``upsert_quality_indicators`` stored procedure so that the ``p_autoProcProgramId`` parameter is used.


1.17.1 (2021-01-13)
-------------------
* ``ispyb_analytics`` schema:

  * Added ``Proposal`` and ``AutoProc*`` views, fixed bugs in view
  * Added data_scientist role and grants

* The script for generating the list of procs now writes the result to the client instead of the server. This way a non-local or Docker MariaDB instance can be used.

1.17.0 (2020-12-30)
-------------------

* Renamed ``schema/`` directory to ``schemas/ispyb/``
* Added ``schemas/ispyb-analytics/`` with its own ``build.sh`` script and so on.
* Allow database name ``$db`` to be defined outside of the main ``build.sh`` script.
* Add a ``BLSubSample`` source enum to help us distinguish between sub-samples created by users and by e.g. CHiMP.
* Stored procedure to populate ``BLSubSample`` for a given sample image file - to be used by the Python API.
* Add ``collectionMode`` and ``priority`` to ``DiffractionPlan`` table.
* Add missing ``experimentTypeId`` foreign key to ``Container`` table.
* Updated ``README.md`` and ``CONTRIBUTING.md``.
* Create new indexes on ``AutoProc table`` to improve unit cell search

1.16.0 (2020-12-04)
-------------------

(This is not a complete list of features for this version)

* Stored procedures for the IspybScmApi interface of gda-ispyb-api:

  * ``retrieve_scm_sample(p_id int unsigned, p_useContainerSession boolean, p_authLogin varchar(45))``
  * ``retrieve_scm_samples_for_container_id(p_containerId int unsigned, p_useContainerSession boolean, p_authLogin varchar(45))``
  * ``retrieve_scm_sample_for_container_barcode_and_location(p_barcode varchar(45), p_location varchar(45), p_useContainerSession boolean, p_authLogin varchar(45))``
  * ``retrieve_scm_container(p_id int unsigned, p_useContainerSession boolean, p_authLogin varchar(45))``
  * ``retrieve_scm_container_for_barcode(p_barcode varchar(45), p_useContainerSession boolean, p_authLogin varchar(45))``
  * ``retrieve_scm_containers_for_session(p_proposalCode varchar(45), p_proposalNumber varchar(45), p_sessionNumber int unsigned, p_status varchar(45), p_authLogin varchar(45))``
