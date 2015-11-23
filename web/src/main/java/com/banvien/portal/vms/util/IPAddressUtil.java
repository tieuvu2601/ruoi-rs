package com.banvien.portal.vms.util;

import java.util.StringTokenizer;

/**
 * Copyright (c) by Ban Vien Co., Ltd.
 * User: MBP
 * Date: 5/14/13
 * Time: 6:37 AM
 * Author: vien.nguyen@banvien.com
 */
public class IPAddressUtil {
    /**
     * Check if the specified address is within the required subnet
     *
     * @param ipaddr String
     * @param subnet String
     * @param mask String
     * @return boolean
     */
    public final static boolean isInSubnet(String ipaddr, String subnet, String mask) {

        //  Convert the addresses to integer values

        int ipaddrInt = parseNumericAddress(ipaddr);
        if ( ipaddrInt == 0)
            return false;

        int subnetInt = parseNumericAddress(subnet);
        if ( subnetInt == 0)
            return false;

        int maskInt = parseNumericAddress(mask);
        if ( maskInt == 0)
            return false;

        //  Check if the address is part of the subnet

        if (( ipaddrInt & maskInt) == subnetInt)
            return true;
        return false;
    }
    /**
     * Check if the specified address is a valid numeric TCP/IP address and return as an integer value
     *
     * @param ipaddr String
     * @return int
     */
    public final static int parseNumericAddress(String ipaddr) {

        //  Check if the string is valid

        if ( ipaddr == null || ipaddr.length() < 7 || ipaddr.length() > 15)
            return 0;

        //  Check the address string, should be n.n.n.n format

        StringTokenizer token = new StringTokenizer(ipaddr,".");
        if ( token.countTokens() != 4)
            return 0;

        int ipInt = 0;

        while ( token.hasMoreTokens()) {

            //  Get the current token and convert to an integer value

            String ipNum = token.nextToken();

            try {

                //  Validate the current address part

                int ipVal = Integer.valueOf(ipNum).intValue();
                if ( ipVal < 0 || ipVal > 255)
                    return 0;

                //  Add to the integer address

                ipInt = (ipInt << 8) + ipVal;
            }
            catch (NumberFormatException ex) {
                return 0;
            }
        }

        //  Return the integer address

        return ipInt;
    }
}
