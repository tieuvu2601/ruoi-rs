/*
 * $Header: /cvsroot/mvnforum/myvietnam/src/net/myvietnam/mvncore/service/impl/EnvironmentServiceImplDefault.java,v 1.13 2008/06/06 10:57:16 minhnn Exp $
 * $Author: minhnn $
 * $Revision: 1.13 $
 * $Date: 2008/06/06 10:57:16 $
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
 * @author: Dung Bui
 */
package net.myvietnam.mvncore.service.impl;

import net.myvietnam.mvncore.service.EnvironmentService;

public class EnvironmentServiceImplDefault implements EnvironmentService {
    
    private boolean shouldRun = true;
    private String reason = "Normal System";
    
    private int mvnForumOption;
    private int mvnCMSOption;
    private int mvnAdOption;
    private boolean isPortlet;
    private String customizeFor;
    
    public EnvironmentServiceImplDefault(int mvnForumOption, int mvnCMSOption, int mvnAdOption, 
                                         boolean isPortlet, String customizeFor) {
        if ( (mvnForumOption != PRODUCT_DISABLED) &&
             (mvnForumOption != PRODUCT_OPENSOURCE) &&
             (mvnForumOption != PRODUCT_ENTERPRISE) ) {
            throw new AssertionError("Assertion in EnvironmentServiceImplDefault constructor. Cannot accept mvnForumOption = " + mvnForumOption);
        }
        if ( (mvnCMSOption != PRODUCT_DISABLED) &&
             (mvnCMSOption != PRODUCT_ENTERPRISE) ) {
            throw new AssertionError("Assertion in EnvironmentServiceImplDefault constructor. Cannot accept mvnCMSOption = " + mvnCMSOption);
        }
        if ( (mvnAdOption != PRODUCT_DISABLED) &&
             (mvnAdOption != PRODUCT_OPENSOURCE) &&
             (mvnAdOption != PRODUCT_ENTERPRISE) ) {
            throw new AssertionError("Assertion in EnvironmentServiceImplDefault constructor. Cannot accept mvnAdOption = " + mvnAdOption);
        }
        
        this.mvnForumOption = mvnForumOption;
        this.mvnCMSOption = mvnCMSOption;
        this.mvnAdOption = mvnAdOption;
        this.isPortlet = isPortlet;
        this.customizeFor = customizeFor;
    }

    public int getForumRunMode() {
        return mvnForumOption;
    }
    
    public int getCmsRunMode() {
        return mvnCMSOption;
    }
    
    public int getAdRunMode() {
        return mvnAdOption;
    }
    
    public boolean isPortlet() {
        return isPortlet;
    }    

    public String customizeFor() {
        return customizeFor;
    }

    /**
     * This method could be use to stop run the forum in some condition.
     * Some use could be a page that immediately stop the forum for security.
     * Other usage is to check to run on some environment such as Servlet 2.3 or later
     *
     * @param shouldRun boolean the new shouldRun
     * @param reason String the reason of the action, this reason will
     *               be shown in the error page
     */
    public void setShouldRun(boolean shouldRun, String reason) {
        this.shouldRun = shouldRun;
        this.reason = reason;
    }

    public boolean isShouldRun() {
        return shouldRun;
    }    

    public String getReason() {
        return reason;
    }

    public void overloadEnvironment() {
    }

}
