-- Create the Exp-eye Core API role.
CREATE ROLE IF NOT EXISTS ispyb_expeye_core_role;

-- You must also create a database user and grant this role to them, e.g.
-- CREATE USER ispyb_expeye_core@'%' IDENTIFIED BY 'the_password';
-- GRANT ispyb_expeye_core_role to ispyb_expeye_core@'%';
-- SET DEFAULT ROLE ispyb_expeye_core_role FOR ispyb_expeye_core@'%';

GRANT ispyb_propagation TO ispyb_expeye_core_role;

CREATE ROLE ispyb_expeye_acquisition_role;

GRANT SELECT, INSERT, UPDATE ON RobotAction TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE ON GridInfo TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE ON DataCollection TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE ON DataCollectionGroup TO ispyb_expeye_acquisition_role;
GRANT SELECT, INSERT, UPDATE ON Position TO ispyb_expeye_acquisition_role;
GRANT ispyb_expeye_acquisition_role TO ispyb_expeye_core_role;
