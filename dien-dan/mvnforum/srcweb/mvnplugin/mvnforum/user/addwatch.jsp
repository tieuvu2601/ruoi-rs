<%--
 - $Header: /cvsroot/mvnforum/mvnforum/srcweb/mvnplugin/mvnforum/user/addwatch.jsp,v 1.68 2008/06/13 09:23:21 phuongpdd Exp $
 - $Author: phuongpdd $
 - $Revision: 1.68 $
 - $Date: 2008/06/13 09:23:21 $
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
<%@ page import="java.util.*" %>
<%@ page import="net.myvietnam.mvncore.util.ParamUtil" %>
<%@ page import="com.mvnforum.db.*" %>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<fmt:bundle basename="mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.addwatch.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body onunload="document.submitform.submitbutton.disabled=false;">
<%@ include file="header.jsp"%>
<br/>
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
  if (document.getElementById("WatchSelector1").checked == true) {
    if (isBlank(document.submitform.category, "<fmt:message key="mvnforum.common.category"/>")) return false;
  } else if (document.getElementById("WatchSelector2").checked == true) {
    if (isBlank(document.submitform.forum, "<fmt:message key="mvnforum.common.forum"/>")) return false;
  } else if (document.getElementById("WatchSelector3").checked == true) {
    if (isBlank(document.submitform.thread, "<fmt:message key="mvnforum.common.thread"/>")) return false;
  }
  return true;
}
//]]>
</script>

<script type="text/javascript" language="JavaScript">
//<![CDATA[
function showGlobalWatch() {
    document.getElementById("WatchSelector0").checked = true;
    document.getElementById("GlobalWatch").style.display = '';
    document.getElementById("CategoryWatch").style.display = 'none';
    document.getElementById("ForumWatch").style.display = 'none';
    document.getElementById("ThreadWatch").style.display = 'none';
}
function showCategoryWatch() {
    document.getElementById("WatchSelector1").checked = true;
    document.getElementById("GlobalWatch").style.display = 'none';
    document.getElementById("CategoryWatch").style.display = '';
    document.getElementById("ForumWatch").style.display = 'none';
    document.getElementById("ThreadWatch").style.display = 'none';
}
function showForumWatch() {
    document.getElementById("WatchSelector2").checked = true;
    document.getElementById("GlobalWatch").style.display = 'none';
    document.getElementById("CategoryWatch").style.display = 'none';
    document.getElementById("ForumWatch").style.display = '';
    document.getElementById("ThreadWatch").style.display = 'none';
}
function showThreadWatch() {
    document.getElementById("WatchSelector3").checked = true;
    document.getElementById("GlobalWatch").style.display = 'none';
    document.getElementById("CategoryWatch").style.display = 'none';
    document.getElementById("ForumWatch").style.display = 'none';
    document.getElementById("ThreadWatch").style.display = '';
}
//]]>
</script>

<table width="95%" align="center">
  <tr class="nav">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" /></td>
    <td width="100%" nowrap="nowrap">
    <a class="nav" href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
    <a class="nav" href="<%=urlResolver.encodeURL(request, response, "myprofile")%>"><fmt:message key="mvnforum.user.header.my_profile"/></a>&nbsp;&raquo;&nbsp;
    <a class="nav" href="<%=urlResolver.encodeURL(request, response, "mywatch")%>"><fmt:message key="mvnforum.user.mywatch.title"/></a>&nbsp;&raquo;&nbsp;
    <fmt:message key="mvnforum.user.addwatch.title"/>
    </td>
  </tr>
</table>
<br/>

<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
  <tr class="pagedesc">
    <td class="warning"><fmt:message key="mvnforum.user.addwatch.warning"/></td>
  </tr>
</table>
<br/>

<%
CategoryCache categoryCache = CategoryCache.getInstance();
ForumCache forumCache = ForumCache.getInstance();
Collection categoryBeans = categoryCache.getBeans();
Collection forumBeans = forumCache.getBeans();
%>

<form action="<%=urlResolver.encodeURL(request, response, "addwatchprocess", URLResolverService.ACTION_URL)%>" method="post" name="submitform">
<%=urlResolver.generateFormAction(request, response, "addwatchprocess")%>
<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.user.addwatch.prompt"/></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td width="30%" valign="top"><fmt:message key="mvnforum.common.watch.option"/></td>
    <td>
      <input type="radio" name="WatchSelector" value="0" id="WatchSelector0" onclick="showGlobalWatch();" class="noborder" /> <fmt:message key="mvnforum.common.watch.option.global"/><br/>
      <input type="radio" name="WatchSelector" value="1" id="WatchSelector1" onclick="showCategoryWatch();" class="noborder" /> <fmt:message key="mvnforum.common.watch.option.category"/><br/>
      <input type="radio" name="WatchSelector" value="2" id="WatchSelector2" onclick="showForumWatch();" class="noborder" /> <fmt:message key="mvnforum.common.watch.option.forum"/><br/>
      <input type="radio" name="WatchSelector" value="3" id="WatchSelector3" onclick="showThreadWatch();" class="noborder" /> <fmt:message key="mvnforum.common.watch.option.thread"/><br/>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>" id="GlobalWatch" style="display: none;">
    <td colspan="2" align="center"><fmt:message key="mvnforum.user.addwatch.global_watch_desc"/></td>
  </tr>
  <tr class="<mvn:cssrow autoIncrease="false"/>" id="CategoryWatch" style="display: none;">
    <td><span class="requiredfield">*</span> <fmt:message key="mvnforum.common.category"/></td>
    <td>
    <%--
      <select name="category">
        <option value=""><fmt:message key="mvnforum.common.prompt.choose_category"/></option>
      <%
      for (Iterator catIterator = categoryBeans.iterator(); catIterator.hasNext(); ) {
          CategoryBean categoryBean = (CategoryBean)catIterator.next();
          if (MyUtil.canViewAnyForumInCategory(categoryBean.getCategoryID(), permission) == false) continue; %>
        <option value="<%=categoryBean.getCategoryID()%>">&nbsp;<%=categoryBean.getCategoryName()%></option>
      <% }//for %>
      </select>
    --%>
    <%
      out.println(request.getAttribute("Result"));
    %>
    </td>
  </tr>
  <tr class="<mvn:cssrow autoIncrease="false"/>" id="ForumWatch" style="display: none;">
    <td><span class="requiredfield">*</span> <fmt:message key="mvnforum.common.forum"/></td>
    <td>
      <select name="forum">
        <option value=""><fmt:message key="mvnforum.common.prompt.choose_forum"/></option>
<%
for (Iterator catIter = categoryBeans.iterator(); catIter.hasNext(); ) {
    CategoryBean categoryBean = (CategoryBean)catIter.next();
    int categoryID = categoryBean.getCategoryID();
    if (MyUtil.canViewAnyForumInCategory(categoryID, permission) == false) continue; %>
        <option value=""></option>
        <option value=""><%=categoryBean.getCategoryName()%></option>
        <option value="">---------------------------------</option>
    <%
    for (Iterator forumIter = forumBeans.iterator(); forumIter.hasNext(); ) {
        ForumBean forumBean = (ForumBean)forumIter.next();
        if (forumBean.getCategoryID() != categoryID) continue;
        if (permission.canReadPost(forumBean.getForumID()) && (forumBean.getForumStatus() != ForumBean.FORUM_STATUS_DISABLED) ) { %>
        <option value="<%=forumBean.getForumID()%>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=forumBean.getForumName()%></option>
<%      } //if
    } // for forum
}// for category %>
      </select>
    </td>
  </tr>
  <tr class="<mvn:cssrow autoIncrease="false"/>" id="ThreadWatch" style="display: none;">
    <td><span class="requiredfield">*</span> <fmt:message key="mvnforum.common.thread"/></td>
    <td><input type="text" name="thread" value="<%=ParamUtil.getParameterFilter(request, "thread")%>" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.common.watch.type"/> <span class="requiredfield"></span></td>
    <td>
    <select name="WatchType">
      <option value="0" selected="selected"><fmt:message key="mvnforum.common.watch.type.default"/></option>
      <option value="1"><fmt:message key="mvnforum.common.watch.type.digest"/></option>
      <option value="2"><fmt:message key="mvnforum.common.watch.type.nondigest"/></option>
    </select>
    </td>
  </tr>
  <tr class="portlet-section-footer">
    <td colspan="2" align="center">
      <input type="button" name="submitbutton" value="<fmt:message key="mvnforum.user.addwatch.button.watch"/>" onclick="javascript:SubmitForm();" class="portlet-form-button" />
    </td>
  </tr>
</mvn:cssrows>
</table>
</form>
<script type="text/javascript" language="JavaScript">
//<![CDATA[
  showCategoryWatch();
//]]>
</script>

<br/>
<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>
