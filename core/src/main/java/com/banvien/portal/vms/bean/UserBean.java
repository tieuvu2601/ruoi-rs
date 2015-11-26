package com.banvien.portal.vms.bean;

import com.banvien.portal.vms.domain.User;

public class UserBean extends AbstractBean<User> {
    public UserBean()
    {
        this.pojo = new User();
    }

    private FileItem fileItem;
    
    private String avatar;

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
}
