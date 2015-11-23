/*
 * $Header: /cvsroot/mvnforum/myvietnam/src/net/myvietnam/mvncore/service/impl/MvnCoreServiceImplDefault.java,v 1.21 2008/06/06 10:18:13 lexuanttkhtn Exp $
 * $Author: lexuanttkhtn $
 * $Revision: 1.21 $
 * $Date: 2008/06/06 10:18:13 $
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
package net.myvietnam.mvncore.service.impl;

import net.myvietnam.mvncore.service.BinaryStorageService;
import net.myvietnam.mvncore.service.EncoderService;
import net.myvietnam.mvncore.service.EnvironmentService;
import net.myvietnam.mvncore.service.EventLogService;
import net.myvietnam.mvncore.service.FileUploadParserService;
import net.myvietnam.mvncore.service.IPFilterService;
import net.myvietnam.mvncore.service.MvnCoreInfoService;
import net.myvietnam.mvncore.service.MvnCoreLifeCycleService;
import net.myvietnam.mvncore.service.MvnCoreService;
import net.myvietnam.mvncore.service.URLResolverService;
import net.myvietnam.mvncore.util.AssertionUtil;

public class MvnCoreServiceImplDefault implements MvnCoreService {
    
    protected EncoderService          encoderService;
    protected URLResolverService      urlResolverService;
    protected EnvironmentService      environmentService;
    protected MvnCoreInfoService      mvnCoreInfoService;
    protected BinaryStorageService    binaryStorageService;
    protected MvnCoreLifeCycleService mvnCoreLifeCycleService;
    protected FileUploadParserService fileUploadParserService;
    protected EventLogService         eventLogService;
    protected IPFilterService         ipFilterService;
    
    private static int count;
    
    public MvnCoreServiceImplDefault() {
        count++;
        AssertionUtil.doAssert(count == 1, "Assertion: Must have only one instance.");
    }   
    
    public EncoderService getEncoderService() {
        if (encoderService == null) {
            encoderService = new EncoderServiceImplDefault() ;
        }
        return encoderService;
    }

    public URLResolverService getURLResolverService() {
        if (urlResolverService == null) {
            urlResolverService = new URLResolverServiceImplServletDefault();
        }
        return urlResolverService;
    }

    public EnvironmentService getEnvironmentService() {
        if (environmentService == null) {
            environmentService = new EnvironmentServiceImplDefault(EnvironmentService.PRODUCT_OPENSOURCE /*forum*/, EnvironmentService.PRODUCT_DISABLED /*cms*/, EnvironmentService.PRODUCT_DISABLED /*ad*/, false /*isPortlet*/, "default" /*customizeFor*/);
        }
        return environmentService;
    }

    public MvnCoreInfoService getMvnCoreInfoService() {
        if (mvnCoreInfoService == null) {
            mvnCoreInfoService = new MvnCoreInfoServiceImplDefault();
        }
        return mvnCoreInfoService;
    }

    public BinaryStorageService getBinaryStorageService() {
        if (binaryStorageService == null) {
            binaryStorageService = new BinaryStorageServiceImplEmpty(); 
        }
        return binaryStorageService;
    }

    public MvnCoreLifeCycleService getMvnCoreLifeCycleService() {
        if (mvnCoreLifeCycleService == null) {
            mvnCoreLifeCycleService = new MvnCoreLifeCycleServiceImplDefault();
        }
        return mvnCoreLifeCycleService;
    }

    public FileUploadParserService getFileUploadParserService() {
        if (fileUploadParserService == null) {
            fileUploadParserService =  new FileUploadParserServiceImplServlet();
        }
        return fileUploadParserService;
    }

    public EventLogService getEventLogService() {
        if (eventLogService == null) {
            eventLogService = new EventLogServiceImplDefault();
        }
        return  eventLogService;
    }

    public IPFilterService getIPFilterService() {
        if (ipFilterService == null) {
            ipFilterService = new IPFilterServiceImplDefault();
        }
        return ipFilterService;
    }

}
