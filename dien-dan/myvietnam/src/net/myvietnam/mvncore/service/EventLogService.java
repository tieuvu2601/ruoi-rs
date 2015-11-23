/*
 * $Header: /cvsroot/mvnforum/myvietnam/src/net/myvietnam/mvncore/service/EventLogService.java,v 1.9 2007/10/15 06:46:00 minhnn Exp $
 * $Author: minhnn $
 * $Revision: 1.9 $
 * $Date: 2007/10/15 06:46:00 $
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
 * @author: Linh Dang 
 */
package net.myvietnam.mvncore.service;

import java.util.Locale;

public interface EventLogService {
    
    public final static int LOW         = 1;
    
    public final static int MEDIUM      = 2;
    
    public final static int HIGH        = 3;
    
    public final static int CRITICAL    = 4;
    
    public void logEvent(String memberName, String eventLogIP, String eventLogModule, String eventLogSubModule,
                         String eventLogName, String eventLogDesc, int eventLogLevel);    
    
    public String getLogLevelDesc(int eventLogLevel, Locale locale);
}
