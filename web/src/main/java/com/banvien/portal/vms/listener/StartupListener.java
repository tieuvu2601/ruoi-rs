package com.banvien.portal.vms.listener;


import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jbpm.api.IdentityService;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.banvien.portal.vms.core.context.AppContext;
import com.banvien.portal.vms.jbpm.service.JbpmSpringService;
import com.banvien.portal.vms.util.Constants;

/**
 * <p>StartupListener class used to initialize and database settings
 * and populate any application-wide drop-downs.
 * <p/>
 * <p>Keep in mind that this listener is executed outside of OpenSessionInViewFilter,
 * so if you're using Hibernate you'll have to explicitly initialize all loaded data at the
 * GenericDao or service level to avoid LazyInitializationException. Hibernate.initialize() works
 * well for doing this.
 *
 */
public class StartupListener implements ServletContextListener {
	private final static Log log = LogFactory.getLog(StartupListener.class);
    
    /**
     * {@inheritDoc}
     */
    @SuppressWarnings("unchecked")
    public void contextInitialized(ServletContextEvent event) {
        log.debug("Initializing context...");

        ServletContext context = event.getServletContext();

        // set fields of Constants class in Application Scope
        context.setAttribute(Constants.class.getSimpleName(), createNameToValueMap());
        
        // Orion starts Servlets before Listeners, so check if the config
        // object already exists
        Map<String, Object> config = (HashMap<String, Object>) context.getAttribute(Constants.CONFIG);

        if (config == null) {
            config = new HashMap<String, Object>();
        }

        if (context.getInitParameter(Constants.CSS_THEME) != null) {
            config.put(Constants.CSS_THEME, context.getInitParameter(Constants.CSS_THEME));
        }

        if (context.getInitParameter(Constants.MOBI8_URL) != null) {
            config.put(Constants.MOBI8_URL, context.getInitParameter(Constants.MOBI8_URL));
        }
        //deploy jbpm
        try {
        	ApplicationContext ctx = WebApplicationContextUtils.getRequiredWebApplicationContext(context);
            AppContext.setApplicationContext(ctx);

	        JbpmSpringService  jbpmSpringService = ctx.getBean(JbpmSpringService.class);
	        if(!jbpmSpringService.isProcessDeployed(Constants.CONTENT_PAGEFLOW_PROCESS_KEY)) {
				jbpmSpringService.deploy(Constants.CONTENT_PAGEFLOW_PROCESS_FILE_NAME);

				IdentityService  identityService = ctx.getBean(IdentityService.class);
				createJbpmTempUser(identityService);
	        }

	        if(!jbpmSpringService.isProcessDeployed(Constants.EDITOR_PAGEFLOW_PROCESS_KEY)) {
	        	jbpmSpringService.deploy(Constants.EDITOR_PAGEFLOW_PROCESS_FILE_NAME);
	        }

	        if(!jbpmSpringService.isProcessDeployed(Constants.APPROVER_PAGEFLOW_PROCESS_KEY)) {
	        	jbpmSpringService.deploy(Constants.APPROVER_PAGEFLOW_PROCESS_FILE_NAME);
	        }

	        if(!jbpmSpringService.isProcessDeployed(Constants.PUBLISHER_PAGEFLOW_PROCESS_KEY)) {
	        	jbpmSpringService.deploy(Constants.PUBLISHER_PAGEFLOW_PROCESS_FILE_NAME);
	        }
        }catch (Throwable e) {
        	log.error(e.getMessage(), e);
		}
        context.setAttribute(Constants.CONFIG, config);

        setupContext(context);
        

    }
    
    private void createJbpmTempUser(IdentityService  identityService) {
		String[] groups = new String[]{Constants.GROUP_AUTHOR, Constants.GROUP_EDITOR, Constants.GROUP_APPROVER,  Constants.GROUP_PUBLISHER};
		String[] users = new String[]{Constants.JBPM_USER_AUTHOR, Constants.JBPM_USER_EDITOR, Constants.JBPM_USER_APPROVER,  Constants.JBPM_USER_PUBLISHER};
		for(int i = 0; i < groups.length; i++) {
			org.jbpm.api.identity.Group jbpmGroup = identityService.findGroupById(groups[i]);
			if(jbpmGroup == null) {
				identityService.createGroup(groups[i]);
			}
			org.jbpm.api.identity.User jbpmUser = identityService.findUserById(users[i]);
			if(jbpmUser == null) {
				identityService.createUser(users[i], users[i], users[i]);
				identityService.createMembership(users[i], groups[i]);
			}
		}
	}
    
	/**
     * This method uses the LookupManager to lookup available roles from the data layer.
     *
     * @param context The servlet context
     */
    public static void setupContext(ServletContext context) {

    }

    /**
     * Shutdown servlet context (currently a no-op method).
     *
     * @param servletContextEvent The servlet context event
     */
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
        //LogFactory.release(Thread.currentThread().getContextClassLoader());
        //Commented out the above call to avoid warning when SLF4J in classpath.
        //WARN: The method class org.apache.commons.logging.impl.SLF4JLogFactory#release() was invoked.
        //WARN: Please see http://www.slf4j.org/codes.html for an explanation.
    }
    
    /**
     * Puts all public static fields via introspection into the resulting Map.
     * Uses the name of the field as key to reference it's in the Map.
     *
     * @return a Map of field names to field values of
     *         all public static fields of this class
     */
    private static Map createNameToValueMap() {
        Map result = new HashMap();
        Field[] publicFields = Constants.class.getFields();
        for (int i = 0; i < publicFields.length; i++) {
            Field field = publicFields[i];
            String name = field.getName();
            try {
                result.put(name, field.get(null));
            } catch (Exception e) {
                log.fatal(e);
            }
        }

        return result;
    }
}
