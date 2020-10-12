# Contributing

It'a assumed that any table changes you wish to make have already been discussed and agreed in the ISPyB collaboration via an issue at: https://github.com/ispyb/ispyb-database-modeling/

## Pull Request Process For Table Changes

1. Create an .sql file with your `ALTER TABLE`, `CREATE TABLE` or similar statements and place it under `schema/updates/` with a name that starts with today's date in 'yyyy-mm-dd_' format like the most recent files in that directory. Run `bin/add_schema_status_stmts.sh path/to/sql-file` to add `INSERT` and `UPDATE` statements against the `SchemaStatus` table at the start and end of your .sql file.
2. Run the `build.sh` script. This will drop and re-create your database using the .sql files in the `schema/` folder: `tables.sql`, `data.sql`, `lookup.sql` and `routines.sql`, and also using the .sql files in the `grants/` folder. It will then run any .sql files in `schema/updates/` not listed in the SchemaStatus table. Finally, it will produce an updated `docs/list_of_tables_and_columns.rst` file.
3. Now make a pull request with the new files the normal way. Travis will run the `build.sh` file on the branch on github to make sure everthing is OK.

## Pull Request Process For Stored Procedures

1. Create an .sql file and place it under `schema/stored_programs/` with a name that starts with `sp_` followed by the name of the stored procedure and the `.sql` extension.
2. See the `README.md` file for the stored procedure naming convention.
3. The first line in the file should typically set the delimiter. e.g.: `DELIMITER ;;`
4. The second line should typically start with `CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE ` followed by the name of the stored procedure.
5. Now comes the procedure parameters enclosed in brackets. See the `README.md` file for the naming convention for these.
6. If it's a read-only procedure, then specify so with `READS SQL DATA`. If the proedure does write data then specify this with `MODIFIES SQL DATA`.
7. Use the `COMMENT 'short documentation here'` clause to add some quick documentation of the procedure's purpose.
8. Now comes the procedure body enclosed in `BEGIN` and `END;;`
9. The last line should set the delimiter back to normal, i.e. `DELIMITER ;`
