
DROP TABLE IF EXISTS configuration;
CREATE TABLE configuration (
  ConfigurationID bigint(20) NOT NULL AUTO_INCREMENT,
  HotLine VARCHAR(255),
  AboutMe VARCHAR(512),
  CustomCSS TEXT,
  PRIMARY KEY (ConfigurationID)
);
