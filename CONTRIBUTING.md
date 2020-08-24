# Contributing

It'a assumed that any table changes you wish to make have already been discussed and agreed in the ISPyB collaboration via an issue at: https://github.com/ispyb/ispyb-database-modeling/

## Pull Request Process For Table Changes

1. Create an .sql file under `schema/updates/` with a name that starts with today's date in the same format as the most recent existing files in that directory. At the start of the file there should be an `INSERT` statement to insert the file name into the SchemaStatus table with a `schemaStatus` value of `ONGOING`. At the end of the files should be an `UPDATE` statement to update the row's `schemaStatus` value to `DONE`. See the existing files in the `schema/updates/` folder for details on this.
2. Update the `schema/` .sql files: Go to the `bin` folder and run e.g. `backup.sh /tmp/`. This will produce the files `tables.sql`, `data.sql`, `lookup.sql` and `routines.sql` in the `/tmp/` folder. Use a tool such as `meld` to compare these against the same files in your `schema/` folder. If there are *material* differences (i.e. not just a comment about a different database version used to create the backup, or a comment with a different time stamp), then copy those files into your `schema/` folder.  
3. Run the `build.sh` script. This will drop and re-create your database using the .sql files in the `schema/` folder: `tables.sql`, `data.sql`, `lookup.sql` and `routines.sql`, and also using the .sql files in the `grants/` folder. It will produce an updated `docs/list_of_tables_and_columns.rst` file as well as making sure that all the .sql update files are listed in the `SchemaStatus` table.
4. Now make a pull request with the updated files the normal way. Travis will run the `build.sh` file on the branch on github to make sure everthing is fine.
