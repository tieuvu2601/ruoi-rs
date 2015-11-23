package com.banvien.portal.vms.filter;

import com.banvien.portal.vms.util.IPAddressUtil;
import org.apache.log4j.Logger;
import org.apache.tools.ant.util.StringUtils;
import org.jbpm.pvm.internal.util.StringUtil;
import org.springframework.security.web.util.AntUrlPathMatcher;
import org.springframework.util.AntPathMatcher;
import org.springframework.web.filter.OncePerRequestFilter;
import com.banvien.portal.vms.util.Constants;

import javax.mail.internet.InternetAddress;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.InetAddress;
import java.util.ArrayList;
import java.util.List;


public class ShopperAccessFilter extends OncePerRequestFilter {
    private transient final Logger logger = Logger.getLogger(getClass());

    private String shopperRangeIPs;

    private String shopperURLs;

    private List<RangeIP> rangeIPList = new ArrayList<RangeIP>();

    public void setShopperRangeIPs(String shopperRangeIPs) {
        this.shopperRangeIPs = shopperRangeIPs;
        parseRangeIP();
    }

    private void parseRangeIP() {
        String arrayIP[] = this.shopperRangeIPs.split(Constants.SEPERATE);
        for (String range : arrayIP) {
            RangeIP rangeIP = parseSubnet2Range(range);
            if (rangeIP != null) {
                rangeIPList.add(rangeIP);
            }
        }
    }

    private RangeIP parseSubnet2Range(String range) {
        String[] tmp = range.split("/");
        if (tmp.length > 1) {
            try{
                String mask = prefixMask2MaskIP(Integer.parseInt(tmp[1]));
                RangeIP rangeIP = new RangeIP(tmp[0], mask);
                return rangeIP;
            }catch (Exception e) {

            }
        }
        return null;
    }

    private String prefixMask2MaskIP(int netPrefix) {
        int shiftby = (1<<31);
        // For the number of bits of the prefix -1 (we already set the sign bit)
        for (int i=netPrefix-1; i>0; i--) {
            // Shift the sign right... Java makes the sign bit sticky on a shift...
            // So no need to "set it back up"...
            shiftby = (shiftby >> 1);
        }
        // Transform the resulting value in xxx.xxx.xxx.xxx format, like if
        /// it was a standard address...
        String maskString = Integer.toString((shiftby >> 24) & 255) + "." + Integer.toString((shiftby >> 16) & 255) + "." + Integer.toString((shiftby >> 8) & 255) + "." + Integer.toString(shiftby & 255);
        return maskString;
    }


    public void setShopperURLs(String shopperURLs) {
        this.shopperURLs = shopperURLs;
    }

    @Override
    public void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
                                 FilterChain chain)
            throws IOException, ServletException {
        String ip = request.getRemoteAddr();
        String requestURI = request.getRequestURI();
        String servletContext = request.getSession().getServletContext().getContextPath();
        requestURI = requestURI.substring(servletContext.length());
        if (needRedirect2Shopper(ip, requestURI)) {
            response.sendRedirect("/daily/index.html");
            return;
        }
        chain.doFilter(request, response);
    }

    private boolean needRedirect2Shopper(String ip, String uri) {
        if (isInShopperRangeIP(ip) && shopperURLs != null) {
            //Check excluded URL
            AntPathMatcher antPathMatcher = new AntPathMatcher();
            if (antPathMatcher.match(shopperURLs.trim(), uri)) {
                return false;
            }
            return true;
        }
        return false;
    }



    private boolean isInShopperRangeIP(String ip) {
        for (RangeIP rangeIP : rangeIPList) {
            if (rangeIP.isValidIP(ip)) {
                return true;
            }
        }
        return false;

    }


    class RangeIP {
        private String subnet;

        private String mask;

        RangeIP(String subnet, String mask) {
            this.subnet = subnet;
            this.mask = mask;
        }

        public String getSubnet() {
            return subnet;
        }

        public void setSubnet(String subnet) {
            this.subnet = subnet;
        }

        public String getMask() {
            return mask;
        }

        public void setMask(String mask) {
            this.mask = mask;
        }

        public boolean isValidIP(String ip) {
            return IPAddressUtil.isInSubnet(ip, subnet, mask);
        }
    }

}
