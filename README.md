[![Build Status](https://travis-ci.org/DiamondLightSource/ispyb-database.svg?branch=master)](https://travis-ci.org/DiamondLightSource/ispyb-database)

# ispyb-database

This package provides everything needed to create the Diamond flavour of the ISPyB database schema. As we evolve the schema we will publish the update scripts here, so hopefully it should be easy for other users of the schema to stay up-to-date.

## Requirements

* Server and a client packages of MariaDB 10.3 or later.
* A Unix-like OS with `bash` shell.
* If binary logging is enabled in the DB system, then execute this before importing the test schema: `SET GLOBAL log_bin_trust_function_creators=ON;`

## Installation

1. Install MariaDB. See the Wiki for ideas on how to install in a particular environment.
2. Copy `.my.example.cnf` to `.my.cnf` and then edit that file to set the `user` and `password`, e.g. `user = root` and use the `password` you set when securing. Optionally, you can also set e.g. `host` and `port`.
3. In a test environment run the `build.sh` file. This creates the database schema and applies the grants as described in the "Schema" and "Grants" sections below.

### Schema

Tip: Execute `./build.sh` to create a development `ispyb_build` database and import all the schema and grants files into it.

Alternatively, do it manually:

Run this on the command-line to create a database and import the schema stored in the SQL files:

```bash
mysql -e "CREATE DATABASE ispyb"
mysql ispyb < schemas/ispyb/tables.sql
mysql ispyb < schemas/ispyb/lookups.sql
mysql ispyb < schemas/ispyb/data.sql
mysql ispyb < schemas/ispyb/routines.sql
```

Note that the `data.sql` file contains test data, so is only useful in a development environment.

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

1. For all .sql files in `schemas/ispyb/updates` that have not already been run, read any comments inside the files to decide if/when you should run them. Run a file e.g. like this:
```bash
mysql ispyb < schemas/ispyb/updates/2019_03_29_BLSession_archived.sql
```
2. If `schemas/ispyb/routines.sql` has been updated since you installed it, you can simply re-run it. E.g.:
```bash
mysql ispyb < schemas/ispyb/routines.sql
```
3. If you ran the `routines.sql`, then re-apply the grants for the routines. E.g.:
```bash
mysql ispyb < grants/ispyb_acquisition.sql
mysql ispyb < grants/ispyb_processing.sql
mysql ispyb < grants/ispyb_web.sql
```

## Releasing

This procedure requires write permission to the repository and a valid `.github-api-token` file.

1. Create a file 'yyyy_mm_dd_AdminVar_bump_version.sql' (replace 'yyyy_mm_dd' with today's date) in the `schemas/ispyb/updates/` folder. As is convention with all updates files, it should start with an `INSERT INTO SchemaStatus ...` statement, and end with an `UPDATE SchemaStatus ...` statement. Between these statements should be a statement to set the version, e.g. ``UPDATE AdminVar SET `value` = '1.22.0' WHERE `name` = 'schemaVersion';`` Several such files can be found in the updates folder.
2. Run `./build.sh`: This will create a clean development database using the schema files in `schemas/ispyb/` and then import any `updates/` files not yet imported.
3. Manually import any stored programs committed since the previous release.
4. Create a backup: `cd bin && ./backup.sh /tmp/`.
5. Copy `/tmp/lookups.sh` to `schemas/ispyb/`. If other changes have been made since the previous release, then you might need to copy other files to the same folder: If any changes to the tables or views, then also copy `/tmp/tables.sql`. If any changes to the stored programs, then also copy `/tmp/routines.sql`. If any changes to the test data, then also copy `/tmp/data.sql`.
6. Commit and push your changes to master.
7. Finally, run the `release.sh` script to create a tag and create a Github release against that tag. The new release should then become available on the project's Github page.

## Useful scripts

* `build.sh`: Creates a development `ispyb_build` database and import all the schema and grants files into it.
* `release.sh`: Makes a release, see the Releasing section.
* `bin/backup.sh`: Makes a backup of the development database.
* `bin/missed_updates.sh`: Generates a list of files in the `schemas/ispyb/updates/` folder that haven't been applied.
* `bin/export_session.sh`: Exports a given session's database rows to SQL files. These can then easily be imported into an empty ispyb database. This can be used e.g. to create a single-session ISPyB/SynchWeb instance if combined with all the relevant data files and processing files for the session, and an instance of SynchWeb.

## Documentation

* Please refer to the [```Wiki```](https://github.com/DiamondLightSource/ispyb-database/wiki) for database diagrams, stored procedure how-to, MariaDB installation and more  
* A complete [```list of tables and columns```](https://github.com/DiamondLightSource/ispyb-database/blob/master/docs/list_of_tables_and_columns.rst) for more details about the tables and columns
* A complete [```list of stored procedures```](https://github.com/DiamondLightSource/ispyb-database/blob/master/docs/list_of_procs.rst) for more details about the stored procedures

