package com.banvien.portal.vms.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.security.web.session.HttpSessionEventPublisher;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;



/**
 * UserCounterListener class used to count the current number
 * of active users for the applications.  Does this by counting
 * how many user objects are stuffed into the session.  It also grabs
 * these users and exposes them in the servlet context.
 *
 */
public class UserCounterListener extends HttpSessionEventPublisher implements ServletContextListener, HttpSessionAttributeListener {
    private transient final Logger logger = Logger.getLogger(getClass());
    /**
     * Name of user counter variable
     */
    public static final String COUNT_KEY = "userOnlineCounter";
    public static final String TOTAL_VISITORS_KEY = "totalVisitors";
    /**
     * Name of users Set in the ServletContext
     */
    public static final String USERS_KEY = "userNames";
    /**
     * The default event we're looking to trap.
     */
    public static final String EVENT_KEY = "SPRING_SECURITY_CONTEXT";
    private transient final Log log = LogFactory.getLog(getClass());
    private transient ServletContext servletContext;
    private int userOnlineCounter = 1;

    /**
     * Initialize the context
     *
     * @param sce the event
     */
    public synchronized void contextInitialized(ServletContextEvent sce) {
        servletContext = sce.getServletContext();
        servletContext.setAttribute(COUNT_KEY, Integer.toString(userOnlineCounter));
        servletContext.setAttribute(TOTAL_VISITORS_KEY, 0);
    }

    /**
     * Set the servletContext, users and counter to null
     *
     * @param event The servletContextEvent
     */
    public synchronized void contextDestroyed(ServletContextEvent event) {
        servletContext = null;
        userOnlineCounter = 0;
    }

    synchronized void incrementUserCounter() {
        userOnlineCounter = Integer.parseInt((String) servletContext.getAttribute(COUNT_KEY));
        userOnlineCounter++;
        servletContext.setAttribute(COUNT_KEY, Integer.toString(userOnlineCounter));
    }

    synchronized void decrementUserCounter() {
        int userOnlineCounter = Integer.parseInt((String) servletContext.getAttribute(COUNT_KEY));
        userOnlineCounter--;

        if (userOnlineCounter < 0) {
            userOnlineCounter = 0;
        }

        servletContext.setAttribute(COUNT_KEY, Integer.toString(userOnlineCounter));
    }

    protected ApplicationContext getContext(ServletContext servletContext) {
        return WebApplicationContextUtils.getWebApplicationContext(servletContext);
    }

    public void sessionCreated(javax.servlet.http.HttpSessionEvent event) {
        incrementUserCounter();
        String ipAddr = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                .getRequest().getRemoteAddr();
        logger.warn("=================Session created for IP: " + ipAddr);
        logger.warn("=================Total Session created: " + userOnlineCounter);
        try{
            if(((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest().getUserPrincipal() != null)
            {
                logger.warn("=================Username just logined: " + ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                        .getRequest().getUserPrincipal().getName());
            }
        }catch (Exception e) {
           //nothing
        }

    }

    @Override
    public void attributeAdded(HttpSessionBindingEvent httpSessionBindingEvent) {
        if(httpSessionBindingEvent.getName().equals(EVENT_KEY)) {
            incrementUserCounter();
        }
    }

    @Override
    public void attributeRemoved(HttpSessionBindingEvent httpSessionBindingEvent) {
        if(httpSessionBindingEvent.getName().equals(EVENT_KEY)) {
            decrementUserCounter();
        }
    }

    @Override
    public void attributeReplaced(HttpSessionBindingEvent httpSessionBindingEvent) {
    }

    public void sessionDestroyed(HttpSessionEvent event) {
        decrementUserCounter();
    }
}
