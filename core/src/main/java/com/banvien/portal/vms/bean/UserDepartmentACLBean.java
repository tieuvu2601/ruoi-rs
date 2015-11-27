package com.banvien.portal.vms.bean;

import com.banvien.portal.vms.domain.Department;
import com.banvien.portal.vms.domain.User;
import com.banvien.portal.vms.domain.UserDepartmentACL;

import java.util.Map;

/**
 * Created by Ban Vien Co., Ltd.
 * User: viennh
 * Email: vien.nguyen@banvien.com
 * Date: 3/12/13
 * Time: 1:29 PM
 */
public class UserDepartmentACLBean extends AbstractBean<Department>{
    private Map<Long, UserDepartmentACL> departmentACLMap;

    private Long userID;

    private Long[] departmentIDsInPage;

    public Long getUserID() {
        return userID;
    }

    public void setUserID(Long userID) {
        this.userID = userID;
    }

    public Map<Long, UserDepartmentACL> getDepartmentACLMap() {
        return departmentACLMap;
    }

    public void setDepartmentACLMap(Map<Long, UserDepartmentACL> departmentACLMap) {
        this.departmentACLMap = departmentACLMap;
    }

    public Long[] getDepartmentIDsInPage() {
        return departmentIDsInPage;
    }

    public void setDepartmentIDsInPage(Long[] departmentIDsInPage) {
        this.departmentIDsInPage = departmentIDsInPage;
    }
}
