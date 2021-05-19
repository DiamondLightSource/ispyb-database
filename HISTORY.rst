=======
History
=======

Unreleased / master
-------------------

1.21.1 (2021-05-19)
-------------------

* Stored procedure changes:

  * Additional `DataCollection` columns are returned by the `retrieve_dc` procedure.

1.21.0 (2021-05-14)
-------------------

* Table changes:

  * The FK constraint for Dewar.firstExperimentId has been changed to `ON DELETE SET NULL ON UPDATE CASCADE`.
  * The data type of the `ParticleClassification.rotationAccuracy` column has been changed from `int unsigned` to `float`.
  * In `DataCollection`: Added new column `dataCollectionPlanId` with FK constraint referencing the table currently known as `DiffractionPlan`. 
  * In `ContainerQueueSample`: Added new columns `status`, `startTime`, `endTime`, `dataCollectionPlanId` and `blSampleId` with FK constraints for the two latter ones.

* New stored procedures for cryo EM:

  * `upsert_particle_picker`
  * `upsert_particle_classification_group`
  * `upsert_particle_classification`
  * `insert_cryoem_initial_model`
  * Grants for these have been added to the `grants/ispyb_processing.sql` file.

* New stored procedures for MX and other disciplines:

  * `insert_aperture`
  * `insert_crystal`
  * `insert_dc_plan`
  * `insert_position`
  * `retrieve_apertures_using_size`
  * `retrieve_container`
  * `retrieve_dcs_for_sample`
  * `retrieve_quality_indicators`
  * `retrieve_robot_actions_for_sample`
  * `retrieve_screenings_for_sample`
  * `retrieve_xfe_fluo_ids_for_sample`
  * A new role ispyb_gda_mxcx has been created with execute grants on these procedures.

* Modified stored procedures:

  * `retrieve_dc`: Added extra column `id` (which is an alias for the primary key).
  * `retrieve_scm_samples_for_container_id`: Only indentation changes, no real changes.

1.20.1 (2021-04-20)
-------------------

- `xchem_db` schema is now part of the release archive file
- `retrieve_dc_plans_for_sample` sproc: add `sampleOrderInPlan` field to result-set
- Redefined which tables are lookup tables
- Code refactoring of `bin/backup.sh` and `bin/export_session.sh`
- `schemas/ispyb/data.sql`: Set `planOrder` for rows in `BLSample_has_DataCollectionPlan` table

1.20.0 (2021-04-13)
-------------------

* Tables, views and indices:

  * New cryoEM table `ParticleClassificationGroup`. Some columns were moved to this table from `ParticlePicker` and `ParticleClassification`.
  * Add `capillary` as enum option to `BLSampleGroup_has_BLSample.type`
  * XChem DB: First version of schema for production (not part of release)
  * Analytics schema: Add access to all lookup tables, `RobotAction`, `ProcessingJob*`, `Protein` tables through views
  * Drop duplicate indices, add missing indices that existed only in DLS prod

* Data in lookup tables:

  * Add additional container types: some historical, some new
  * Update `ExperimentType.proposalType`: Change scm to saxs, MX to mx
  * Update `ContainerType.proposalType`: Change scm to saxs
  * Add two XPDF and five MX container types
  * Update `SpaceGroup` table: Remove newlines in names. Set `MX_used` = 1 for all SGs.
  
* Stored procedures:

  * `retrieve_scm_*``: Preferentially get experiement type and container type+capacity from new lookup tables `ExperimentType` and `ContainerType`, otherwise fall-back to `experimentType` and `containerType`+`capacity` columns in the `Container` table.
  * `upsert_sample_image`: set `BLSampleImage.modifiedTimeStamp` if the upsert is an update

* Tools and documentation:

  * New script `bin/missed_updates.sh` to identify update .sql files that haven't been run
  * `bin/backup.sh`: Use `--add-drop-trigger` flag to drop trigger if exists before creation
  * `CONTRIBUTING.md`: Simplify pull request procedure for table changes
  * Updated simplified MX database diagram files
  * Move list + string with lookup tables to separate file so it can be reused
  * All bash scripts have been given new shebang lines to run on systems where bash is not at `/bin/bash`.
  
* Users, roles and grants:

  * More `INSERT` grants for `ispyb_web` role: DC, DCG, `ProcessingJob`, `ProcessingJobParameter`
  * New `ispyb_ro_nopii` role (read-only-except-PII)

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
