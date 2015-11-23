/*
 * $Header: /cvsroot/mvnforum/mvnforum/src/com/mvnforum/MVNForumFactoryConfig.java,v 1.30 2008/05/30 04:41:13 minhnn Exp $
 * $Author: minhnn $
 * $Revision: 1.30 $
 * $Date: 2008/05/30 04:41:13 $
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
 * @author: Luis Miguel Hernanz
 * @author: Minh Nguyen
 */
package com.mvnforum;

import java.io.File;

import net.myvietnam.mvncore.configuration.DOM4JConfiguration;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import net.myvietnam.mvncore.util.FileUtil;

/**
 * Class that loads and makes accesible the factory configuration.
 *
 * @author <a href="luish@germinus.com">Luis Miguel Hernanz</a>
 * @version $Revision: 1.30 $
 */
public class MVNForumFactoryConfig {

    private static final Log log = LogFactory.getLog(MVNForumFactoryConfig.class);

    private static final String OPTION_FILE_NAME     = "mvnforum.xml";

    private static String authenticatorClassName     = null;
    private static String memberManagerClassName     = "com.mvnforum.db.jdbc.MemberDAOImplJDBC";
    private static String onlineUserFactoryClassName = "com.mvnforum.auth.OnlineUserFactoryImpl";
    private static String requestProcessorClassName  = "com.mvnforum.RequestProcessorDefault";
    private static String luceneAnalyzerClassName    = "org.apache.lucene.analysis.standard.StandardAnalyzer";
    private static String mvnAuthServiceClassName    = "com.mvnforum.auth.service.impl.MvnAuthServiceImplDefault";
    private static String mvnForumServiceClassName   = "com.mvnforum.service.impl.MvnForumServiceImpl";

    public static String getMemberManagerClassName() {
        return memberManagerClassName;
    }
    public static void setMemberManagerClassName(String memberManagerClassName) {
        MVNForumFactoryConfig.memberManagerClassName = memberManagerClassName;
    }

    public static String getOnlineUserFactoryClassName() {
        return onlineUserFactoryClassName;
    }
    public static void setOnlineUserFactoryClassName(String onlineUserFactoryClassName) {
        MVNForumFactoryConfig.onlineUserFactoryClassName = onlineUserFactoryClassName;
    }

    public static String getAuthenticatorClassName() {
        return authenticatorClassName;
    }
    public static void setAuthenticatorClassName(String authenticatorClassName) {
        MVNForumFactoryConfig.authenticatorClassName = authenticatorClassName;
    }

    public static String getRequestProcessorClassName() {
        return requestProcessorClassName;
    }
    public static void setRequestProcessorClassName(String requestProcessorClassName) {
        MVNForumFactoryConfig.requestProcessorClassName = requestProcessorClassName;
    }

    public static String getLuceneAnalyzerClassName() {
        return luceneAnalyzerClassName;
    }
    public static void setLuceneAnalyzerClassName(String luceneAnalyzerClassName) {
        MVNForumFactoryConfig.luceneAnalyzerClassName = luceneAnalyzerClassName;
    }

    public static String getMvnAuthServiceClassName() {
        return mvnAuthServiceClassName;
    }
    public static void setMvnAuthServiceClassName(String mvnAuthServiceClassName) {
        MVNForumFactoryConfig.mvnAuthServiceClassName = mvnAuthServiceClassName;
    }

    public static String getMvnForumServiceClassName() {
        return mvnForumServiceClassName;
    }
    public static void setMvnForumServiceClassName(String mvnForumServiceClassName) {
        MVNForumFactoryConfig.mvnForumServiceClassName = mvnForumServiceClassName;
    }

    static {
        try {
            String strPathName      = FileUtil.getServletClassesPath();
            String configFilename   = strPathName + OPTION_FILE_NAME;
            DOM4JConfiguration conf = new DOM4JConfiguration(new File(configFilename));

            memberManagerClassName     = conf.getString("mvnforumfactoryconfig.member_implementation", "");
            onlineUserFactoryClassName = conf.getString("mvnforumfactoryconfig.onlineuser_implementation", onlineUserFactoryClassName);
            authenticatorClassName     = conf.getString("mvnforumfactoryconfig.authenticator_implementation", authenticatorClassName);
            requestProcessorClassName  = conf.getString("mvnforumfactoryconfig.requestprocessor_implementation", requestProcessorClassName);
            luceneAnalyzerClassName    = conf.getString("mvnforumfactoryconfig.lucene_analyzer_implementation", luceneAnalyzerClassName);
            mvnAuthServiceClassName    = conf.getString("mvnforumfactoryconfig.mvn_auth_service_implementation", mvnAuthServiceClassName);
            mvnForumServiceClassName   = conf.getString("mvnforumfactoryconfig.mvnforum_service_implementation", mvnForumServiceClassName);
        } catch (Exception e) {
            log.error("Error loading the factory properties", e);
        }
    }
}
