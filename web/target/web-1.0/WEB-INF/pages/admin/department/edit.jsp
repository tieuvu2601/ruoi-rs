<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="department.management"/></title>
    <meta name="heading" content="Department Management"/>
</head>
<div class="pathway">
   <c:choose>
       <c:when test="${not empty item.pojo.departmentID}">
           <fmt:message key="department.edit"/>
       </c:when>
       <c:otherwise>
           <fmt:message key="department.add"/>
       </c:otherwise>
   </c:choose>
</div>
<c:url var="url" value="/admin/department/edit.html"/>
<c:url var="backUrl" value="/admin/department/list.html"/>

<div id="content">
    <form:form commandName="item" action="${url}" method="post" id="itemForm">
        <div class="box_container">
            <div class="header">
                <fmt:message key="department.management"/>
            </div>

            <div class="form">
                <table width="100%" cellpadding="5" cellspacing="5" border="0">
                    <tr>
                        <td width="15%"><fmt:message key="department.code"/></td>
                        <td>
                            <form:input path="pojo.code" size="40"/>
                            <form:errors path="pojo.code" cssClass="validateError"/>
                        </td>
                    </tr>
                    <tr>
                        <td width="15%">Organization Unit</td>
                        <td>
                            <form:input path="pojo.organizationUnit" size="40"/>
                            <form:errors path="pojo.organizationUnit" cssClass="validateError"/>
                        </td>
                    </tr>
                    <tr>
                        <td><fmt:message key="department.name"/></td>
                        <td>
                            <form:input path="pojo.name" size="40"/>
                            <form:errors path="pojo.name" cssClass="validateError"/>
                        </td>
                    </tr>
                    <tr>
                        <td><fmt:message key="department.isbranch"/></td>
                        <td>
                            <form:checkbox path="pojo.isBranch" value="1"/><fmt:message key="label.yes"/>
                            <form:errors path="pojo.isBranch" cssClass="validateError"/>
                        </td>
                    </tr>
                    <tr>
                        <td><fmt:message key="department.description"/></td>
                        <td>
                            <form:input path="pojo.description" size="40"/>
                            <form:errors path="pojo.description" cssClass="validateError"/>
                        </td>
                    </tr>

                    <tr>
                        <td></td>
                        <td>
                            <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                            <form:hidden path="pojo.departmentID"/>
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