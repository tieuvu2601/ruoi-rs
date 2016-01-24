CREATE DATABASE RealEstate DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;

USE RealEstate;

DROP TABLE IF EXISTS UserGroup;
CREATE TABLE UserGroup (
  UserGroupID bigint(20) NOT NULL AUTO_INCREMENT,
  Code VARCHAR(255) NOT NULL,
  Name VARCHAR(255) NOT NULL,
  Description VARCHAR(255),
  CreatedDate TIMESTAMP NOT NULL,
  ModifiedDate TIMESTAMP,
  PRIMARY KEY (UserGroupID),
  UNIQUE (Code)
);


DROP TABLE IF EXISTS Users;
CREATE TABLE Users (
  UserID bigint(20) NOT NULL AUTO_INCREMENT,
  Username VARCHAR(255) NOT NULL,
  Password VARCHAR(255) NOT NULL,
  Email VARCHAR(255) NOT NULL,
  FirstName VARCHAR(255) NOT NULL,
  LastName VARCHAR(255) NOT NULL,
  DisplayName VARCHAR(255) NOT NULL,
  MobileNumber VARCHAR(255) NOT NULL,
  Status int(11) DEFAULT 1,
  UserGroupID bigint(20) NOT NULL,
  CreatedDate TIMESTAMP NOT NULL,
  ModifiedDate TIMESTAMP,
  Avatar varchar(255),
  FullAccess int(11) DEFAULT 0,
  PRIMARY KEY (userID),
  UNIQUE (Username),
  UNIQUE (Email),
  FOREIGN KEY (UserGroupID) REFERENCES UserGroup(UserGroupID) ON DELETE NO ACTION ON UPDATE NO ACTION
);

DROP TABLE IF EXISTS Role;
CREATE TABLE Role(
  RoleID bigint(20) NOT NULL AUTO_INCREMENT,
  Role VARCHAR(255) NOT NULL,
  Name VARCHAR(255) NOT NULL,
  Description varchar(255),
  CreatedDate TIMESTAMP NOT NULL,
  ModifiedDate TIMESTAMP,
  PRIMARY KEY (RoleID),
  UNIQUE (Role)
);

DROP TABLE IF EXISTS UserRole;
CREATE TABLE UserRole (
  UserRoleID bigint(20) NOT NULL AUTO_INCREMENT,
  UserID bigint(20) NOT NULL,
  RoleID bigint(20) NOT NULL,
  PRIMARY KEY (UserRoleID),
  UNIQUE (UserID, RoleID),
  FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (RoleID) REFERENCES Role(RoleID) ON DELETE NO ACTION ON UPDATE NO ACTION
);

DROP TABLE IF EXISTS AuthoringTemplate;
CREATE TABLE AuthoringTemplate (
  AuthoringTemplateID bigint(20) NOT NULL AUTO_INCREMENT,
  Code VARCHAR(40) NOT NULL,
  Name VARCHAR(255) NOT NULL,
  TemplateContent longtext,
  CreatedDate TIMESTAMP NOT NULL,
  ModifiedDate TIMESTAMP,
  PRIMARY KEY (AuthoringTemplateID),
  UNIQUE (Code)
);

DROP TABLE IF EXISTS Category;
CREATE TABLE Category (
  CategoryID bigint(20) NOT NULL AUTO_INCREMENT,
  Code varchar(255) NOT NULL,
  Name varchar(255) NOT NULL,
  PrefixUrl varchar(255) DEFAULT NULL,
  Description varchar(255) DEFAULT NULL,
  DisplayOrder int(11) DEFAULT '1',
  AuthoringTemplateID bigint(20) NOT NULL,
  ParentID bigint(20) DEFAULT NULL,
  CreatedDate timestamp NOT NULL,
  ModifiedDate timestamp NOT NULL,
  Keyword varchar(255) DEFAULT NULL,
  Title varchar(255) DEFAULT NULL,
  PRIMARY KEY (CategoryID),
  UNIQUE (Code),
  FOREIGN KEY (AuthoringTemplateID) REFERENCES AuthoringTemplate(AuthoringTemplateID) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (ParentID) REFERENCES Category(CategoryID) ON DELETE NO ACTION ON UPDATE NO ACTION
);

DROP TABLE IF EXISTS Content;
CREATE TABLE Content (
  ContentID bigint(20) NOT NULL AUTO_INCREMENT,
  CategoryID bigint(20) NOT NULL,
  AuthoringTemplateID bigint(20) DEFAULT NULL,
  Title VARCHAR(255) NOT NULL,
  Keyword VARCHAR(255),
  Location VARCHAR(255),
  DisplayOrder int(11) DEFAULT 1,
  XmlData text,
  Thumbnails VARCHAR(255),
  BeginDate TIMESTAMP,
  EndDate TIMESTAMP,
  CreatedDate TIMESTAMP NOT NULL,
  ModifiedDate TIMESTAMP,
  Status int(11) NOT NULL DEFAULT 0,
  PublishedDate TIMESTAMP,
  CreatedBy bigint(20) NOT NULL,
  PRIMARY KEY (ContentID),
  UNIQUE KEY (Title),
  FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (AuthoringTemplateID) REFERENCES AuthoringTemplate(AuthoringTemplateID) ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (CreatedBy) REFERENCES Users(UserID) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- CLEAR DATA --

-- DROP TABLE IF EXISTS Content;
-- DROP TABLE IF EXISTS Category;
-- DROP TABLE IF EXISTS AuthoringTemplate;
-- DROP TABLE IF EXISTS UserRole;
-- DROP TABLE IF EXISTS Role;
-- DROP TABLE IF EXISTS Users;
-- DROP TABLE IF EXISTS UserGroup;

-- INIT DATABASE --

INSERT INTO UserGroup(Code, Name, Description, CreatedDate) VALUES ('Administrator', 'Administrator', 'Administrator', NOW());
INSERT INTO Users(Username, Password, Email, FirstName, LastName, DisplayName, MobileNumber, Status, UserGroupID, CreatedDate, FullAccess)
VALUES ('admin', '123456', 'khanh.tran@hoanghacgroup.com', 'Administrator', 'Administrator', 'Administrator', '000000000', 1, 1, NOW(), 1);

ALTER TABLE content ADD COLUMN EmailSubject VARCHAR(512);
ALTER TABLE content ADD COLUMN EmailContent text;

