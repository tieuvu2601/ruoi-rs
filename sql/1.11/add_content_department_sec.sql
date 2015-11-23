CREATE TABLE PortalContentDepartment (
  ContentDepartmentID NUMBER PRIMARY KEY,
  ContentID NUMBER NOT NULL,
  DepartmentID NUMBER NOT NULL,
  CONSTRAINT "PORTALCONTENTDEPARTMENT_UQ" UNIQUE (ContentID, DepartmentID)
);

ALTER TABLE PortalContentDepartment ADD CONSTRAINT FK_CD_Content FOREIGN KEY (ContentID) REFERENCES PortalContent(ContentID) ON DELETE CASCADE ;
ALTER TABLE PortalContentDepartment ADD CONSTRAINT FK_CD_Department FOREIGN KEY (DepartmentID) REFERENCES PortalDepartment(DepartmentID) ON DELETE CASCADE ;
CREATE SEQUENCE PortalContentDepartment_SEQ  MINVALUE 1 MAXVALUE 999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;


ALTER TABLE PORTALDEPARTMENT
ADD
(
  IsBranch INT null
);

CREATE TABLE PortalUserDepartmentACL (
  UserDepartmentACLID NUMBER PRIMARY KEY,
  UserID NUMBER NOT NULL,
  DepartmentID NUMBER NOT NULL,
  CONSTRAINT "PortalUserDepartmentACL_UQ" UNIQUE (UserID, DepartmentID)
);

ALTER TABLE PortalUserDepartmentACL ADD CONSTRAINT FK_UDACL_User FOREIGN KEY (UserID) REFERENCES PortalUser(UserID) ON DELETE CASCADE ;
ALTER TABLE PortalUserDepartmentACL ADD CONSTRAINT FK_UDACL_Department FOREIGN KEY (DepartmentID) REFERENCES PortalDepartment(DepartmentID) ON DELETE CASCADE ;
CREATE SEQUENCE PortalUserDepartmentACL_SEQ  MINVALUE 1 MAXVALUE 999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

