<%--
 - $Header: /cvsroot/mvnforum/mvnforum/srcweb/mvnplugin/mvnforum/admin/listmembergroup.jsp,v 1.72 2008/06/13 09:23:18 phuongpdd Exp $
 - $Author: phuongpdd $
 - $Revision: 1.72 $
 - $Date: 2008/06/13 09:23:18 $
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
<%@ page import="java.util.*"%>
<%@ page import="com.mvnforum.db.*" %>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<fmt:bundle basename="mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.admin.listmembergroup.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css" />
</mvn:head>
<mvn:body>
<%@ include file="header.jsp"%>
<br/>

<%
GroupsBean groupBean = (GroupsBean)request.getAttribute("GroupsBean");
%>

<table width="95%" align="center">
  <tr class="nav">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" /></td>
    <td width="100%" nowrap="nowrap">
    <%if (isServlet) {%>
    <a class="nav" href="<%=urlResolver.encodeURL(request, response, "index", URLResolverService.RENDER_URL, "view")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
    <%}%>
    <a class="nav" href="<%=urlResolver.encodeURL(request, response, "index")%>">Admin CP</a>&nbsp;&raquo;&nbsp;
    <a class="nav" href="<%=urlResolver.encodeURL(request, response, "groupmanagement")%>">Group Management</a>&nbsp;&raquo;&nbsp;
    <fmt:message key="mvnforum.common.group"/>: <a class="nav" href="<%=urlResolver.encodeURL(request, response, "viewgroup?group=" + groupBean.getGroupID())%>"><%=groupBean.getGroupName()%></a>&nbsp;&raquo;&nbsp;
    <fmt:message key="mvnforum.admin.listmembergroup.title"/>
    </td>
  </tr>
</table>
<br/>

<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
  <tr class="pagedesc">
    <td>
      <fmt:message key="mvnforum.admin.listmembergroup.info"/><br/><br/>
      <fmt:message key="mvnforum.common.prompt.choose_tasks"/><br/>
      <a href="<%=urlResolver.encodeURL(request, response, "addmembergroup?group=" + groupBean.getGroupID())%>" class="command"><fmt:message key="mvnforum.admin.addmembergroup.title"/></a><br/>
    </td>
  </tr>
</table>
<br/>

<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
  <tr class="portlet-section-header">
    <td><fmt:message key="mvnforum.common.member.login_name"/></td>
    <td align="center"><fmt:message key="mvnforum.admin.listmembergroup.is_owner"/></td>
    <td align="center"><fmt:message key="mvnforum.common.group.privilege"/></td>
    <td align="center"><fmt:message key="mvnforum.admin.listmembergroup.remove_from_group"/></td>
  </tr>
<mvn:cssrows>
<%
int ownerID = groupBean.getGroupOwnerID();

Collection objMemberGroupBeans = (Collection)request.getAttribute("MemberGroupBeans");
for (Iterator iterator = objMemberGroupBeans.iterator(); iterator.hasNext(); ) {
    MemberGroupBean objMemberGroupBean = (MemberGroupBean)iterator.next();
%>
  <tr class="<mvn:cssrow/>">
    <td><a class="memberName" href="<%=urlResolver.encodeURL(request, response, "viewmember?memberid=" + objMemberGroupBean.getMemberID())%>"><%=objMemberGroupBean.getMemberName()%></a></td>
    <td align="center">
      <% if (objMemberGroupBean.getMemberID() == ownerID) {%>
        <font color="#008000"><fmt:message key="mvnforum.common.yes"/></font>
      <% } %>
    </td>
    <td align="center">
      <%=objMemberGroupBean.getPrivilege()%>
    </td>
    <td align="center">
      <a href="<%=urlResolver.encodeURL(request, response, "deletemembergroupprocess?memberid=" + objMemberGroupBean.getMemberID() + "&amp;group=" + groupBean.getGroupID())%>" class="command"><fmt:message key="mvnforum.common.action.remove"/></a>
    </td>
  </tr>
<%
}//for
if (objMemberGroupBeans.size() == 0) { %>
  <tr class="<mvn:cssrow/>"><td colspan="4" align="center"><fmt:message key="mvnforum.admin.listmembergroup.no_member_in_group"/></td></tr>
<% } //if%>
</table>
</mvn:cssrows>
<br/>

<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>