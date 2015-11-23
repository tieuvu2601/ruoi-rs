package com.banvien.portal.vms.service;

import com.banvien.portal.vms.dao.UserDepartmentACLDAO;
import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.domain.Department;
import com.banvien.portal.vms.domain.User;
import com.banvien.portal.vms.domain.UserDepartmentACL;
import com.banvien.portal.vms.exception.ObjectNotFoundException;

import java.util.List;

/**
 * Created by Ban Vien Ltd.
 * User: Vien Nguyen (vien.nguyen@banvien.com)
 * Date: 11/29/12
 * Time: 1:33 AM
 */
public class UserDepartmentACLServiceImpl extends GenericServiceImpl<UserDepartmentACL, Long> implements UserDepartmentACLService{
    private UserDepartmentACLDAO userDepartmentACLDAO;

    public void setUserDepartmentACLDAO(UserDepartmentACLDAO userDepartmentACLDAO) {
        this.userDepartmentACLDAO = userDepartmentACLDAO;
    }

    @Override
    protected GenericDAO<UserDepartmentACL, Long> getGenericDAO() {
        return userDepartmentACLDAO;
    }


    @Override
    public UserDepartmentACL getItemByDepartmentAndUser(Long departmentID, Long userID) throws ObjectNotFoundException{
        UserDepartmentACL res = this.userDepartmentACLDAO.getItemByDepartmentAndUser(departmentID, userID);
        if (res == null) throw  new ObjectNotFoundException("Not found ACL for department " + departmentID + " of user " + userID);
        return res;
    }

    @Override
    public void updateUserACL(Long userID, Long[] departmentIDsInPage, String[] checkList) {
        List<UserDepartmentACL> userDepartmentACLs = userDepartmentACLDAO.findByDepartmentsOfUser(userID, departmentIDsInPage);
        if (checkList != null && checkList.length > 0) {
            for (String s : checkList) {
                Long id = Long.valueOf(s);
                UserDepartmentACL userDepartmentACL = null;
                for (int i = userDepartmentACLs.size() - 1; i >= 0; i--) {
                    UserDepartmentACL temp = userDepartmentACLs.get(i);
                    if (temp.getDepartment().getDepartmentID().equals(id)) {
                        userDepartmentACL = temp;
                        userDepartmentACLs.remove(i);
                        break;
                    }
                }
                if (userDepartmentACL == null) {
                    userDepartmentACL = new UserDepartmentACL();
                    User user = new User();
                    user.setUserID(userID);
                    Department department = new Department();
                    department.setDepartmentID(id);
                    userDepartmentACL.setUser(user);
                    userDepartmentACL.setDepartment(department);

                    this.userDepartmentACLDAO.save(userDepartmentACL);

                }
            }
        }

        if (userDepartmentACLs.size() > 0) {
            this.userDepartmentACLDAO.deleteAll(userDepartmentACLs);
        }
    }
}
