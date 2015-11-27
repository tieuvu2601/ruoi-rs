package com.banvien.portal.vms.dao.impl;

import com.banvien.portal.vms.dao.GenericDAO;
import com.banvien.portal.vms.util.HibernateUtil;
import org.hibernate.*;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.Restrictions;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * Common query methods 
 *
 * @author Nguyen Hai Vien
 */
public abstract class AbstractHibernateDAO<T, ID extends Serializable> extends HibernateDaoSupport implements GenericDAO<T, ID> {

	private Class<T> persistentClass;

	public AbstractHibernateDAO() {
		this.persistentClass = (Class<T>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0];
	}

    /**
     *
     * @return
     */
    public Class<T> getPersistentClass() {
        return persistentClass;
    }

    /**
     *
     * @param persistentClass
     */
    protected AbstractHibernateDAO(Class<T> persistentClass) {
        this.persistentClass = persistentClass;
    }
     /**
     * @param id
     * @param lock
     * @return
     */
    @SuppressWarnings("unchecked")
	public T findById(ID id, boolean lock) {
        T entity = null;
        if (lock) {
            entity = (T) getHibernateTemplate().get(getPersistentClass(), id,
                    LockMode.UPGRADE);
        } else {
            entity = (T) getHibernateTemplate().get(getPersistentClass(), id);
        }
        return entity;
    }

    @SuppressWarnings("unchecked")
    public T findEqualUnique(final String property, final Object value) {
             T result = (T) getHibernateTemplate().execute(new HibernateCallback() {
                     public Object doInHibernate(Session session)
                                     throws HibernateException, SQLException {
                         Criteria criteria = session.createCriteria(getPersistentClass());
                         criteria.add(Restrictions.eq(property,value));
                         return criteria.uniqueResult();
                    }
       });
       return result;
    }

    @Override
    public List<T> findProperty(final String property, final Object value) {
        List<T> result = (List<T>) getHibernateTemplate().execute(new HibernateCallback() {
                     public Object doInHibernate(Session session)
                                     throws HibernateException, SQLException {
                         Criteria criteria = session.createCriteria(getPersistentClass());
                         criteria.add(Restrictions.eq(property,value));
                         return criteria.list();
                    }
       });
       return result;
    }

    @Override
    public List<T> findProperties(final Map<String, Object> propertyNameValues) {
        List<T> result = (List<T>) getHibernateTemplate().execute(new HibernateCallback() {
                     public Object doInHibernate(Session session)
                                     throws HibernateException, SQLException {
                         Criteria criteria = session.createCriteria(getPersistentClass());
                         for (String name : propertyNameValues.keySet()) {
                             criteria.add(Restrictions.eq(name,propertyNameValues.get(name)));
                         }
                         return criteria.list();
                    }
       });
       return result;
    }
    
    
    

    /**
     *
     * @param exampleInstance -
     * @param excludeProperty -
     * @return list
     */
    @SuppressWarnings("unchecked")
	public List<T> findByExample(final T exampleInstance, final String... excludeProperty) {

    	List<T> result = (List<T>) getHibernateTemplate().execute(
    			new HibernateCallback() {
					public Object doInHibernate(Session session) throws HibernateException, SQLException {

						Criteria crit = session.createCriteria(getPersistentClass());
						Example example =  Example.create(exampleInstance);
						for (String exclude : excludeProperty) {
							example.excludeProperty(exclude);
						}
						example.excludeNone().excludeZeroes().ignoreCase();
						crit.add(example);

						return crit.list();
					}
    			}
    		);
    	return result;

    }

    @SuppressWarnings("unchecked")
     public T findByIdNoAutoCommit(final ID id) {
         T result = (T) getHibernateTemplate().execute(new HibernateCallback() {
                 @SuppressWarnings("deprecation")
				public Object doInHibernate(Session session)
                                 throws HibernateException, SQLException {
                         session.connection().setAutoCommit(false);
                         return session.load(getPersistentClass(), id);
                 }
         });
         return result;
     }


    /**
     *
     */
    public void delete(T entity) throws DataAccessException {
        getHibernateTemplate().delete(entity);

    }

    public void delete(ID id) throws DataAccessException {
        T entity = findById(id, true);
        getHibernateTemplate().delete(entity);

    }
    
    /**
    *
    */
   public void deleteAll(List<T> entities) throws DataAccessException {
       getHibernateTemplate().deleteAll(entities);

   }

    /**
     *
     */
    public T save(T entity) throws DataAccessException {
        getHibernateTemplate().save(entity);
        return entity;
    }

    public void saveAll(final Collection entities) throws DataAccessException {
        getHibernateTemplate().executeWithNativeSession(new HibernateCallback() {
		    public Object doInHibernate(Session session)
                                 throws HibernateException, SQLException {
                for (Object entity : entities) {
					session.save(entity);
				}
                return null;
            }
        });
    }

    /**
     *
     */
    public T saveOrUpdate(T entity) throws DataAccessException {
        getHibernateTemplate().saveOrUpdate(entity);
        return entity;
    }

    @Override
    public void saveOrUpdateAll(Collection entities) throws DataAccessException {
        getHibernateTemplate().saveOrUpdateAll(entities);
    }

    /**
     *
     */
    public T update(T entity) throws DataAccessException {
        getHibernateTemplate().update(entity);
        return entity;
    }

    @SuppressWarnings("unchecked")
	protected List<T> findByCriteria(final Criterion... criterion) {

    	List<T> result = (List<T>) getHibernateTemplate().execute(
    			new HibernateCallback() {
					public Object doInHibernate(Session session) throws HibernateException, SQLException {

						Criteria crit = session.createCriteria(getPersistentClass());
						for (Criterion c : criterion) {
							crit.add(c);
						}
						return (List<T>) crit.list();
					}
    			}
    		);
    	return result;
   }


    public void detach(final T entity) {
         getHibernateTemplate().execute(new HibernateCallback() {
                 public Object doInHibernate(Session session)
                                 throws HibernateException, SQLException {
                         session.evict(entity);
                         return null;
                 }
         });
     }

    @SuppressWarnings("unchecked")
	public List<T> findAll() {
        return this.getHibernateTemplate().find("from " + this.getPersistentClass().getName());
    }


    /**
      * return list of row based on maxResults
      */
     @SuppressWarnings("unchecked")
     public List<T> find(final int maxResults) {
             List<T> result = (List<T>) getHibernateTemplate().execute(
                             new HibernateCallback() {
                                     public Object doInHibernate(Session session)
                                                     throws HibernateException, SQLException {
                                             Criteria criteria = session
                                                             .createCriteria(getPersistentClass());
                                             criteria.setFirstResult(0);
                                             criteria.setMaxResults(maxResults);
                                             return criteria.list();
                                     }
                             });
             return result;
     }

    @SuppressWarnings("unchecked")
 	public List<T> findByProperties(Map<String, Object> propertyNameValues,
 			String orderBy, String orderDirection, boolean andSearch,
 			boolean exactMatch, String whereClause, boolean ignoreCase) {
    	List<T> res = new ArrayList<T>();
 		Object[] nameQuery = HibernateUtil.buildNameQuery(this
 				.getPersistentClass(), propertyNameValues, null, orderBy,
 				orderDirection, andSearch, exactMatch, whereClause,
 				ignoreCase);
 		if (nameQuery.length == 3) {
 			res = getHibernateTemplate().findByNamedParam((String) nameQuery[0], (String[]) nameQuery[1], (Object[]) nameQuery[2]);
 		} else if (nameQuery.length == 1) {
 			res = this.getHibernateTemplate().find((String) nameQuery[0]);
 		} 
 		return res;
 	}

    public List<T> findByProperties(Map<String, Object> propertyNameValues,
 			String orderBy, String orderDirection, boolean andSearch,
 			boolean exactMatch, Integer startRow, Integer pageSize) {
    	List<T> res = new ArrayList<T>();
 		final Object[] nameQuery = HibernateUtil.buildNameQuery(this
 				.getPersistentClass(), propertyNameValues, null, orderBy,
 				orderDirection, andSearch, exactMatch, null,
 				true);

        final int firstResult = startRow;
        final int maxResults = pageSize;
        res = (List<T>)getHibernateTemplate().execute(
                new HibernateCallback() {
                    public Object doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery((String) nameQuery[0]);
                        if (nameQuery.length == 3) {
                            String[] params = (String[]) nameQuery[1];
                            Object[] values = (Object[]) nameQuery[2];
                            for (int i = 0; i < params.length; i++) {
                                query.setParameter(params[i], values[i]);
                            }
                        }
                        query.setFirstResult(firstResult);
                        query.setMaxResults(maxResults);
                        return query.list();
                    }
                });
 		return res;
 	}

    public List<T> findByProperties(Map<String, Object> propertyNameValues,
 			String orderBy, String orderDirection, boolean andSearch,
 			boolean exactMatch, String whereClause, Integer startRow, Integer pageSize) {
    	List<T> res = new ArrayList<T>();
 		final Object[] nameQuery = HibernateUtil.buildNameQuery(this
 				.getPersistentClass(), propertyNameValues, null, orderBy,
 				orderDirection, andSearch, exactMatch, whereClause,
 				true);

        final int firstResult = startRow;
        final int maxResults = pageSize;
        res = (List<T>)getHibernateTemplate().execute(
                new HibernateCallback() {
                    public Object doInHibernate(Session session)
                            throws HibernateException, SQLException {
                        Query query = session
                                .createQuery((String) nameQuery[0]);
                        if (nameQuery.length == 3) {
                            String[] params = (String[]) nameQuery[1];
                            Object[] values = (Object[]) nameQuery[2];
                            for (int i = 0; i < params.length; i++) {
                                query.setParameter(params[i], values[i]);
                            }
                        }
                        query.setFirstResult(firstResult);
                        query.setMaxResults(maxResults);
                        return query.list();
                    }
                });
 		return res;
 	}

 	@SuppressWarnings("unchecked")
 	public List<T> findByProperties(Map<String, Object> propertyNameValues,
 			String orderBy, String orderDirection, boolean andSearch) {
 		return findByProperties(propertyNameValues, orderBy, orderDirection,
 				andSearch, null);
 	}

 	public List<T> findByProperties(Map<String, Object> propertyNameValues,
 			String orderBy, String orderDirection, boolean andSearch,
 			String selectFromClause) {
 		return findByProperties(propertyNameValues, orderBy, orderDirection,
 				andSearch, false, selectFromClause);
 	}

 	public List<T> findByProperties(Map<String, Object> propertyNameValues,
 			String orderBy, String orderDirection, boolean andSearch,
 			boolean exactMatch) {
 		return findByProperties(propertyNameValues, orderBy, orderDirection,
 				andSearch, exactMatch, null);
 	}

 	@SuppressWarnings("unchecked")
 	public List<T> findByProperties(Map<String, Object> propertyNameValues,
 			String orderBy, String orderDirection, boolean andSearch,
 			boolean exactMatch, String selectFromClause) {
 		return findByProperties(propertyNameValues, orderBy, orderDirection,
 				andSearch, exactMatch, selectFromClause, false);
 	}
	/**
	 * search using Query object and filter out row based on startRow and
	 * pagesize.
	 */
	@SuppressWarnings("unchecked")
	public Object[] searchByProperties(Map<String, Object> propertyNameValues,
			int startRow, int pageSize, String orderBy, String orderDirection,
			boolean andSearch, boolean exactMatch, String whereClause) {
		Object[] result = new Object[] { 0, (new ArrayList()) };
		try {
			final Object[] nameQuery = HibernateUtil.buildNameQuery(this
					.getPersistentClass(), propertyNameValues, null, orderBy,
					orderDirection, andSearch, exactMatch, whereClause,
					false);
			final int firstResult = startRow;
			final int maxResults = pageSize;
			Object rowsObj = getHibernateTemplate().execute(
					new HibernateCallback() {
						public Object doInHibernate(Session session)
								throws HibernateException, SQLException {
							Query query = session
									.createQuery((String) nameQuery[0]);
							if (nameQuery.length == 3) {
								String[] params = (String[]) nameQuery[1];
								Object[] values = (Object[]) nameQuery[2];
								for (int i = 0; i < params.length; i++) {
									query.setParameter(params[i], values[i]);
								}
							}
							query.setFirstResult(firstResult);
							query.setMaxResults(maxResults);
							return query.list();
						}
					});
			List rows = null;
			if (rowsObj != null) {
				rows = (List) rowsObj;
			} 
	
			final Object[] nameQuery2 = HibernateUtil.buildNameQuery(this
                    .getPersistentClass(), propertyNameValues, null, null,
                    null, andSearch, exactMatch, whereClause, false);
	
			Object totalRows = getHibernateTemplate().execute(
					new HibernateCallback() {
						public Object doInHibernate(Session session)
								throws HibernateException, SQLException {
							Query query = session
									.createQuery("select count(*) "
											+ nameQuery2[0]);
							if (nameQuery.length == 3) {
								String[] params = (String[]) nameQuery2[1];
								Object[] values = (Object[]) nameQuery2[2];
								for (int i = 0; i < params.length; i++) {
									query.setParameter(params[i], values[i]);
								}
							}
							return query.uniqueResult();/* Long */
						}
					});
	
			result = new Object[] { totalRows, rows };
		} catch (Exception ex) {
			logger.error(ex);
		}
		return result;
	}
	
	public Object[] searchByProperties(Map<String, Object> propertyNameValues,
			int startRow, int pageSize, String orderBy, String orderDirection,
			boolean andSearch) {
		return searchByProperties(propertyNameValues, startRow, pageSize,
				orderBy, orderDirection, andSearch, null);
	}
	
	public Object[] searchByProperties(Map<String, Object> propertyNameValues,
			int startRow, int pageSize, String orderBy, String orderDirection,
			boolean andSearch, String whereClause) {
		return searchByProperties(propertyNameValues, startRow, pageSize,
				orderBy, orderDirection, andSearch, false, whereClause);
	}
	
	public Object[] searchByProperties(Map<String, Object> propertyNameValues,
			int startRow, int pageSize, String orderBy, String orderDirection,
			boolean andSearch, boolean exactMatch) {
		return searchByProperties(propertyNameValues, startRow, pageSize,
				orderBy, orderDirection, andSearch, exactMatch, null);
	}

}
