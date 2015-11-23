/*
 * $Header: /cvsroot/mvnforum/myvietnam/src/net/myvietnam/mvncore/interceptor/sample/MyContentInterceptor.java,v 1.9 2007/01/15 10:31:16 dungbtm Exp $
 * $Author: dungbtm $
 * $Revision: 1.9 $
 * $Date: 2007/01/15 10:31:16 $
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
 */
package net.myvietnam.mvncore.interceptor.sample;

import net.myvietnam.mvncore.interceptor.ContentInterceptor;
import net.myvietnam.mvncore.util.AssertionUtil;
import net.myvietnam.mvncore.exception.InterceptorException;

/**
 * Simple ContentInterceptor to check for the word "vulgar".
 * This sample interceptor only demonstrate the idea, you should
 * write your own class based on your or your organization's rule
 */
public class MyContentInterceptor implements ContentInterceptor {
    
    private static int count;

    public MyContentInterceptor() {
        count++;
        AssertionUtil.doAssert(count == 1, "Assertion: Must have only one instance.");
    }

    /**
     * Simple checking for the word "vulgar"
     * @param content String content to be validated
     * @throws InterceptorException
     */
    public String validateContent(String content) throws InterceptorException {
        String lowerContent = content.toLowerCase();
        if (lowerContent.indexOf("vulgar") != -1) {
            throw new InterceptorException("Do not allow content that include word 'vulgar'");
        }
        return content;
    }
}
