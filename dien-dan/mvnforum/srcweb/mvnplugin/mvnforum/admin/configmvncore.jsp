<%--
 - $Header: /cvsroot/mvnforum/mvnforum/srcweb/mvnplugin/mvnforum/admin/configmvncore.jsp,v 1.64.2.1 2008/11/17 07:56:16 nguyendnc Exp $
 - $Author: nguyendnc $
 - $Revision: 1.64.2.1 $
 - $Date: 2008/11/17 07:56:16 $
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
 --%>
<%@ page contentType="text/html;charset=utf-8" %>
<%@ page errorPage="fatalerror.jsp"%>
<%@ page import="net.myvietnam.mvncore.util.DateUtil" %>
<%@ page import="net.myvietnam.mvncore.configuration.DOM4JConfiguration" %>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<fmt:bundle basename="mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.admin.configmvncore.title"/></mvn:title>
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
  if (document.submitform.use_datasource.checked == false) {
    if (isBlank(document.submitform.database_type, "database_type")) return false;
    if (isBlank(document.submitform.driver_class_name, "driver_class_name")) return false;
    if (isBlank(document.submitform.database_url, "database_url")) return false;
    if (isBlank(document.submitform.database_user, "database_user")) return false;
    if (!isUnsignedInteger(document.submitform.max_connection, "max_connection")) return false;
    if (!isUnsignedInteger(document.submitform.max_time_to_wait, "max_time_to_wait")) return false;
    if (!isUnsignedInteger(document.submitform.minutes_between_refresh, "minutes_between_refresh")) return false;
  } else {
    if (isBlank(document.submitform.datasource_name, "datasource_name")) return false;
  }
  
  if (isBlank(document.submitform.default_mail_from, "default_mail_from")) return false;
  if (!isEmail(document.submitform.default_mail_from, "default_mail_from")) return false;
  
  if (document.submitform.receive_mail_enable_mail_source.checked == false) {
    if (isBlank(document.submitform.receive_mail_server, "recieve mail_server")) return false;
    if (!isUnsignedInteger(document.submitform.send_mail_port, "receive mail port")) return false;
  } else {
    if (isBlank(document.submitform.receive_mail_source_name, "receive mail source name")) return false;
  }
  
  if (document.submitform.send_mail_use_embeded_smtp_mail_server.checked == false) {
    if (document.submitform.send_mail_enable_mail_source.checked == false) {
      if (isBlank(document.submitform.send_mail_server, "send mail_server")) return false;
      if (!isUnsignedInteger(document.submitform.receive_mail_port, "send mail port")) return false;
    } else {
      if (isBlank(document.submitform.send_mail_source_name, "send mail source name")) return false;
    }
  }
  
  if (isBlank(document.submitform.server_path, "server_path")) return false;
  if (!isValidServerHourOffset(document.submitform.server_hour_offset, "server_hour_offset")) return false;
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
function OnChangeUseDatasource() {
  if (document.submitform.use_datasource.checked == false) {
    document.getElementById("id_driver_class_name").style.display = '';
    document.getElementById("id_database_url").style.display = '';
    document.getElementById("id_database_user").style.display = '';
    document.getElementById("id_database_password").style.display = '';
    document.getElementById("id_max_connection").style.display = '';
    document.getElementById("id_max_time_to_wait").style.display = '';
    document.getElementById("id_minutes_between_refresh").style.display = '';
    document.getElementById("id_datasource_name").style.display = 'none';
  } else {
    document.getElementById("id_driver_class_name").style.display = 'none';
    document.getElementById("id_database_url").style.display = 'none';
    document.getElementById("id_database_user").style.display = 'none';
    document.getElementById("id_database_password").style.display = 'none';
    document.getElementById("id_max_connection").style.display = 'none';
    document.getElementById("id_max_time_to_wait").style.display = 'none';
    document.getElementById("id_minutes_between_refresh").style.display = 'none';
    document.getElementById("id_datasource_name").style.display = '';
  }
}
function OnChangeUseMailsource() {
  if (document.submitform.receive_mail_enable_mail_source.checked == false) {
    document.getElementById("id_receive_mail_mail_server").style.display = '';
    document.getElementById("id_recevie_mail_username").style.display = '';
    document.getElementById("id_receive_mail_password").style.display = '';
    document.getElementById("id_receive_mail_port").style.display = '';
    document.getElementById("id_receive_mail_source_name").style.display = 'none';
  } else {
    document.getElementById("id_receive_mail_mail_server").style.display = 'none';
    document.getElementById("id_recevie_mail_username").style.display = 'none';
    document.getElementById("id_receive_mail_password").style.display = 'none';
    document.getElementById("id_receive_mail_port").style.display = 'none';
    document.getElementById("id_receive_mail_source_name").style.display = '';
  }
  
  if (document.submitform.send_mail_use_embeded_smtp_mail_server.checked == false) {
    document.getElementById("id_send_mail_enable_mail_source").style.display = '';
    if (document.submitform.send_mail_enable_mail_source.checked == false) {
      document.getElementById("id_send_mail_use_secure_connection").style.display = '';
      document.getElementById("id_send_mail_mail_server").style.display = '';
      document.getElementById("id_send_mail_username").style.display = '';
      document.getElementById("id_send_mail_password").style.display = '';
      document.getElementById("id_send_mail_port").style.display = '';
      document.getElementById("id_send_mail_source_name").style.display = 'none';
    } else {
      document.getElementById("id_send_mail_use_secure_connection").style.display = 'none';
      document.getElementById("id_send_mail_mail_server").style.display = 'none';
      document.getElementById("id_send_mail_username").style.display = 'none';
      document.getElementById("id_send_mail_password").style.display = 'none';
      document.getElementById("id_send_mail_port").style.display = 'none';
      document.getElementById("id_send_mail_source_name").style.display = '';
    }
  } else {
    document.getElementById("id_send_mail_enable_mail_source").style.display = 'none';
    document.getElementById("id_send_mail_use_secure_connection").style.display = 'none';
    document.getElementById("id_send_mail_mail_server").style.display = 'none';
    document.getElementById("id_send_mail_username").style.display = 'none';
    document.getElementById("id_send_mail_password").style.display = 'none';
    document.getElementById("id_send_mail_port").style.display = 'none';
    document.getElementById("id_send_mail_source_name").style.display = 'none';
  }  
}
function isValidServerHourOffset(obj, message) {
    if (isBlank(obj, message)) {
      return false;
    }
    var  val = obj.value;
    if (isNaN(val) || val < -13 || val > 13) {
        alert(message + " <fmt:message key="mvnforum.common.js.prompt.server_hour_offset_mustbe_valid_number"/>");
        obj.focus();
        return false;
    }
    for (var i=0;i<val.length;i++) {
        if (val.charAt(i) == '.') {
            alert(message + " <fmt:message key="mvnforum.common.js.prompt.mustbe_unsigned_number"/>");
            obj.focus();
            return false;
        }
    }
    obj.value = parseInt(val,10);
    return true;
}
//]]>
</script>

<%@ include file="header.jsp"%>
<br />
<%
DOM4JConfiguration mvncoreConfig = (DOM4JConfiguration)request.getAttribute("mvncoreConfig");
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
    <fmt:message key="mvnforum.admin.configmvncore.title"/>
    </td>
  </tr>
</table>
<br/>

<form action="<%=urlResolver.encodeURL(request, response, "configmvncoreprocess", URLResolverService.ACTION_URL)%>" method="post" name="submitform">
<%=urlResolver.generateFormAction(request, response, "configmvncoreprocess")%>
<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.config.config_mvncore_database"/></td>
  </tr>
  <tr class="<mvn:cssrow/>" id="id_database_type">
    <td>database_type <span class="requiredfield">*</span></td>
    <td>
    <select name="database_type">
      <% String database_type = mvncoreConfig.getString("dboptions.database_type", "");%>
      <option value="0" <%= (database_type.equals("0")) ? "selected=\"selected\"" : "" %>><fmt:message key="mvnforum.admin.config.default"/> (<fmt:message key="mvnforum.admin.config.auto_detect"/>)</option>
      <option value="2" <%= (database_type.equals("2")) ? "selected=\"selected\"" : "" %>><fmt:message key="mvnforum.admin.config.not_support_scrollable_resultset"/></option>
    </select>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>use_datasource <span class="requiredfield">*</span></td>
    <td>
    <% String use_datasource = mvncoreConfig.getString("dboptions.use_datasource", "");%>
    <input type="checkbox" name="use_datasource" value="true" class="noborder" onclick="javascript:OnChangeUseDatasource();"
    <% if ("true".equals(use_datasource)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>" id="id_datasource_name">
    <td>datasource_name <span class="requiredfield">*</span></td>
    <td><input type="text" size="70" name="datasource_name" value="<%=mvncoreConfig.getString("dboptions.datasource_name", "")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow autoIncrease="false"/>" id="id_driver_class_name">
    <td>driver_class_name <span class="requiredfield">*</span></td>
    <td><input type="text" size="70" name="driver_class_name" value="<%=mvncoreConfig.getString("dboptions.driver_class_name", "")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>" id="id_database_url">
    <td>database_url <span class="requiredfield">*</span></td>
    <td><input type="text" size="70" name="database_url" value="<%=mvncoreConfig.getString("dboptions.database_url", "")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>" id="id_database_user">
    <td>database_user <span class="requiredfield">*</span></td>
    <td><input type="text" size="70" name="database_user" value="<%=mvncoreConfig.getString("dboptions.database_user", "")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>" id="id_database_password">
    <td>database_password</td>
    <td><input type="password" size="70" name="database_password" value="<%=mvncoreConfig.getString("dboptions.database_password", "")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>" id="id_max_connection">
    <td>max_connection <span class="requiredfield">*</span></td>
    <td><input type="text" size="70" name="max_connection" value="<%=mvncoreConfig.getString("dboptions.max_connection", "")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>" id="id_max_time_to_wait">
    <td>max_time_to_wait <span class="requiredfield">*</span></td>
    <td><input type="text" size="70" name="max_time_to_wait" value="<%=mvncoreConfig.getString("dboptions.max_time_to_wait", "")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>" id="id_minutes_between_refresh">
    <td>minutes_between_refresh <span class="requiredfield">*</span></td>
    <td><input type="text" size="70" name="minutes_between_refresh" value="<%=mvncoreConfig.getString("dboptions.minutes_between_refresh", "")%>" /></td>
  </tr>
</mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.config.config_mvncore_mail"/></td>
  </tr>
<mvn:cssrows>
  <tr class="<mvn:cssrow/>">
    <td>default_mail_from <span class="requiredfield">*</span></td>
    <td><input type="text" size="70" name="default_mail_from" value="<%=mvncoreConfig.getString("mailoptions.default_mail_from", "")%>" /></td>
  </tr>
</mvn:cssrows>
  <tr class="portlet-section-subheader">
    <td colspan="2"><fmt:message key="mvnforum.admin.config.config_mvncore_mail.recieve_mail_option"/></td>
  </tr>  
<mvn:cssrows>
  <tr class="<mvn:cssrow/>" id="id_receive_mail_enable_mail_source">
    <td>enable_mail_source <span class="requiredfield">*</span></td>
    <td> 
    <% String receive_enable_mail_source = mvncoreConfig.getString("mailoptions.receive_mail.enable_mail_source", "");%>
    <input type="checkbox" name="receive_mail_enable_mail_source" value="true" class="noborder" onclick="javascript:OnChangeUseMailsource();"
    <% if ("true".equals(receive_enable_mail_source)) { %>
        checked="checked"
    <% } %>
    />
    </td>    
  </tr>
  <tr class="<mvn:cssrow/>" id="id_receive_mail_source_name">
    <td>mail_source_name <span class="requiredfield">*</span></td>
    <td><input type="text" size="70" name="receive_mail_source_name" value="<%=mvncoreConfig.getString("mailoptions.receive_mail.mail_source_name", "")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow autoIncrease="false"/>" id="id_receive_mail_mail_server">
    <td>mail_server <span class="requiredfield">*</span></td>
    <td><input type="text" size="70" name="receive_mail_server" value="<%=mvncoreConfig.getString("mailoptions.receive_mail.mail_server", "")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>" id="id_recevie_mail_username">
    <td>username</td>
    <td><input type="text" size="70" name="receive_mail_username" value="<%=mvncoreConfig.getString("mailoptions.receive_mail.username", "")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>" id="id_receive_mail_password">
    <td>password</td>
    <td><input type="password" size="70" name="receive_mail_password" value="<%=mvncoreConfig.getString("mailoptions.receive_mail.password", "")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>" id="id_receive_mail_port">
    <td>port <span class="requiredfield">*</span></td>
    <td><input type="text" size="70" name="receive_mail_port" value="<%=mvncoreConfig.getString("mailoptions.receive_mail.port", "25")%>" /></td>
  </tr> 
</mvn:cssrows>
  <tr class="portlet-section-subheader">
    <td colspan="2"><fmt:message key="mvnforum.admin.config.config_mvncore_mail.send_mail_option"/></td>
  </tr> 
<mvn:cssrows>
  <tr class="<mvn:cssrow/>" id="id_send_mail_use_embeded_smtp_mail_server">
    <td>use_embeded_smtp_mail_server <span class="requiredfield">*</span></td>
    <td> 
    <% String sendmail_use_embeded_smtp_mail_server = mvncoreConfig.getString("mailoptions.send_mail.use_embeded_smtp_mail_server", "");%>
    <input type="checkbox" name="send_mail_use_embeded_smtp_mail_server" value="true" class="noborder" onclick="javascript:OnChangeUseMailsource();"
    <% if ("true".equals(sendmail_use_embeded_smtp_mail_server)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr> 
  <tr class="<mvn:cssrow/>" id="id_send_mail_enable_mail_source">
    <td>enable_mail_source <span class="requiredfield">*</span></td>
    <td> 
    <% String sendmail_enable_mail_source = mvncoreConfig.getString("mailoptions.send_mail.enable_mail_source", "");%>
    <input type="checkbox" name="send_mail_enable_mail_source" value="true" class="noborder" onclick="javascript:OnChangeUseMailsource();"
    <% if ("true".equals(sendmail_enable_mail_source)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>" id="id_send_mail_source_name">
    <td>mail_source_name <span class="requiredfield">*</span></td>
    <td><input type="text" size="70" name="send_mail_source_name" value="<%=mvncoreConfig.getString("mailoptions.send_mail.mail_source_name", "")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>" id="id_send_mail_use_secure_connection">
    <td>use_secure_connection <span class="requiredfield">*</span></td>
    <td> 
    <% String sendmail_use_secure_connection = mvncoreConfig.getString("mailoptions.send_mail.use_secure_connection", "");%>
    <input type="checkbox" name="send_mail_use_secure_connection" value="true" class="noborder"
    <% if ("true".equals(sendmail_use_secure_connection)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr> 
  <tr class="<mvn:cssrow autoIncrease="false"/>" id="id_send_mail_mail_server">
    <td>mail_server <span class="requiredfield">*</span></td>
    <td><input type="text" size="70" name="send_mail_server" value="<%=mvncoreConfig.getString("mailoptions.send_mail.mail_server", "")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>" id="id_send_mail_username">
    <td>username</td>
    <td><input type="text" size="70" name="send_mail_username" value="<%=mvncoreConfig.getString("mailoptions.send_mail.username", "")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>" id="id_send_mail_password">
    <td>password</td>
    <td><input type="password" size="70" name="send_mail_password" value="<%=mvncoreConfig.getString("mailoptions.send_mail.password", "")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>" id="id_send_mail_port">
    <td>port <span class="requiredfield">*</span></td>
    <td><input type="text" size="70" name="send_mail_port" value="<%=mvncoreConfig.getString("mailoptions.send_mail.port", "25")%>" /></td>
  </tr>   
</mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.config.config_mvncore_param"/></td>
  </tr>
<mvn:cssrows>
  <tr class="<mvn:cssrow/>">
    <td>context_path</td>
    <td>
    <input type="text" size="70" name="context_path" value="<%=mvncoreConfig.getString("paramoptions.context_path", "")%>" /><br/>
    <fmt:message key="mvnforum.admin.config.auto_detect"/>: <b><%= request.getContextPath() %></b>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>server_path <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="70" name="server_path" value="<%=mvncoreConfig.getString("paramoptions.server_path", "")%>" /><br/>
    <fmt:message key="mvnforum.admin.config.auto_detect"/> (<fmt:message key="mvnforum.admin.config.method"/> 1): <b><%= ParamUtil.getServer(request) %></b><br/>
    <fmt:message key="mvnforum.admin.config.auto_detect"/> (<fmt:message key="mvnforum.admin.config.method"/> 2): <b><%= ParamUtil.getServer2(request) %></b>
    </td>
  </tr>
</mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.config.config_mvncore_date"/></td>
  </tr>
<mvn:cssrows>
  <tr class="<mvn:cssrow/>">
    <td>server_hour_offset <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="70" name="server_hour_offset" value="<%=mvncoreConfig.getString("dateoptions.server_hour_offset", "0")%>" />
    <br/><fmt:message key="mvnforum.admin.config.auto_detect"/>: <b><%= java.util.TimeZone.getDefault().getRawOffset() / DateUtil.HOUR %></b>
    </td>
  </tr>
</mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.config.config_mvncore_user_agent"/></td>
  </tr>
<mvn:cssrows>
  <tr class="<mvn:cssrow/>">
    <td>blocked_user_agent</td>
    <td>
    <input type="text" size="70" name="blocked_user_agent" value="<%=mvncoreConfig.getString("useragentoptions.blocked_user_agent", "")%>" />
    </td>
  </tr>
</mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.config.config_mvncore_core"/></td>
  </tr>
<mvn:cssrows>
  <tr class="<mvn:cssrow/>">
    <td>timermanager_datasource</td>
    <td>
    <input type="text" size="70" name="timermanager_datasource" value="<%=mvncoreConfig.getString("mvncoreconfig.timermanager_datasource", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_link_nofollow</td>
    <td>
    <% String enable_link_nofollow = mvncoreConfig.getString("mvncoreconfig.enable_link_nofollow", "");%>
    <input type="checkbox" name="enable_link_nofollow" value="true" class="noborder"
    <% if ("true".equals(enable_link_nofollow)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>enable_encode_url</td>
    <td>
    <% String enable_encode_url = mvncoreConfig.getString("mvncoreconfig.enable_encode_url", "");%>
    <input type="checkbox" name="enable_encode_url" value="true" class="noborder"
    <% if ("true".equals(enable_encode_url)) { %>
        checked="checked"
    <% } %>
    />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>portal_type</td>
    <td>
    <select name="portal_type">
 <% String portal_type = mvncoreConfig.getString("mvncoreconfig.portal_type", "");
    String[] arr = {"non-portal", "uportal", "jetspeed2", "liferay", "jboss", "weblogic", "exoplatform"};
    for (int i = 0; i < arr.length; i++) {
      if (arr[i].equals(portal_type)) { %>
      <option value="<%=arr[i]%>" selected="selected"><%=arr[i]%></option>
    <%} else { %>
      <option value="<%=arr[i]%>"><%=arr[i]%></option>
    <%}
    } %>
    </select>
    </td>
  </tr>
<mvn:cssrows>
  <tr class="<mvn:cssrow/>">
    <td>allow_http_referer_prefix_list</td>
    <td>
    <input type="text" size="70" name="allow_http_referer_prefix_list" value="<%=mvncoreConfig.getString("mvncoreconfig.allow_http_referer_prefix_list", "")%>" />
    </td>
  </tr>
</mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.config.config_mvncore_core"/></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>mvncoreservice_implementation <span class="requiredfield">*</span></td>
    <td>
    <input type="text" size="70" name="mvncoreservice_implementation" value="<%=mvncoreConfig.getString("mvncoreconfig.mvncoreservice_implementation", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>timertaskext_implementation_list</td>
    <td>
    <input type="text" size="70" name="timertaskext_implementation_list" value="<%=mvncoreConfig.getString("mvncoreconfig.timertaskext_implementation_list", "")%>" />
    </td>
  </tr>
</mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.config.config_mvncore_interceptor"/></td>
  </tr>
<mvn:cssrows>
  <tr class="<mvn:cssrow/>">
    <td>mailinterceptor_implementation</td>
    <td>
    <input type="text" size="70" name="mailinterceptor_implementation" value="<%=mvncoreConfig.getString("interceptor.mailinterceptor_implementation", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>contentinterceptor_implementation</td>
    <td>
    <input type="text" size="70" name="contentinterceptor_implementation" value="<%=mvncoreConfig.getString("interceptor.contentinterceptor_implementation", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>loginidinterceptor_implementation</td>
    <td>
    <input type="text" size="70" name="loginidinterceptor_implementation" value="<%=mvncoreConfig.getString("interceptor.loginidinterceptor_implementation", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td>passwordinterceptor_implementation</td>
    <td>
    <input type="text" size="70" name="passwordinterceptor_implementation" value="<%=mvncoreConfig.getString("interceptor.passwordinterceptor_implementation", "")%>" />
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><span class="requiredfield">*</span> <fmt:message key="mvnforum.common.prompt.current_password"/>:</td>
    <td><input type="password" name="MemberCurrentMatkhau" size="30" /></td>
  </tr>
</mvn:cssrows>
  <tr class="portlet-section-footer">
    <td colspan="2" align="center">
      <input type="button" name="submitbutton" value="<fmt:message key="mvnforum.common.action.save_and_reload"/>" onclick="javascript:SubmitForm();" class="portlet-form-button" />
      <input type="button" value="<fmt:message key="mvnforum.common.action.cancel"/>" class="liteoption" onclick="javascript:gotoPage('<%=urlResolver.encodeURL(request, response, "configindex")%>');" />
    </td>
  </tr>
</table>
</form>
<br/>
<script language="JavaScript" type="text/javascript">
//<![CDATA[
    OnChangeUseDatasource();
    OnChangeUseMailsource();
//]]>
</script>

<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>
