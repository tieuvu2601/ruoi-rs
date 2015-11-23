/*
 * $Header: /cvsroot/mvnforum/mvnforum/src/com/mvnforum/db/ThreadCache.java,v 1.12 2008/05/30 04:41:29 minhnn Exp $
 * $Author: minhnn $
 * $Revision: 1.12 $
 * $Date: 2008/05/30 04:41:29 $
 *
 * ====================================================================
 *
 * Copyright (C) 2002-2007 by MyVietnam.net
 *
 * All copyright notices regarding mvnForum MUST remain
 * intact in the scripts and in the outputted HTML.
 * The "powered by" text/logo with a link back to
 * http://www.mvnForum.com and http://www.MyVietnam.net in
 * the footer of the pages MUST remain visible when the pages
 * are viewed on the internet or intranet.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 * Support can be obtained from support forums at:
 * http://www.mvnForum.com/mvnforum/index
 *
 * Correspondence and Marketing Questions can be sent to:
 * info at MyVietnam net
 *
 * @author: Minh Nguyen
 * @author: Mai  Nguyen
 */
package com.mvnforum.db;

import java.util.Collection;

import net.myvietnam.mvncore.exception.DatabaseException;
import net.myvietnam.mvncore.util.DateUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mvnforum.MVNForumConfig;
import com.whirlycott.cache.*;

public class ThreadCache {

    private static final Log log = LogFactory.getLog(ThreadCache.class);
    
    public static final long TIME_OUT = DateUtil.MINUTE * 10;

    // static singleton variable
    static private ThreadCache instance = new ThreadCache();

    // instance variable
    private Cache cache;

    public ThreadCache() {
        //Use the cache manager to create the default cache
        try {
            if (MVNForumConfig.getEnableCacheThread()) {
                cache = CacheManager.getInstance().getCache("thread");
            }
        } catch (CacheException ex) {
            log.error("Cannot get the WhirlyCache. Thread caching is disabled.", ex);
        } catch (LinkageError e) {
            // @todo: Should be never throw
            log.error("Cannot get the WhirlyCache caused by Package Conflict. Thread caching is disabled.", e);
        }
    }

    /**
     * Returns the single instance
     * @return ThreadCache : the singleton instance.
     *
     * NOTE: if use normal singleton pattern, this method should be synchronized
     */
    static public ThreadCache getInstance() {
        return instance;
    }

    public String getEfficiencyReport() {
        String result = "No report";
        if (cache == null) {
            if (MVNForumConfig.getEnableCacheThread() == false) {
                result = "Cache is disabled.";
            } else {
                result = "Cache cannot be inited";
            }
        } else if (cache instanceof CacheDecorator) {
            result = ((CacheDecorator)cache).getEfficiencyReport();
        }
        return result;
    }

    public void clear() {
        if (cache != null) {
            cache.clear();
        }
    }

    public int getPreviousEnableThread(int forumID, int threadID)
        throws DatabaseException {

        Integer previousThreadID = null;
        if (cache != null) {
            StringBuffer buffer = new StringBuffer(128);
            buffer.append("getPreviousEnableThread").append("_").append(forumID).append("_").append(threadID);
            String key = buffer.toString();
            previousThreadID = (Integer)cache.retrieve(key);
            if (previousThreadID == null) {
                int previousTopic = DAOFactory.getThreadDAO().getPreviousEnableThread(forumID, threadID);// can throw AssertionError
                previousThreadID = new Integer(previousTopic);

                cache.store(key, previousThreadID, TIME_OUT);
            }
        } else {
            int previousTopic = DAOFactory.getThreadDAO().getPreviousEnableThread(forumID, threadID);// can throw AssertionError
            previousThreadID = new Integer(previousTopic);
        }

        return previousThreadID.intValue();
    }

    public int getNextEnableThread(int forumID, int threadID)
        throws DatabaseException {

        Integer nextThreadID = null;
        if (cache != null) {
            StringBuffer buffer = new StringBuffer(128);
            buffer.append("getNextEnableThread").append("_").append(forumID).append("_").append(threadID);
            String key = buffer.toString();
            nextThreadID = (Integer)cache.retrieve(key);
            if (nextThreadID == null) {
                int previousTopic = DAOFactory.getThreadDAO().getNextEnableThread(forumID, threadID);// can throw AssertionError
                nextThreadID = new Integer(previousTopic);

                cache.store(key, nextThreadID, TIME_OUT);
            }
        } else {
            int previousTopic = DAOFactory.getThreadDAO().getNextEnableThread(forumID, threadID);// can throw AssertionError
            nextThreadID = new Integer(previousTopic);
        }

        return nextThreadID.intValue();
    }

    public Collection getEnableGlobalAnnouncements()
        throws DatabaseException {

        Collection result = null;
        if (cache != null) {
            StringBuffer buffer = new StringBuffer(128);
            buffer.append("getEnableGlobalAnnouncements");
            String key = buffer.toString();
            result = (Collection)cache.retrieve(key);
            if (result == null) {
                result = DAOFactory.getThreadDAO().getEnableGlobalAnnouncements();

                cache.store(key, result, TIME_OUT);
            }
        } else {
            result = DAOFactory.getThreadDAO().getEnableGlobalAnnouncements();
        }

        return result;
    }

    public Collection getEnableForumAnnouncements_inForum(int forumID)
        throws DatabaseException {

        Collection result = null;
        if (cache != null) {
            StringBuffer buffer = new StringBuffer(128);
            buffer.append("getEnableForumAnnouncements_inForum").append(forumID);
            String key = buffer.toString();
            result = (Collection)cache.retrieve(key);
            if (result == null) {
                result = DAOFactory.getThreadDAO().getEnableForumAnnouncements_inForum(forumID);

                cache.store(key, result, TIME_OUT);
            }
        } else {
            result = DAOFactory.getThreadDAO().getEnableForumAnnouncements_inForum(forumID);
        }

        return result;
    }

    public Collection getEnableStickies_inForum(int forumID)
        throws DatabaseException {

        Collection result = null;
        if (cache != null) {
            StringBuffer buffer = new StringBuffer(128);
            buffer.append("getEnableStickies_inForum").append(forumID);
            String key = buffer.toString();
            result = (Collection)cache.retrieve(key);
            if (result == null) {
                result = DAOFactory.getThreadDAO().getEnableStickies_inForum(forumID);

                cache.store(key, result, TIME_OUT);
            }
        } else {
            result = DAOFactory.getThreadDAO().getEnableStickies_inForum(forumID);
        }

        return result;
    }

    public Collection getNormalEnableThreads_inForum_withSortSupport_limit(int forumID, int offset, int rowsToReturn, String sort, String order)
        throws DatabaseException {

        Collection result = null;
        if (cache != null) {
            StringBuffer buffer = new StringBuffer(128);
            buffer.append("getNormalEnableThreads_inForum_withSortSupport_limit");
            buffer.append(forumID).append("_");
            buffer.append(offset).append("_");
            buffer.append(rowsToReturn).append("_");
            buffer.append(sort).append("_");
            buffer.append(order).append("_");
            String key = buffer.toString();
            result = (Collection)cache.retrieve(key);
            if (result == null) {
                result = DAOFactory.getThreadDAO().getNormalEnableThreads_inForum_withSortSupport_limit(forumID, offset, rowsToReturn, sort, order);

                cache.store(key, result, TIME_OUT);
            }
        } else {
            result = DAOFactory.getThreadDAO().getNormalEnableThreads_inForum_withSortSupport_limit(forumID, offset, rowsToReturn, sort, order);
        }

        return result;
    }

    public int getNumberOfEnableThreads_inForum(int forumID)
        throws DatabaseException {

        Integer result = null;
        if (cache != null) {
            StringBuffer buffer = new StringBuffer(128);
            buffer.append("getNumberOfEnableThreads_inForum").append("_").append(forumID);
            String key = buffer.toString();
            result = (Integer)cache.retrieve(key);
            if (result == null) {
                int i = DAOFactory.getThreadDAO().getNumberOfEnableThreads_inForum(forumID);
                result = new Integer(i);

                cache.store(key, result, TIME_OUT);
            }
        } else {
            int i = DAOFactory.getThreadDAO().getNumberOfEnableThreads_inForum(forumID);
            result = new Integer(i);
        }

        return result.intValue();
    }

    public int getNumberOfNormalEnableThreads_inForum(int forumID)
        throws DatabaseException {

        Integer result = null;
        if (cache != null) {
            StringBuffer buffer = new StringBuffer(128);
            buffer.append("getNumberOfNormalEnableThreads_inForum").append("_").append(forumID);
            String key = buffer.toString();
            result = (Integer)cache.retrieve(key);
            if (result == null) {
                int i = DAOFactory.getThreadDAO().getNumberOfNormalEnableThreads_inForum(forumID);
                result = new Integer(i);

                cache.store(key, result, TIME_OUT);
            }
        } else {
            int i = DAOFactory.getThreadDAO().getNumberOfNormalEnableThreads_inForum(forumID);
            result = new Integer(i);
        }

        return result.intValue();
    }

}
