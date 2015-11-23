<%@page trimDirectiveWhitespaces="true"%>
<%@ include file="/common/taglibs.jsp"%>
<head>
    <title><fmt:message key="login.title"/></title>
</head>
<div id="content">
    <div>
         <div class="loginBox">
             <div style="margin:30px 50px;">
                 <form name="loginForm" action="<c:url value="/j_security_check"/>" method="post">
                 <table width="450px" cellpadding="5" cellspacing="5" border="0">
                     <tr>
                         <td colspan="2">Nhập tên đăng nhập và mật khẩu để đăng nhập vào hệ thống</td>

                     </tr>
                     <tr>
                         <td>Tên đăng nhập</td>
                         <td><input type="text" name="j_username"/></td>
                     </tr>
                     <tr>
                         <td>Mật khẩu</td>
                         <td><input type="password" name="j_password"/></td>
                     </tr>
                     <tr>
                         <td></td>
                         <td>
                             <input type="submit" name="buttonLogin" value="Đăng nhập"/>
                         </td>
                     </tr>
                     <c:if test="${not empty param.error}">
                     <tr>
                         <td colspan="2" style="color:red;">
                             <c:choose>
                                 <c:when test="${param.error == 1}">
                                     Tên đăng nhập và mật khẩu không đúng. Xin vui lòng thử lại.
                                 </c:when>
                                 <c:when test="${param.error == 2}">
                                     Phiên làm việc của bạn đã kết thúc. Xin vui lòng đăng nhập lại để tiếp tục.
                                 </c:when>
                             </c:choose>
                         </td>
                     </tr>
                     </c:if>
                 </table>
                 </form>
             </div>
         </div>
    </div>
</div>