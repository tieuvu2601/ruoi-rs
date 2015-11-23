package com.banvien.jcr.api.struts;


import javax.jcr.Repository;
import javax.jcr.Session;
import javax.jcr.SimpleCredentials;
import javax.servlet.ServletException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.jackrabbit.rmi.client.ClientRepositoryFactory;
import org.apache.struts.action.ActionServlet;
import org.apache.struts.action.PlugIn;
import org.apache.struts.config.ModuleConfig;

public class JcrPlugin implements PlugIn{
	private String rmiPath;
	private static String webdavContextPath;
	private static Session session;
	private Log logger = LogFactory.getLog(JcrPlugin.class);
	
	public void destroy() {
		session.logout();
	}
	public void init(ActionServlet arg0, ModuleConfig arg1) throws ServletException {
		logger.info("Entering JackrabbitPlugin.init()");
		
		try{
			//String name = "rmi://10.2.80.59:1098/jackrabbit.repository"; // The RMI URL of the repository
		    
			ClientRepositoryFactory factory = new ClientRepositoryFactory();
			
			Repository repository = factory.getRepository(rmiPath);
			SimpleCredentials cred = new SimpleCredentials("adminId", "admin".toCharArray());
			session = repository.login(cred);
			logger.info("Entering JackrabbitPlugin.init() ok");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	public static Session getSession() {
		return session;
	}
	public String getRmiPath() {
		return rmiPath;
	}
	public void setRmiPath(String rmiPath) {
		this.rmiPath = rmiPath;
	}
	public static String getWebdavContextPath() {
		return webdavContextPath;
	}
	public void setWebdavContextPath(String webdavContextPath) {
		this.webdavContextPath = webdavContextPath;
	}
}
