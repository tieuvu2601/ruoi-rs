package com.banvien.portal.vms.service.impl;

import com.banvien.portal.vms.bean.UserBean;
import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.dao.RoleDAO;
import com.banvien.portal.vms.dao.UserRoleDAO;
import com.banvien.portal.vms.domain.Role;
import com.banvien.portal.vms.domain.User;
import com.banvien.portal.vms.domain.UserRole;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.UserRoleService;
import org.apache.log4j.Logger;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 11/13/12
 * Time: 4:59 PM
 * Author: vien.nguyen@banvien.com
 */
public class UserRoleServiceImpl extends GenericServiceImpl<UserRole, Long> implements UserRoleService {
    private transient final Logger logger = Logger.getLogger(getClass());

    private UserRoleDAO userRoleDAO;

    public RoleDAO getRoleDAO() {
        return roleDAO;
    }

    public void setRoleDAO(RoleDAO roleDAO) {
        this.roleDAO = roleDAO;
    }

    private RoleDAO roleDAO;

    public void setUserRoleDAO(UserRoleDAO userRoleDAO) {
        this.userRoleDAO = userRoleDAO;
    }

    @Override
    protected GenericDAO<UserRole, Long> getGenericDAO() {
        return userRoleDAO;
    }

    @Override
    public void updateItem(UserRole pojo) throws ObjectNotFoundException, DuplicateException {

        UserRole dbItem = this.userRoleDAO.findByIdNoAutoCommit(pojo.getUserRoleID());
        if (dbItem == null) throw new ObjectNotFoundException("Not found account " + pojo.getUserRoleID());

        this.userRoleDAO.detach(dbItem);
        this.userRoleDAO.update(pojo);
    }


    @Override
    public Integer deleteItems(String[] checkList) {
        Integer res = 0;
        if (checkList != null && checkList.length > 0) {
            res = checkList.length;
            for (String id : checkList) {
                userRoleDAO.delete(Long.parseLong(id));
            }
        }
        return res;
    }    


    @Override
    public Integer updateItemsByUserRole(UserBean usr) {
        Integer res = 0;
        Map<String, Object> properties = new HashMap<String, Object>();
        StringBuffer whereClause = new StringBuffer(" 1 = 1 ");

        if (usr.getPojo().getUserID() != null) {
            properties.put("user.userID", usr.getPojo().getUserID());
        }

        Object obj[] = roleDAO.searchByProperties(new HashMap<String, Object>(), usr.getFirstItem(), usr.getMaxPageItems() , null, null, true, whereClause.toString());
        if(usr.getRoleBean() != null)
        {
            obj = roleDAO.searchByProperties(new HashMap<String, Object>(), usr.getRoleBean().getFirstItem(), usr.getRoleBean().getMaxPageItems(), usr.getRoleBean().getSortExpression(), usr.getRoleBean().getSortDirection(), true, whereClause.toString());
        }
        List<Role> _lstRole = (List<Role>)obj[1];

        Object objs[] = userRoleDAO.searchByProperties(properties, 0, -1 , "userRoleID","DESC" ,true, whereClause.toString());
        List<UserRole> lst = (List<UserRole>)objs[1];


        for(int i = 0; i < lst.size(); i ++)
        {
            for(int j = 0; j < _lstRole.size(); j ++)
            {
                if(lst.get(i).getUser().getUserID().equals(usr.getPojo().getUserID()) && lst.get(i).getRole().getRoleID() == _lstRole.get(j).getRoleID())
                {
                    try
                    {
                        userRoleDAO.delete(lst.get(i).getUserRoleID());
                        res ++;
                    }
                    catch(Exception e)
                    {
                        logger.error(e.getMessage(), e);
                    }

                }
            }
        }


        if (usr.getRoleBean() != null && usr.getRoleBean().getCheckList() != null) {

            for (String id : usr.getRoleBean().getCheckList()) {
                UserRole usrl = new UserRole();

                User usradd = new User();
                usradd.setUserID(usr.getPojo().getUserID());

                Role r = new Role();
                r.setRoleID(Long.parseLong(id));

                usrl.setUser(usradd);
                usrl.setRole(r);

                userRoleDAO.save(usrl);
            }
        }


        return res;
    }
}
