package com.banvien.portal.vms.service.impl;

import com.banvien.portal.vms.bean.UserBean;
import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.dao.RoleDAO;
import com.banvien.portal.vms.dao.UserRoleDAO;
import com.banvien.portal.vms.domain.RoleEntity;
import com.banvien.portal.vms.domain.UserEntity;
import com.banvien.portal.vms.domain.UserRoleEntity;
import com.banvien.portal.vms.exception.DuplicateException;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import com.banvien.portal.vms.service.UserRoleService;
import org.apache.log4j.Logger;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserRoleServiceImpl extends GenericServiceImpl<UserRoleEntity, Long> implements UserRoleService {
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
    protected GenericDAO<UserRoleEntity, Long> getGenericDAO() {
        return userRoleDAO;
    }

    @Override
    public void updateItem(UserRoleEntity pojo) throws ObjectNotFoundException, DuplicateException {

        UserRoleEntity dbItem = this.userRoleDAO.findByIdNoAutoCommit(pojo.getUserRoleId());
        if (dbItem == null) throw new ObjectNotFoundException("Not found account " + pojo.getUserRoleId());

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

        if (usr.getPojo().getUserId() != null) {
            properties.put("user.userID", usr.getPojo().getUserId());
        }

        Object obj[] = roleDAO.searchByProperties(new HashMap<String, Object>(), usr.getFirstItem(), usr.getMaxPageItems() , null, null, true, whereClause.toString());
        if(usr.getRoleBean() != null){
            obj = roleDAO.searchByProperties(new HashMap<String, Object>(), usr.getRoleBean().getFirstItem(), usr.getRoleBean().getMaxPageItems(), usr.getRoleBean().getSortExpression(), usr.getRoleBean().getSortDirection(), true, whereClause.toString());
        }
        List<RoleEntity> _lstRoleEntity = (List<RoleEntity>)obj[1];

        Object objs[] = userRoleDAO.searchByProperties(properties, 0, -1 , "userRoleID","DESC" ,true, whereClause.toString());
        List<UserRoleEntity> lst = (List<UserRoleEntity>)objs[1];


        for(int i = 0; i < lst.size(); i ++){
            for(int j = 0; j < _lstRoleEntity.size(); j ++){
                if(lst.get(i).getUser().getUserId().equals(usr.getPojo().getUserId()) && lst.get(i).getRole().getRoleId() == _lstRoleEntity.get(j).getRoleId()){
                    try{
                        userRoleDAO.delete(lst.get(i).getUserRoleId());
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
                UserRoleEntity usrl = new UserRoleEntity();

                UserEntity usradd = new UserEntity();
                usradd.setUserId(usr.getPojo().getUserId());

                RoleEntity r = new RoleEntity();
                r.setRoleId(Long.parseLong(id));

                usrl.setUser(usradd);
                usrl.setRole(r);
                userRoleDAO.save(usrl);
            }
        }


        return res;
    }
}
