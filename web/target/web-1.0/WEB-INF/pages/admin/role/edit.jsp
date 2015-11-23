<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="role.management"/></title>
    <meta name="heading" content="<fmt:message key="role.management"/>"/>
</head>
<div class="pathway">
   <c:choose>
       <c:when test="${not empty item.pojo.roleID}">
           <fmt:message key="role.edit"/>
       </c:when>
       <c:otherwise>
           <fmt:message key="role.add"/>
       </c:otherwise>
   </c:choose>
</div>
<c:url var="url" value="/admin/role/edit.html"/>
<c:url var="backUrl" value="/admin/role/list.html"/>

<div id="content">
    <form:form commandName="item" action="${url}" method="post" id="itemForm">
        <div class="box_container">
            <div class="header">
                <fmt:message key="role.management"/>
            </div>

            <div class="form">
                <table width="100%" cellpadding="5" cellspacing="5" border="0">
                    <tr>
                        <td><fmt:message key="role.role"/></td>
                        <td>
                            <form:input path="pojo.role" size="40"/>
                            <form:errors path="pojo.role" cssClass="validateError"/>
                        </td>

                    </tr>
                    <tr>
                        <td><fmt:message key="role.name"/></td>
                        <td>
                            <form:input path="pojo.name" size="40"/>
                            <form:errors path="pojo.name" cssClass="validateError"/>
                        </td>

                    </tr>
                    <tr>
                        <td><fmt:message key="role.description"/></td>
                        <td>
                            <form:input path="pojo.description" size="40"/>
                        </td>

                    </tr>

                    <tr>
                        <td></td>
                        <td>
                            <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                            <form:hidden path="pojo.roleID"/>
                            <input type="button" value="<fmt:message key="button.save"/>" onclick="$('#itemForm').submit();"/>
                            <input type="button" value="<fmt:message key="button.back"/>" onclick="document.location.href='${backUrl}';"/>

                        </td>
                    </tr>
                </table>
            </div>
            <c:if test="${not empty messageResponse}">
                <div style="text-align: left; color: red;">
                    <label>${messageResponse}</label>
                </div>
            </c:if>
        </div>
    </form:form>
</div>