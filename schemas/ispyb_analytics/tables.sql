CREATE TABLE Instrument (
  instrumentId SMALLINT UNSIGNED PRIMARY KEY,
  name VARCHAR(10)
);

-- Create permissions tables.
-- We don't care about foreign key constraints.

CREATE TABLE Instrument_has_Username (
  instrumentId SMALLINT UNSIGNED,
  username VARCHAR(45),
  PRIMARY KEY(instrumentId, username)
);

CREATE TABLE Proposal_has_Instrument (
  instrumentId SMALLINT UNSIGNED,
  proposalId INT(10) UNSIGNED,
  PRIMARY KEY(proposalId, instrumentId)
);
