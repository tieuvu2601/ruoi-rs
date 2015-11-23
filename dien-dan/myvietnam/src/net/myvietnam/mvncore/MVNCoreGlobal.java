/*
 * $Header: /cvsroot/mvnforum/myvietnam/src/net/myvietnam/mvncore/MVNCoreGlobal.java,v 1.8 2008/05/29 17:43:42 minhnn Exp $
 * $Author: minhnn $
 * $Revision: 1.8 $
 * $Date: 2008/05/29 17:43:42 $
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
package net.myvietnam.mvncore;

public final class MVNCoreGlobal {

    private MVNCoreGlobal() {
    }

/*************************************************************************
 * NOTE: below constants can be changed for each build,
 *       these constant MUST NOT break the compatibility
 *************************************************************************/
    public final static String RESOURCE_BUNDLE_NAME   = "mvncore_java_i18n";

    public final static String MVNCORE_REQUEST_LOCALE = "mvncore.request.Locale";
    
    public static final String CLIENT_IP              = "IP_OF_CLIENT";
    public static final String SERVER_IP              = "IP_OF_SERVER";
    public static final String USER_AGENT             = "USER_AGENT";

    public static final String UN_KNOWN_IP            = "UN.KNOWN.IP";
    public static final String UN_KNOWN_USER_AGENT    = "UN.KNOWN.USER_AGENT";

}
