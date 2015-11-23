/*
 * $Header: /cvsroot/mvnforum/myvietnam/src/net/myvietnam/mvncore/interceptor/sample/MyCompanyMailInterceptor.java,v 1.5 2007/01/15 10:31:15 dungbtm Exp $
 * $Author: dungbtm $
 * $Revision: 1.5 $
 * $Date: 2007/01/15 10:31:15 $
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

import net.myvietnam.mvncore.interceptor.MailInterceptor;
import net.myvietnam.mvncore.exception.InterceptorException;

/**
 * This sample MailInterceptor show how to make sure that only users
 * in a specific domain, say mycompany.com, are allowed to use the system.
 * You can based on this sample to write your own MailInterceptor
 */
public class MyCompanyMailInterceptor implements MailInterceptor {

    public MyCompanyMailInterceptor() {
    }

    /**
     * In this sample interceptor, it check that only emails in
     * domain mycompany.com are accepted
     *
     * @param email String email to be validated
     * @throws InterceptorException
     */
    public void validateEmail(String email) throws InterceptorException {
        email = email.toLowerCase();
        if (email.endsWith("@mycompany.com") == false) {
            throw new InterceptorException("Cannot accept email that is not in domain mycompany.com");
        }
    }
}
