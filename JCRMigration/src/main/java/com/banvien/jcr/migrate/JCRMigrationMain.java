package com.banvien.jcr.migrate;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.banvien.jcr.api.FileItem;
import com.banvien.jcr.api.IJcrContent;

public class JCRMigrationMain {
	 private transient static final Logger logger = Logger.getLogger(JCRMigrationMain.class);
	public static void main(String[] args) {
		ApplicationContext context = new ClassPathXmlApplicationContext(new String[]{"migrationContext-jcr.xml", 
				"migrationContext-jcr2.xml"});
		
		IJcrContent jcrContent = (IJcrContent)context.getBean("jcrContent");
		IJcrContent jcrContent2 = (IJcrContent)context.getBean("jcrContent2");
		logger.debug("Getting files...");
		try{
			Object obj = jcrContent2.getAll("vms-web");
			if(obj != null){
				Object[] objs = (Object[])obj;
				int size = Integer.valueOf(objs[0].toString());
				if(size > 0){
					List<FileItem> fileItems = (List<FileItem>)objs[1];
					if(fileItems.size() > 0){
						logger.debug("TOTAL FILES: " + fileItems.size());
						for (FileItem file : fileItems) {
							try{
								String path = file.getPath().substring(1);
								int iSecondFlash = path.lastIndexOf("/");
								path = path.substring(0, iSecondFlash);
								logger.debug("Writing " + file.getPath() + " to " + path);
								jcrContent.write(path, file);
							}catch (Exception e) {
								logger.error("ERROR: " + file.getPath(), e);
							}
						}
					}
				}
			}else {
				logger.debug("There is no file in JCR");
			}
		}catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		logger.debug("DONE.");
		System.exit(0);
	}

}
