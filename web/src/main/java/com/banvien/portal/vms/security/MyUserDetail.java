package com.banvien.portal.vms.security;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class MyUserDetail extends User {

	public MyUserDetail(String username, String password, boolean enabled,
			boolean accountNonExpired, boolean credentialsNonExpired,
			boolean accountNonLocked, GrantedAuthority[] authorities) {
		super(username, password, enabled, accountNonExpired, credentialsNonExpired,
				accountNonLocked, authorities);
	}
	
	private Long userId;

    private String displayName;
	

	private String email;

    private Long departmentID;

    private Boolean isFullAccessSystem;
	
	
	/**
	 * @return the userID
	 */
    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    /**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}
	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public Long getDepartmentID() {
        return departmentID;
    }

    public void setDepartmentID(Long departmentID) {
        this.departmentID = departmentID;
    }

    public Boolean getFullAccessSystem() {
        return isFullAccessSystem;
    }

    public void setFullAccessSystem(Boolean fullAccessSystem) {
        isFullAccessSystem = fullAccessSystem;
    }

    public Boolean getIsFullAccessSystem() {
        return isFullAccessSystem;
    }

    public void setIsFullAccessSystem(Boolean isFullAccessSystem) {
        this.isFullAccessSystem = isFullAccessSystem;
    }
}
