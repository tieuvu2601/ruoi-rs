package com.banvien.portal.vms.util;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.io.IOException;
import java.util.Properties;

/**
 *  viennh
 *  Just a simple Config
 */
public class MailConfig extends Properties {

    private static MailConfig instance = new MailConfig();
    private static final Log log = LogFactory.getLog(MailConfig.class);

    public static MailConfig getInstance() {
        return instance;
    }

    private MailConfig() {
        super();
        try {
            super.load(Thread.currentThread().getContextClassLoader().getResourceAsStream("mail.properties"));
        } catch (IOException e) {
            log.fatal("ERROR: can not load config file mail.properties : " + e);
        }
    }
}
