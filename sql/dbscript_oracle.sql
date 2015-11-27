SET DEFINE OFF;
CREATE USER vms_portal IDENTIFIED BY 123456 DEFAULT TABLESPACE USERS TEMPORARY TABLESPACE TEMP;
GRANT CREATE SESSION, RESOURCE, CREATE VIEW, CREATE MATERIALIZED VIEW, CREATE SYNONYM TO vms_portal;
connect vms_portal/123456

CREATE TABLE "VMS_PORTAL"."PORTALUSERGROUP"
(
   UserGroupID            NUMBER(24,0)                        NOT NULL PRIMARY KEY,
   Code                   VARCHAR2(50 CHAR)                   NOT NULL,
   Name                   VARCHAR2(250 CHAR)                  NOT NULL,
   Description            CLOB                   	NULL,
   CreatedDate            TIMESTAMP                      NOT NULL,
   ModifiedDate           TIMESTAMP                      NOT NULL,
CONSTRAINT "PORTALUSERGROUP_UQ" UNIQUE (Code)   
) TABLESPACE "USERS";

CREATE TABLE "VMS_PORTAL"."PORTALROLE"
(
   RoleID                 NUMBER(24,0)                            NOT NULL PRIMARY KEY,
   Role                   VARCHAR2(50 CHAR)                   NOT NULL,
   Name                   VARCHAR2(250 CHAR)                  NOT NULL,
   Description            CLOB                   NULL,
   CreatedDate            TIMESTAMP                      NOT NULL,
   ModifiedDate           TIMESTAMP                      NOT NULL,
CONSTRAINT "PORTALROLE_UQ" UNIQUE (Role)   
) TABLESPACE "USERS";

CREATE TABLE "VMS_PORTAL"."PORTALDEPARTMENT"
(
   DepartmentID                 NUMBER(24,0)                            NOT NULL PRIMARY KEY,
   Code                   VARCHAR2(50 CHAR)                   NOT NULL,
   Name                   VARCHAR2(250 CHAR)                  NOT NULL,
   Description            CLOB                   NULL,
   CreatedDate            TIMESTAMP                      NOT NULL,
   ModifiedDate           TIMESTAMP                      NOT NULL,
   CONSTRAINT "PORTALDEPARTMENT_UQ" UNIQUE (Code)
 ) TABLESPACE "USERS";

CREATE TABLE "VMS_PORTAL"."PORTALUSER"
(
   UserID                 NUMBER(24,0)                            NOT NULL PRIMARY KEY,
   Username               VARCHAR2(250 CHAR)                  NOT NULL,
   Password               VARCHAR2(250 CHAR)                  NULL,
   Email                  VARCHAR2(250 CHAR)                  NOT NULL,
   Firstname              VARCHAR2(250 CHAR)                  NOT NULL,
   Lastname               VARCHAR2(250 CHAR)                  NOT NULL,
   MobileNumber           VARCHAR2(20 CHAR)                   NULL,
   Status                 NUMBER(24,0)                            NOT NULL,
   UserGroupID            NUMBER(24,0)                            NOT NULL,
   DepartmentID           NUMBER(24,0)                            NULL,
   CreatedDate            TIMESTAMP                      NOT NULL,
   ModifiedDate           TIMESTAMP                      NOT NULL,
   CONSTRAINT "PORTALUSER_USERNAME_UQ" UNIQUE (Username),
   CONSTRAINT "PORTALUSER_EMAIL_UQ" UNIQUE (Email),
   CONSTRAINT "PORTALUSER_MOBILE_UQ" UNIQUE (MobileNumber),
   CONSTRAINT "PORTALUSER_USERGROUP_FK" FOREIGN KEY(UserGroupID) REFERENCES "VMS_PORTAL"."PORTALUSERGROUP"(UserGroupID),
   CONSTRAINT "PORTALUSER_DEPARTMENT_FK" FOREIGN KEY(DepartmentID) REFERENCES "VMS_PORTAL"."PORTALDEPARTMENT"(DepartmentID)
) TABLESPACE "USERS";

CREATE TABLE "VMS_PORTAL"."PORTALUSERROLE" (
   UserRoleID             NUMBER(24,0)                            NOT NULL PRIMARY KEY,
   UserID                 NUMBER(24,0)                            NOT NULL,
   RoleID                 NUMBER(24,0)                            NOT NULL,  
   CONSTRAINT "PORTALUSERROLE_UQ" UNIQUE (UserID, RoleID),
   CONSTRAINT "PORTALUSERROLE_USER_FK" FOREIGN KEY(UserID) REFERENCES "VMS_PORTAL"."PORTALUSER"(UserID),
   CONSTRAINT "PORTALUSERROLE_ROLE_FK" FOREIGN KEY(RoleID) REFERENCES "VMS_PORTAL"."PORTALROLE"(RoleID)
) TABLESPACE "USERS";




CREATE TABLE "VMS_PORTAL"."PORTALAUTHORINGTEMPLATE"
(
   AuthoringTemplateID   NUMBER(24,0)                            NOT NULL PRIMARY KEY,
   Code                   VARCHAR2(250 CHAR)                  NOT NULL,
   Name                   VARCHAR2(250 CHAR)                  NOT NULL,
   XSDFile                VARCHAR(500 CHAR)                   NULL,
   TemplateContent        CLOB                           NULL,
   CreatedDate            TIMESTAMP                      NOT NULL,
   ModifiedDate           TIMESTAMP                      NOT NULL,
   CONSTRAINT "PORTALAUTHORINGTEMPLATE_UQ" UNIQUE (Code)
) TABLESPACE "USERS";

CREATE TABLE "VMS_PORTAL"."PORTALRENDERINGTEMPLATE"
(
   RenderingTemplateID    NUMBER(24,0)                            NOT NULL PRIMARY KEY,
   Code                   VARCHAR2(250 CHAR)                  NOT NULL,
   Name                   VARCHAR2(250 CHAR)                  NOT NULL,
   TemplateContent               CLOB                   NOT NULL,
   CreatedDate            TIMESTAMP                      NOT NULL,
   ModifiedDate           TIMESTAMP                      NOT NULL, 
   CONSTRAINT "PORTALRENDERINGTEMPLATE_UQ" UNIQUE (Code)
) TABLESPACE "USERS";

CREATE TABLE "VMS_PORTAL"."PORTALCATEGORY"
(
   CategoryID             NUMBER(24,0)                            NOT NULL PRIMARY KEY,
   Code                   VARCHAR2(50 CHAR)                   NOT NULL,
   Name                   VARCHAR2(250 CHAR)                  NOT NULL,
   Keyword                VARCHAR2(500 CHAR)                  NULL,
   Description            CLOB                   NULL,
   DisplayOrder           NUMBER(24,0)                            NULL,
   AuthoringTemplateID     NUMBER(24,0)                            NULL,
   RenderingTemplateID     NUMBER(24,0)                            NULL,
   CreatedDate            TIMESTAMP                      NOT NULL,
   ModifiedDate           TIMESTAMP                      NOT NULL,
   CONSTRAINT "PORTALCATEGORY_UQ" UNIQUE (Code),
   CONSTRAINT "PORTALCATEGORY_AUTHORING_FK" FOREIGN KEY(AuthoringTemplateID) REFERENCES "VMS_PORTAL"."PORTALAUTHORINGTEMPLATE"(AuthoringTemplateID),
   CONSTRAINT "PORTALCATEGORY_RENDERING_FK" FOREIGN KEY(RenderingTemplateID) REFERENCES "VMS_PORTAL"."PORTALRENDERINGTEMPLATE"(RenderingTemplateID)
) TABLESPACE "USERS";

CREATE TABLE "VMS_PORTAL"."PORTALCONTENT"
(
   ContentID              NUMBER(24,0)                            NOT NULL PRIMARY KEY,
   Title                  VARCHAR2(500 CHAR)                  NOT NULL,
   Keyword                VARCHAR2(500 CHAR)                  NULL,
   Thumbnail              VARCHAR2(500 CHAR)                  NULL,
   XMLData                CLOB                   NULL,
   AuthoringTemplateID    NUMBER(24,0)                            NOT NULL,
   AccessPolicy           NUMBER(24,0)                            NOT NULL,
   DisplayOrder           NUMBER(24,0)                            NULL,
   Hot                    NUMBER(24,0)                            NULL,
   CreatedDate            TIMESTAMP                      NOT NULL,
   ModifiedDate           TIMESTAMP                      NOT NULL,
 CONSTRAINT "PORTALCONTENT_AUTHORING_FK" FOREIGN KEY(AuthoringTemplateID) REFERENCES "VMS_PORTAL"."PORTALAUTHORINGTEMPLATE"(AuthoringTemplateID) 
) TABLESPACE "USERS";

CREATE TABLE "VMS_PORTAL"."PORTALCONTENTCATEGORY"(
  ContentCategoryID       NUMBER(24,0)                            NOT NULL PRIMARY KEY,
  ContentID               NUMBER(24,0)                            NOT NULL,
  CategoryID              NUMBER(24,0)                            NOT NULL,
  CreatedDate            TIMESTAMP                      NOT NULL,
  ModifiedDate           TIMESTAMP                      NOT NULL,  
  CONSTRAINT "CONTENTCATEGORY_UQ" UNIQUE (ContentID, CategoryID),
  CONSTRAINT "CONTENTCATEGORY_CONTENT_FK" FOREIGN KEY(ContentID) REFERENCES "VMS_PORTAL"."PORTALCONTENT"(ContentID),
  CONSTRAINT "CONTENTCATEGORY_CATEGORY_FK" FOREIGN KEY(CategoryID) REFERENCES "VMS_PORTAL"."PORTALCATEGORY"(CategoryID)
) TABLESPACE "USERS";

CREATE TABLE "VMS_PORTAL"."PORTALCOMMENT"
(
   CommentID              NUMBER(24,0)                            NOT NULL PRIMARY KEY,
   ContentID              NUMBER(24,0)                            NOT NULL,
   CommentText            CLOB                   				  NULL,
   CreatedBy              NUMBER(24,0)                            NULL,
   Status                 NUMBER(24,0)                            NULL,
   CreatedDate            TIMESTAMP                      NOT NULL,
   ModifiedDate           TIMESTAMP                      NOT NULL,
CONSTRAINT "PORTALCOMMENT_CONTENT_FK" FOREIGN KEY(ContentID) REFERENCES "VMS_PORTAL"."PORTALCONTENT"(ContentID)   
) TABLESPACE "USERS";

CREATE TABLE "VMS_PORTAL"."PORTALTRACKING"
(
   TrackingID             NUMBER(24,0)                            NOT NULL PRIMARY KEY,
   ContentID              NUMBER(24,0)                            NOT NULL,
   Views              	  NUMBER(24,0)                            DEFAULT 0 NULL,
   Likes                  NUMBER(24,0)                            DEFAULT 0 NULL,
   Dislike                NUMBER(24,0)                            DEFAULT 0 NULL,
   TrackingDate           DATE                      NOT NULL,
   CONSTRAINT "PORTALTRACKING_CONTENT_FK" FOREIGN KEY(ContentID) REFERENCES "VMS_PORTAL"."PORTALCONTENT"(ContentID)  
) TABLESPACE "USERS";

CREATE TABLE "VMS_PORTAL"."PORTALPAGE"
(
   PageID              NUMBER(24,0)                            NOT NULL PRIMARY KEY,
   Code                  VARCHAR2(255 CHAR)                  NOT NULL,
   Keyword                VARCHAR2(500 CHAR)                  NULL,
   Title                VARCHAR2(500 CHAR)                  NULL,
   XMLData                CLOB                   NULL,
   CreatedDate            TIMESTAMP                      NOT NULL,
   ModifiedDate           TIMESTAMP                      NOT NULL
) TABLESPACE "USERS";
CREATE SEQUENCE  "VMS_PORTAL"."PORTALUSERGROUP_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
CREATE SEQUENCE  "VMS_PORTAL"."PORTALDEPARTMENT_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
CREATE SEQUENCE  "VMS_PORTAL"."PORTALUSER_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
CREATE SEQUENCE  "VMS_PORTAL"."PORTALROLE_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
CREATE SEQUENCE  "VMS_PORTAL"."PORTALCONTENTCATEGORY_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
CREATE SEQUENCE  "VMS_PORTAL"."PORTALTEMPLATE_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
CREATE SEQUENCE  "VMS_PORTAL"."PORTALCONTENT_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
CREATE SEQUENCE  "VMS_PORTAL"."PORTALCOMMENT_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
CREATE SEQUENCE  "VMS_PORTAL"."PORTALTRACKING_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

CREATE SEQUENCE  "VMS_PORTAL"."PORTALPAGE_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

COMMIT;