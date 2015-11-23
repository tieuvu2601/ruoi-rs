package com.banvien.portal.vms.jbpm.service;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jbpm.api.ProcessEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextClosedEvent;
import org.springframework.stereotype.Component;

/**
 * A Spring ApplicationListener that will properly shut down
 * the jBPM process engine when the Spring context is destroyed.
 * 
 * @author hieu
 */
@Component
 @SuppressWarnings("unchecked")
public class SpringJbpmJobExecutorShutdownHook implements ApplicationListener<ContextClosedEvent> {
    
	private transient final Log log = LogFactory.getLog(getClass());
    
	@Autowired
    ProcessEngine processEngine;
    
    public void onApplicationEvent(ContextClosedEvent event) {
        log.info("Spring ApplicationContext shutting down.  Closing jBPM process engine.");
        processEngine.close();
        log.info("jBPM process engine closed.");
    }
}
