<%--
 - $Header: /cvsroot/mvnforum/mvnforum/srcweb/mvnplugin/mvnforum/user/editwatch.jsp,v 1.28 2008/06/13 09:23:25 phuongpdd Exp $
 - $Author: phuongpdd $
 - $Revision: 1.28 $
 - $Date: 2008/06/13 09:23:25 $
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
 - @author: Anh, Dong Thi Lan
 --%>
<%@ page contentType="text/html;charset=utf-8" %>
<%@ page errorPage="fatalerror.jsp"%>

<%@ page import="com.mvnforum.db.WatchBean" %>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<fmt:bundle basename="mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.editwatch.title"/></mvn:title>
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
  return true;
}
//]]>
</script>

<%@ include file="header.jsp"%>
<br/>
<%
WatchBean watchBean = (WatchBean) request.getAttribute("WatchBean");
%>

<table width="95%" align="center">
  <tr class="nav">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt=""/></td>
    <td width="100%" nowrap="nowrap">
    <a class="nav" href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
    <a class="nav" href="<%=urlResolver.encodeURL(request, response, "myprofile")%>"><fmt:message key="mvnforum.user.header.my_profile"/></a>&nbsp;&raquo;&nbsp;
    <a class="nav" href="<%=urlResolver.encodeURL(request, response, "mywatch")%>"><fmt:message key="mvnforum.user.mywatch.title"/></a>&nbsp;&raquo;&nbsp;
    <fmt:message key="mvnforum.user.editwatch.title"/>
    </td>
  </tr>
</table>
<br/>

<form action="<%=urlResolver.encodeURL(request, response, "editwatchprocess", URLResolverService.ACTION_URL)%>" method="post" name="submitform">
<%=urlResolver.generateFormAction(request, response, "editwatchprocess")%>
  <input type="hidden" name="WatchID" value="<%=watchBean.getWatchID()%>" />
  <table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center"> 
  <mvn:cssrows>
    <tr class="portlet-section-header">
      <td colspan="2"><fmt:message key="mvnforum.user.editwatch.title"/></td>
    </tr>
    <tr class="<mvn:cssrow/>">
      <td><fmt:message key="mvnforum.common.watch.type"/></td>
      <td>
      <select name="WatchType">
        <option value="0" <%if (watchBean.getWatchType() == 0) { %> selected="selected" <% } %>><fmt:message key="mvnforum.common.watch.type.default"/></option>
        <option value="1" <%if (watchBean.getWatchType() == 1) { %> selected="selected" <% } %>><fmt:message key="mvnforum.common.watch.type.digest"/></option>
        <option value="2" <%if (watchBean.getWatchType() == 2) { %> selected="selected" <% } %>><fmt:message key="mvnforum.common.watch.type.nondigest"/></option>
      </select>
      </td>
    </tr>
    <tr class="portlet-section-footer">
      <td colspan="2" align="center">
        <input name="submitbutton" type="button" value="<fmt:message key="mvnforum.common.action.save"/>" onclick="javascript:SubmitForm();" class="portlet-form-button" />
      </td>
    </tr>
  </mvn:cssrows>
  </table>
  </form>
<br/>
<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>
