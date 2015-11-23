/*
 * $Header: /cvsroot/mvnforum/myvietnam/src/net/myvietnam/mvncore/security/SecurityUtil.java,v 1.4.2.4 2009/03/10 08:38:09 minhnn Exp $
 * $Author: minhnn $
 * $Revision: 1.4.2.4 $
 * $Date: 2009/03/10 08:38:09 $
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
package net.myvietnam.mvncore.security;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import net.myvietnam.mvncore.MVNCoreConfig;
import net.myvietnam.mvncore.MVNCoreResourceBundle;
import net.myvietnam.mvncore.util.I18nUtil;
import net.myvietnam.mvncore.util.StringUtil;
import net.myvietnam.mvncore.web.GenericRequest;
import net.myvietnam.mvncore.web.impl.GenericRequestServletImpl;

public class SecurityUtil {
    
    private static final Log log = LogFactory.getLog(SecurityUtil.class);
    
    private SecurityUtil() {}

    public static void checkHttpPostMethod(HttpServletRequest request) {

        checkHttpReferer(request);

        String method = request.getMethod();
        if (method.equalsIgnoreCase("POST") == false) {
            Locale locale = I18nUtil.getLocaleInRequest(request);
            String localizedMessage = MVNCoreResourceBundle.getString(locale, "mvncore.exception.IllegalStateException.use_post_method");
            throw new IllegalStateException(localizedMessage);
        }
        
    }
    
    public static void checkHttpPostMethod(GenericRequest genericRequest) {
        
        if (genericRequest.isServletRequest()) {
            checkHttpPostMethod(genericRequest.getServletRequest());
        }
        
    }
    
    public static void checkHttpReferer(HttpServletRequest request) {

        GenericRequest genericRequest = new GenericRequestServletImpl(request);
        checkHttpReferer(genericRequest);
        
    } 
  
    public static void checkHttpReferer(GenericRequest request) {
        
        String allowListStr = MVNCoreConfig.getAllowHttpRefererPrefixList();
        if ("allow_all_referer".equals(allowListStr)) {
            return;
        }
        
        String allowedLists[] = MVNCoreConfig.getAllowHttpRefererPrefixListArray();
        boolean isValid = false;

        String referer = StringUtil.getEmptyStringIfNull(request.getReferer()).trim().toLowerCase();
        for (int i = 0; i < allowedLists.length; i++) {
            if (referer.startsWith(allowedLists[i])) {
                isValid = true;
                break;
            }
        }
        if (isValid == false) {
            log.debug("Referer " + referer + " is not in the trusted domains.");
            Locale locale = I18nUtil.getLocaleInRequest(request);
            String localizedMessage = MVNCoreResourceBundle.getString(locale, "mvncore.exception.IllegalStateException.not_in_allowed_referer_list");
            throw new IllegalStateException(localizedMessage);
        }
        
    } 
    
}
