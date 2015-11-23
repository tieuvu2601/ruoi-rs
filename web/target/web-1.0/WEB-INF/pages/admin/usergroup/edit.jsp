<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="usergroup.management"/></title>
    <meta name="heading" content="<fmt:message key="usergroup.management"/>"/>
</head>
<div class="pathway">
   <c:choose>
       <c:when test="${not empty item.pojo.userGroupID}">
           <fmt:message key="usergroup.edit"/>
       </c:when>
       <c:otherwise>
           <fmt:message key="usergroup.add"/>
       </c:otherwise>
   </c:choose>
</div>
<c:url var="url" value="/admin/usergroup/edit.html"/>
<c:url var="backUrl" value="/admin/usergroup/list.html"/>

<div id="content">
    <form:form commandName="item" action="${url}" method="post" id="itemForm">
        <div class="box_container">
            <div class="header">
                <fmt:message key="usergroup.management"/>
            </div>

            <div class="form">
                <table width="100%" cellpadding="5" cellspacing="5" border="0">
                    <tr>
                        <td><fmt:message key="usergroup.code"/></td>
                        <td>
                            <form:input path="pojo.code" size="40"/>
                            <form:errors path="pojo.code" cssClass="validateError"/>
                        </td>

                    </tr>
                    <tr>
                        <td><fmt:message key="usergroup.name"/></td>
                        <td>
                            <form:input path="pojo.name" size="40"/>
                            <form:errors path="pojo.name" cssClass="validateError"/>
                        </td>

                    </tr>
                    <tr>
                        <td><fmt:message key="usergroup.description"/></td>
                        <td>
                            <form:input path="pojo.description" size="40"/>
                        </td>

                    </tr>

                    <tr>
                        <td></td>
                        <td>
                            <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                            <form:hidden path="pojo.userGroupID"/>
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