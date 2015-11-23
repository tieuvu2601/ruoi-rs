/*
 * $Header: /cvsroot/mvnforum/mvnforum/src/com/mvnforum/service/impl/CategoryBuilderServiceImplDefault.java,v 1.1 2008/06/04 10:57:23 phuongpdd Exp $
 * $Author: phuongpdd $
 * $Revision: 1.1 $
 * $Date: 2008/06/04 10:57:23 $
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
 * @author: MVN Developers
 */
package com.mvnforum.service.impl;

import net.myvietnam.mvncore.exception.DatabaseException;
import net.myvietnam.mvncore.util.AssertionUtil;

import com.mvnforum.categorytree.CategoryBuilder;
import com.mvnforum.categorytree.DefaultCategoryTreeBuilder;
import com.mvnforum.service.CategoryBuilderService;

public class CategoryBuilderServiceImplDefault implements CategoryBuilderService {

    private static int count;

    public CategoryBuilderServiceImplDefault() {
        count++;
        AssertionUtil.doAssert(count == 1, "Assertion: Must have only one instance.");
    }
    
    public CategoryBuilder getCategoryTreeBuilder() throws DatabaseException {
        return new DefaultCategoryTreeBuilder();
    }

}
