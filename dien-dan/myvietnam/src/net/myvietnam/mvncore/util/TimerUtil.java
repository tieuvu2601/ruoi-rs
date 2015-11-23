/*
 * $Header: /cvsroot/mvnforum/myvietnam/src/net/myvietnam/mvncore/util/TimerUtil.java,v 1.19 2008/05/30 04:18:38 minhnn Exp $
 * $Author: minhnn $
 * $Revision: 1.19 $
 * $Date: 2008/05/30 04:18:38 $
 *
 * ====================================================================
 *
 * Copyright (C) 2002-2007 by MyVietnam.net
 *
 * All copyright notices regarding MyVietnam and MyVietnam CoreLib
 * MUST remain intact in the scripts and source code.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 *
 * Correspondence and Marketing Questions can be sent to:
 * info at MyVietnam net
 *
 * @author: Minh Nguyen  
 * @author: Mai  Nguyen  
 */
package net.myvietnam.mvncore.util;

import java.util.Timer;
import java.util.TimerTask;
import java.util.Date;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public final class TimerUtil {

    // static variable
    private static final Log log = LogFactory.getLog(TimerUtil.class);

    // static variable
    private static TimerUtil instance = null;

    // static variable
    private static boolean isCanceled = false;

    // instance variables
    private Timer timer = null;

    // private constructor will prevent any instantiation
    private TimerUtil() {
        log.debug("TimerUtil is instantiated.");
        timer = new Timer();
    }

    private void reloadTimer() {
        log.info("Reload Timer in TimerUtil.");
        if (isCanceled == false) {
            timer.cancel(); // Cancel the errored timer
            timer = new Timer();
        } else {
            log.warn("Cannot reload a cancelled Timer.");
        }
    }

    /**
     * This static method is used to get the Singleton instance of TimerUtil
     * @return the singleton instance of TimerUtil
     */
    public static synchronized TimerUtil getInstance() {
        if (instance == null) {
            instance = new TimerUtil();
        }
        return instance;
    }

    public void cancel() {
        log.debug("TimerUtil.cancel() is called");
        
        isCanceled = true;
        timer.cancel();
    }
    
    public boolean isTimerCanceled() {
        return isCanceled;
    }

    public void schedule(TimerTask task, Date firstTime, long period) {
        if (isCanceled == false) {
            try {
                timer.schedule(task, firstTime, period);
            } catch (IllegalStateException ex) {
                log.error("Cannot schedule task!", ex);
                reloadTimer();
            }
        }
    }

    public void schedule(TimerTask task, Date time) {
        if (isCanceled == false) {
            try {
                timer.schedule(task, time);
            } catch (IllegalStateException ex) {
                log.error("Cannot schedule task!", ex);
                reloadTimer();
            }
        }
    }

    public void schedule(TimerTask task, long delay) {
        if (isCanceled == false) {
            try {
                timer.schedule(task, delay);
            } catch (IllegalStateException ex) {
                log.error("Cannot schedule task!", ex);
                reloadTimer();
            }
        }
    }

    public void schedule(TimerTask task, long delay, long period) {
        if (isCanceled == false) {
            try {
                timer.schedule(task, delay, period);
            } catch (IllegalStateException ex) {
                log.error("Cannot schedule task!", ex);
                reloadTimer();
            }
        }
    }

    public void scheduleAtFixedRate(TimerTask task, Date firstTime, long period) {
        if (isCanceled == false) {
            try {
                timer.schedule(task, firstTime, period);
            } catch (IllegalStateException ex) {
                log.error("Cannot schedule task!", ex);
                reloadTimer();
            }
        }
    }

    public void scheduleAtFixedRate(TimerTask task, long delay, long period) {
        if (isCanceled == false) {
            try {
                timer.schedule(task, delay, period);
            } catch (IllegalStateException ex) {
                log.error("Cannot schedule task!", ex);
                reloadTimer();
            }
        }
    }
}
