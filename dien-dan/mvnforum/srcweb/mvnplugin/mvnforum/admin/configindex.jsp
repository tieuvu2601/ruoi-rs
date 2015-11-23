<%--
 - $Header: /cvsroot/mvnforum/mvnforum/srcweb/mvnplugin/mvnforum/admin/configindex.jsp,v 1.123.2.2 2008/11/18 08:04:11 lexuanttkhtn Exp $
 - $Author: lexuanttkhtn $
 - $Revision: 1.123.2.2 $
 - $Date: 2008/11/18 08:04:11 $
 -
 - ====================================================================
 -
 - Copyright (C) 2002-2007 by MyVietnam.net
 -
 - All copyright notices regarding mvnForum MUST remain 
 - intact in the scripts and in the outputted HTML.
 - The "powered by" text/logo with a link back to
 - http://www.mvnForum.com and http://www.MyVietnam.net in 
 - the footer of the pages MUST remain visible when the pages
 - are viewed on the internet or intranet.
 -
 - This program is free software; you can redistribute it and/or modify
 - it under the terms of the GNU General Public License as published by
 - the Free Software Foundation; either version 2 of the License, or
 - any later version.
 -
 - This program is distributed in the hope that it will be useful,
 - but WITHOUT ANY WARRANTY; without even the implied warranty of
 - MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 - GNU General Public License for more details.
 -
 - You should have received a copy of the GNU General Public License
 - along with this program; if not, write to the Free Software
 - Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 -
 - Support can be obtained from support forums at:
 - http://www.mvnForum.com/mvnforum/index
 -
 - Correspondence and Marketing Questions can be sent to:
 - info at MyVietnam net
 -
 - @author: Minh Nguyen  
 - @author: Mai  Nguyen  
 - @author: Igor Manic   
 --%>
<%@ page contentType="text/html;charset=utf-8" %>
<%@ page errorPage="fatalerror.jsp"%>
<%@ page import="net.myvietnam.mvncore.db.DBUtils" %>
<%@ page import="net.myvietnam.mvncore.util.StringUtil" %>
<%@ page import="net.myvietnam.mvncore.configuration.DOM4JConfiguration" %>
<%@ page import="com.mvnforum.db.MemberBean" %>
<%@ page import="com.mvnforum.db.WatchBean" %>
<%@ page import="com.mvnforum.db.ForumBean" %>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<fmt:bundle basename="mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.admin.configindex.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css" />
</mvn:head>
<mvn:body>

<%@ include file="header.jsp"%>
<br/>
<%
DOM4JConfiguration mvnforumConfig = (DOM4JConfiguration)request.getAttribute("mvnforumConfig");
DOM4JConfiguration mvncoreConfig  = (DOM4JConfiguration)request.getAttribute("mvncoreConfig");
%>

<table width="95%" align="center">
  <tr class="nav">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/check_icon.png" alt="" /></td>
    <td width="100%" nowrap="nowrap">
    <%if (isServlet) {%>
    <a class="nav" href="<%=urlResolver.encodeURL(request, response, "index", URLResolverService.RENDER_URL, "view")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
    <%}%>
    <a class="nav" href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.admin.index.title"/></a>&nbsp;&raquo;&nbsp;
    <a class="nav" href="<%=urlResolver.encodeURL(request, response, "misctasks")%>"><fmt:message key="mvnforum.admin.misctasks.title"/></a>&nbsp;&raquo;&nbsp;
    <fmt:message key="mvnforum.admin.configindex.title"/>
    </td>
  </tr>
</table>
<br/>

<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
  <tr class="pagedesc">
    <td>
      <fmt:message key="mvnforum.admin.configindex.info"/><br/>
      <span class="warning"><fmt:message key="mvnforum.admin.configindex.warning"/></span><br/><br/>
      <fmt:message key="mvnforum.common.prompt.choose_tasks"/><br/>

<%if (permission.canAdminSystem()) {%>
      <a href="<%=urlResolver.encodeURL(request, response, "configbackupprocess", URLResolverService.ACTION_URL)%>" class="command"><fmt:message key="mvnforum.admin.configindex.command.backup_config_files"/></a><br/>
<%}%>

<%if (permission.canAdminSystem()) {%>
      <a href="<%=urlResolver.encodeURL(request, response, "commitconfigs", URLResolverService.ACTION_URL)%>" class="command"><fmt:message key="mvnforum.admin.configindex.command.reload_all_changes"/></a><br/>
<%}%>

<%if (permission.canAdminSystem() && (environmentService.getForumRunMode() == EnvironmentService.PRODUCT_ENTERPRISE)) {%>
      <a href="<%=urlResolver.encodeURL(request, response, "configenterprise", URLResolverService.RENDER_URL)%>" class="command"><fmt:message key="mvnforum.admin.configenterprisex.title"/></a><br/>
<%}%>
    </td>
  </tr>
</table>


<%-- Below is mvncore.xml --%>
<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.config.config_mvncore_database"/></td>
  </tr>
<mvn:cssrows>
  <tr class="<mvn:cssrow/>">
    <td>database_type <span class="requiredfield">*</span></td>
    <% 
    String str_database_type = mvncoreConfig.getString("dboptions.database_type", ""); 
    String databaseName = "Invalid value, please correct it.";
    try {
        int database_type = Integer.parseInt(str_database_type);
        databaseName = DBUtils.getDatabaseTypeName(database_type);
    } catch (Exception e) {}
    %>
    <td><%=mvncoreConfig.getString("dboptions.database_type", "")%> (<%=databaseName%>)</td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>use_datasource <span class="requiredfield">*</span></td>
    <td><%=mvncoreConfig.getString("dboptions.use_datasource", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>driver_class_name <span class="requiredfield">*</span></td>
    <td><%=mvncoreConfig.getString("dboptions.driver_class_name", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>database_url <span class="requiredfield">*</span></td>
    <td><%=mvncoreConfig.getString("dboptions.database_url", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>database_user <span class="requiredfield">*</span></td>
    <td><%=mvncoreConfig.getString("dboptions.database_user", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>database_password</td>
    <td><%=StringUtil.getHiddenPassword(mvncoreConfig.getString("dboptions.database_password", ""))%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_connection <span class="requiredfield">*</span></td>
    <td><%=mvncoreConfig.getString("dboptions.max_connection", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_time_to_wait <span class="requiredfield">*</span></td>
    <td><%=mvncoreConfig.getString("dboptions.max_time_to_wait", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>minutes_between_refresh <span class="requiredfield">*</span></td>
    <td><%=mvncoreConfig.getString("dboptions.minutes_between_refresh", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>datasource_name <span class="requiredfield">*</span></td>
    <td><%=mvncoreConfig.getString("dboptions.datasource_name", "")%></td>
  </tr>
</mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.config.config_mvncore_mail"/></td>
  </tr>
<mvn:cssrows>
  <tr class="<mvn:cssrow/>">
    <td>default_mail_from <span class="requiredfield">*</span></td>
    <td><%=mvncoreConfig.getString("mailoptions.default_mail_from", "")%></td>
  </tr>  
</mvn:cssrows>
  <tr class="portlet-section-subheader">
    <td colspan="2"><fmt:message key="mvnforum.admin.config.config_mvncore_mail.recieve_mail_option"/></td>
  </tr>
<mvn:cssrows>
  <tr class="<mvn:cssrow/>">
    <td>enable_mail_source <span class="requiredfield">*</span></td>
    <td><%=mvncoreConfig.getString("mailoptions.receive_mail.enable_mail_source", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>mail_source_name</td>
    <td><%=mvncoreConfig.getString("mailoptions.receive_mail.mail_source_name", "")%></td>
  </tr>    
  <tr class="<mvn:cssrow/>">
    <td>mail_server <span class="requiredfield">*</span></td>
    <td><%=mvncoreConfig.getString("mailoptions.receive_mail.mail_server", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>username</td>
    <td><%=mvncoreConfig.getString("mailoptions.receive_mail.username", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>password</td>
    <td><%=StringUtil.getHiddenPassword(mvncoreConfig.getString("mailoptions.receive_mail.password", ""))%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>port <span class="requiredfield">*</span></td>
    <td><%=mvncoreConfig.getString("mailoptions.receive_mail.port", "")%></td>
  </tr>
</mvn:cssrows>
  <tr class="portlet-section-subheader">
    <td colspan="2"><fmt:message key="mvnforum.admin.config.config_mvncore_mail.send_mail_option"/></td>
  </tr>
<mvn:cssrows>
  <tr class="<mvn:cssrow/>">
    <td>use_embeded_smtp_mail_server <span class="requiredfield">*</span></td>
    <td><%=mvncoreConfig.getString("mailoptions.send_mail.use_embeded_smtp_mail_server", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_mail_source <span class="requiredfield">*</span></td>
    <td><%=mvncoreConfig.getString("mailoptions.send_mail.enable_mail_source", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>mail_source_name</td>
    <td><%=mvncoreConfig.getString("mailoptions.send_mail.mail_source_name", "")%></td>
  </tr>    
  <tr class="<mvn:cssrow/>">
    <td>use_secure_connection <span class="requiredfield">*</span></td>
    <td><%=mvncoreConfig.getString("mailoptions.send_mail.use_secure_connection", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>mail_server <span class="requiredfield">*</span></td>
    <td><%=mvncoreConfig.getString("mailoptions.send_mail.mail_server", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>username</td>
    <td><%=mvncoreConfig.getString("mailoptions.send_mail.username", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>password</td>
    <td><%=StringUtil.getHiddenPassword(mvncoreConfig.getString("mailoptions.send_mail.password", ""))%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>port <span class="requiredfield">*</span></td>
    <td><%=mvncoreConfig.getString("mailoptions.send_mail.port", "")%></td>
  </tr>    
</mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.config.config_mvncore_param"/></td>
  </tr>
<mvn:cssrows>
  <tr class="<mvn:cssrow/>">
    <td>context_path</td>
    <td><%=mvncoreConfig.getString("paramoptions.context_path", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>server_path <span class="requiredfield">*</span></td>
    <td><%=mvncoreConfig.getString("paramoptions.server_path", "")%></td>
  </tr>
</mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.config.config_mvncore_date"/></td>
  </tr>
<mvn:cssrows>
  <tr class="<mvn:cssrow/>">
    <td>server_hour_offset <span class="requiredfield">*</span></td>
    <td><%=mvncoreConfig.getString("dateoptions.server_hour_offset", "")%></td>
  </tr>
</mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.config.config_mvncore_user_agent"/></td>
  </tr>
<mvn:cssrows>
  <tr class="<mvn:cssrow/>">
    <td>blocked_user_agent</td>
    <td><%=mvncoreConfig.getString("useragentoptions.blocked_user_agent", "")%></td>
  </tr>
</mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.config.config_mvncore_core"/></td>
  </tr>
<mvn:cssrows>
  <tr class="<mvn:cssrow/>">
    <td>timermanager_datasource</td>
    <td><%=mvncoreConfig.getString("mvncoreconfig.timermanager_datasource", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_link_nofollow</td>
    <td><%=mvncoreConfig.getString("mvncoreconfig.enable_link_nofollow", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_encode_url</td>
    <td><%=mvncoreConfig.getString("mvncoreconfig.enable_encode_url", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>portal_type</td>
    <td><%=mvncoreConfig.getString("mvncoreconfig.portal_type", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>allow_http_referer_prefix_list</td>
    <td><%=mvncoreConfig.getString("mvncoreconfig.allow_http_referer_prefix_list", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>mvncoreservice_implementation <span class="requiredfield">*</span></td>
    <td><%=mvncoreConfig.getString("mvncoreconfig.mvncoreservice_implementation", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>timertaskext_implementation_list</td>
    <td><%=mvncoreConfig.getString("mvncoreconfig.timertaskext_implementation_list", "")%></td>
  </tr>
</mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.config.config_mvncore_interceptor"/></td>
  </tr>
<mvn:cssrows>
  <tr class="<mvn:cssrow/>">
    <td>mailinterceptor_implementation</td>
    <td><%=mvncoreConfig.getString("interceptor.mailinterceptor_implementation", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>contentinterceptor_implementation</td>
    <td><%=mvncoreConfig.getString("interceptor.contentinterceptor_implementation", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>loginidinterceptor_implementation</td>
    <td><%=mvncoreConfig.getString("interceptor.loginidinterceptor_implementation", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>passwordinterceptor_implementation</td>
    <td><%=mvncoreConfig.getString("interceptor.passwordinterceptor_implementation", "")%></td>
  </tr>
</mvn:cssrows>
  <tr class="portlet-section-footer">
    <td colspan="2" align="center">
      <a href="<%=urlResolver.encodeURL(request, response, "configmvncore")%>" class="command"><fmt:message key="mvnforum.admin.configmvncore.title"/></a>
    </td>
  </tr>
</table>


<%-- Below is mvnforum.xml --%>
<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.config.config_url_pattern"/></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td width="30%"><fmt:message key="mvnforum.admin.config.config_url_pattern.user_module"/> <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("usermoduleconfig.url_pattern", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td width="30%"><fmt:message key="mvnforum.admin.config.config_url_pattern.admin_module"/> <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("adminmoduleconfig.url_pattern", "")%></td>
  </tr>
</mvn:cssrows>
  <tr class="portlet-section-footer">
    <td colspan="2" align="center">
      <a href="<%=urlResolver.encodeURL(request, response, "configurlpattern")%>" class="command"><fmt:message key="mvnforum.admin.configurlpattern.title"/></a>
    </td>
  </tr>
</table>

<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.config.config_step1_core"/></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td width="30%">mvnforum_home <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.mvnforum_home", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td width="30%">mvnforum_log <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.mvnforum_log", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>webmaster_email <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.webmaster_email", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>watch_email <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.watch_email", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>logo_url <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.logo_url", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>redirect_login_url <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.redirect_login_url", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>redirect_logout_url <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.redirect_logout_url", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>supported_locales</td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.supported_locales", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>default_locale_name <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.default_locale_name", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>locale_parameter_name <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.locale_parameter_name", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>default_guest_name <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.default_guest_name", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>default_guest_timezone <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.default_guest_timezone", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_cache_member <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_cache_member", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_cache_post <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_cache_post", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_cache_thread <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_cache_thread", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_cache_forum <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_cache_forum", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_cache_category <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_cache_category", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_passwordless_auth <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_passwordless_auth", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_login_info_in_cookie <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_login_info_in_cookie", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_login_info_in_session <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_login_info_in_session", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_login_info_in_realm <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_login_info_in_realm", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_login_info_in_customization <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_login_info_in_customization", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_friendly_url <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_friendly_url", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_check_invalid_session <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_check_invalid_session", "")%></td>
  </tr> 
  <tr class="<mvn:cssrow/>">
    <td>require_activation <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.require_activation", "")%></td>
  </tr>   
  <tr class="<mvn:cssrow/>">
    <td>enable_login <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_login", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_new_member <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_new_member", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_new_post <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_new_post", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_rss <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_rss", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_watch <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_watch", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_attachment <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_attachment", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_avatar <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_avatar", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_emoticon <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_emoticon", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_captcha <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_captcha", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_portal_like_index_page <span class="requiredfield">*</span></td>
   <td><%=mvnforumConfig.getString("mvnforumconfig.enable_portal_like_index_page", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_message_attachment <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_message_attachment", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_search <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_search", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_online_users <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_online_users", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_duplicate_onlineusers <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_duplicate_onlineusers", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_invisible_users <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_invisible_users", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_listmembers <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_listmembers", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_last_login_of_current_member <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_show_last_login_of_current_member", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_last_login <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_show_last_login", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_auto_watching <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_auto_watching", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_birthday <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_show_birthday", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_gender <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_show_gender", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_address <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_show_address", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_city <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_show_city", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_state <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_show_state", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_homepage <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_show_homepage", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_country <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_show_country", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_phone <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_show_phone", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_mobile <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_show_mobile", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_fax <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_show_fax", "")%></td>
  </tr> 
  <tr class="<mvn:cssrow/>">
    <td>enable_show_career <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_show_career", "")%></td>
  </tr>
   <tr class="<mvn:cssrow/>">
    <td>enable_show_cool_link_1 <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_show_cool_link_1", "")%></td>
  </tr>
   <tr class="<mvn:cssrow/>">
    <td>enable_show_cool_link_2 <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_show_cool_link_2", "")%></td>
  </tr>
   <tr class="<mvn:cssrow/>">
    <td>enable_show_yahoo <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_show_yahoo", "")%></td>
  </tr>
   <tr class="<mvn:cssrow/>">
    <td>enable_show_aol <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_show_aol", "")%></td>
  </tr>
   <tr class="<mvn:cssrow/>">
    <td>enable_show_career <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_show_career", "")%></td>
  </tr>
   <tr class="<mvn:cssrow/>">
    <td>enable_show_icq <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_show_icq", "")%></td>
  </tr>
   <tr class="<mvn:cssrow/>">
    <td>enable_show_msn <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_show_msn", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_join_date <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_show_join_date", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_post_count <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_show_post_count", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_view_count <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_show_view_count", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_email <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_show_email", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_online_status <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_show_online_status", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_firstname <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_show_firstname", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_lastname <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_show_lastname", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_use_popup_menu_in_viewthread <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_use_popup_menu_in_viewthread", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_split_thread <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_split_thread", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_listunansweredthreads <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_listunansweredthreads", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_list_users_browsing_thread <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_list_users_browsing_thread", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_email_to_admin_content_with_censored_words <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_email_to_admin_content_with_censored_words", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_guest_view_listusers <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_guest_view_listusers", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>only_normal_thread_type_in_active_threads <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.only_normal_thread_type_in_active_threads", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>send_watchmail_as_html <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.send_watchmail_as_html", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_easy_watching <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_easy_watching", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_send_watch_mail_of_my_own_post <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_send_watch_mail_of_my_own_post", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_last_post_body_in_watch <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.max_last_post_body_in_watch", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_message_attachment <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_message_attachment", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_most_active_threads <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_most_active_threads", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_most_active_members <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_most_active_members", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_site_statistics_overview <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_site_statistics_overview", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_admin_can_change_password <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_admin_can_change_password", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_guest_view_image_attachment <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_guest_view_image_attachment", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_expanse_category_tree_by_default <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_expanse_category_tree_by_default", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>default_watch_option <span class="requiredfield">*</span></td>
    <td>
    <%=mvnforumConfig.getString("mvnforumconfig.default_watch_option", "")%>
    <%
    int default_watch_option = mvnforumConfig.getInt("mvnforumconfig.default_watch_option", WatchBean.WATCH_OPTION_DEFAULT);
    String str_default_watch_option = "Default (daily watch)";
    if (default_watch_option == WatchBean.WATCH_OPTION_LIVE) {
        str_default_watch_option = "Live Watch";
    } else if (default_watch_option == WatchBean.WATCH_OPTION_HOURLY) {
        str_default_watch_option = "Hourly Watch";
    } else if (default_watch_option == WatchBean.WATCH_OPTION_DAILY) {
        str_default_watch_option = "Daily Watch";
    } else if (default_watch_option == WatchBean.WATCH_OPTION_WEEKLY) {
        str_default_watch_option = "Weekly Watch";
    }
    %>
    : <%=str_default_watch_option%>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>default_moderation_option <span class="requiredfield">*</span></td>
    <td>
    <%=mvnforumConfig.getString("mvnforumconfig.default_moderation_option", "")%>
    <%
    int default_moderation_option = mvnforumConfig.getInt("mvnforumconfig.default_moderation_option", ForumBean.FORUM_MODERATION_MODE_NO_MODERATION);
    String str_default_moderation_option = "Default (No Moderation)";
    if (default_moderation_option == ForumBean.FORUM_MODERATION_MODE_THREAD_AND_POST) {
        str_default_moderation_option = "Thread and Post Moderation";
    } else if (default_moderation_option == ForumBean.FORUM_MODERATION_MODE_THREAD_ONLY) {
        str_default_moderation_option = "Thread only Moderation";
    } else if (default_moderation_option == ForumBean.FORUM_MODERATION_MODE_POST_ONLY) {
        str_default_moderation_option = "Post only Moderation";
    }
    %>
    : <%=str_default_moderation_option%>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
     <td>enable_encrypt_password_on_browser <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_encrypt_password_on_browser", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
     <td>enable_external_user_database <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_external_user_database", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
     <td>enable_list_new_members_in_recent_days <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_list_new_members_in_recent_days", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
     <td>days_to_show_recent_members <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.days_to_show_recent_members", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
     <td>enable_list_users_browsing_forum <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_list_users_browsing_forum", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
     <td>enable_email_threatening_content <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_email_threatening_content", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
     <td>have_internet <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.have_internet", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
     <td>event_log_locale <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.event_log_locale", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
     <td>default_category_id <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.default_category_id", "")%></td>
  </tr>
   <tr class="<mvn:cssrow/>">
     <td>default_watch_type <span class="requiredfield">*</span></td>
    <td>
      <%=mvnforumConfig.getString("mvnforumconfig.default_watch_type", "")%>
      <%
      int default_watch_type = mvnforumConfig.getInt("mvnforumconfig.default_watch_type", WatchBean.WATCH_TYPE_DIGEST);
      String str_default_watch_type = "Default (Digest)";
      if (default_watch_type == WatchBean.WATCH_TYPE_NONDIGEST) {
          str_default_watch_type = "Non Digest";
      }
      %>
      : <%=str_default_watch_type%>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>default_status_of_registered_member <span class="requiredfield">*</span></td>
    <td>
      <%=mvnforumConfig.getString("mvnforumconfig.default_status_of_registered_member", "")%>
      <%
      int default_status_of_registered_member = mvnforumConfig.getInt("mvnforumconfig.default_status_of_registered_member", MemberBean.MEMBER_STATUS_ENABLE);
      String str_default_status_of_registered_member = "Default (Enable Status)";
      if (default_status_of_registered_member == MemberBean.MEMBER_STATUS_PENDING) {
          str_default_status_of_registered_member = "Pending Status";
      }
      %>
      : <%=str_default_status_of_registered_member%>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_register_rule <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_register_rule", "")%></td>
  </tr>
</mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.config.config_step1_image_thumbnail"/></td>
  </tr>
<mvn:cssrows>    
  <tr class="<mvn:cssrow/>">
    <td>enable_image_thumbnail <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.image_thumbnail.enable", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>image_thumbnail_width <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.image_thumbnail.width", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>image_thumbnail_height <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.image_thumbnail.height", "")%></td>
  </tr>
</mvn:cssrows> 
<mvn:cssrows>    
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.config.config_step1_factory"/></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>member_implementation <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumfactoryconfig.member_implementation", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>onlineuser_implementation <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumfactoryconfig.onlineuser_implementation", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>authenticator_implementation</td>
    <td><%=mvnforumConfig.getString("mvnforumfactoryconfig.authenticator_implementation", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>requestprocessor_implementation <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumfactoryconfig.requestprocessor_implementation", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>lucene_analyzer_implementation <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumfactoryconfig.lucene_analyzer_implementation", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>mvn_auth_service_implementation <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumfactoryconfig.mvn_auth_service_implementation", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>mvnforum_service_implementation <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumfactoryconfig.mvnforum_service_implementation", "")%></td>
  </tr>
</mvn:cssrows>  
  <tr class="portlet-section-footer">
    <td colspan="2" align="center">
      <a href="<%=urlResolver.encodeURL(request, response, "configstepone")%>" class="command"><fmt:message key="mvnforum.admin.configstepone.title"/></a>
    </td>
  </tr>
</table>
<br/>
<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.config.config_step2"/></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_private_message <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.max_private_message", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_message_attachment_size <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.max_message_attachment_size", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td width="30%">max_attachment_size <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.max_attachment_size", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_favorite_thread <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.max_favorite_thread", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_edit_days <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.max_edit_days", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_attach_days <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.max_attach_days", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_delete_days <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.max_delete_days", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>rows_per_page <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.rows_per_page", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>rows_per_rss <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.rows_per_rss", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>hot_topic_threshold <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.hot_topic_threshold", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_posts_per_hour_per_member <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.max_posts_per_hour_per_member", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_posts_per_hour_per_ip <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.max_posts_per_hour_per_ip", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_http_requests_per_hour_per_ip <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.max_http_requests_per_hour_per_ip", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_members_per_hour_per_ip <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.max_members_per_hour_per_ip", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_logins_per_hour_per_ip <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.max_logins_per_hour_per_ip", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_messages_per_hour_per_ip <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.max_messages_per_hour_per_ip", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_password_days <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.max_password_days", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_chars_in_short_summary <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.max_chars_in_short_summary", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_chars_in_long_summary <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.max_chars_in_long_summary", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_chars_in_rss <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.max_chars_in_rss", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_backup_on_server <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.enable_backup_on_server", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_import_size <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.max_import_size", "")%></td>
  </tr>
</mvn:cssrows>  
  <tr class="portlet-section-footer">
    <td colspan="2" align="center">
      <a href="<%=urlResolver.encodeURL(request, response, "configsteptwo")%>" class="command"><fmt:message key="mvnforum.admin.configsteptwo.title"/></a>
    </td>
  </tr>
</table>
<br/>
<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.config.config_step3"/></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>require_register_firstname <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.require_register_firstname", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>require_register_lastname <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.require_register_lastname", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td width="30%">require_register_gender <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.require_register_gender", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>require_register_birthday <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.require_register_birthday", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>require_register_address <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.require_register_address", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>require_register_city <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.require_register_city", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>require_register_state <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.require_register_state", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>require_register_country <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.require_register_country", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>require_register_phone <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.require_register_phone", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>require_register_mobile <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.require_register_mobile", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>require_register_fax <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.require_register_fax", "")%></td>
  </tr>  
  <tr class="<mvn:cssrow/>">
    <td>require_register_career <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.require_register_career", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>require_register_homepage <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.require_register_homepage", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>require_register_yahoo <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.require_register_yahoo", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>require_register_aol <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.require_register_aol", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>require_register_icq <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.require_register_icq", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>require_register_msn <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.require_register_msn", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>require_register_link_1 <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.require_register_link_1", "")%></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>require_register_link_2 <span class="requiredfield">*</span></td>
    <td><%=mvnforumConfig.getString("mvnforumconfig.require_register_link_2", "")%></td>
  </tr>
</mvn:cssrows>  
  <tr class="portlet-section-footer">
    <td colspan="2" align="center">
      <a href="<%=urlResolver.encodeURL(request, response, "configstepthree")%>" class="command"><fmt:message key="mvnforum.admin.configstepthree.title"/></a>
    </td>
  </tr>
</table>



<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>
