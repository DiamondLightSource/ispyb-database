-- Create the propagation application role.
CREATE ROLE IF NOT EXISTS ispyb_propagation;

-- You must also create a database user and grant this role to them, e.g.
-- CREATE USER propagation@'%' IDENTIFIED BY 'the_propagation_password';
-- GRANT ispyb_propagation to propagation@'%';
-- SET DEFAULT ROLE ispyb_propagation FOR propagation@'%';

-- Grants for ispyb_propagation
GRANT SELECT, UPDATE, INSERT, DELETE ON Proposal TO ispyb_propagation;
GRANT SELECT, UPDATE, INSERT, DELETE ON BLSession TO ispyb_propagation;
GRANT SELECT, UPDATE, INSERT, DELETE ON ProposalHasPerson TO ispyb_propagation;
GRANT SELECT, UPDATE, INSERT, DELETE ON Session_has_Person TO ispyb_propagation;
GRANT SELECT, UPDATE, INSERT, DELETE ON Protein TO ispyb_propagation;
GRANT SELECT, UPDATE, INSERT, DELETE ON ContainerRegistry_has_Proposal TO ispyb_propagation;
GRANT SELECT, UPDATE, INSERT, DELETE ON Person TO ispyb_propagation;
GRANT SELECT, UPDATE, INSERT, DELETE ON UserGroup_has_Person TO ispyb_propagation;
GRANT SELECT ON BF_fault TO ispyb_propagation;
GRANT SELECT ON BLSampleGroup to ispyb_propagation;
GRANT SELECT ON Container TO ispyb_propagation;
GRANT SELECT ON ContainerQueue TO ispyb_propagation;
GRANT SELECT ON ContainerReport TO ispyb_propagation;
GRANT SELECT ON CourierTermsAccepted TO ispyb_propagation;
GRANT SELECT ON DataCollectionComment TO ispyb_propagation;
GRANT SELECT ON DewarRegistry_has_Proposal TO ispyb_propagation;
GRANT SELECT, DELETE ON LabContact TO ispyb_propagation;
GRANT SELECT, DELETE ON Laboratory TO ispyb_propagation;
GRANT SELECT ON Project TO ispyb_propagation;
GRANT SELECT ON DataCollectionGroup TO ispyb_propagation;
GRANT SELECT ON DataCollection TO ispyb_propagation;
GRANT SELECT ON EnergyScan TO ispyb_propagation;
GRANT SELECT ON XFEFluorescenceSpectrum TO ispyb_propagation;
GRANT SELECT ON RobotAction TO ispyb_propagation;
GRANT SELECT ON BeamlineAction TO ispyb_propagation;
GRANT SELECT, INSERT ON SessionType TO ispyb_propagation;
GRANT SELECT ON UserGroup_has_LDAPSearchParameters TO ispyb_propagation;
GRANT SELECT ON LDAPSearchParameters TO ispyb_propagation;
GRANT SELECT ON LDAPSearchBase TO ispyb_propagation;
GRANT SELECT ON UserGroup TO ispyb_propagation;
GRANT SELECT, UPDATE, INSERT ON BeamCalendar TO ispyb_propagation;
GRANT SELECT, UPDATE, INSERT ON v_run TO ispyb_propagation;
GRANT SELECT, DELETE ON SW_onceToken TO ispyb_propagation;
