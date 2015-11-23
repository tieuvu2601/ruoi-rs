package com.banvien.portal.vms.util;

/**
 * Cache utility - Singleton to monitor the GerneralCacheAdministrator from OS Cache to provide the APIs for caching objects
 */

import com.opensymphony.oscache.base.CacheEntry;
import com.opensymphony.oscache.base.NeedsRefreshException;
import com.opensymphony.oscache.general.GeneralCacheAdministrator;
import com.opensymphony.oscache.web.filter.ExpiresRefreshPolicy;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.io.IOException;
import java.util.Properties;

/**
 * @author Nguyen Hai Vien
 *
 */
public class CacheUtil {
	private transient final Log log = LogFactory.getLog(getClass());
	private static CacheUtil instance = new CacheUtil();
	private GeneralCacheAdministrator generalCacheAdministrator;
	private int time = 1800;
	private CacheUtil() {
		Properties properties = new Properties();
		try {
			properties.load(Thread.currentThread().getContextClassLoader().getResourceAsStream("oscache.properties"));
		} catch (IOException e) {
			log.error("Could not load properties file" + e.getMessage());
		}		
		this.generalCacheAdministrator = new GeneralCacheAdministrator(properties);
		/**
		 * Set default expiration time for cache entry
		 */
		try{
			time = (Integer)properties.get("cache.time");
		}catch (Exception e) {
			this.time = 1800; 
		}
	}
	
	public static CacheUtil getInstance() {
		return instance;
	}
	
	public Object getValue(String key) {
		boolean updated = false;
		Object myValue = null;
		int myRefreshPeriod = CacheEntry.INDEFINITE_EXPIRY;
		try {
		    // Get from the cache
		    myValue = generalCacheAdministrator.getFromCache(key, myRefreshPeriod);
		} catch (NeedsRefreshException nre) {
		    try {
		        // Store in the cache
		        generalCacheAdministrator.putInCache(key, myValue);
		        updated = true;
		    } finally {
		        if (!updated) {
		            // It is essential that cancelUpdate is called if the
		            // cached content could not be rebuilt
		       	 	generalCacheAdministrator.cancelUpdate(key);
		        }
		    }
		}
		return myValue;
	}
	/**
	 * 
	 * @param key
	 * @param value
	 */
	public void putValue(String key, Object value) {
		this.putValue(key, value, time);
	}
	
	public void remove(String key) {
		generalCacheAdministrator.removeEntry(key);
	}
	/**
	 * Put object in cache with specified expiration time in second
	 * @param key
	 * @param value
	 * @param expiredTime - Expiration time in second
	 */
	public void putValue(String key, Object value, int expiredTime) {
		ExpiresRefreshPolicy exRefreshPolicy = new ExpiresRefreshPolicy(expiredTime);
		generalCacheAdministrator.putInCache(key, value, exRefreshPolicy);
	}
}
