<%--
 - $Header: /cvsroot/mvnforum/mvnforum/srcweb/mvnplugin/mvnforum/user/addmember.jsp,v 1.116 2008/06/23 07:53:43 lexuanttkhtn Exp $
 - $Author: lexuanttkhtn $
 - $Revision: 1.116 $
 - $Date: 2008/06/23 07:53:43 $
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
<%@ page import="java.util.Locale" %>

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<fmt:bundle basename="mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.addmember.title"/></mvn:title>
<%@ include file="/mvnplugin/mvnforum/meta.jsp"%>
<link href="<%=onlineUser.getCssPath()%>" rel="stylesheet" type="text/css"/>
</mvn:head>
<mvn:body onunload="document.submitform.submitbutton.disabled=false;">
<script language="JavaScript1.2" src="<%=contextPath%>/mvnplugin/mvnforum/js/vietuni.js" type="text/javascript"></script>
<script type="text/javascript">
//<![CDATA[
function SubmitForm() {
  if (ValidateForm()) {
  <% if (MVNForumConfig.getRequireActivation()) {%>
    alert("<fmt:message key="mvnforum.user.addmember.javascript_prompt"/>");
  <% } %>
    <mvn:servlet>
      document.submitform.submitbutton.disabled=true;
    </mvn:servlet>  
    document.submitform.submit();
  }
}

function ValidateForm() {
  var field,temp;
  field = document.submitform.MemberName;
  temp = field.value;
  if (isBlank(field, "<fmt:message key="mvnforum.common.member.login_name"/>")) return false;
  if (!checkGoodName(temp, "<fmt:message key="mvnforum.common.member.login_name"/>")) return false;

  field=document.submitform.MemberMatkhau;
  temp=field.value
  if (isBlank(field, "<fmt:message key="mvnforum.common.member.password"/>")) return false;
  //Check Password's length
  if (temp.length < 3) {
    alert("<fmt:message key="mvnforum.common.js.prompt.invalidlongpassword"/>");
    field.focus();
    return false;
  }

  field=document.submitform.MemberMatkhauConfirm;
  if (isBlank(field, "<fmt:message key="mvnforum.common.member.password"/> (<fmt:message key="mvnforum.common.retype"/>)")) return false;

  if (temp!=field.value) {
    alert("<fmt:message key="mvnforum.common.member.password"/> <fmt:message key="mvnforum.common.js.prompt.notmatch"/>"); 
    return false;
  }

  field=document.submitform.MemberEmail;
  temp=field.value
  if (isBlank(field, "<fmt:message key="mvnforum.common.member.email"/>")) return false;
  if (!isEmail(field, "<fmt:message key="mvnforum.common.member.email"/>")) return false;

  <%--field=document.submitform.MemberEmailConfirm;--%>
  <%--if (isBlank(field, "<fmt:message key="mvnforum.common.member.email"/> (<fmt:message key="mvnforum.common.retype"/>)")) return false;--%>
  <%--if (!isEmail(field, "<fmt:message key="mvnforum.common.member.email"/>")) return false;--%>

  <%--if (temp!=field.value) {--%>
    <%--alert("<fmt:message key="mvnforum.common.member.email"/> <fmt:message key="mvnforum.common.js.prompt.notmatch"/>");--%>
    <%--return false;--%>
  <%--}--%>
<%if (MVNForumConfig.getEnableShowFirstName() && MVNForumConfig.isRequireRegisterFirstname()) {%>
    if (isBlank(document.submitform.MemberFirstname, "<fmt:message key="mvnforum.common.member.first_name"/>")) return false;
<%}%>

<%--<%if (MVNForumConfig.getEnableShowLastName() && MVNForumConfig.isRequireRegisterLastname()) {%>--%>
    <%--if (isBlank(document.submitform.MemberLastname, "<fmt:message key="mvnforum.common.member.last_name"/>")) return false;--%>
<%--<%}%>--%>

<%if (MVNForumConfig.getEnableShowGender() && MVNForumConfig.isRequireRegisterGender()) {%>
    if (document.submitform.MemberGender.value == -1) {
      alert("<fmt:message key="mvnforum.common.member.gender"/> <fmt:message key="mvnforum.common.js.prompt.fieldrequired"/>"); 
      return false;
    }
<%}%>

<%if (MVNForumConfig.getEnableShowBirthday() && MVNForumConfig.isRequireRegisterBirthday()) {%>
    if (document.submitform.day.value=="") {
      alert("<fmt:message key="mvnforum.common.member.birthday"/> <fmt:message key="mvnforum.common.js.prompt.fieldrequired"/>"); 
      return false;
    }
    if (document.submitform.month.value=="") {
      alert("<fmt:message key="mvnforum.common.member.birthday"/> <fmt:message key="mvnforum.common.js.prompt.fieldrequired"/>"); 
      return false;
    }
    if (document.submitform.year.value=="") {
      alert("<fmt:message key="mvnforum.common.member.birthday"/> <fmt:message key="mvnforum.common.js.prompt.fieldrequired"/>"); 
      return false;
    }
<%}%>

<%if (MVNForumConfig.getEnableShowAddress() && MVNForumConfig.isRequireRegisterAddress()) {%>
    if (isBlank(document.submitform.MemberAddress, "<fmt:message key="mvnforum.common.member.address"/>")) return false;
<%}%>

<%if (MVNForumConfig.getEnableShowCity() && MVNForumConfig.isRequireRegisterCity()) {%>
    if (isBlank(document.submitform.MemberCity, "<fmt:message key="mvnforum.common.member.city"/>")) return false;
<%}%>

<%if (MVNForumConfig.getEnableShowState() && MVNForumConfig.isRequireRegisterState()) {%>
    if (isBlank(document.submitform.MemberState, "<fmt:message key="mvnforum.common.member.state"/>")) return false;
<%}%>

<%if (MVNForumConfig.getEnableShowCountry() && MVNForumConfig.isRequireRegisterCountry()) {%>
    if (isBlank(document.submitform.MemberCountry, "<fmt:message key="mvnforum.common.member.country"/>")) return false;
<%}%>

<%if (MVNForumConfig.getEnableShowPhone() && MVNForumConfig.isRequireRegisterPhone()) {%>
    if (isBlank(document.submitform.MemberPhone, "<fmt:message key="mvnforum.common.member.phone"/>")) return false;
<%}%>

<%if (MVNForumConfig.getEnableShowMobile() && MVNForumConfig.isRequireRegisterMobile()) {%>
    if (isBlank(document.submitform.MemberMobile, "<fmt:message key="mvnforum.common.member.mobile"/>")) return false;
<%}%>

<%if (MVNForumConfig.getEnableShowFax() && MVNForumConfig.isRequireRegisterFax()) {%>
    if (isBlank(document.submitform.MemberFax, "<fmt:message key="mvnforum.common.member.fax"/>")) return false;
<%}%>

<%if (MVNForumConfig.getEnableShowCareer() && MVNForumConfig.isRequireRegisterCareer()) {%>
    if (isBlank(document.submitform.MemberCareer, "<fmt:message key="mvnforum.common.member.career"/>")) return false;
<%}%>

<%if (MVNForumConfig.getEnableShowHomepage() && MVNForumConfig.isRequireRegisterHomepage()) {%>
    if (isBlank(document.submitform.MemberHomepage, "<fmt:message key="mvnforum.common.member.homepage"/>")) return false;
<%}%>

<%if (MVNForumConfig.getEnableShowYahoo() && MVNForumConfig.isRequireRegisterYahoo()) {%>
    if (isBlank(document.submitform.MemberYahoo, "<fmt:message key="mvnforum.common.member.yahoo"/>")) return false;
<%}%>

<%if (MVNForumConfig.getEnableShowAOL() && MVNForumConfig.isRequireRegisterAol()) {%>
    if (isBlank(document.submitform.MemberAol, "<fmt:message key="mvnforum.common.member.aol"/>")) return false;
<%}%>

<%if (MVNForumConfig.getEnableShowICQ() && MVNForumConfig.isRequireRegisterIcq()) {%>
    if (isBlank(document.submitform.MemberIcq, "<fmt:message key="mvnforum.common.member.icq"/>")) return false;
<%}%>

<%if (MVNForumConfig.getEnableShowMSN() && MVNForumConfig.isRequireRegisterMsn()) {%>
    if (isBlank(document.submitform.MemberMsn, "<fmt:message key="mvnforum.common.member.msn"/>")) return false;
<%}%>

<%if (MVNForumConfig.getEnableShowCoolLink1() && MVNForumConfig.isRequireRegisterLink1()) {%>
    if (isBlank(document.submitform.MemberCoolLink1, "<fmt:message key="mvnforum.common.member.cool_link"/> 1")) return false;
<%}%>

<%if (MVNForumConfig.getEnableShowCoolLink2() && MVNForumConfig.isRequireRegisterLink2()) {%>
    if (isBlank(document.submitform.MemberCoolLink2, "<fmt:message key="mvnforum.common.member.cool_link"/> 2")) return false;
<%}%>

<%if (MVNForumConfig.getEnableCaptcha()) {%>
    if (isBlank(document.submitform.CaptchaResponse, "<fmt:message key="mvnforum.common.captcha.response"/>")) return false;
<%}%>

  return true;
}
//]]>
</script>

<%@ include file="header.jsp"%>
<br/>

<table width="95%" align="center">
  <tr class="nav">
    <td><img src="<%=contextPath%>/mvnplugin/mvnforum/images/nav.gif" alt="" /></td>
    <td width="100%" nowrap="nowrap">
    <a class="nav" href="<%=urlResolver.encodeURL(request, response, "index")%>"><fmt:message key="mvnforum.common.nav.index"/></a>&nbsp;&raquo;&nbsp;
    <fmt:message key="mvnforum.user.addmember.title"/>
    </td>
  </tr>
</table>
<br/>

<form action="<%=urlResolver.encodeURL(request, response, "registermemberprocess", URLResolverService.ACTION_URL)%>" method="post" id="submitform" name="submitform">
<%=urlResolver.generateFormAction(request, response, "registermemberprocess")%>
<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.user.addmember.prompt"/></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td nowrap="nowrap"><span class="requiredfield">*</span> <fmt:message key="mvnforum.common.member.login_name"/></td>
    <td><input type="text" size="60" name="MemberName" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td nowrap="nowrap"><span class="requiredfield">*</span> <fmt:message key="mvnforum.common.member.password"/></td>
    <td><input type="password" size="60" name="MemberMatkhau" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td nowrap="nowrap"><span class="requiredfield">*</span> <fmt:message key="mvnforum.common.member.password"/> (<fmt:message key="mvnforum.common.retype"/>)</td>
    <td><input type="password" size="60" name="MemberMatkhauConfirm" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td nowrap="nowrap"><span class="requiredfield">*</span> <fmt:message key="mvnforum.common.member.email"/></td>
    <td>
      <input type="text" size="60" name="MemberEmail" />
    <% if (MVNForumConfig.getRequireActivation()) {%>
      <br/><span class="warning"><fmt:message key="mvnforum.user.addmember.correct_email_remind"/></span>
    <% } %>
    </td>
  </tr>
  <%--<tr class="<mvn:cssrow/>">--%>
    <%--<td nowrap="nowrap"><span class="requiredfield">*</span> <fmt:message key="mvnforum.common.member.email"/> (<fmt:message key="mvnforum.common.retype"/>)</td>--%>
    <%--<td><input type="text" size="60" name="MemberEmailConfirm" /></td>--%>
  <%--</tr>--%>
<% if (MVNForumConfig.getEnableShowFirstName()) { %>
  <tr class="<mvn:cssrow/>">
    <td nowrap="nowrap">
      <% if (MVNForumConfig.isRequireRegisterFirstname()) { %><span class="requiredfield">*</span><% } %>
      <fmt:message key="mvnforum.common.member.first_name"/>
    </td>
    <td><input type="text" size="60" name="MemberFirstname" onkeyup="initTyper(this);" /></td>
  </tr>
<% } %>
<%--<% if (MVNForumConfig.getEnableShowLastName()) { %>--%>
  <%--<tr class="<mvn:cssrow/>">--%>
    <%--<td nowrap="nowrap">--%>
      <%--<% if (MVNForumConfig.isRequireRegisterLastname()) { %><span class="requiredfield">*</span><% } %>--%>
      <%--<fmt:message key="mvnforum.common.member.last_name"/>--%>
    <%--</td>--%>
    <%--<td><input type="text" size="60" name="MemberLastname" onkeyup="initTyper(this);" /></td>--%>
  <%--</tr>--%>
<%--<% } %>--%>
<% if (MVNForumConfig.getEnableShowGender()) { %>
  <tr class="<mvn:cssrow/>">
    <td nowrap="nowrap">
      <% if (MVNForumConfig.isRequireRegisterGender()) { %><span class="requiredfield">*</span><% } %>
      <fmt:message key="mvnforum.common.member.gender"/>
    </td>
    <td>
    <select name="MemberGender" size="1">
      <option value="-1"></option>
      <option value="1"><fmt:message key="mvnforum.common.member.male"/></option>
      <option value="0"><fmt:message key="mvnforum.common.member.female"/></option>
    </select>
    </td>
  </tr>
<% } %>
<% if (MVNForumConfig.getEnableShowBirthday()) { %>
  <tr class="<mvn:cssrow/>">
    <td nowrap="nowrap">
      <% if (MVNForumConfig.isRequireRegisterBirthday()) { %><span class="requiredfield">*</span><% } %>
      <fmt:message key="mvnforum.common.member.birthday"/> (dd/mm/yyyy)
    </td>
    <td>
<%@ include file="inc_date_option.jsp"%>
    </td>
  </tr>
<% } %>
  <%--<tr class="<mvn:cssrow/>">--%>
    <%--<td nowrap="nowrap"><fmt:message key="mvnforum.common.member.show_email"/></td>--%>
    <%--<td><input type="checkbox" checked="checked" size="60" name="MemberEmailVisible" value="yes" class="noborder" /></td>--%>
  <%--</tr>--%>
  <%--<tr class="<mvn:cssrow/>">--%>
    <%--<td nowrap="nowrap"><fmt:message key="mvnforum.common.member.name_visible"/></td>--%>
    <%--<td><input type="checkbox" checked="checked" size="60" name="MemberNameVisible" value="yes" class="noborder" <%if (MVNForumConfig.getEnableInvisibleUsers()==false) {%> disabled="disabled"<%}%> /></td>--%>
  <%--</tr>--%>
  <tr class="<mvn:cssrow/>">
    <td nowrap="nowrap"><fmt:message key="mvnforum.common.member.posts_per_page"/></td>
    <td>
      <select name="MemberPostsPerPage">
        <option value="5">5</option>
        <option value="10" selected="selected">10</option>
        <option value="15">15</option>
        <option value="20">20</option>
        <option value="30">30</option>
        <option value="50">50</option>
      </select>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td nowrap="nowrap"><fmt:message key="mvnforum.common.member.language"/></td>
    <td>
      <select name="MemberLanguage" size="1">
        <option value=""><fmt:message key="mvnforum.common.member.default_language"/></option>
<%
Locale[] locales = MVNForumConfig.getSupportedLocales();
for (int i = 0; i < locales.length; i++) {
    Locale locale = locales[i]; %>
        <option value="<%=locale.toString()%>"><%=locale.getDisplayName(locale)%></option>
<% } %>
      </select>
    </td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td nowrap="nowrap"><fmt:message key="mvnforum.common.member.time_zone"/></td>
    <td>
<%
double selectedTimeZone = MVNForumConfig.getDefaultGuestTimeZone();
String timeZoneSelectName = "MemberTimeZone";
%>
<%@ include file="inc_timezone_option.jsp"%>
    </td>
  </tr>
<%-- @todo: Should we add the following row:
  <tr class="portlet-section-header">
    <td colspan="2">Personal data (will not be revealed or given to third parties... or some similiar message? And maybe a link to some privacy statement?</td>
  </tr>
--%>
<% if (MVNForumConfig.getEnableShowAddress()) { %>
  <tr class="<mvn:cssrow/>">
    <td nowrap="nowrap">
      <% if (MVNForumConfig.isRequireRegisterAddress()) { %><span class="requiredfield">*</span><% } %>
      <fmt:message key="mvnforum.common.member.address"/>
    </td>
    <td><input type="text" size="60" name="MemberAddress" onkeyup="initTyper(this);" /></td>
  </tr>
<% } %>
<%--<% if (MVNForumConfig.getEnableShowCity()) { %>--%>
  <%--<tr class="<mvn:cssrow/>">--%>
    <%--<td nowrap="nowrap">--%>
      <%--<% if (MVNForumConfig.isRequireRegisterCity()) { %><span class="requiredfield">*</span><% } %>--%>
      <%--<fmt:message key="mvnforum.common.member.city"/>--%>
    <%--</td>--%>
    <%--<td><input type="text" size="60" name="MemberCity" onkeyup="initTyper(this);" /></td>--%>
  <%--</tr>--%>
<%--<% } %>--%>
<%--<% if (MVNForumConfig.getEnableShowState()) { %>--%>
  <%--<tr class="<mvn:cssrow/>">--%>
    <%--<td nowrap="nowrap">--%>
      <%--<% if (MVNForumConfig.isRequireRegisterState()) { %><span class="requiredfield">*</span><% } %>    --%>
      <%--<fmt:message key="mvnforum.common.member.state"/>--%>
    <%--</td>--%>
    <%--<td><input type="text" size="60" name="MemberState" onkeyup="initTyper(this);" /></td>--%>
  <%--</tr>--%>
<%--<% } %>--%>
<%--<% if (MVNForumConfig.getEnableShowCountry()) { %>--%>
  <%--<tr class="<mvn:cssrow/>">--%>
    <%--<td nowrap="nowrap">--%>
      <%--<% if (MVNForumConfig.isRequireRegisterCountry()) { %><span class="requiredfield">*</span><% } %>    --%>
      <%--<fmt:message key="mvnforum.common.member.country"/>--%>
    <%--</td>--%>
    <%--<td><input type="text" size="60" name="MemberCountry" onkeyup="initTyper(this);" /></td>--%>
  <%--</tr>--%>
<%--<% } %>--%>
<% if (MVNForumConfig.getEnableShowPhone()) { %>
  <tr class="<mvn:cssrow/>">
    <td nowrap="nowrap">
      <% if (MVNForumConfig.isRequireRegisterPhone()) { %><span class="requiredfield">*</span><% } %>    
      <fmt:message key="mvnforum.common.member.phone"/>
    </td>
    <td><input type="text" size="60" name="MemberPhone" /></td>
  </tr>
<% } %>
<% if (MVNForumConfig.getEnableShowMobile()) { %>
  <tr class="<mvn:cssrow/>">
    <td nowrap="nowrap">
      <% if (MVNForumConfig.isRequireRegisterMobile()) { %><span class="requiredfield">*</span><% } %>    
      <fmt:message key="mvnforum.common.member.mobile"/>
    </td>
    <td><input type="text" size="60" name="MemberMobile" /></td>
  </tr>
<% } %>


<%--<% if (MVNForumConfig.getEnableShowFax()) { %>--%>
  <%--<tr class="<mvn:cssrow/>">--%>
    <%--<td nowrap="nowrap">--%>
      <%--<% if (MVNForumConfig.isRequireRegisterFax()) { %><span class="requiredfield">*</span><% } %>    --%>
      <%--<fmt:message key="mvnforum.common.member.fax"/>--%>
    <%--</td>--%>
    <%--<td><input type="text" size="60" name="MemberFax" /></td>--%>
  <%--</tr>--%>
<%--<% } %>--%>
<%--<% if (MVNForumConfig.getEnableShowCareer()) { %>--%>
  <%--<tr class="<mvn:cssrow/>">--%>
    <%--<td nowrap="nowrap">--%>
      <%--<% if (MVNForumConfig.isRequireRegisterCareer()) { %><span class="requiredfield">*</span><% } %>    --%>
      <%--<fmt:message key="mvnforum.common.member.career"/>--%>
    <%--</td>--%>
    <%--<td><input type="text" size="60" name="MemberCareer" onkeyup="initTyper(this);" /></td>--%>
  <%--</tr>--%>
<%--<% } %>--%>
<%--<% if (MVNForumConfig.getEnableShowHomepage()) { %>--%>
  <%--<tr class="<mvn:cssrow/>">--%>
    <%--<td nowrap="nowrap">--%>
      <%--<% if (MVNForumConfig.isRequireRegisterHomepage()) { %><span class="requiredfield">*</span><% } %>    --%>
      <%--<fmt:message key="mvnforum.common.member.homepage"/>--%>
    <%--</td>--%>
    <%--<td><input type="text" size="60" name="MemberHomepage" value="http://" /></td>--%>
  <%--</tr>--%>
<%--<% } %>--%>
<%--<% if (MVNForumConfig.getEnableShowYahoo()) { %>--%>
  <%--<tr class="<mvn:cssrow/>">--%>
    <%--<td nowrap="nowrap">--%>
      <%--<% if (MVNForumConfig.isRequireRegisterYahoo()) { %><span class="requiredfield">*</span><% } %>    --%>
      <%--<fmt:message key="mvnforum.common.member.yahoo"/>--%>
    <%--</td>--%>
    <%--<td><input type="text" size="60" name="MemberYahoo" /></td>--%>
  <%--</tr>--%>
<%--<% } %>--%>
<%--<% if (MVNForumConfig.getEnableShowAOL()) { %>--%>
  <%--<tr class="<mvn:cssrow/>">--%>
    <%--<td nowrap="nowrap">--%>
      <%--<% if (MVNForumConfig.isRequireRegisterAol()) { %><span class="requiredfield">*</span><% } %>    --%>
      <%--<fmt:message key="mvnforum.common.member.aol"/>--%>
    <%--</td>--%>
    <%--<td><input type="text" size="60" name="MemberAol" /></td>--%>
  <%--</tr>--%>
<%--<% } %>--%>
<%--<% if (MVNForumConfig.getEnableShowICQ()) { %>--%>
  <%--<tr class="<mvn:cssrow/>">--%>
    <%--<td nowrap="nowrap">--%>
      <%--<% if (MVNForumConfig.isRequireRegisterIcq()) { %><span class="requiredfield">*</span><% } %>    --%>
      <%--<fmt:message key="mvnforum.common.member.icq"/>--%>
    <%--</td>--%>
    <%--<td><input type="text" size="60" name="MemberIcq" /></td>--%>
  <%--</tr>--%>
<%--<% } %>--%>
<%--<% if (MVNForumConfig.getEnableShowMSN()) { %>--%>
  <%--<tr class="<mvn:cssrow/>">--%>
    <%--<td nowrap="nowrap">--%>
      <%--<% if (MVNForumConfig.isRequireRegisterMsn()) { %><span class="requiredfield">*</span><% } %>    --%>
      <%--<fmt:message key="mvnforum.common.member.msn"/>--%>
    <%--</td>--%>
    <%--<td><input type="text" size="60" name="MemberMsn" /></td>--%>
  <%--</tr>--%>
<%--<% } %>--%>
<%--<% if (MVNForumConfig.getEnableShowCoolLink1()) { %>--%>
  <%--<tr class="<mvn:cssrow/>">--%>
    <%--<td nowrap="nowrap">--%>
      <%--<% if (MVNForumConfig.isRequireRegisterLink1()) { %><span class="requiredfield">*</span><% } %>    --%>
      <%--<fmt:message key="mvnforum.common.member.cool_link"/> 1--%>
    <%--</td>--%>
    <%--<td><input type="text" size="60" name="MemberCoolLink1" value="http://" /></td>--%>
  <%--</tr>--%>
<%--<% } %>--%>
<%--<% if (MVNForumConfig.getEnableShowCoolLink2()) { %>--%>
  <%--<tr class="<mvn:cssrow/>">--%>
    <%--<td nowrap="nowrap">--%>
      <%--<% if (MVNForumConfig.isRequireRegisterLink2()) { %><span class="requiredfield">*</span><% } %>    --%>
      <%--<fmt:message key="mvnforum.common.member.cool_link"/> 2--%>
    <%--</td>--%>
    <%--<td><input type="text" size="60" name="MemberCoolLink2" value="http://" /></td>--%>
  <%--</tr>--%>
<%--<% } %>--%>

<%if (MVNForumConfig.getEnableCaptcha()) {%>
  <tr class="<mvn:cssrow/>">
    <td nowrap="nowrap"><fmt:message key="mvnforum.common.captcha.challenge"/></td>
    <td><img src="<%=urlResolver.encodeURL(request, response, "captchaimage?time="+System.currentTimeMillis())%>" alt="<fmt:message key="mvnforum.common.captcha.desc"/>" title="<fmt:message key="mvnforum.common.captcha.desc"/>" border="0" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td nowrap="nowrap"><span class="requiredfield">*</span> <fmt:message key="mvnforum.common.captcha.response"/></td>
    <td><input type="text" size="60" name="CaptchaResponse" value="" /></td>
  </tr>
<%}// end if captcha%>
<%if (currentLocale.equals("vi")) {/*vietnamese here*/%>
  <tr class="<mvn:cssrow/>">
    <td valign="top" nowrap="nowrap"><fmt:message key="mvnforum.common.vietnamese_type"/>:</td>
    <td>
      <input type="radio" name="vnselector" id="TELEX" value="TELEX" onclick="setTypingMode(1);" class="noborder"/> <fmt:message key="mvnforum.common.vietnamese_type.telex"/>&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="radio" name="vnselector" id="VNI" value="VNI" onclick="setTypingMode(2);" class="noborder"/> <fmt:message key="mvnforum.common.vietnamese_type.vni"/>&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="radio" name="vnselector" id="VIQR" value="VIQR" onclick="setTypingMode(3);" class="noborder"/> <fmt:message key="mvnforum.common.vietnamese_type.VIQR"/><br/>
      <input type="radio" name="vnselector" id="NOVN" value="NOVN" onclick="setTypingMode(0);" class="noborder"/> <fmt:message key="mvnforum.common.vietnamese_type.not_use"/>
      <script type="text/javascript" language="JavaScript">
      //<![CDATA[
      initVNTyperMode();
      //]]>
      </script>
    </td>
  </tr>
<%}// end if vietnamese%>
  <tr class="portlet-section-footer">
    <td colspan="2" align="center">
    <input type="button" name="submitbutton" class="portlet-form-button" value="<fmt:message key="mvnforum.common.action.register"/>" onclick="javascript:SubmitForm();" />
    <input type="reset" value="<fmt:message key="mvnforum.common.action.reset"/>" class="liteoption" />
    </td>
  </tr>
</mvn:cssrows>
</table>
</form>

<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>
