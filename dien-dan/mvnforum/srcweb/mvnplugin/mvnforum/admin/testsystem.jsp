<%--
 - $Header: /cvsroot/mvnforum/mvnforum/srcweb/mvnplugin/mvnforum/admin/testsystem.jsp,v 1.66 2008/06/13 09:23:19 phuongpdd Exp $
 - $Author: phuongpdd $
 - $Revision: 1.66 $
 - $Date: 2008/06/13 09:23:19 $
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
<%@ page import="net.myvietnam.mvncore.info.LibInfo" %>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<fmt:bundle basename="mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.admin.testsystem.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css" />
</mvn:head>
<mvn:body>
<%@ include file="header.jsp"%>
<br/>

<table width="95%" align="center">
  <tr class="nav">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/check_icon.png" alt="" /></td>
    <td width="100%" nowrap="nowrap">
    <%if (isServlet) {%>
    <a class="nav" href="<%=urlResolver.encodeURL(request, response, "index", URLResolverService.RENDER_URL, "view")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
    <%}%>
    <a class="nav" href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.admin.index.title"/></a>&nbsp;&raquo;&nbsp;
    <a class="nav" href="<%=urlResolver.encodeURL(request, response, "misctasks")%>"><fmt:message key="mvnforum.admin.misctasks.title"/></a>&nbsp;&raquo;&nbsp;
    <fmt:message key="mvnforum.admin.testsystem.title"/>
    </td>
  </tr>
</table>
<br/>

<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
  <tr class="pagedesc">
    <td>
    <fmt:message key="mvnforum.admin.testsystem.info"/>
    </td>
  </tr>
</table>


<%
    LibInfo libInfo = new LibInfo();
%>
<mvn:cssrows>
<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.testsystem.system_info"/></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td width="30%"><fmt:message key="mvnforum.admin.testsystem.support_image_processing"/></td>
    <td>
    <%if (libInfo.isSupportImageProcessing()) {%>
    <font color="#008000"><fmt:message key="mvnforum.common.yes"/></font>
    <%} else {%>
    <font color="#FF0080"><fmt:message key="mvnforum.common.no"/></font> 
    (<fmt:message key="mvnforum.admin.testsystem.more_info"/> <a href="http://java.sun.com/products/java-media/2D/forDevelopers/java2dfaq.html#xvfb">Sun 2D FAQ</a>)
    <%}%>
    </td>
  </tr>
</table>
</mvn:cssrows>


<mvn:cssrows>
<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.admin.testsystem.library_info"/></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td width="30%"><fmt:message key="mvnforum.admin.testsystem.support"/> JNDI</td>
    <td>
    <%if (libInfo.isSupportJNDI()) {%><font color="#008000"><fmt:message key="mvnforum.common.yes"/></font><%} else {%><font color="#FF0080"><fmt:message key="mvnforum.common.no"/></font><%}%>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.admin.testsystem.support"/> Java Sql Ext</td>
    <td>
    <%if (libInfo.isSupportJavaxSql()) {%><font color="#008000"><fmt:message key="mvnforum.common.yes"/></font><%} else {%><font color="#FF0080"><fmt:message key="mvnforum.common.no"/></font><%}%>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.admin.testsystem.support"/> Java Activation Framework</td>
    <td>
    <%if (libInfo.isSupportJAF()) {%><font color="#008000"><fmt:message key="mvnforum.common.yes"/></font><%} else {%><font color="#FF0080"><fmt:message key="mvnforum.common.no"/></font><%}%>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.admin.testsystem.support"/> Java Mail</td>
    <td>
    <%if (libInfo.isSupportMail()) {%><font color="#008000"><fmt:message key="mvnforum.common.yes"/></font><%} else {%><font color="#FF0080"><fmt:message key="mvnforum.common.no"/></font><%}%>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.admin.testsystem.support"/> Jakarta Common IO</td>
    <td>
    <%if (libInfo.isSupportCommonIo()) {%><font color="#008000"><fmt:message key="mvnforum.common.yes"/></font><%} else {%><font color="#FF0080"><fmt:message key="mvnforum.common.no"/></font><%}%>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.admin.testsystem.support"/> Jakarta Common Logging</td>
    <td>
    <%if (libInfo.isSupportCommonLogging()) {%><font color="#008000"><fmt:message key="mvnforum.common.yes"/></font><%} else {%><font color="#FF0080"><fmt:message key="mvnforum.common.no"/></font><%}%>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.admin.testsystem.support"/> Jakarta Common Codec</td>
    <td>
    <%if (libInfo.isSupportCommonCodec()) {%><font color="#008000"><fmt:message key="mvnforum.common.yes"/></font><%} else {%><font color="#FF0080"><fmt:message key="mvnforum.common.no"/></font><%}%>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.admin.testsystem.support"/> Jakarta Common Collection</td>
    <td>
    <%if (libInfo.isSupportCommonCollection()) {%><font color="#008000"><fmt:message key="mvnforum.common.yes"/></font><%} else {%><font color="#FF0080"><fmt:message key="mvnforum.common.no"/></font><%}%>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.admin.testsystem.support"/> Jakarta Common Digester</td>
    <td>
    <%if (libInfo.isSupportCommonDigester()) {%><font color="#008000"><fmt:message key="mvnforum.common.yes"/></font><%} else {%><font color="#FF0080"><fmt:message key="mvnforum.common.no"/></font><%}%>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.admin.testsystem.support"/> Jakarta Common Lang</td>
    <td>
    <%if (libInfo.isSupportCommonLang()) {%><font color="#008000"><fmt:message key="mvnforum.common.yes"/></font><%} else {%><font color="#FF0080"><fmt:message key="mvnforum.common.no"/></font><%}%>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.admin.testsystem.support"/> Jakarta Regular Expression</td>
    <td>
    <%if (libInfo.isSupportJakartaRegExp()) {%><font color="#008000"><fmt:message key="mvnforum.common.yes"/></font><%} else {%><font color="#FF0080"><fmt:message key="mvnforum.common.no"/></font><%}%>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.admin.testsystem.support"/> Jakarta BeanUtils</td>
    <td>
    <%if (libInfo.isSupportBeanUtils()) {%><font color="#008000"><fmt:message key="mvnforum.common.yes"/></font><%} else {%><font color="#FF0080"><fmt:message key="mvnforum.common.no"/></font><%}%>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.admin.testsystem.support"/> Jakarta Lucene</td>
    <td>
    <%if (libInfo.isSupportLucene()) {%><font color="#008000"><fmt:message key="mvnforum.common.yes"/></font><%} else {%><font color="#FF0080"><fmt:message key="mvnforum.common.no"/></font><%}%>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.admin.testsystem.support"/> Dom4j</td>
    <td>
    <%if (libInfo.isSupportDom4j()) {%><font color="#008000"><fmt:message key="mvnforum.common.yes"/></font><%} else {%><font color="#FF0080"><fmt:message key="mvnforum.common.no"/></font><%}%>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.admin.testsystem.support"/> Pager Tag lib</td>
    <td>
    <%if (libInfo.isSupportPagerTaglib()) {%><font color="#008000"><fmt:message key="mvnforum.common.yes"/></font><%} else {%><font color="#FF0080"><fmt:message key="mvnforum.common.no"/></font><%}%>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.admin.testsystem.support"/> Whirlycache</td>
    <td>
    <%if (libInfo.isSupportWhirlycache()) {%><font color="#008000"><fmt:message key="mvnforum.common.yes"/></font><%} else {%><font color="#FF0080"><fmt:message key="mvnforum.common.no"/></font><%}%>
    </td>
  </tr>
  <%-- JDom is needed by old WhirlyCache
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.admin.testsystem.support"/> JDom</td>
    <td>
    <%if (libInfo.isSupportJDom()) {%><font color="#008000"><fmt:message key="mvnforum.common.yes"/></font><%} else {%><font color="#FF0080"><fmt:message key="mvnforum.common.no"/></font><%}%>
    </td>
  </tr>
  --%>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.admin.testsystem.support"/> Jzonic</td>
    <td>
    <%if (libInfo.isSupportJzonic()) {%><font color="#008000"><fmt:message key="mvnforum.common.yes"/></font><%} else {%><font color="#FF0080"><fmt:message key="mvnforum.common.no"/></font><%}%>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.admin.testsystem.support"/> DNS Java</td>
    <td>
    <%if (libInfo.isSupportDNSJava()) {%><font color="#008000"><fmt:message key="mvnforum.common.yes"/></font><%} else {%><font color="#FF0080"><fmt:message key="mvnforum.common.no"/></font><%}%>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.admin.testsystem.support"/> Asipirin SMTP Server</td>
    <td>
    <%if (libInfo.isSupportAspirinSMTPServer()) {%><font color="#008000"><fmt:message key="mvnforum.common.yes"/></font><%} else {%><font color="#FF0080"><fmt:message key="mvnforum.common.no"/></font><%}%>
    </td>
  </tr>
</table>
</mvn:cssrows>


<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>
