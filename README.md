[![Build Status](https://travis-ci.org/DiamondLightSource/ispyb-database.svg?branch=master)](https://travis-ci.org/DiamondLightSource/ispyb-database)

# ispyb-database

This package provides everything needed to create the Diamond flavour of the ISPyB database schema. As we evolve the schema we will publish the update scripts here, so hopefully it should be easy for other users of the schema to stay up-to-date.

## Requirements

* We recommend MariaDB 10.3 or later.
* If binary logging is enabled in the DB system, then execute this before importing the test schema: `SET GLOBAL log_bin_trust_function_creators=ON;``

## Installation

### Schema

Run this on the command-line to create a database and import the schema stored in the SQL files:

```bash
mysql -e "CREATE DATABASE ispyb"
mysql ispyb < schema/tables.sql
mysql ispyb < schema/lookups.sql
mysql ispyb < schema/data.sql
mysql ispyb < schema/routines.sql
```

Note that the `data.sql` file contains test data, so is only useful in a development environment.

Alternatively, in a test environment you can also run the `build.sh` file. This creates the database, runs the above .sql files and more.

### Grants

Then apply the grants:

```bash
mysql ispyb < grants/ispyb_acquisition.sql
mysql ispyb < grants/ispyb_processing.sql
mysql ispyb < grants/ispyb_web.sql
```
Note that the grants files are based on roles, so to actually use these grants, you also need to create database users and grant the roles to them. This is described in the header section of the grant files.

### Miscellaneous Notes

Note that SynchWeb currently assumes [`sql_mode`](https://mariadb.com/kb/en/library/sql-mode/) is not set. I.e. it assumes that you have a line like the below in the MariaDB .cnf file:

```
sql_mode=''
```

In a development environment it might be useful to log all SQL errors. In MariaDB, you can install the [SQL Error Log Plugin](https://mariadb.com/kb/en/library/sql-error-log-plugin/) to get these logged to a file `sql_errors.log` inside your datadir. Run this from the mariadb command-line:

```
INSTALL SONAME 'sql_errlog';
```
You can verify that it's installed and activated with:

```
SHOW PLUGINS SONAME WHERE Name = 'SQL_ERROR_LOG';
```

## Updating

In order to update a production database, please follow this procedure:

1. For all .sql files in `schema/updates` that have not already been run, read any comments inside the files to decide if/when you should run them. Run a file e.g. like this:
```bash
mysql ispyb < schema/updates/2019_03_29_BLSession_archived.sql
```
2. If `schema/routines.sql` has been updated since you installed it, you can simply re-run it. E.g.:
```bash
mysql ispyb < schema/routines.sql
```
3. If you ran the `routines.sql`, then re-apply the grants for the routines. E.g.:
```bash
mysql ispyb < grants/ispyb_acquisition.sql
mysql ispyb < grants/ispyb_processing.sql
mysql ispyb < grants/ispyb_web.sql
```

## Documentation

* Please refer to the [```Wiki```](https://github.com/DiamondLightSource/ispyb-database/wiki) for database diagrams, stored procedure how-to, MariaDB installation and more  
* A complete [```list of tables and columns```](https://github.com/DiamondLightSource/ispyb-database/blob/master/docs/list_of_tables_and_columns.rst) for more details about the tables and columns
* A complete [```list of stored procedures```](https://github.com/DiamondLightSource/ispyb-database/blob/master/docs/list_of_procs.rst) for more details about the stored procedures

## Naming and type convention

* Table names: UpperCamelCase (i.e. TableName, DataCollection)
* Column names: lowerCamelCase (i.e. columnName, dataCollectionId)
* Table names are in singular when a single row in the table contains only one of the items that the name refers to (i.e. Container, but note: ImageQualityIndicators because there are multiple indicators in a single row)
* Flag indication: 1=yes, 0=no, NULL=unknown
* Primary key columns are always integer
* Linker tables used for many-to-many relationships between two entities Entity1 and Entity2 are named according to the pattern 'Entity1_has_Entity2'. If both have the same prefix, then the prefix might be left out of the last one, e.g. 'Component_has_SubType' where 'SubType' refers to the entity 'ComponentSubType'.
* Stored programs: lowercase_underscore_delimited. The first word should be a verb describing what the procedure or function does, e.g. `update`, `upsert`, `insert`, `retrieve`. The second word should typically refer to a table or entity. If needed, add more words after this to describe how to identify the row(s) you want to operate on, e.g. `for_barcode` or `for_container_id_and_location`. However, if the row is identified by primary key, then this information can be skipped, e.g. `retrieve_sample`.
* Parameter names for stored programs: Start with `p_` followed typically by a column name. If the column is the primary key of the entity / table referred to by the stored program name, then simply call the parameter `p_id`.
* Sometimes it's justified to use abbreviations to avoid excessively long names.

The schema does have some tables and columns that don't adhere to this convention. Some of those should be corrected, but there could be good reasons to break with the convention in a few cases.
