/*
 * $Header: /cvsroot/mvnforum/mvnforum/src/com/mvnforum/user/ForumUserServlet.java,v 1.71 2008/06/27 04:28:04 lexuanttkhtn Exp $
 * $Author: lexuanttkhtn $
 * $Revision: 1.71 $
 * $Date: 2008/06/27 04:28:04 $
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
package com.mvnforum.user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import net.myvietnam.mvncore.exception.BadInputException;
import net.myvietnam.mvncore.exception.FloodException;
import net.myvietnam.mvncore.filter.UserAgentFilter;
import net.myvietnam.mvncore.security.FloodControl;
import net.myvietnam.mvncore.service.*;
import net.myvietnam.mvncore.service.impl.MvnCoreLifeCycleServiceImplDefault;
import net.myvietnam.mvncore.util.I18nUtil;
import net.myvietnam.mvncore.util.ParamUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mvnforum.*;
import com.mvnforum.auth.*;
import com.mvnforum.service.*;
import com.mvnforum.service.impl.MvnForumLifeCycleServiceImplDefault;

public class ForumUserServlet extends HttpServlet {

    private static final Log log = LogFactory.getLog(ForumUserServlet.class);

    private static int count = 0;

    private ModuleProcessor              userModuleProcessor          = null;
    private MvnForumInfoService          mvnForumInfo                 = MvnForumServiceFactory.getMvnForumService().getMvnForumInfoService();
    private IPFilterService              ipFilterService              = MvnCoreServiceFactory.getMvnCoreService().getIPFilterService();
    private EnvironmentService           environmentService           = MvnCoreServiceFactory.getMvnCoreService().getEnvironmentService();
    private CentralAuthenticationService centralAuthenticationService = MvnForumServiceFactory.getMvnForumService().getCentralAuthenticationService();

    /** Initialize global variables */
    public void init() throws ServletException {
        userModuleProcessor = MvnForumServiceFactory.getMvnForumService().getModuleProcessorService().getUserModuleProcessor();
        userModuleProcessor.setServlet(this);

        if (MvnCoreLifeCycleServiceImplDefault.isCalled() == false) {
            environmentService.setShouldRun(false, "MvnCoreLifeCycleServiceImplDefault has not been called");
        }

        if (MvnForumLifeCycleServiceImplDefault.isCalled() == false) {
            environmentService.setShouldRun(false, "MvnForumLifeCycleServiceImplDefault has not been called");
        }

        log.info("<<---- ForumUserServlet has been inited.  Detailed info: " + mvnForumInfo.getProductVersion() + " (Build: " + mvnForumInfo.getProductReleaseDate() + ") ---->>");
    }

    /** Process the HTTP Get request */
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        process(request, response);
    }

    /** Process the HTTP Post request */
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        process(request, response);
    }

    public void process(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException {

        if (environmentService.isShouldRun() == false) {
            String error = "Cannot init system. Reason : " + environmentService.getReason();
            request.setAttribute("fatal_error_message", error);
            getServletContext().getRequestDispatcher("/mvnplugin/mvnforum/mvnfatalerror.jsp").forward(request, response);
            return;
        }

        long startTime = 0;
        if (log.isDebugEnabled()) {
            startTime = System.currentTimeMillis();
        }
        count++;
        try {
            String currentIP = request.getRemoteAddr();
            
            // Control the HTTP request, we don't want user to try too many request
            try {
                FloodControl.ensureNotReachMaximum(MVNForumGlobal.FLOOD_ID_HTTP_REQUEST_PER_IP, currentIP);
            } catch (FloodException fe) {
                getServletContext().getRequestDispatcher("/mvnplugin/mvnforum/max_http_request.jsp").forward(request, response);
                return;
            }
            FloodControl.increaseCount(MVNForumGlobal.FLOOD_ID_HTTP_REQUEST_PER_IP, currentIP);

            if (ipFilterService.filter(request) == false) {
                getServletContext().getRequestDispatcher("/mvnplugin/mvnforum/404.jsp").forward(request, response);
                return;
            }
            if (UserAgentFilter.filter(request) == false) {
                getServletContext().getRequestDispatcher("/mvnplugin/mvnforum/404.jsp").forward(request, response);
                return;
            }

            //request.setCharacterEncoding("utf-8");
            centralAuthenticationService.trackTicket(request);

            String responseURI = null;
            responseURI = ManagerFactory.getRequestProcessor().preLogin(request, response);

            // This will make sure that the user information is put in the request.
            OnlineUserManager onlineUserManager = OnlineUserManager.getInstance();
            OnlineUser onlineUser = onlineUserManager.getOnlineUser(request);// could throw DatabaseException :-(
            OnlineUserAction action = onlineUser.getOnlineUserAction();

            if (action.getRemoteAddr().equals(currentIP) == false) {
                // we will forward if this user is logged in, and ignore if he is Guest
                if (onlineUser.isMember() && 
                    MVNForumConfig.getEnableCheckInvalidSession() && 
                    (onlineUser.getAuthenticationType() != OnlineUser.AUTHENTICATION_TYPE_COOKIE) ) {
                    request.getRequestDispatcher("/mvnplugin/mvnforum/invalidsession.jsp").forward(request, response);
                    return;
                }
            }
            // check the module is on. Otherwise, go to message inform that
            // the module is Off now. Please access later when the admin change mode to on
            if (MVNForumConfig.getShouldShowUserArea() == false) {
                if (!onlineUser.getPermission().canAdminSystem()) {
                    request.getRequestDispatcher("/mvnplugin/mvnforum/turnoff.jsp").forward(request, response);
                    return;
                }
            }

            //Config.set(request, Config.FMT_FALLBACK_LOCALE, "en");
            String localeName = ParamUtil.getParameter(request, MVNForumConfig.getLocaleParameterName());
            if (MVNForumConfig.supportLocale(localeName)) {
                onlineUser.setLocaleName(localeName);
            }
            I18nUtil.setLocaleInRequest(request, onlineUser.getLocale());
            
            // save Vietnamese typer mode if exists one
            //MyUtil.saveVNTyperMode(request, response);

            if (responseURI == null) {
                responseURI = ManagerFactory.getRequestProcessor().preProcess(request, response);
            }

            if (responseURI == null) {
                // this method should not throw Exception (it must catch all Exceptions)
                responseURI = userModuleProcessor.process(request, response);
            }

            responseURI = ManagerFactory.getRequestProcessor().postProcess(request, response, responseURI);
            if (responseURI != null) {
                if (response.isCommitted() == false) {
                    if (responseURI.startsWith("http://") || responseURI.startsWith("https://")) {
                        response.sendRedirect(responseURI);
                    } else {
                        if (responseURI.endsWith(".jsp")) {
                            // this will cause the exception compiler.Compiler if the jsp cannot be compiled,
                            // which cause MVNForumConfig.setShouldRun to be called below

                            if ((responseURI.indexOf("votepollx") != -1) || (responseURI.indexOf("poll_") != -1) || (responseURI.indexOf("error_") != -1)) {
                                RequestDispatcher dispatcher = request.getRequestDispatcher(responseURI);
                                if (dispatcher != null) {
                                    dispatcher.include(request, response);
                                } else {
                                    log.warn("Cannot get RequestDispatcher for responseURI = " + responseURI);
                                }
                            } else {
                                RequestDispatcher dispatcher = request.getRequestDispatcher(responseURI);
                                if (dispatcher != null) {
                                    dispatcher.forward(request, response);
                                } else {
                                    log.warn("Cannot get RequestDispatcher for responseURI = " + responseURI);
                                }
                            }
                        } else {
                            response.sendRedirect(request.getContextPath() + responseURI);
                        }
                    }
                } else {// already committed, only accept include
                    if (responseURI.startsWith("http://") || responseURI.startsWith("https://")) {
                        // do nothing
                    } else {
                        if (responseURI.endsWith(".jsp")) {
                            // this will cause the exception compiler.Compiler if the jsp cannot be compiled,
                            // which cause MVNForumConfig.setShouldRun to be called below

                            if ((responseURI.indexOf("votepollx") != -1) || (responseURI.indexOf("poll_") != -1) || (responseURI.indexOf("error_") != -1)) {
                                RequestDispatcher dispatcher = request.getRequestDispatcher(responseURI);
                                if (dispatcher != null) {
                                    dispatcher.include(request, response);
                                } else {
                                    log.warn("Cannot get RequestDispatcher for responseURI = " + responseURI);
                                }
                            } 
                        } 
                    }
                }
            }
        } catch (AuthenticationException e) {
            //do nothing, because onlineUserManager.getOnlineUser(request); could throw this exception
        } catch (Throwable e) {
            // so it should never go here
            environmentService.setShouldRun(false, "Assertion in ForumUserServlet.");
            if (e instanceof BadInputException) {
                // we log in WARN level if this is the exception from user input
                log.warn("Exception in ForumUserServlet e = " + e.getMessage(), e);
            } else if (e instanceof AssertionError) {
                // we log in FATAL level if this is the exception from user input
                log.fatal("Exception in ForumUserServlet e = " + e.getMessage(), e);
            } else {
                log.error("Exception in ForumUserServlet [" + e.getClass().getName() + "] : " + e.getMessage(), e);
            }
        } finally {
            if (log.isDebugEnabled()) {
                long processTime = System.currentTimeMillis() - startTime;
                log.debug("ForumUserServlet processed " + count + " times. Took " + processTime + " milliseconds.\n");
            }
        }
    }// process

    /**
     * Clean up resources
     */
    public void destroy() {
        log.info("<<---- ForumUserServlet has been destroyed. ---->>");
    }
}
