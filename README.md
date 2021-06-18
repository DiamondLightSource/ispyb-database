[![Build Status](https://travis-ci.org/DiamondLightSource/ispyb-database.svg?branch=master)](https://travis-ci.org/DiamondLightSource/ispyb-database)

# ispyb-database

This package provides everything needed to create the Diamond flavour of the ISPyB database schema. As we evolve the schema we will publish the update scripts here, so hopefully it should be easy for other users of the schema to stay up-to-date.

## Requirements

* MariaDB 10.3 or later, both a server and a client. See the Wiki for ideas on how to install in a particular environment.
* A Unix-like OS with `bash` shell is assumed.
* If binary logging is enabled in the DB system, then execute this before importing the test schema: `SET GLOBAL log_bin_trust_function_creators=ON;`

## Installation

1. Copy `.my.example.cnf` to `.my.cnf` and then edit that file to set the `user` and `password`, e.g. `user = root` and use the `password` you set when securing. Optionally, you can also set e.g. `host` and `port`.
2. In a test environment run the `build.sh` file. This creates the database schema and applies the grants as described in the "Schema" and "Grants" sections below.

### Schema

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

1. Create a file 'yyyy_mm_dd_AdminVar_bump_version.sql' (replace 'yyyy_mm_dd' with today's date) in the `updates/` folder.
2. Run `./build.sh`: This will create a clean development database from the schema files in `schemas/ispyb/` and import any `updates/` files not yet imported.
3. Manually import any stored programs you've made.
4. Create a backup: `cd bin && ./backup.sh /tmp/`.
5. Copy `/tmp/lookups.sh` to `schemas/ispyb/`. If you've made changes to the tables, also copy /tmp/tables.sql. If you've made changes to the stored programs, then also copy `/tmp/routines.sql`. If you've made changes to the test data, then also copy `/tmp/data.sql`.
6. Commit and push your changes to master.
7. Finally, run the `release.sh` script to create a tag and create a Github release against that tag.

## Documentation

* Please refer to the [```Wiki```](https://github.com/DiamondLightSource/ispyb-database/wiki) for database diagrams, stored procedure how-to, MariaDB installation and more  
* A complete [```list of tables and columns```](https://github.com/DiamondLightSource/ispyb-database/blob/master/docs/list_of_tables_and_columns.rst) for more details about the tables and columns
* A complete [```list of stored procedures```](https://github.com/DiamondLightSource/ispyb-database/blob/master/docs/list_of_procs.rst) for more details about the stored procedures

