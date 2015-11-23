package com.banvien.portal.vms.security;


import org.apache.log4j.Logger;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.util.StringUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 *
 */
public class MyAuthenticationSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {
	private transient final Logger logger = Logger.getLogger(getClass());
    
	
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws ServletException, IOException {
    	String targetUrl = "";
    	try {
    		RequestCache requestCache = new HttpSessionRequestCache();
    		if(requestCache != null) {
		    	SavedRequest savedRequest =
		    			requestCache.getRequest(request, response);
		    	targetUrl = savedRequest.getRedirectUrl();
    		}
    	}catch (Exception e) {
    		logger.debug("Cannot get previous URL");
		}
        if (StringUtils.hasText(targetUrl)) {
        	clearAuthenticationAttributes(request);
            
            logger.debug("Redirecting to DefaultSavedRequest Url: " + targetUrl);
            getRedirectStrategy().sendRedirect(request, response, targetUrl);
            return;
        }else {
        	super.onAuthenticationSuccess(request, response, authentication);
        }
    }
}
