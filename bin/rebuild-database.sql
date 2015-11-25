Phan tich database theo Thong tin website http://timcanho.com.vn/ cho Ruoi



CREATE TABLE UsersGroup (
  userGroupId BIGINT(20) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  code VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  description VARCHAR(255),
  UNIQUE (code)
);

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

CREATE TABLE ProductType (
  productTypeId BIGINT(20) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  code VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  displayOrder INT NOT NULL DEFAULT 0,
  UNIQUE (code)
);

CREATE TABLE ProductCategory (
  productCategoryId BIGINT(20) PRIMARY KEY,
  code VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  displayOrder INT NOT NULL DEFAULT 0,
  parentId BIGINT(20),
  UNIQUE (code),
  FOREIGN KEY (parentId) REFERENCES ProductCategory(productCategoryId)
);

CREATE TABLE Product (
  productId BIGINT(20) PRIMARY KEY NOT NULL AUTO_INCREMENT,
  productTypeId BIGINT(20) NOT NULL,
  productCategoryId BIGINT(20) NOT NULL,
  title VARCHAR(255) NOT NULL,
  keyword VARCHAR(255) NOT NULL,
  prefixUrl VARCHAR(255),
  shortDescription VARCHAR(255) NOT NULL,
  dataXML TEXT,
  thumbnails VARCHAR(255),
  location VARCHAR(255),
  locationPoint VARCHAR(255),
  images TEXT,
  displayOrder INT NOT NULL DEFAULT 0,
  createdDate TIMESTAMP NOT NULL,
  modifiedDate TIMESTAMP,
  publishedDate TIMESTAMP,
  author VARCHAR(100),
  UNIQUE (title),
  FOREIGN KEY (productTypeId) REFERENCES ProductType(productTypeId),
  FOREIGN KEY (productCategoryId) REFERENCES ProductCategory(productCategoryId)
);

CREATE TABLE ProductPromotion(
   productPromotionId BIGINT(20) PRIMARY KEY NOT NULL AUTO_INCREMENT,
   productId BIGINT(20) NOT NULL,
   title VARCHAR(255) NOT NULL,
   value BIGINT(20)  NOT NULL
);

CREATE TABLE ProductComment (
  productCommentId BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  productId BIGINT(20) NOT NUll,
  customerName VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  phoneNumber VARCHAR(20),
  message TEXT NOT NULL,
  createdDate TIMESTAMP NOT NULL,
  resolvedDate TIMESTAMP,
  resolvedBy VARCHAR(255)
);

-- // MUST BE REVISE

CREATE TABLE Customer (
   productCommentId BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
   customerName VARCHAR(255) NOT NULL,
   email VARCHAR(255) NOT NULL,
   phoneNumber VARCHAR(20),
   location VARCHAR(255),
   locationPoint VARCHAR(255),
   autoGetEmail int(11) DEFAULT 0,
   createdDate TIMESTAMP NOT NULL
)


