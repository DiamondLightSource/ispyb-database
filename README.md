[![Build Status](https://travis-ci.org/DiamondLightSource/ispyb-database.svg?branch=master)](https://travis-ci.org/DiamondLightSource/ispyb-database)

# ispyb-database

This package provides all the scripts necessary to create an up-to-date ISPyB
database.

## Requirements

* MariaDB 10.0+ or MySQL 5.6+, but we recommend MariaDB 10.2 or later.
* If binary logging is enabled in the DB system, then execute this before importing the test schema: set global log_bin_trust_function_creators=ON;

## Installation

Run this on the command-line to create a database and import the schema stored in the SQL files:

```bash
mysql -e "CREATE DATABASE ispyb"
mysql ispyb < schema/tables.sql
mysql ispyb < schema/lookups.sql
mysql ispyb < schema/data.sql
mysql ispyb < schema/routines.sql
```

Note that the `data.sql` file contains test data, so is only useful in a development environment.

Alternatively, in a test environment you can also run the build.sh file. This creates the database, runs the above .sql files and more.

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

The schema does have some tables and columns that don't adhere to this convention, and there could be good reasons to break with the convention in certain cases. However, in the vast majority of cases we should try to follow this convention.
