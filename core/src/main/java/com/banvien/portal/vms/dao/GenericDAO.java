package com.banvien.portal.vms.dao;

import org.springframework.dao.DataAccessException;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * Generated at Sun Feb 20 16:11:08 ICT 2011
 *
 * @author Vien Nguyen Hai
 */
public interface GenericDAO<T, ID extends Serializable> {

    public Class<T> getPersistentClass();

    public T findById(ID id, boolean lock);

    public T findEqualUnique(final String property, final Object value);

    public T findByIdNoAutoCommit(final ID id);

    List<T> findByExample(T exampleInstance, String... excludeProperty);

	T save(T entity) throws DataAccessException;

    public void saveAll(final Collection entities) throws DataAccessException;

	T update(T entity) throws DataAccessException;

	T saveOrUpdate(T entity) throws DataAccessException;

    void saveOrUpdateAll(final Collection entities) throws DataAccessException;

	void delete(T entity) throws DataAccessException;

    void delete(ID entity) throws DataAccessException;
	
	void deleteAll(List<T> entities) throws DataAccessException;

    void detach(T entity);

    List<T> findAll();

    List<T> find(int maxResults);
    
    public List<T> findProperty(final String property, final Object value);
    public List<T> findProperties(Map<String, Object> propertyNameValues);
    
    public List<T> findByProperties(Map<String, Object> propertyNameValues,
                                    String orderBy, String orderDirection, boolean andSearch,
                                    String whereClause);

	public List<T> findByProperties(Map<String, Object> propertyNameValues,
                                    String orderBy, String orderDirection, boolean andSearch,
                                    boolean exactMatch);

    public List<T> findByProperties(Map<String, Object> propertyNameValues,
                                    String orderBy, String orderDirection, boolean andSearch,
                                    boolean exactMatch, Integer offset, Integer limit);
    public List<T> findByProperties(Map<String, Object> propertyNameValues,
                                    String orderBy, String orderDirection, boolean andSearch,
                                    boolean exactMatch, String whereClause, Integer offset, Integer limit);

	public List<T> findByProperties(Map<String, Object> propertyNameValues,
                                    String orderBy, String orderDirection, boolean andSearch,
                                    boolean exactMatch, String whereClause, boolean ignoreCase);

	public Object[] searchByProperties(Map<String, Object> propertyNameValues,
                                       int startRow, int pageSize, String orderBy, String orderDirection,
                                       boolean andSearch, String whereClause);
}
