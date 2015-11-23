package com.banvien.portal.vms.security;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.banvien.portal.vms.dao.DepartmentDAO;
import com.banvien.portal.vms.dao.UserDAO;
import com.banvien.portal.vms.dao.UserGroupDAO;
import com.banvien.portal.vms.domain.Department;
import com.banvien.portal.vms.dto.UserDTO;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.jbpm.api.IdentityService;
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
import com.banvien.portal.vms.dto.C2UserDTO;
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

    private IdentityService identityService;

    private LdapUserLookup ldapUserLookup;

    private UserGroupDAO userGroupDAO;

    private UserDAO userDAO;

    public void setLdapUserLookup(LdapUserLookup ldapUserLookup) {
        this.ldapUserLookup = ldapUserLookup;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public void setRoleDAO(RoleDAO roleDAO) {
        this.roleDAO = roleDAO;
    }

    public void setDepartmentDAO(DepartmentDAO departmentDAO) {
        this.departmentDAO = departmentDAO;
    }

    public void setIdentityService(IdentityService identityService) {
		this.identityService = identityService;
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
//            if (account == null) {
                //Check from LDAP
//                UserDTO userDTO = null;
//                try{
//                    userDTO = ldapUserLookup.getUser(username);
//                    if (userDTO != null) {
//                        account = new User();
//                        account.setUsername(username);
//                        account.setPassword(userDTO.getPassword());
//                        account.setDisplayName(userDTO.getDisplayName());
//                        account.setStatus(1);
//                        account.setCreatedDate(new Timestamp(System.currentTimeMillis()));
//                        account.setIsShopper(0);
//                        account.setUserGroup(userGroupDAO.findEqualUnique("code", Constants.GROUP_GUEST));
//
//                        if (StringUtils.isNotBlank(userDTO.getDepartment())) {
//                            Department department = departmentDAO.findEqualUnique("organizationUnit", userDTO.getDepartment());
//                            account.setDepartment(department);
//                        }
//
//                        account = userService.save(account);
//                    }
//                }catch (Exception e) {
//                    userDTO = null;
//                }
//                if (userDTO == null) {
//                    C2UserDTO c2UserDTO = userService.findC2UserByUsername(username);
//                    if (c2UserDTO != null) {
//                        account = new User();
//                        account.setUsername(c2UserDTO.getUsername());
//                        account.setPassword(c2UserDTO.getPassword());
//                        account.setDisplayName(c2UserDTO.getFullname());
//                        account.setStatus(Integer.valueOf(c2UserDTO.getStatus()));
//                        account.setCreatedDate(new Timestamp(System.currentTimeMillis()));
//                        account.setUserGroup(userGroupDAO.findEqualUnique("code", Constants.GROUP_GUEST));
//                        try{
//                            Department department = departmentDAO.findDepartmentByShopCode(c2UserDTO.getShopcode());
//                            account.setDepartment(department);
//                            if (!department.getCode().equals(c2UserDTO.getShopcode())) {
//                                account.setIsShopper(1);
//                            }else{
//                                account.setIsShopper(0);
//                            }
//                        }catch (Exception e) {
//
//                        }
//                        account = userService.save(account);
//                    }
//                }
//            }
			if (account == null || !activeStatus.equals(account.getStatus())) {				
				throw new UsernameNotFoundException("UserProcessingFilter.usernameNotFound");
			}
			
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			throw new UsernameNotFoundException(e.getMessage());
		}
		//create jbpm user and usergroup if not existed
		try {
			if(account.getUserGroup() != null) {
				org.jbpm.api.identity.Group jbpmGroup = identityService.findGroupById(account.getUserGroup().getCode());
				if(jbpmGroup == null) {
					identityService.createGroup(account.getUserGroup().getCode());
				}
			}
			org.jbpm.api.identity.User jbpmUser = identityService.findUserById(username);
			if(jbpmUser != null) {
				List<String> jbpmGroups = identityService.findGroupIdsByUser(username);
				if(jbpmGroups != null && jbpmGroups.size() > 0 && account.getUserGroup() != null) {
                    try {
                        identityService.deleteMembership(username, jbpmGroups.get(0), null);
                        identityService.createMembership(username, account.getUserGroup().getCode());
                        }catch(Exception e) {}
//					identityService.createMembership(username, account.getUserGroup().getCode());
				}else if(account.getUserGroup() != null) {
					identityService.createMembership(username, account.getUserGroup().getCode());
				}
			}else {
				identityService.createUser(username, username, account.getDisplayName());
				if(account.getUserGroup() != null) {
					identityService.createMembership(username, account.getUserGroup().getCode());
				}
			}
			
		}catch (Exception e) {
			logger.error(e.getMessage(), e);
			throw new UsernameNotFoundException("UserProcessingFilter.usernameNotFound");
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