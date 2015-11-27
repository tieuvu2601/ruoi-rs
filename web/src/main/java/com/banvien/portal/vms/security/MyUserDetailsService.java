package com.banvien.portal.vms.security;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.banvien.portal.vms.dao.DepartmentDAO;
import com.banvien.portal.vms.dao.UserDAO;
import com.banvien.portal.vms.dao.UserGroupDAO;
import org.apache.log4j.Logger;
import org.springframework.beans.BeanUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.userdetails.UserCache;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.banvien.portal.vms.dao.RoleDAO;
import com.banvien.portal.vms.domain.Role;
import com.banvien.portal.vms.domain.User;
import com.banvien.portal.vms.service.UserService;
import com.banvien.portal.vms.util.Constants;


/**
 * @author Nguyen Hai Vien
 * 
 */

public class MyUserDetailsService implements UserDetailsService {
	 private transient final Logger logger = Logger.getLogger(MyUserDetailsService.class);

	protected UserCache userCache = null;
	
	private UserService userService;

    private RoleDAO roleDAO;

    private DepartmentDAO departmentDAO;

    private UserGroupDAO userGroupDAO;

    private UserDAO userDAO;

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public void setRoleDAO(RoleDAO roleDAO) {
        this.roleDAO = roleDAO;
    }

    public void setDepartmentDAO(DepartmentDAO departmentDAO) {
        this.departmentDAO = departmentDAO;
    }

    public void setUserGroupDAO(UserGroupDAO userGroupDAO) {
        this.userGroupDAO = userGroupDAO;
    }

    public UserDAO getUserDAO() {
        return userDAO;
    }

    public void setUserDAO(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    /**
	 * Creates new instance of UserManagerDaoImpl
	 */
	public MyUserDetailsService() {

	}

	/**
	 * Set UserCache
	 * 
	 * @param userCache
	 *            user cache to set
	 */
	public void setUserCache(UserCache userCache) {
		this.userCache = userCache;
	}

	/**
	 * Locates the user based on the username. In the actual implementation, the
	 * search may possibly be case insensitive, or case insensitive depending on
	 * how the implementaion instance is configured. In this case, the
	 * <code>UserDetails</code> object that comes back may have a username
	 * that is of a different case than what was actually requested..
	 * 
	 * @param username
	 *            the username presented to the {@link
	 *            org.springframework.security.authentication.dao.DaoAuthenticationProvider}
	 * @return a fully populated user record (never <code>null</code>)
	 * @throws org.springframework.security.core.userdetails.UsernameNotFoundException
	 *             if the user could not be found or the user has no
	 *             GrantedAuthority
	 * @throws org.springframework.dao.DataAccessException
	 *             if user could not be found for a repository-specific reason
	 */
	public UserDetails loadUserByUsername(String username)
			throws UsernameNotFoundException, DataAccessException {
        logger.warn("=================User " + username + " try to login");
		User account = null;

		try {
			account = userService.findByUserName(username);
			Integer activeStatus = 1;
			if (account == null || !activeStatus.equals(account.getStatus())) {				
				throw new UsernameNotFoundException("UserProcessingFilter.usernameNotFound");
			}
			
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			throw new UsernameNotFoundException(e.getMessage());
		}

		Map<String, GrantedAuthority> authorities = new HashMap<String, GrantedAuthority>();

		//this line of code is used to check whether the user has login or not
		authorities.put(Constants.LOGON_ROLE, new GrantedAuthorityImpl(Constants.LOGON_ROLE));
        if (account.getUserGroup() != null) {
		    authorities.put(account.getUserGroup().getCode(), new GrantedAuthorityImpl(account.getUserGroup().getCode()));
        }

        List<Role> roleList = roleDAO.findByUserID(account.getUserID());
        for (Role role : roleList) {
            authorities.put(role.getRole(), new GrantedAuthorityImpl(role.getRole()));
        }
        if (account.getFullAccess() != null && account.getFullAccess().equals(1)) {
            authorities.put(Constants.FULL_ACCESS_RIGHT, new GrantedAuthorityImpl(Constants.FULL_ACCESS_RIGHT));
        }

		GrantedAuthority[] grantedAuthority = new GrantedAuthority[authorities.size()];
		authorities.values().toArray(grantedAuthority);
		MyUserDetail loginUser = new MyUserDetail(username, username, true, true, true, true, grantedAuthority);

        if (account != null && account.getDepartment() != null) {
            loginUser.setDepartmentID(account.getDepartment().getDepartmentID());
        }
        loginUser.setFullAccessSystem(account.getFullAccess() != null && account.getFullAccess().equals(1) ? true : false);
		BeanUtils.copyProperties(account, loginUser);

		return loginUser;
	}
}