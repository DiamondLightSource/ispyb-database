CREATE ROLE IF NOT EXISTS maxscale_role;
CREATE ROLE IF NOT EXISTS maxmon_role;

-- You must also create database users and grant these roles to them, e.g.
-- CREATE USER maxscale_user@'%' IDENTIFIED BY 'the_password';
-- CREATE USER maxmon_user@'%' IDENTIFIED BY 'the_password';
-- GRANT maxscale_role to maxscale_user@'%';
-- GRANT maxmon_role to maxmon_user@'%';
-- SET DEFAULT ROLE maxscale_role FOR maxscale_user@'%';
-- SET DEFAULT ROLE maxmon_role FOR maxmon_user@'%';

GRANT SHOW DATABASES ON *.* TO maxscale_role;
GRANT SELECT ON mysql.procs_priv TO maxscale_role;
GRANT SELECT ON mysql.tables_priv TO maxscale_role;
GRANT SELECT ON mysql.db TO maxscale_role;
GRANT SELECT ON mysql.roles_mapping TO maxscale_role;
GRANT SELECT ON mysql.columns_priv TO maxscale_role;
GRANT SELECT ON mysql.proxies_priv TO maxscale_role;
GRANT SELECT ON mysql.user TO maxscale_role;

GRANT REPLICATION SLAVE, BINLOG MONITOR, SLAVE MONITOR ON *.* TO maxmon_role;
GRANT SELECT ON mysql.user TO maxmon_role;
