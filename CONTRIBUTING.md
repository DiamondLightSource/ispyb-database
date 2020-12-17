# Contributing

It'a assumed that any table changes you wish to make have already been discussed and agreed in the ISPyB collaboration via an issue at: https://github.com/ispyb/ispyb-database-modeling/

## Table changes and their pull request process

1. Create an .sql file with your `ALTER TABLE`, `CREATE TABLE` or similar statements and place it under `schema/updates/` with a name that starts with today's date in 'yyyy-mm-dd_' format like the most recent files in that directory. Run `bin/add_schema_status_stmts.sh path/to/sql-file` to add `INSERT` and `UPDATE` statements against the `SchemaStatus` table at the start and end of your .sql file.
2. Run the `build.sh` script. This will drop and re-create your database using the .sql files in the `schema/` folder: `tables.sql`, `data.sql`, `lookup.sql` and `routines.sql`, and also using the .sql files in the `grants/` folder. It will then run any .sql files in `schema/updates/` not listed in the SchemaStatus table. Finally, it will produce an updated `docs/list_of_tables_and_columns.rst` file.
3. Now make a pull request with the new files the normal way. Travis will run the `build.sh` file on the branch on github to make sure everthing is OK.

## Stored procedures and functions and their pull request process

1. Create an .sql file and place it under `schema/stored_programs/` with a name that starts with `sp_` for a stored procedure or `sf_` for a function, followed by the name of the stored procedure/function and the `.sql` extension. See the appendix for the stored program naming convention.
2. The first line in the file should typically set the delimiter, e.g.: `DELIMITER ;;`
3. The second line should typically start with `CREATE OR REPLACE DEFINER=`ispyb_root`@`%` PROCEDURE ` followed by the name of the stored procedure.
4. Now comes the procedure parameters enclosed in brackets. See the appendix for the naming convention for these. If you want the procedure to do authorization using a particular username, then that username should be the last parameter, and it should be called `p_authLogin`. Authorization in this context means you want the procedure to return a result set or modify data if and only if the given user should be allowed to do so. In a read-only procedure that tyoically means doing a `JOIN` with the Person and `Session_has_Person` tables.
5. Next, if it's a read-only procedure, then specify so with `READS SQL DATA`. On the other hand, if the proedure writes data then specify this with `MODIFIES SQL DATA`.
6. Use the `COMMENT 'short documentation here'` clause to add some quick documentation of the procedure's purpose.
7. Now comes the procedure body enclosed in `BEGIN` and `END;;`
8. The last line in the script should set the delimiter back to normal, i.e. `DELIMITER ;`
9. It's not a good idea to write program code with implicit assumptions about an unchanging table structure. Let's explainy by example:

Let's say you want to write the results of a certain kind of data processing. Currently, the schema has a particular hierarchy of tables to hold these results. So you create one `insert_` procedure for each of the tables in the hierarchy and then you write your other program code based around this set of stored procedures. You deploy and everything works fine. However, a few months later it's decided that this table structure needs serious re-design to support new requirements. Perhaps some of the hierarchy is replaced by a single `JSON` column or some of the tables are merged into one single table. Now you have to not only rewrite the stored procedures but also your program code.

It would have been better to write a single stored procedure to store the results using a JSON column or MariaDB dynamic columns as the input parameter. In you had done so in the above example, you would only have had to rewrite the stored procedure, not your program code. Another advantage of a single procedure for storing this information is that it can be made transactional. In other words, you can avoid ending up with incomplete processing results in the database if something goes wrong in the middle of writing the processing results. You store either a complete processing result or nothing at all.

## Appendix: Naming and type convention

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