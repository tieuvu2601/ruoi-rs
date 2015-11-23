/*
 * $Header: /cvsroot/mvnforum/myvietnam/src/net/myvietnam/mvncore/service/MvnCoreServiceFactory.java,v 1.15 2008/05/30 04:18:37 minhnn Exp $
 * $Author: minhnn $
 * $Revision: 1.15 $
 * $Date: 2008/05/30 04:18:37 $
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
 * @author: Trong Vo
 */
package net.myvietnam.mvncore.service;

import net.myvietnam.mvncore.MVNCoreConfig;
import net.myvietnam.mvncore.service.impl.MvnCoreServiceImplDefault;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public final class MvnCoreServiceFactory {

    private static final Log log = LogFactory.getLog(MvnCoreServiceFactory.class);

    private MvnCoreServiceFactory() {
    }

    private static MvnCoreService mvnCoreService = null;

    public static synchronized MvnCoreService getMvnCoreService() {

        if (mvnCoreService == null) {
            try {
                Class c = Class.forName(MVNCoreConfig.getMvnCoreServiceClassName());
                
                mvnCoreService = (MvnCoreService) c.newInstance();
                log.info("MvnCoreService = " + mvnCoreService);
            } catch (Exception e) {
                log.error("Error loading the MvnCoreService.", e);
                log.warn("Error loading the MvnCoreService. Using default MvnCoreService: " + MvnCoreServiceImplDefault.class.getName());
                mvnCoreService = new MvnCoreServiceImplDefault();
            }
        }
        return mvnCoreService;
    }

}
