package com.banvien.portal.vms.security;

import com.banvien.portal.vms.util.Constants;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AuthenticationProcessingFilterExtends extends
        AbstractAuthenticationProcessingFilter {
	protected final Log logger = LogFactory.getLog(this.getClass());
	public AuthenticationProcessingFilterExtends(){
		super("/loginProcess");
	}
	protected AuthenticationProcessingFilterExtends(
			String defaultFilterProcessesUrl) {
		super(defaultFilterProcessesUrl);
	}

	
	private String languageParam = "location";
	
	

	public String getLanguageParam() {
		return languageParam;
	}

	public void setLanguageParam(String languageParam) {
		this.languageParam = languageParam;
	}

	
	
	@Override
	public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
			throws AuthenticationException {
		String username = obtainUsername(request);
		String password = obtainPassword(request);

		if (username == null) {
			username = "";
		}

		if (password == null){
			password = "";
		}
		
		username = username.trim().toUpperCase();
		
		UsernamePasswordAuthenticationToken authRequest = new UsernamePasswordAuthenticationToken(username, password);

		// Place the last username attempted into HttpSession for views
		request.getSession().setAttribute(Constants.ACEGI_SECURITY_LAST_USERNAME_KEY, username);
		String j_username = request.getParameter(Constants.ACEGI_SECURITY_FORM_USERNAME_KEY);
		request.getSession().setAttribute(Constants.ACEGI_SECURITY_FORM_USERNAME_KEY, j_username);

		String lang = null;
		lang = request.getParameter(this.languageParam);

		if (lang == null || lang.trim().equals("")) {
			lang = (String) request.getSession().getAttribute(
					this.languageParam);
		}
		request.getSession().setAttribute("lang", lang);

		// Allow subclasses to set the "details" property
		setDetails(request, authRequest);
		return this.getAuthenticationManager().authenticate(authRequest);
	}
	

	/**
	 * Enables subclasses to override the composition of the password, such as
	 * by including additional values and a separator.
	 * <p>
	 * This might be used for example if a postcode/zipcode was required in
	 * addition to the password. A delimiter such as a pipe (|) should be used
	 * to separate the password and extended value(s). The
	 * <code>AuthenticationDao</code> will need to generate the expected
	 * password in a corresponding manner.
	 * </p>
	 * 
	 * @param request
	 *            so that request attributes can be retrieved
	 * 
	 * @return the password that will be presented in the
	 *         <code>Authentication</code> request token to the
	 *         <code>AuthenticationManager</code>
	 */
	protected String obtainPassword(HttpServletRequest request) {
		return request.getParameter(Constants.ACEGI_SECURITY_FORM_PASSWORD_KEY);
	}
	

	/**
	 * Enables subclasses to override the composition of the username, such as
	 * by including additional values and a separator.
	 * 
	 * @param request
	 *            so that request attributes can be retrieved
	 * 
	 * @return the username that will be presented in the
	 *         <code>Authentication</code> request token to the
	 *         <code>AuthenticationManager</code>
	 */
	protected String obtainUsername(HttpServletRequest request) {
		return StringUtils.trim(request.getParameter(Constants.ACEGI_SECURITY_FORM_USERNAME_KEY));
	}

	/**
	 * Provided so that subclasses may configure what is put into the
	 * authentication request's details property.
	 * 
	 * @param request
	 *            that an authentication request is being created for
	 * @param authRequest
	 *            the authentication request object that should have its details
	 *            set
	 */
	protected void setDetails(HttpServletRequest request,
			UsernamePasswordAuthenticationToken authRequest) {
		authRequest.setDetails(authenticationDetailsSource.buildDetails(request));
	}


}
