/*
 * $Header: /cvsroot/mvnforum/mvnforum/src/com/mvnforum/categorytree/impl/FtlCategoryTreeListener.java,v 1.7 2008/05/30 18:08:38 minhnn Exp $
 * $Author: minhnn $
 * $Revision: 1.7 $
 * $Date: 2008/05/30 18:08:38 $
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
 * @author: Phong Ta Quoc
 */
package com.mvnforum.categorytree.impl;

import java.io.IOException;
import java.io.StringWriter;
import java.util.*;

import com.mvnforum.categorytree.CategoryTreeListener;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import freemarker.template.Template;
import freemarker.template.TemplateException;

public abstract class FtlCategoryTreeListener implements CategoryTreeListener {

    private static final Log log = LogFactory.getLog(FtlCategoryTreeListener.class);
    
    protected Map root;
    protected Vector rows = new Vector();
    protected StringWriter html;
    protected Template template;

    public void init(Template template) {
        this.template = template;
        html = new StringWriter();
        root = new HashMap();
        root.put("Rows", rows);
    }

    public void process() {
        try {
            template.process(root, html);
        } catch (TemplateException e) {
            log.error("Cannot Process Template View Member Permission", e);
        } catch (IOException e) {
            log.error("Cannot Process Template View Member Permission", e);
        }
    }

    public void commitTemplate(StringBuffer html) {
        process();
        html.append(this.html);
    }

    public void update(Observable Observable, Object object) {
        //override it in listener implementation.
    }
}
