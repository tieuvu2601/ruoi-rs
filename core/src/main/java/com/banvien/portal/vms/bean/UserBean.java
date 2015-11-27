package com.banvien.portal.vms.bean;

import com.banvien.portal.vms.domain.User;

import java.util.Map;

public class UserBean extends AbstractBean<User> {
    public UserBean()
    {
        this.pojo = new User();
    }

    public RoleBean getRoleBean() {
        return roleBean;
    }

    public void setRoleBean(RoleBean roleBean) {
        this.roleBean = roleBean;
    }

    private RoleBean roleBean;

    public Map<Long, Boolean> getRoleMap() {
        return roleMap;
    }

    public void setRoleMap(Map<Long, Boolean> roleMap) {
        this.roleMap = roleMap;
    }

    public FileItem getFileItem() {
		return fileItem;
	}

	public void setFileItem(FileItem fileItem) {
		this.fileItem = fileItem;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	private Map<Long, Boolean> roleMap;
    
    private FileItem fileItem;
    
    private String avatar;

}
