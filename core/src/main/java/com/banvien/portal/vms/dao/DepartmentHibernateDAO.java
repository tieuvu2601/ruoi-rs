package com.banvien.portal.vms.dao;

import com.banvien.portal.vms.domain.Department;
import com.banvien.portal.vms.dto.C2ShopDTO;
import com.banvien.portal.vms.exception.ObjectNotFoundException;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;
import org.springframework.orm.hibernate3.HibernateCallback;

import java.sql.SQLException;
import java.util.List;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * Department: MBP
 * Date: 11/13/12
 * Time: 4:32 PM
 * Author: vien.nguyen@banvien.com
 */
public class DepartmentHibernateDAO extends AbstractHibernateDAO<Department, Long> implements DepartmentDAO {
    @Override
    public List<Department> findAllAndOrderByName() {
        return getHibernateTemplate().execute(
                new HibernateCallback<List<Department>>() {
                    public List<Department> doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery("FROM Department ORDER BY name");
                        return (List<Department>) query.list();
                    }
                });
    }

    @Override
    public Department findDepartmentByShopCode(String shopcode) throws ObjectNotFoundException {
        Department res = findEqualUnique("code", shopcode);
        if (res == null) {
            while(true) {
                C2ShopDTO c2ShopDTO = null;
                c2ShopDTO = findC2ShopByShopCode(shopcode);
                if (c2ShopDTO == null) break;
                shopcode = c2ShopDTO.getParentShopCode();
                res = findEqualUnique("code", shopcode);
                if (res != null) {
                    break;
                }
            }
        }
        return res;
    }

    private C2ShopDTO findC2ShopByShopCode(final String shopCode) {
        return getHibernateTemplate().execute(
                new HibernateCallback<C2ShopDTO>() {
                    public C2ShopDTO doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        SQLQuery query = session
                                .createSQLQuery("SELECT SHOP_CODE as \"shopCode\", PAR_SHOP_CODE as \"parentShopCode\" FROM shop_webnoibo WHERE SHOP_CODE = :shopCode");
                        query.setParameter("shopCode", shopCode);
                        query.setResultTransformer(Transformers.aliasToBean(C2ShopDTO.class));
                        return (C2ShopDTO) query.uniqueResult();
                    }
                });
    }
}
