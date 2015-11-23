<%--
 - $Header: /cvsroot/mvnforum/mvnforum/srcweb/mvnplugin/mvnforum/user/forgotpassword.jsp,v 1.65 2008/06/13 09:23:21 phuongpdd Exp $
 - $Author: phuongpdd $
 - $Revision: 1.65 $
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

<%@ include file="inc_common.jsp"%>
<%@ include file="inc_doctype.jsp"%>
<fmt:bundle basename="mvnForum_i18n">
<mvn:html locale="${currentLocale}">
<mvn:head>
  <mvn:title><fmt:message key="mvnforum.common.forum.title_name"/> - <fmt:message key="mvnforum.user.forgotpassword.title"/></mvn:title>
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
  if (isBlank(document.submitform.MemberName, "<fmt:message key="mvnforum.common.member.login_name"/>")) return false;
  if (isBlank(document.submitform.MemberEmail, "<fmt:message key="mvnforum.common.member.email"/>")) return false;
  if (!isEmail(document.submitform.MemberEmail, "<fmt:message key="mvnforum.common.member.email"/>")) return false;
<%if (MVNForumConfig.getEnableCaptcha()) {%>
  if (isBlank(document.submitform.CaptchaResponse, "<fmt:message key="mvnforum.common.captcha.response"/>")) return false;
<%}// end if captcha%>
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
    <fmt:message key="mvnforum.user.forgotpassword.title"/>
    </td>
  </tr>
</table>
<br/>

<form action="<%=urlResolver.encodeURL(request, response, "forgotpasswordprocess", URLResolverService.ACTION_URL)%>" method="post" name="submitform">
<%=urlResolver.generateFormAction(request, response, "forgotpasswordprocess")%>
<table class="tborder" width="95%" cellspacing="0" cellpadding="3" align="center">
<mvn:cssrows>
  <tr class="portlet-section-header">
    <td colspan="2"><fmt:message key="mvnforum.user.forgotpassword.prompt"/>:</td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.common.member.login_name"/></td>
    <td><input type="text" name="MemberName" size="60" maxlength="30" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.common.member.email"/></td>
    <td><input type="text" name="MemberEmail" size="60" /></td>
  </tr>
<%if (MVNForumConfig.getEnableCaptcha()) {%>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.common.captcha.challenge"/></td>
    <td><img src="<%=urlResolver.encodeURL(request, response, "captchaimage?time="+System.currentTimeMillis())%>" alt="<fmt:message key="mvnforum.common.captcha.desc"/>" title="<fmt:message key="mvnforum.common.captcha.desc"/>" border="0" /></td>
  </tr>
  <tr class="<mvn:cssrow/>">
    <td><fmt:message key="mvnforum.common.captcha.response"/></td>
    <td><input type="text" size="60" name="CaptchaResponse" value="" /></td>
  </tr>
<%}// end if captcha%>
  <tr class="portlet-section-footer">
    <td colspan="2" align="center">
      <input name="submitbutton" type="button" value="<fmt:message key="mvnforum.user.forgotpassword.button.send_password"/>" onclick="javascript:SubmitForm();" class="portlet-form-button" />
    </td>
  </tr>
</mvn:cssrows>
</table>
</form>

<script language="JavaScript" type="text/javascript">
//<![CDATA[
    document.submitform.MemberName.focus();
//]]>
</script>

<br/>
<%@ include file="footer.jsp"%>
</mvn:body>
</mvn:html>
</fmt:bundle>
