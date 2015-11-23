<%--
 - $Header: /cvsroot/mvnforum/mvnforum/srcweb/mvnplugin/mvnforum/admin/configstepone.jsp,v 1.86.2.1 2008/11/18 08:04:11 lexuanttkhtn Exp $
 - $Author: lexuanttkhtn $
 - $Revision: 1.86.2.1 $
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
<%@ page import="net.myvietnam.mvncore.configuration.DOM4JConfiguration" %>
<%@ page import="com.mvnforum.db.MemberBean" %>
<%@ page import="com.mvnforum.db.WatchBean" %>
<%@ page import="com.mvnforum.db.ForumBean" %>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<fmt:bundle basename="mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.admin.configstepone.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body onunload="document.submitform.submitbutton.disabled=false;">

<script type="text/javascript">
//<![CDATA[
function SubmitForm() {
  if (ValidateForm()) {
    <mvn:servlet>
      document.submitform.submitbutton.disabled=true;
    </mvn:servlet>  
    document.submitform.submit();
  }
}

function ValidateForm() {
  if (isBlank(document.submitform.mvnforum_home, "mvnforum_home")) return false;
  if (isBlank(document.submitform.mvnforum_log, "mvnforum_log")) return false;
  if (isBlank(document.submitform.webmaster_email, "webmaster_email")) return false;
  if (!isEmail(document.submitform.webmaster_email, "websmater_email")) return false;
  if (isBlank(document.submitform.watch_email, "watch_email")) return false;
  if (!isEmail(document.submitform.watch_email, "watch_email")) return false; 
  if (isBlank(document.submitform.logo_url, "logo_url")) return false;
  if (isBlank(document.submitform.redirect_login_url, "redirect_login_url")) return false;
  //if (isBlank(document.submitform.supported_locales, "mvnforum.admin.config.supported_locales")) return false;
  if (isBlank(document.submitform.default_locale_name, "default_locale_name")) return false;
  if (isBlank(document.submitform.locale_parameter_name, "locale_parameter_name")) return false;
  if (isBlank(document.submitform.default_guest_name, "default_guest_name")) return false;
  if (!isUnsignedInteger(document.submitform.default_guest_timezone, "default_guest_timezone")) return false;
  if (!isUnsignedInteger(document.submitform.max_last_post_body_in_watch, "max_last_post_body_in_watch")) return false;
  if (!isUnsignedInteger(document.submitform.days_to_show_recent_members, "days_to_show_recent_members")) return false;
  
  if (isBlank(document.submitform.member_implementation, "member_implementation")) return false;
  if (isBlank(document.submitform.onlineuser_implementation, "onlineuser_implementation")) return false;
  if (isBlank(document.submitform.requestprocessor_implementation, "requestprocessor_implementation")) return false;
  if (isBlank(document.submitform.lucene_analyzer_implementation, "lucene_analyzer_implementation")) return false;
  if (isBlank(document.submitform.mvnforum_service_implementation, "mvnforum_service_implementation")) return false;
  if (isBlank(document.submitform.mvn_auth_service_implementation, "mvn_auth_service_implementation")) return false;
  
  if (document.submitform.enable_image_thumbnail.checked) {
    if (!isUnsignedInteger(document.submitform.image_thumbnail_width, "image_thumbnail_width")) return false;
    if (!isUnsignedInteger(document.submitform.image_thumbnail_height, "image_thumbnail_height")) return false;
  }
  if (isBlank(document.submitform.MemberCurrentMatkhau, "<fmt:message key="mvnforum.common.prompt.current_password"/>")) {
      return false;
  }
  if (document.submitform.MemberCurrentMatkhau.value.length < 3) {
    alert("<fmt:message key="mvnforum.common.js.prompt.invalidlongpassword"/>");
    document.submitform.MemberCurrentMatkhau.focus();
    return false;
  }
  return true;
}
function OnChangeImageThumbnailStatus() {
  if (document.submitform.enable_image_thumbnail.checked == false) {
    document.getElementById("id_image_thumbnail_width").style.display = 'none';
    document.getElementById("id_image_thumbnail_height").style.display = 'none';
  } else {
    document.getElementById("id_image_thumbnail_width").style.display = '';
    document.getElementById("id_image_thumbnail_height").style.display = '';
  }
}
//]]>
</script>

<%@ include file="header.jsp"%>
<br/>
<%
DOM4JConfiguration mvnforumConfig = (DOM4JConfiguration)request.getAttribute("mvnforumConfig");
%>

<table width="95%" align="center">
  <tr class="nav">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" /></td>
    <td width="100%" nowrap="nowrap">
    <%if (isServlet) {%>
    <a class="nav" href="<%=urlResolver.encodeURL(request, response, "index", URLResolverService.RENDER_URL, "view")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
    <%}%>
    <a class="nav" href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.admin.index.title"/></a>&nbsp;&raquo;&nbsp;
    <a class="nav" href="<%=urlResolver.encodeURL(request, response, "configindex")%>"><fmt:message key="mvnforum.admin.configindex.title"/></a>&nbsp;&raquo;&nbsp;
    <fmt:message key="mvnforum.admin.configstepone.title"/>
    </td>
  </tr>
</table>
<br/>

<form action="<%=urlResolver.encodeURL(request, response, "configsteponeprocess", URLResolverService.ACTION_URL)%>" method="post" name="submitform">
<%=urlResolver.generateFormAction(request, response, "configsteponeprocess")%>
<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.config.config_step1_core"/></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>mvnforum_home <span class="requiredfield">*</span></td>
    <td>
     <% String  mvnforum_home_current = mvnforumConfig.getString("mvnforumconfig.mvnforum_home", "");
        String  mvnforum_home_suggestion = application.getRealPath("/WEB-INF/mvnForumHome");
      %>
      <input type="text" size="70" name="mvnforum_home" value="<%=mvnforum_home_current%>" />
     <% if (mvnforum_home_current.equals(mvnforum_home_suggestion) == false) { %> 
     <br/>Suggestion: <b><%=mvnforum_home_suggestion%></b> 
     <%}%>
    </td> 
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>mvnforum_log <span class="requiredfield">*</span></td>
    <td>
     <% String  mvnforum_log_current = mvnforumConfig.getString("mvnforumconfig.mvnforum_log", "");
        String  mvnforum_log_suggestion = application.getRealPath("/WEB-INF/mvnForumHome/log/mvnforum.log");
      %>
     <input type="text" size="70" name="mvnforum_log" value="<%=mvnforum_log_current%>" />
     
     <% if (mvnforum_log_current.equals(mvnforum_log_suggestion) == false) { %> 
     <br/>Suggestion: <b><%=mvnforum_log_suggestion%></b>
     <%}%>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>webmaster_email <span class="requiredfield">*</span></td>
    <td><input type="text" size="70" name="webmaster_email" value="<%=mvnforumConfig.getString("mvnforumconfig.webmaster_email", "")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>watch_email <span class="requiredfield">*</span></td>
    <td><input type="text" size="70" name="watch_email" value="<%=mvnforumConfig.getString("mvnforumconfig.watch_email", "")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>logo_url <span class="requiredfield">*</span></td>
    <td><input type="text" size="70" name="logo_url" value="<%=mvnforumConfig.getString("mvnforumconfig.logo_url", "")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>redirect_login_url <span class="requiredfield">*</span></td>
    <td><input type="text" size="70" name="redirect_login_url" value="<%=mvnforumConfig.getString("mvnforumconfig.redirect_login_url", "")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>redirect_logout_url <span class="requiredfield">*</span></td>
    <td><input type="text" size="70" name="redirect_logout_url" value="<%=mvnforumConfig.getString("mvnforumconfig.redirect_logout_url", "")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>supported_locales</td>
    <td><input type="text" size="70" name="supported_locales" value="<%=mvnforumConfig.getString("mvnforumconfig.supported_locales", "")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>default_locale_name <span class="requiredfield">*</span></td>
    <td><input type="text" size="70" name="default_locale_name" value="<%=mvnforumConfig.getString("mvnforumconfig.default_locale_name", "")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>locale_parameter_name <span class="requiredfield">*</span></td>
    <td><input type="text" size="70" name="locale_parameter_name" value="<%=mvnforumConfig.getString("mvnforumconfig.locale_parameter_name", "")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>default_guest_name <span class="requiredfield">*</span></td>
    <td><input type="text" size="70" name="default_guest_name" value="<%=mvnforumConfig.getString("mvnforumconfig.default_guest_name", "")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>default_guest_timezone <span class="requiredfield">*</span></td>
    <td><input type="text" size="70" name="default_guest_timezone" value="<%=mvnforumConfig.getString("mvnforumconfig.default_guest_timezone", "")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_cache_member <span class="requiredfield">*</span></td>
    <td>
    <% String enable_cache_member = mvnforumConfig.getString("mvnforumconfig.enable_cache_member", "");%>
    <input type="checkbox" name="enable_cache_member" value="true" class="noborder"
    <% if ("true".equals(enable_cache_member)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_cache_post <span class="requiredfield">*</span></td>
    <td>
    <% String enable_cache_post = mvnforumConfig.getString("mvnforumconfig.enable_cache_post", "");%>
    <input type="checkbox" name="enable_cache_post" value="true" class="noborder"
    <% if ("true".equals(enable_cache_post)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_cache_thread <span class="requiredfield">*</span></td>
    <td>
    <% String enable_cache_thread = mvnforumConfig.getString("mvnforumconfig.enable_cache_thread", "");%>
    <input type="checkbox" name="enable_cache_thread" value="true" class="noborder"
    <% if ("true".equals(enable_cache_thread)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_cache_forum <span class="requiredfield">*</span></td>
    <td>
    <% String enable_cache_forum = mvnforumConfig.getString("mvnforumconfig.enable_cache_forum", "");%>    
    <input type="checkbox" name="enable_cache_forum" value="true" class="noborder"
    <% if ("true".equals(enable_cache_forum)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_cache_category <span class="requiredfield">*</span></td>
    <td>
    <% String enable_cache_category = mvnforumConfig.getString("mvnforumconfig.enable_cache_category", "");%>
    <input type="checkbox" name="enable_cache_category" value="true" class="noborder"
    <% if ("true".equals(enable_cache_category)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_passwordless_auth <span class="requiredfield">*</span></td>
    <td>
    <% String enable_passwordless_auth = mvnforumConfig.getString("mvnforumconfig.enable_passwordless_auth", "");%>    
    <input type="checkbox" name="enable_passwordless_auth" value="true" class="noborder"
    <% if ("true".equals(enable_passwordless_auth)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_login_info_in_cookie <span class="requiredfield">*</span></td>
    <td>
    <% String enable_login_info_in_cookie = mvnforumConfig.getString("mvnforumconfig.enable_login_info_in_cookie", "");%>
    <input type="checkbox" name="enable_login_info_in_cookie" value="true" class="noborder"
    <% if ("true".equals(enable_login_info_in_cookie)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_login_info_in_session <span class="requiredfield">*</span></td>
    <td>
    <% String enable_login_info_in_session = mvnforumConfig.getString("mvnforumconfig.enable_login_info_in_session", "");%>    
    <input type="checkbox" name="enable_login_info_in_session" value="true" class="noborder"
    <% if ("true".equals(enable_login_info_in_session)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_login_info_in_realm <span class="requiredfield">*</span></td>
    <td>
    <% String enable_login_info_in_realm = mvnforumConfig.getString("mvnforumconfig.enable_login_info_in_realm", "");%>
    <input type="checkbox" name="enable_login_info_in_realm" value="true" class="noborder"
    <% if ("true".equals(enable_login_info_in_realm)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_login_info_in_customization <span class="requiredfield">*</span></td>
    <td>
    <% String enable_login_info_in_customization = mvnforumConfig.getString("mvnforumconfig.enable_login_info_in_customization", "");%>
    <input type="checkbox" name="enable_login_info_in_customization" value="true" class="noborder"
    <% if ("true".equals(enable_login_info_in_customization)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_friendly_url <span class="requiredfield">*</span></td>
    <td>
    <% String enable_friendly_url = mvnforumConfig.getString("mvnforumconfig.enable_friendly_url", "");%>
    <input type="checkbox" name="enable_friendly_url" value="true" class="noborder"
    <% if ("true".equals(enable_friendly_url)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_check_invalid_session <span class="requiredfield">*</span></td>
    <td>
    <% String enable_check_invalid_session = mvnforumConfig.getString("mvnforumconfig.enable_check_invalid_session", "");%>
    <input type="checkbox" name="enable_check_invalid_session" value="true" class="noborder"
    <% if ("true".equals(enable_check_invalid_session)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>require_activation <span class="requiredfield">*</span></td>
    <td>
    <% String require_activation = mvnforumConfig.getString("mvnforumconfig.require_activation", "");%>
    <input type="checkbox" name="require_activation" value="true" class="noborder"
    <% if ("true".equals(require_activation)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_login <span class="requiredfield">*</span></td>
    <td>
    <% String enable_login = mvnforumConfig.getString("mvnforumconfig.enable_login", "");%>
    <input type="checkbox" name="enable_login" value="true" class="noborder"
    <% if ("true".equals(enable_login)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_new_member <span class="requiredfield">*</span></td>
    <td>
    <% String enable_new_member = mvnforumConfig.getString("mvnforumconfig.enable_new_member", "");%>
    <input type="checkbox" name="enable_new_member" value="true" class="noborder"
    <% if ("true".equals(enable_new_member)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_new_post <span class="requiredfield">*</span></td>
    <td>
    <% String enable_new_post = mvnforumConfig.getString("mvnforumconfig.enable_new_post", "");%>
    <input type="checkbox" name="enable_new_post" value="true" class="noborder"
    <% if ("true".equals(enable_new_post)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_rss <span class="requiredfield">*</span></td>
    <td>
    <% String enable_rss = mvnforumConfig.getString("mvnforumconfig.enable_rss", "");%>
    <input type="checkbox" name="enable_rss" value="true" class="noborder"
    <% if ("true".equals(enable_rss)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_watch <span class="requiredfield">*</span></td>
    <td>
    <% String enable_watch = mvnforumConfig.getString("mvnforumconfig.enable_watch", "");%>
    <input type="checkbox" name="enable_watch" value="true" class="noborder"
    <% if ("true".equals(enable_watch)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_attachment <span class="requiredfield">*</span></td>
    <td>
    <% String enable_attachment = mvnforumConfig.getString("mvnforumconfig.enable_attachment", "");%>
    <input type="checkbox" name="enable_attachment" value="true" class="noborder"
    <% if ("true".equals(enable_attachment)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_avatar <span class="requiredfield">*</span></td>
    <td>
    <% String enable_avatar = mvnforumConfig.getString("mvnforumconfig.enable_avatar", "");%>
    <input type="checkbox" name="enable_avatar" value="true" class="noborder"
    <% if ("true".equals(enable_avatar)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_emoticon <span class="requiredfield">*</span></td>
    <td>
    <% String enable_emoticon = mvnforumConfig.getString("mvnforumconfig.enable_emoticon", "");%>
    <input type="checkbox" name="enable_emoticon" value="true" class="noborder"
    <% if ("true".equals(enable_emoticon)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_captcha <span class="requiredfield">*</span></td>
    <td>
    <% String enable_captcha = mvnforumConfig.getString("mvnforumconfig.enable_captcha", "");%>
    <input type="checkbox" name="enable_captcha" value="true" class="noborder"
    <% if ("true".equals(enable_captcha)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_portal_like_index_page <span class="requiredfield">*</span></td>
    <td>
    <% String enable_portal_like_index_page = mvnforumConfig.getString("mvnforumconfig.enable_portal_like_index_page", "");%>
    <input type="checkbox" name="enable_portal_like_index_page" value="true" class="noborder"
    <% if ("true".equals(enable_portal_like_index_page)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_search <span class="requiredfield">*</span></td>
    <td>
    <% String enable_search = mvnforumConfig.getString("mvnforumconfig.enable_search", "");%>
    <input type="checkbox" name="enable_search" value="true" class="noborder"
    <% if ("true".equals(enable_search)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_online_users <span class="requiredfield">*</span></td>
    <td>
    <% String enable_online_users = mvnforumConfig.getString("mvnforumconfig.enable_online_users", "");%>
    <input type="checkbox" name="enable_online_users" value="true" class="noborder"
    <% if ("true".equals(enable_online_users)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_duplicate_onlineusers <span class="requiredfield">*</span></td>
    <td>
    <% String enable_duplicate_onlineusers = mvnforumConfig.getString("mvnforumconfig.enable_duplicate_onlineusers", "");%>
    <input type="checkbox" name="enable_duplicate_onlineusers" value="true" class="noborder"
    <% if ("true".equals(enable_duplicate_onlineusers)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_invisible_users <span class="requiredfield">*</span></td>
    <td>
    <% String enable_invisible_users = mvnforumConfig.getString("mvnforumconfig.enable_invisible_users", "");%>
    <input type="checkbox" name="enable_invisible_users" value="true" class="noborder"
    <% if ("true".equals(enable_invisible_users)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_listmembers <span class="requiredfield">*</span></td>
    <td>
    <% String enable_listmembers = mvnforumConfig.getString("mvnforumconfig.enable_listmembers", "");%>
    <input type="checkbox" name="enable_listmembers" value="true" class="noborder"
    <% if ("true".equals(enable_listmembers)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_last_login_of_current_member <span class="requiredfield">*</span></td>
    <td>
    <% String enable_show_last_login_of_current_member = mvnforumConfig.getString("mvnforumconfig.enable_show_last_login_of_current_member", "");%>
    <input type="checkbox" name="enable_show_last_login_of_current_member" value="true" class="noborder"
    <% if ("true".equals(enable_show_last_login_of_current_member)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_last_login <span class="requiredfield">*</span></td>
    <td>
    <% String enable_show_last_login = mvnforumConfig.getString("mvnforumconfig.enable_show_last_login", "");%>
    <input type="checkbox" name="enable_show_last_login" value="true" class="noborder"
    <% if ("true".equals(enable_show_last_login)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_auto_watching <span class="requiredfield">*</span></td>
    <td>
    <% String enable_auto_watching = mvnforumConfig.getString("mvnforumconfig.enable_auto_watching", "");%>
    <input type="checkbox" name="enable_auto_watching" value="true" class="noborder"
    <% if ("true".equals(enable_auto_watching)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_birthday <span class="requiredfield">*</span></td>
    <td>
    <% String enable_show_birthday = mvnforumConfig.getString("mvnforumconfig.enable_show_birthday", "");%>
    <input type="checkbox" name="enable_show_birthday" value="true" class="noborder"
    <% if ("true".equals(enable_show_birthday)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_gender <span class="requiredfield">*</span></td>
    <td>
    <% String enable_show_gender = mvnforumConfig.getString("mvnforumconfig.enable_show_gender", "");%>
    <input type="checkbox" name="enable_show_gender" value="true" class="noborder"
    <% if ("true".equals(enable_show_gender)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_address <span class="requiredfield">*</span></td>
    <td>
    <% String enable_show_address = mvnforumConfig.getString("mvnforumconfig.enable_show_address", "");%>
    <input type="checkbox" name="enable_show_address" value="true" class="noborder"
    <% if ("true".equals(enable_show_address)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_city <span class="requiredfield">*</span></td>
    <td>
    <% String enable_show_city = mvnforumConfig.getString("mvnforumconfig.enable_show_city", "");%>
    <input type="checkbox" name="enable_show_city" value="true" class="noborder"
    <% if ("true".equals(enable_show_city)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_state <span class="requiredfield">*</span></td>
    <td>
    <% String enable_show_state = mvnforumConfig.getString("mvnforumconfig.enable_show_state", "");%>
    <input type="checkbox" name="enable_show_state" value="true" class="noborder"
    <% if ("true".equals(enable_show_state)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_homepage <span class="requiredfield">*</span></td>
    <td>
    <% String enable_show_homepage = mvnforumConfig.getString("mvnforumconfig.enable_show_homepage", "");%>
    <input type="checkbox" name="enable_show_homepage" value="true" class="noborder"
    <% if ("true".equals(enable_show_homepage)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_country <span class="requiredfield">*</span></td>
    <td>
    <% String enable_show_country = mvnforumConfig.getString("mvnforumconfig.enable_show_country", "");%>
    <input type="checkbox" name="enable_show_country" value="true" class="noborder"
    <% if ("true".equals(enable_show_country)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_phone <span class="requiredfield">*</span></td>
    <td>
    <% String enable_show_phone = mvnforumConfig.getString("mvnforumconfig.enable_show_phone", "");%>
    <input type="checkbox" name="enable_show_phone" value="true" class="noborder"
    <% if ("true".equals(enable_show_phone)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_mobile <span class="requiredfield">*</span></td>
    <td>
    <% String enable_show_mobile = mvnforumConfig.getString("mvnforumconfig.enable_show_mobile", "");%>
    <input type="checkbox" name="enable_show_mobile" value="true" class="noborder"
    <% if ("true".equals(enable_show_mobile)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_fax <span class="requiredfield">*</span></td>
    <td>
    <% String enable_show_fax = mvnforumConfig.getString("mvnforumconfig.enable_show_fax", "");%>
    <input type="checkbox" name="enable_show_fax" value="true" class="noborder"
    <% if ("true".equals(enable_show_fax)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_career <span class="requiredfield">*</span></td>
    <td>
    <% String enable_show_career = mvnforumConfig.getString("mvnforumconfig.enable_show_career", "");%>
    <input type="checkbox" name="enable_show_career" value="true" class="noborder"
    <% if ("true".equals(enable_show_career)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_cool_link_1 <span class="requiredfield">*</span></td>
    <td>
    <% String enable_show_cool_link_1 = mvnforumConfig.getString("mvnforumconfig.enable_show_cool_link_1", "");%>
    <input type="checkbox" name="enable_show_cool_link_1" value="true" class="noborder"
    <% if ("true".equals(enable_show_cool_link_1)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_cool_link_2 <span class="requiredfield">*</span></td>
    <td>
    <% String enable_show_cool_link_2 = mvnforumConfig.getString("mvnforumconfig.enable_show_cool_link_2", "");%>
    <input type="checkbox" name="enable_show_cool_link_2" value="true" class="noborder"
    <% if ("true".equals(enable_show_cool_link_2)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_yahoo <span class="requiredfield">*</span></td>
    <td>
    <% String enable_show_yahoo = mvnforumConfig.getString("mvnforumconfig.enable_show_yahoo", "");%>
    <input type="checkbox" name="enable_show_yahoo" value="true" class="noborder"
    <% if ("true".equals(enable_show_yahoo)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_aol <span class="requiredfield">*</span></td>
    <td>
    <% String enable_show_aol = mvnforumConfig.getString("mvnforumconfig.enable_show_aol", "");%>
    <input type="checkbox" name="enable_show_aol" value="true" class="noborder"
    <% if ("true".equals(enable_show_aol)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_icq <span class="requiredfield">*</span></td>
    <td>
    <% String enable_show_icq = mvnforumConfig.getString("mvnforumconfig.enable_show_icq", "");%>
    <input type="checkbox" name="enable_show_icq" value="true" class="noborder"
    <% if ("true".equals(enable_show_icq)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_msn <span class="requiredfield">*</span></td>
    <td>
    <% String enable_show_msn = mvnforumConfig.getString("mvnforumconfig.enable_show_msn", "");%>
    <input type="checkbox" name="enable_show_msn" value="true" class="noborder"
    <% if ("true".equals(enable_show_msn)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_join_date <span class="requiredfield">*</span></td>
    <td>
    <% String enable_show_join_date = mvnforumConfig.getString("mvnforumconfig.enable_show_join_date", "");%>
    <input type="checkbox" name="enable_show_join_date" value="true" class="noborder"
    <% if ("true".equals(enable_show_join_date)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_post_count <span class="requiredfield">*</span></td>
    <td>
    <% String enable_show_post_count = mvnforumConfig.getString("mvnforumconfig.enable_show_post_count", "");%>
    <input type="checkbox" name="enable_show_post_count" value="true" class="noborder"
    <% if ("true".equals(enable_show_post_count)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_view_count <span class="requiredfield">*</span></td>
    <td>
    <% String enable_show_view_count = mvnforumConfig.getString("mvnforumconfig.enable_show_view_count", "");%>
    <input type="checkbox" name="enable_show_view_count" value="true" class="noborder"
    <% if ("true".equals(enable_show_view_count)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_email <span class="requiredfield">*</span></td>
    <td>    
    <% String enable_show_email = mvnforumConfig.getString("mvnforumconfig.enable_show_email", "");%>
    <input type="checkbox" name="enable_show_email" value="true" class="noborder"
    <% if ("true".equals(enable_show_email)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_online_status <span class="requiredfield">*</span></td>
    <td>
    <% String enable_show_online_status = mvnforumConfig.getString("mvnforumconfig.enable_show_online_status", "");%>
    <input type="checkbox" name="enable_show_online_status" value="true" class="noborder"
    <% if ("true".equals(enable_show_online_status)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_firstname <span class="requiredfield">*</span></td>
    <td>
    <% String enable_show_firstname = mvnforumConfig.getString("mvnforumconfig.enable_show_firstname", "");%>
    <input type="checkbox" name="enable_show_firstname" value="true" class="noborder"
    <% if ("true".equals(enable_show_firstname)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_show_lastname <span class="requiredfield">*</span></td>
    <td>
    <% String enable_show_lastname = mvnforumConfig.getString("mvnforumconfig.enable_show_lastname", "");%>
    <input type="checkbox" name="enable_show_lastname" value="true" class="noborder"
    <% if ("true".equals(enable_show_lastname)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_use_popup_menu_in_viewthread <span class="requiredfield">*</span></td>
    <td>
    <% String enable_use_popup_menu_in_viewthread = mvnforumConfig.getString("mvnforumconfig.enable_use_popup_menu_in_viewthread", "");%>
    <input type="checkbox" name="enable_use_popup_menu_in_viewthread" value="true" class="noborder"
    <% if ("true".equals(enable_use_popup_menu_in_viewthread)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_split_thread <span class="requiredfield">*</span></td>
    <td>
    <% String enable_split_thread = mvnforumConfig.getString("mvnforumconfig.enable_split_thread", "");%>
    <input type="checkbox" name="enable_split_thread" value="true" class="noborder"
    <% if ("true".equals(enable_split_thread)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>  
  <tr class="<mvn:cssrow/>">
    <td>enable_listunansweredthreads <span class="requiredfield">*</span></td>
    <td>
    <% String enable_listunansweredthreads = mvnforumConfig.getString("mvnforumconfig.enable_listunansweredthreads", "");%>
    <input type="checkbox" name="enable_listunansweredthreads" value="true" class="noborder"
    <% if ("true".equals(enable_listunansweredthreads)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_list_users_browsing_thread <span class="requiredfield">*</span></td>
    <td>
    <% String enable_list_users_browsing_thread = mvnforumConfig.getString("mvnforumconfig.enable_list_users_browsing_thread", "");%>
    <input type="checkbox" name="enable_list_users_browsing_thread" value="true" class="noborder"
    <% if ("true".equals(enable_list_users_browsing_thread)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_email_to_admin_content_with_censored_words <span class="requiredfield">*</span></td>
    <td>
    <% String enable_email_to_admin_content_with_censored_words = mvnforumConfig.getString("mvnforumconfig.enable_email_to_admin_content_with_censored_words", "");%>
    <input type="checkbox" name="enable_email_to_admin_content_with_censored_words" value="true" class="noborder"
    <% if ("true".equals(enable_email_to_admin_content_with_censored_words)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_guest_view_listusers <span class="requiredfield">*</span></td>
    <td>
    <% String enable_guest_view_listusers = mvnforumConfig.getString("mvnforumconfig.enable_guest_view_listusers", "");%>
    <input type="checkbox" name="enable_guest_view_listusers" value="true" class="noborder"
    <% if ("true".equals(enable_guest_view_listusers)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>only_normal_thread_type_in_active_threads <span class="requiredfield">*</span></td>
    <td>
    <% String only_normal_thread_type_in_active_threads = mvnforumConfig.getString("mvnforumconfig.only_normal_thread_type_in_active_threads", "");%>
    <input type="checkbox" name="only_normal_thread_type_in_active_threads" value="true" class="noborder"
    <% if ("true".equals(only_normal_thread_type_in_active_threads)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>send_watchmail_as_html <span class="requiredfield">*</span></td>
    <td>
    <% String send_watchmail_as_html = mvnforumConfig.getString("mvnforumconfig.send_watchmail_as_html", "");%>
    <input type="checkbox" name="send_watchmail_as_html" value="true" class="noborder"
    <% if ("true".equals(send_watchmail_as_html)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_easy_watching <span class="requiredfield">*</span></td>
    <td>
    <% String enable_easy_watching = mvnforumConfig.getString("mvnforumconfig.enable_easy_watching", "");%>
    <input type="checkbox" name="enable_easy_watching" value="true" class="noborder"
    <% if ("true".equals(enable_easy_watching)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_send_watch_mail_of_my_own_post <span class="requiredfield">*</span></td>
    <td>
    <% String enable_send_watch_mail_of_my_own_post = mvnforumConfig.getString("mvnforumconfig.enable_send_watch_mail_of_my_own_post", "");%>
    <input type="checkbox" name="enable_send_watch_mail_of_my_own_post" value="true" class="noborder"
    <% if ("true".equals(enable_send_watch_mail_of_my_own_post)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_last_post_body_in_watch <span class="requiredfield">*</span></td>
    <td><input type="text" size="70" name="max_last_post_body_in_watch" value="<%=mvnforumConfig.getString("mvnforumconfig.max_last_post_body_in_watch", "")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_private_message <span class="requiredfield">*</span></td>
    <td>
    <% String enable_private_message = mvnforumConfig.getString("mvnforumconfig.enable_private_message", "");%>
    <input type="checkbox" name="enable_private_message" value="true" class="noborder"
    <% if ("true".equals(enable_private_message)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_public_message <span class="requiredfield">*</span></td>
    <td>
    <% String enable_public_message = mvnforumConfig.getString("mvnforumconfig.enable_public_message", "");%>
    <input type="checkbox" name="enable_public_message" value="true" class="noborder"
    <% if ("true".equals(enable_public_message)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_message_attachment <span class="requiredfield">*</span></td>
    <td>
    <% String enable_message_attachment = mvnforumConfig.getString("mvnforumconfig.enable_message_attachment", "");%>
    <input type="checkbox" name="enable_message_attachment" value="true" class="noborder"
    <% if ("true".equals(enable_message_attachment)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_most_active_threads <span class="requiredfield">*</span></td>
    <td>
    <% String enable_most_active_threads = mvnforumConfig.getString("mvnforumconfig.enable_most_active_threads", "");%>
    <input type="checkbox" name="enable_most_active_threads" value="true" class="noborder"
    <% if ("true".equals(enable_most_active_threads)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_most_active_members <span class="requiredfield">*</span></td>
    <td>
    <% String enable_most_active_members = mvnforumConfig.getString("mvnforumconfig.enable_most_active_members", "");%>
    <input type="checkbox" name="enable_most_active_members" value="true" class="noborder"
    <% if ("true".equals(enable_most_active_members)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_site_statistics_overview <span class="requiredfield">*</span></td>
    <td>
    <% String enable_site_statistics_overview = mvnforumConfig.getString("mvnforumconfig.enable_site_statistics_overview", "");%>
    <input type="checkbox" name="enable_site_statistics_overview" value="true" class="noborder"
    <% if ("true".equals(enable_site_statistics_overview)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td nowrap="nowrap">enable_admin_can_change_password <span class="requiredfield">*</span></td>
    <td>
    <% String enable_admin_can_change_password = mvnforumConfig.getString("mvnforumconfig.enable_admin_can_change_password", "");%>
    <input type="checkbox" name="enable_admin_can_change_password" value="true" class="noborder"
    <% if ("true".equals(enable_admin_can_change_password)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td nowrap="nowrap">enable_guest_view_image_attachment <span class="requiredfield">*</span></td>
    <td>
    <% String enable_guest_view_image_attachment = mvnforumConfig.getString("mvnforumconfig.enable_guest_view_image_attachment", "");%>
    <input type="checkbox" name="enable_guest_view_image_attachment" value="true" class="noborder"
    <% if ("true".equals(enable_guest_view_image_attachment)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td nowrap="nowrap">enable_expanse_category_tree_by_default <span class="requiredfield">*</span></td>
    <td>
    <% String enable_expanse_category_tree_by_default = mvnforumConfig.getString("mvnforumconfig.enable_expanse_category_tree_by_default", "");%>
    <input type="checkbox" name="enable_expanse_category_tree_by_default" value="true" class="noborder"
    <% if ("true".equals(enable_expanse_category_tree_by_default)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>default_watch_option <span class="requiredfield">*</span></td>
    <td>
    <select name="default_watch_option">
    <% String default_watch_option = mvnforumConfig.getString("mvnforumconfig.default_watch_option", "");%>
      <option value="<%=WatchBean.WATCH_OPTION_DEFAULT%>" <%= (String.valueOf(WatchBean.WATCH_OPTION_DEFAULT).equals(default_watch_option)) ? "selected=\"selected\"" : "" %>>Default (daily watch)</option>
      <option value="<%=WatchBean.WATCH_OPTION_LIVE%>" <%= (String.valueOf(WatchBean.WATCH_OPTION_LIVE).equals(default_watch_option)) ? "selected=\"selected\"" : "" %>>Live Watch</option>
      <option value="<%=WatchBean.WATCH_OPTION_HOURLY%>" <%= (String.valueOf(WatchBean.WATCH_OPTION_HOURLY).equals(default_watch_option)) ? "selected=\"selected\"" : "" %>>Hourly Watch</option>
      <option value="<%=WatchBean.WATCH_OPTION_DAILY%>" <%= (String.valueOf(WatchBean.WATCH_OPTION_DAILY).equals(default_watch_option)) ? "selected=\"selected\"" : "" %>>Daily Watch</option>
      <option value="<%=WatchBean.WATCH_OPTION_WEEKLY%>" <%= (String.valueOf(WatchBean.WATCH_OPTION_WEEKLY).equals(default_watch_option)) ? "selected=\"selected\"" : "" %>>Weekly Watch</option>
    </select>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>default_moderation_option <span class="requiredfield">*</span></td>
    <td>
    <select name="default_moderation_option">
    <% String default_moderation_option = mvnforumConfig.getString("mvnforumconfig.default_moderation_option", "");%>
      <option value="<%=ForumBean.FORUM_MODERATION_MODE_NO_MODERATION%>" <%= (String.valueOf(ForumBean.FORUM_MODERATION_MODE_NO_MODERATION).equals(default_moderation_option)) ? "selected=\"selected\"" : "" %>>Default (No Moderation)</option>
      <option value="<%=ForumBean.FORUM_MODERATION_MODE_THREAD_AND_POST%>" <%= (String.valueOf(ForumBean.FORUM_MODERATION_MODE_THREAD_AND_POST).equals(default_moderation_option)) ? "selected=\"selected\"" : "" %>>Thread and Post Moderation</option>
      <option value="<%=ForumBean.FORUM_MODERATION_MODE_THREAD_ONLY%>" <%= (String.valueOf(ForumBean.FORUM_MODERATION_MODE_THREAD_ONLY).equals(default_moderation_option)) ? "selected=\"selected\"" : "" %>>Thread only Moderation</option>
      <option value="<%=ForumBean.FORUM_MODERATION_MODE_POST_ONLY%>" <%= (String.valueOf(ForumBean.FORUM_MODERATION_MODE_POST_ONLY).equals(default_moderation_option)) ? "selected=\"selected\"" : "" %>>Post only Moderation</option>
    </select>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_encrypt_password_on_browser <span class="requiredfield">*</span></td>
    <td>
    <% String enable_encrypt_password_on_browser = mvnforumConfig.getString("mvnforumconfig.enable_encrypt_password_on_browser", "");%>
    <input type="checkbox" name="enable_encrypt_password_on_browser" value="true" class="noborder"
    <% if ("true".equals(enable_encrypt_password_on_browser)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_external_user_database <span class="requiredfield">*</span></td>
    <td>
    <% String enable_external_user_database = mvnforumConfig.getString("mvnforumconfig.enable_external_user_database", "");%>
    <input type="checkbox" name="enable_external_user_database" value="true" class="noborder"
    <% if ("true".equals(enable_external_user_database)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_list_new_members_in_recent_days <span class="requiredfield">*</span></td>
    <td>
    <% String enable_list_new_members_in_recent_days = mvnforumConfig.getString("mvnforumconfig.enable_list_new_members_in_recent_days", "");%>
    <input type="checkbox" name="enable_list_new_members_in_recent_days" value="true" class="noborder"
    <% if ("true".equals(enable_list_new_members_in_recent_days)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>days_to_show_recent_members <span class="requiredfield">*</span></td>
    <td><input type="text" size="70" name="days_to_show_recent_members" value="<%=mvnforumConfig.getString("mvnforumconfig.days_to_show_recent_members", "")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_list_users_browsing_forum <span class="requiredfield">*</span></td>
    <td>
    <% String enable_list_users_browsing_forum = mvnforumConfig.getString("mvnforumconfig.enable_list_users_browsing_forum", "");%>
    <input type="checkbox" name="enable_list_users_browsing_forum" value="true" class="noborder"
    <% if ("true".equals(enable_list_users_browsing_forum)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_email_threatening_content <span class="requiredfield">*</span></td>
    <td>
     <% String enable_email_threatening_content = mvnforumConfig.getString("mvnforumconfig.enable_email_threatening_content", "");%>
    <input type="checkbox" name="enable_email_threatening_content" value="true" class="noborder"
    <% if ("true".equals(enable_email_threatening_content)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>have_internet <span class="requiredfield">*</span></td>
    <td>
     <% String have_internet = mvnforumConfig.getString("mvnforumconfig.have_internet", "");%>
    <input type="checkbox" name="have_internet" value="true" class="noborder"
    <% if ("true".equals(have_internet)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>event_log_locale <span class="requiredfield">*</span></td>
    <td><input type="text" size="70" name="event_log_locale" value="<%=mvnforumConfig.getString("mvnforumconfig.event_log_locale", "")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>default_category_id <span class="requiredfield">*</span></td>
    <td><input type="text" size="70" name="default_category_id" value="<%=mvnforumConfig.getString("mvnforumconfig.default_category_id", "")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>default_watch_type <span class="requiredfield">*</span></td>
    <td>
      <select name="default_watch_type">
        <% String default_watch_type = mvnforumConfig.getString("mvnforumconfig.default_watch_type", "");%>
        <option value="<%=WatchBean.WATCH_TYPE_DIGEST%>" <%= (String.valueOf(WatchBean.WATCH_TYPE_DIGEST).equals(default_watch_type)) ? "selected=\"selected\"" : "" %>>Default (Digest)</option>
        <option value="<%=WatchBean.WATCH_TYPE_NONDIGEST%>" <%= (String.valueOf(WatchBean.WATCH_TYPE_NONDIGEST).equals(default_watch_type)) ? "selected=\"selected\"" : "" %>>Non Digest</option></select>  
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>default_status_of_registered_member <span class="requiredfield">*</span></td>
    <td>
      <select name="default_status_of_registered_member">
        <% String default_status_of_registered_member = mvnforumConfig.getString("mvnforumconfig.default_status_of_registered_member", "");%>
        <option value="<%=MemberBean.MEMBER_STATUS_ENABLE%>" <%= (String.valueOf(MemberBean.MEMBER_STATUS_ENABLE).equals(default_status_of_registered_member)) ? "selected=\"selected\"" : "" %>>Default (Enable Status)</option>
        <option value="<%=MemberBean.MEMBER_STATUS_PENDING%>" <%= (String.valueOf(MemberBean.MEMBER_STATUS_PENDING).equals(default_status_of_registered_member)) ? "selected=\"selected\"" : "" %>>Pending Status</option></select>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_register_rule <span class="requiredfield">*</span></td>
    <td>
     <% String enable_register_rule = mvnforumConfig.getString("mvnforumconfig.enable_register_rule", "");%>
    <input type="checkbox" name="enable_register_rule" value="true" class="noborder"
    <% if ("true".equals(enable_register_rule)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
</mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.config.config_step1_image_thumbnail"/></td>
  </tr>
<mvn:cssrows>
  <tr class="<mvn:cssrow/>" id="id_image_thumbnail">
    <td>enable_image_thumbnail <span class="requiredfield">*</span></td>
    <td>
    <% String enable_image_thumbnail = mvnforumConfig.getString("mvnforumconfig.image_thumbnail.enable", "");
       boolean enableImageThumbnail = "true".equals(enable_image_thumbnail);
    %>
    <input type="checkbox" name="enable_image_thumbnail" value="true" class="noborder" onchange="javascript:OnChangeImageThumbnailStatus();"
    <% if (enableImageThumbnail) { %> checked="checked"<%}%>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>" id="id_image_thumbnail_width" <% if (enableImageThumbnail == false) { %> style="display: none;"<%}%>>
    <td>image_thumbnail_width <span class="requiredfield">*</span></td>
    <td><input type="text" size="70" name="image_thumbnail_width" value="<%=mvnforumConfig.getString("mvnforumconfig.image_thumbnail.width", "")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>" id="id_image_thumbnail_height" <% if (enableImageThumbnail == false) { %> style="display: none;"<%}%>>
    <td>image_thumbnail_height <span class="requiredfield">*</span></td>
    <td><input type="text" size="70" name="image_thumbnail_height" value="<%=mvnforumConfig.getString("mvnforumconfig.image_thumbnail.height", "")%>" /></td>
  </tr>
</mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.config.config_step1_factory"/></td>
  </tr>
<mvn:cssrows>
  <tr class="<mvn:cssrow/>">
    <td>member_implementation <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="70" name="member_implementation" value="<%=mvnforumConfig.getString("mvnforumfactoryconfig.member_implementation", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>onlineuser_implementation <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="70" name="onlineuser_implementation" value="<%=mvnforumConfig.getString("mvnforumfactoryconfig.onlineuser_implementation", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>authenticator_implementation</td>
    <td>
    <input type="text" size="70" name="authenticator_implementation" value="<%=mvnforumConfig.getString("mvnforumfactoryconfig.authenticator_implementation", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>requestprocessor_implementation <span class="requiredfield">*</span></td>
    <td>
      <input type="text" size="70" name="requestprocessor_implementation" value="<%=mvnforumConfig.getString("mvnforumfactoryconfig.requestprocessor_implementation", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>lucene_analyzer_implementation <span class="requiredfield">*</span></td>
    <td>
      <input type="text" size="70" name="lucene_analyzer_implementation" value="<%=mvnforumConfig.getString("mvnforumfactoryconfig.lucene_analyzer_implementation", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>mvn_auth_service_implementation <span class="requiredfield">*</span></td>
    <td>
      <input type="text" size="70" name="mvn_auth_service_implementation" value="<%=mvnforumConfig.getString("mvnforumfactoryconfig.mvn_auth_service_implementation", "")%>" />
    </td>    
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>mvnforum_service_implementation <span class="requiredfield">*</span></td>
    <td>
      <input type="text" size="70" name="mvnforum_service_implementation" value="<%=mvnforumConfig.getString("mvnforumfactoryconfig.mvnforum_service_implementation", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><span class="requiredfield">*</span> <fmt:message key="mvnforum.common.prompt.current_password"/>:</td>
    <td><input type="password" name="MemberCurrentMatkhau" size="30" /></td>
  </tr>
</mvn:cssrows>  
  <tr class="portlet-section-footer">
    <td colspan="2" align="center">
      <input type="button" name="submitbutton" value="<fmt:message key="mvnforum.common.action.save_and_reload"/>" class="portlet-form-button" onclick="javascript:SubmitForm();" />
      <input type="button" value="<fmt:message key="mvnforum.common.action.cancel"/>" class="liteoption" onclick="javascript:gotoPage('<%=urlResolver.encodeURL(request, response, "configindex")%>');" />
    </td>
  </tr>
</table>
</form>

<br/>

<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>
