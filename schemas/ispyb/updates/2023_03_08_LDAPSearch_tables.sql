INSERT IGNORE INTO SchemaStatus (scriptName, schemaStatus) VALUES ('2023_03_08_LDAPSearch_tables.sql', 'ONGOING');

CREATE TABLE LDAPSearchParameters (
    ldapSearchParametersId int(11) unsigned auto_increment PRIMARY KEY,
    accountType enum('group_member', 'staff_account', 'functional_account') NOT NULL COMMENT 'The entity type returned by the search',
    accountTypeGroupName varchar(100) COMMENT 'all accounts of this type must be members of this group',
    oneOrMany enum('one', 'many') NOT NULL COMMENT 'Expected number of search results',
    hostURL varchar(200) NOT NULL COMMENT 'URL for the LDAP host',
    filter varchar(200) COMMENT 'A filter string for the search',
    attributes varchar(255) NOT NULL COMMENT 'Comma-separated list of search attributes'
)
COMMENT 'All necessary parameters to run an LDAP search, except the search base';

CREATE TABLE LDAPSearchBase (
    ldapSearchBaseId int(11) unsigned auto_increment PRIMARY KEY,
    ldapSearchParametersId int(11) unsigned NOT NULL COMMENT 'The other LDAP search parameters to be used with this search base',
    searchBase varchar(200) NOT NULL COMMENT 'Name of the object we search for',
    sequenceNumber tinyint unsigned NOT NULL COMMENT 'The number in the sequence of searches where this search base should be attempted',
    CONSTRAINT LDAPSearchBase_fk_ldapSearchParametersId FOREIGN KEY (ldapSearchParametersId) REFERENCES LDAPSearchParameters (ldapSearchParametersId)
)
COMMENT 'LDAP search base and the sequence number in which it should be attempted';

CREATE TABLE UserGroup_has_LDAPSearchParameters (
    userGroupId int(11) unsigned NOT NULL,
    ldapSearchParametersId int(11) unsigned NOT NULL,
    name varchar(200) NOT NULL COMMENT 'Name of the object we search for',     
    PRIMARY KEY (userGroupId, ldapSearchParametersId, name),
    CONSTRAINT UserGroup_has_LDAPSearchParameters_fk1 FOREIGN KEY (userGroupId) REFERENCES UserGroup (userGroupId),
    CONSTRAINT UserGroup_has_LDAPSearchParameters_fk2 FOREIGN KEY (ldapSearchParametersId) REFERENCES LDAPSearchParameters (ldapSearchParametersId)    
)
COMMENT 'Gives the LDAP search parameters needed to find a set of usergroup members';

UPDATE SchemaStatus SET schemaStatus = 'DONE' WHERE scriptName = '2023_03_08_LDAPSearch_tables.sql';
