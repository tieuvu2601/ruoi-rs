/**
 * 
 */
package com.banvien.portal.vms.security;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.security.web.authentication.rememberme.TokenBasedRememberMeServices;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author Nguyen Hai Vien
 *
 */
public class MyLogoutSuccessHandler implements LogoutSuccessHandler {
	protected final Log logger = LogFactory.getLog(this.getClass());
	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
	private String logoutSuccessUrl = "/login.html?action=logout";
	/**
	 * @param logoutSuccessUrl the logoutSuccessUrl to set
	 */
	public void setLogoutSuccessUrl(String logoutSuccessUrl) {
		this.logoutSuccessUrl = logoutSuccessUrl;
	}
	public void onLogoutSuccess(HttpServletRequest request,
			HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {

		Cookie terminate = new Cookie(TokenBasedRememberMeServices.SPRING_SECURITY_REMEMBER_ME_COOKIE_KEY, null);
		String contextPath = request.getContextPath();
		terminate.setPath(contextPath != null && contextPath.length() > 0 ? contextPath : "/");
		terminate.setMaxAge(0);
		response.addCookie(terminate);

		/**
		 * Invalidate session
		 */
		if (request.getSession(false) != null) {
			request.getSession(false).invalidate();
		}
        SecurityContextHolder.clearContext();
        request.getSession(true); //Create new session
		redirectStrategy.sendRedirect(request, response, this.logoutSuccessUrl);
	}
}
