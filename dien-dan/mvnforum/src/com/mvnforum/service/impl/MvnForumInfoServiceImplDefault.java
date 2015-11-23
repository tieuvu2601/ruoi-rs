/*
 * $Header: /cvsroot/mvnforum/mvnforum/src/com/mvnforum/service/impl/MvnForumInfoServiceImplDefault.java,v 1.40.2.8 2010/08/17 04:35:46 minhnn Exp $
 * $Author: minhnn $
 * $Revision: 1.40.2.8 $
 * $Date: 2010/08/17 04:35:46 $
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
 * @author: Minh Nguyen
 * @author: Mai  Nguyen
 */
package com.mvnforum.service.impl;

import com.mvnforum.service.MvnForumInfoService;
import net.myvietnam.mvncore.util.AssertionUtil;
import net.myvietnam.mvncore.util.ImageUtil;

import java.awt.image.BufferedImage;

public class MvnForumInfoServiceImplDefault implements MvnForumInfoService {

    private static int count;

    public MvnForumInfoServiceImplDefault() {
        count++;
        AssertionUtil.doAssert(count == 1, "Assertion: Must have only one instance.");
    }

    private static String PRODUCT_NAME         = "Trung tâm Thông tin Di động Khu vực II";

    private static String PRODUCT_DESC         = "Trung tâm Thông tin Di động Khu vực II";

    private static String PRODUCT_VERSION      = "";

    private static String PRODUCT_RELEASE_DATE = "24 December 2012";

    private static String PRODUCT_HOMEPAGE     = "";

    public String getProductName() {
        return PRODUCT_NAME;
    }

    public String getProductDesc() {
        return PRODUCT_DESC;
    }

    public String getProductVersion() {
        return PRODUCT_VERSION;
    }

    public String getProductReleaseDate() {
        return PRODUCT_RELEASE_DATE;
    }

    public String getProductHomepage() {
        return PRODUCT_HOMEPAGE;
    }

    public BufferedImage getImage() {
        return ImageUtil.getProductionImage(PRODUCT_VERSION, PRODUCT_RELEASE_DATE);
    }

}
