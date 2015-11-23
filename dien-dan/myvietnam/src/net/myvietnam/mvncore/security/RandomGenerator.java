/*
 * $Header: /cvsroot/mvnforum/myvietnam/src/net/myvietnam/mvncore/security/RandomGenerator.java,v 1.5 2008/05/29 17:43:42 minhnn Exp $
 * $Author: minhnn $
 * $Revision: 1.5 $
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
package net.myvietnam.mvncore.security;

import org.apache.commons.lang.RandomStringUtils;

public final class RandomGenerator {

    // prevent instantiation
    private RandomGenerator() {
    }

    public static String getRandomMD5_Base64() {
        String randomString = getRandomString();
        return Encoder.getMD5_Base64(randomString);
    }

    private static String getRandomString() {
        // generate a long string, idealy at least 128 characters
        StringBuffer randomString = new StringBuffer(128);
        randomString.append(String.valueOf(System.currentTimeMillis()));
        randomString.append(RandomStringUtils.randomAlphanumeric(30));
        randomString.append(RandomStringUtils.randomNumeric(30));
        randomString.append(String.valueOf(System.currentTimeMillis()));
        return randomString.toString();
    }

    public static void main (String args[]) {
//        System.out.println("getRandomString     = " + getRandomString());
//        System.out.println("getRandomMD5_Base64 = " + getRandomMD5_Base64());
    }
}
