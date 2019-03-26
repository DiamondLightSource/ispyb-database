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

## Documentation

* Please refer to the [```Wiki```](https://github.com/DiamondLightSource/ispyb-database/wiki) for database diagrams, stored procedure how-to, MariaDB installation and more  
* A complete [```list of tables and columns```](https://github.com/DiamondLightSource/ispyb-database/blob/master/doc/list_of_tables_and_columns.rst) for more details about the tables and columns
* A complete [```list of stored procedures```](https://github.com/DiamondLightSource/ispyb-database/blob/master/doc/list_of_procs.rst) for more details about the stored procedures
