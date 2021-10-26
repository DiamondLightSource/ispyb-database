# Releasing a new version

This procedure requires write permission to the repository and a valid `.github-api-token` file.

1. Create a file 'yyyy_mm_dd_AdminVar_bump_version.sql' (replace 'yyyy_mm_dd' with today's date) in the `schemas/ispyb/updates/` folder. As is convention with all updates files, it should start with an `INSERT INTO SchemaStatus ...` statement, and end with an `UPDATE SchemaStatus ...` statement. Between these statements should be a statement to set the version, e.g. ``UPDATE AdminVar SET `value` = '1.22.0' WHERE `name` = 'schemaVersion';`` Several such files can be found in the updates folder.
2. Run `./build.sh`: This will create a clean development database using the schema files in `schemas/ispyb/` and then import any `updates/` files not yet imported.
3. Manually import any stored programs committed since the previous release.
4. Create a backup: `cd bin && ./backup.sh /tmp/`.
5. Copy `/tmp/lookups.sh` to `schemas/ispyb/`. If other changes have been made since the previous release, then you might need to copy other files to the same folder: If any changes to the tables or views, then also copy `/tmp/tables.sql`. If any changes to the stored programs, then also copy `/tmp/routines.sql`. If any changes to the test data, then also copy `/tmp/data.sql`.
6. Commit and push your changes to master.
7. Finally, run the `release.sh` script to create a tag and create a Github release against that tag. The new release should then become available on the project's Github page.
