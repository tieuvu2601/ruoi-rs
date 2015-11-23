DROP TABLE IF EXISTS PortalOpinion;
CREATE TABLE PortalOpinion (
  OpinionID double(19, 0) NOT NULL auto_increment,
  UserName varchar(15),
  PhoneNumber varchar(15),
  email varchar(255),
  Title varchar(255),
  Description TEXT,
  Status TINYINT DEFAULT 0,
  CreatedDate TIMESTAMP NOT NULL,
  ResolvedDate TIMESTAMP,
  UserID double(19, 0) DEFAULT NULL,
  PRIMARY KEY  (OpinionID)
) ;