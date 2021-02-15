=======
History
=======

Unreleased / master
-------------------
* Add ``upsert_dc_grid`` and ``retrieve_grid_info_for_dc`` stored procedures for
  inserting/retrieving ``GridInfo`` entries via a ``dataCollectionId`` rather than
  ``dataCollectionGroupId``.

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
