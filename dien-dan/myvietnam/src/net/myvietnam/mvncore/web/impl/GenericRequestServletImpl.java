/*
 * $Header: /cvsroot/mvnforum/myvietnam/src/net/myvietnam/mvncore/web/impl/GenericRequestServletImpl.java,v 1.11.2.1 2008/11/17 07:55:28 nguyendnc Exp $
 * $Author: nguyendnc $
 * $Revision: 1.11.2.1 $
 * $Date: 2008/11/17 07:55:28 $
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
 * @author: Phong Ta Quoc 
 */
package net.myvietnam.mvncore.web.impl;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import net.myvietnam.mvncore.web.GenericRequest;

public class GenericRequestServletImpl extends HttpServletRequestWrapper implements GenericRequest {

    private ServletContext context;

    public GenericRequestServletImpl(HttpServletRequest request) {
        super(request);
    }

    public GenericRequestServletImpl(HttpServletRequest request, ServletContext context) {
        super(request);
        this.context = context;
    }

    public HttpServletRequest getServletRequest() {
        return (HttpServletRequest)getRequest();
    }

    public Object getPortletRequest() {
        return null;
    }

    public boolean isServletRequest() {
        return true;
    }

    public boolean isPortletRequest() {
        return false;
    }

    public String getSessionId() {
        return this.getSession().getId();
    }

    public String getRealPath(String path) {
        if (context == null) {
            throw new IllegalStateException("Cannot getRealPath with a null context.");
        }

        return context.getRealPath(path);
    }
    
    public void setSessionAttribute(String name, Object value) {
        this.getSession().setAttribute(name, value);
    }
    
    public Object getSessionAttribute(String name) {
        return this.getSession().getAttribute(name);
    }
    
    public void setSessionAttribute(String name, Object value, int scope) {
        this.getSession().setAttribute(name, value);
    }

    public Object getSessionAttribute(String name, int scope) {
        return this.getSession().getAttribute(name);
    }

    public String getMethod() {
        return this.getServletRequest().getMethod();
    }

    public String getUserAgent() {
        return getHeader("User-Agent");
    }
    
    public String getReferer() {
        return getHeader("Referer");
    }
    
    public String getPortalInfo() {
        return null;
    }

}
