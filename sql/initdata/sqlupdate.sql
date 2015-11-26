-- DROP DATABASE AND ADD NEW
DROP DATABASE RealEstate;
CREATE DATABASE RealEstate  DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;

DROP TABLE IF EXISTS UsersGroup;
CREATE TABLE UsersGroup (
  userGroupId BIGINT(20) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  code VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  UNIQUE (code)
);

DROP TABLE IF EXISTS Users;
CREATE TABLE Users (
  userId BIGINT(20) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  userGroupId BIGINT(20) DEFAULT NULL,
  username varchar(255) DEFAULT NULL,
  password varchar(255) DEFAULT NULL,
  email varchar(255) DEFAULT NULL,
  firstName varchar(255) DEFAULT NULL,
  lastName varchar(255) DEFAULT NULL,
  displayName varchar(255) DEFAULT NULL,
  phoneNumber varchar(255) DEFAULT NULL,
  status int(11) DEFAULT NULL,
  createdDate datetime DEFAULT NULL,
  modifiedDate datetime DEFAULT NULL,
  avatar varchar(255) DEFAULT NULL,
  fullAccess int(11) DEFAULT NULL,
  UNIQUE (username),
  FOREIGN KEY (userGroupId) REFERENCES UsersGroup(userGroupId)
);

DROP TABLE IF EXISTS ContentType;
CREATE TABLE ContentType (
  contentTypeId BIGINT(20) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  code VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  displayOrder INT NOT NULL DEFAULT 0,
  UNIQUE (code)
);

DROP TABLE IF EXISTS ContentCategory;
CREATE TABLE ContentCategory (
  contentCategoryId BIGINT(20) PRIMARY KEY,
  code VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  displayOrder INT NOT NULL DEFAULT 0,
  parentId BIGINT(20),
  UNIQUE (code),
  FOREIGN KEY (parentId) REFERENCES ContentCategory(contentCategoryId)
);

DROP TABLE IF EXISTS AuthoringTemplate;
CREATE TABLE AuthoringTemplate (
   authoringTemplateId BIGINT(20) PRIMARY KEY NOT NULL AUTO_INCREMENT,
   code VARCHAR(255) NOT NULL,
   name VARCHAR(255) NOT NULL,
   templateContent TEXT NOT NULL,
   event INT NOT NULL DEFAULT 0,
   createdDate TIMESTAMP NOT NULL,
   modifiedDate TIMESTAMP,
   UNIQUE (code)
);

DROP TABLE IF EXISTS Content;
CREATE TABLE Content (
  contentId BIGINT(20) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  contentTypeId BIGINT(20) NOT NULL,
  contentCategoryId BIGINT(20) NOT NULL,
  authoringTemplateId BIGINT(20) NOT NULL,
  title VARCHAR(255) NOT NULL,
  keyword VARCHAR(255) NOT NULL,
  prefixUrl VARCHAR(255),
  shortDescription VARCHAR(255) NOT NULL,
  dataXML TEXT,
  location VARCHAR(255),
  locationPoint VARCHAR(255),
  displayOrder INT NOT NULL DEFAULT 0,
  createdDate TIMESTAMP NOT NULL,
  modifiedDate TIMESTAMP,
  publishedDate TIMESTAMP,
  author BIGINT NOT NULL,
  UNIQUE (title),
  FOREIGN KEY (contentTypeId) REFERENCES ContentType(contentTypeId),
  FOREIGN KEY (contentCategoryId) REFERENCES ContentCategory(contentCategoryId),
  FOREIGN KEY (authoringTemplateId) REFERENCES AuthoringTemplate(authoringTemplateId),
  FOREIGN KEY (author) REFERENCES Users(userId)
);

