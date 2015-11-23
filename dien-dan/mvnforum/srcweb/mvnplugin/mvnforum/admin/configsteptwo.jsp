<%--
 - $Header: /cvsroot/mvnforum/mvnforum/srcweb/mvnplugin/mvnforum/admin/configsteptwo.jsp,v 1.48 2008/06/13 09:23:17 phuongpdd Exp $
 - $Author: phuongpdd $
 - $Revision: 1.48 $
 - $Date: 2008/06/13 09:23:17 $
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

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<fmt:bundle basename="mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.admin.configsteptwo.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css" />
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
  if (!isUnsignedInteger(document.submitform.max_private_message, "max_private_message")) return false;
  if (isBlank(document.submitform.max_message_attachment_size, "max_message_attachment_size")) return false;
  if (isBlank(document.submitform.max_attachment_size, "max_attachment_size")) return false;
  if (!isUnsignedInteger(document.submitform.max_favorite_thread, "max_favorite_thread")) return false;
  if (!isUnsignedInteger(document.submitform.max_edit_days, "max_edit_days")) return false;
  if (!isUnsignedInteger(document.submitform.max_attach_days, "max_attach_days")) return false;
  if (!isUnsignedInteger(document.submitform.max_delete_days, "max_delete_days")) return false;
  if (!isUnsignedInteger(document.submitform.rows_per_page, "rows_per_page")) return false;
  if (!isUnsignedInteger(document.submitform.rows_per_rss, "rows_per_rss")) return false;
  if (!isUnsignedInteger(document.submitform.hot_topic_threshold, "hot_topic_threshold")) return false;
  if (!isUnsignedInteger(document.submitform.max_http_requests_per_hour_per_ip, "max_http_requests_per_hour_per_ip")) return false;
  if (!isUnsignedInteger(document.submitform.max_posts_per_hour_per_ip, "max_posts_per_hour_per_ip")) return false;
  if (!isUnsignedInteger(document.submitform.max_members_per_hour_per_ip, "max_members_per_hour_per_ip")) return false;
  if (!isUnsignedInteger(document.submitform.max_logins_per_hour_per_ip, "max_logins_per_hour_per_ip")) return false;
  if (!isUnsignedInteger(document.submitform.max_messages_per_hour_per_ip, "max_messages_per_hour_per_ip")) return false;
  if (!isUnsignedInteger(document.submitform.max_password_days, "max_password_days")) return false;
  if (!isUnsignedInteger(document.submitform.max_posts_per_hour_per_member, "max_posts_per_hour_per_member")) return false;
  if (!isUnsignedInteger(document.submitform.max_chars_in_short_summary, "max_chars_in_short_summary")) return false;
  if (!isUnsignedInteger(document.submitform.max_chars_in_long_summary, "max_chars_in_long_summary")) return false;
  if (!isUnsignedInteger(document.submitform.max_chars_in_rss, "max_chars_in_rss")) return false;
  if (!isUnsignedInteger(document.submitform.max_import_size, "max_import_size")) return false;
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
    <fmt:message key="mvnforum.admin.configsteptwo.title"/>
    </td>
  </tr>
</table>
<br/>

<form action="<%=urlResolver.encodeURL(request, response, "configsteptwoprocess", URLResolverService.ACTION_URL)%>" method="post" name="submitform">
<%=urlResolver.generateFormAction(request, response, "configsteptwoprocess")%>
<mvn:cssrows>
<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.config.config_step2"/></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_private_message <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="60" name="max_private_message" value="<%=mvnforumConfig.getString("mvnforumconfig.max_private_message", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_message_attachment_size <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="60" name="max_message_attachment_size" value="<%=mvnforumConfig.getString("mvnforumconfig.max_message_attachment_size", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_attachment_size <span class="requiredfield">*</span></td>
    <td><input type="text" size="60" name="max_attachment_size" value="<%=mvnforumConfig.getString("mvnforumconfig.max_attachment_size", "")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_favorite_thread <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="60" name="max_favorite_thread" value="<%=mvnforumConfig.getString("mvnforumconfig.max_favorite_thread", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_edit_days <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="60" name="max_edit_days" value="<%=mvnforumConfig.getString("mvnforumconfig.max_edit_days", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_attach_days <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="60" name="max_attach_days" value="<%=mvnforumConfig.getString("mvnforumconfig.max_attach_days", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_delete_days <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="60" name="max_delete_days" value="<%=mvnforumConfig.getString("mvnforumconfig.max_delete_days", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>rows_per_page <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="60" name="rows_per_page" value="<%=mvnforumConfig.getString("mvnforumconfig.rows_per_page", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>rows_per_rss <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="60" name="rows_per_rss" value="<%=mvnforumConfig.getString("mvnforumconfig.rows_per_rss", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>hot_topic_threshold <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="60" name="hot_topic_threshold" value="<%=mvnforumConfig.getString("mvnforumconfig.hot_topic_threshold", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_posts_per_hour_per_member <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="60" name="max_posts_per_hour_per_member" value="<%=mvnforumConfig.getString("mvnforumconfig.max_posts_per_hour_per_member", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_posts_per_hour_per_ip <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="60" name="max_posts_per_hour_per_ip" value="<%=mvnforumConfig.getString("mvnforumconfig.max_posts_per_hour_per_ip", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_http_requests_per_hour_per_ip <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="60" name="max_http_requests_per_hour_per_ip" value="<%=mvnforumConfig.getString("mvnforumconfig.max_http_requests_per_hour_per_ip", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_members_per_hour_per_ip <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="60" name="max_members_per_hour_per_ip" value="<%=mvnforumConfig.getString("mvnforumconfig.max_members_per_hour_per_ip", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_logins_per_hour_per_ip <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="60" name="max_logins_per_hour_per_ip" value="<%=mvnforumConfig.getString("mvnforumconfig.max_logins_per_hour_per_ip", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_messages_per_hour_per_ip <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="60" name="max_messages_per_hour_per_ip" value="<%=mvnforumConfig.getString("mvnforumconfig.max_messages_per_hour_per_ip", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_password_days <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="60" name="max_password_days" value="<%=mvnforumConfig.getString("mvnforumconfig.max_password_days", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_chars_in_short_summary <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="60" name="max_chars_in_short_summary" value="<%=mvnforumConfig.getString("mvnforumconfig.max_chars_in_short_summary", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_chars_in_long_summary <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="60" name="max_chars_in_long_summary" value="<%=mvnforumConfig.getString("mvnforumconfig.max_chars_in_long_summary", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_chars_in_rss <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="60" name="max_chars_in_rss" value="<%=mvnforumConfig.getString("mvnforumconfig.max_chars_in_rss", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_backup_on_server <span class="requiredfield">*</span></td>
    <td>
    <% String enable_backup_on_server = mvnforumConfig.getString("mvnforumconfig.enable_backup_on_server", "");%>
    <input type="checkbox" name="enable_backup_on_server" value="true" class="noborder"
    <% if ("true".equals(enable_backup_on_server)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>max_import_size <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="60" name="max_import_size" value="<%=mvnforumConfig.getString("mvnforumconfig.max_import_size", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><span class="requiredfield">*</span> <fmt:message key="mvnforum.common.prompt.current_password"/>:</td>
    <td><input type="password" name="MemberCurrentMatkhau" size="30" /></td>
  </tr>
  <tr class="portlet-section-footer">
    <td colspan="2" align="center">
      <input type="button" name="submitbutton" value="<fmt:message key="mvnforum.common.action.save_and_reload"/>" class="portlet-form-button" onclick="javascript:SubmitForm();" />
      <input type="button" value="<fmt:message key="mvnforum.common.action.cancel"/>" class="liteoption" onclick="javascript:gotoPage('<%=urlResolver.encodeURL(request, response, "configindex")%>');" />
    </td>
  </tr>
</table>
</mvn:cssrows>
</form>

<br/>

<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>