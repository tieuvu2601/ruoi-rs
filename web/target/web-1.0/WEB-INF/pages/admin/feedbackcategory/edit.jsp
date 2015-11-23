<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="feedbackcategory.management"/></title>
    <meta name="heading" content="Feedback Category Management"/>
</head>
<div class="pathway">
   <c:choose>
       <c:when test="${not empty item.pojo.feedbackCategoryID}">
           <fmt:message key="feedbackcategory.edit"/>
       </c:when>
       <c:otherwise>
           <fmt:message key="feedbackcategory.add"/>
       </c:otherwise>
   </c:choose>
</div>
<c:url var="url" value="/admin/feedbackcategory/edit.html"/>
<c:url var="backUrl" value="/admin/feedbackcategory/list.html"/>

<div id="content">
    <form:form commandName="item" action="${url}" method="post" id="itemForm">
        <div class="box_container">
            <div class="header">
                <fmt:message key="feedbackcategory.management"/>
            </div>

            <div class="form">
                <table width="100%" cellpadding="5" cellspacing="5" border="0">
                    <tr>
                        <td><fmt:message key="feedbackcategory.name"/></td>
                        <td>
                            <form:input path="pojo.name" size="40"/>
                            <form:errors path="pojo.name" cssClass="validateError"/>
                        </td>

                    </tr>
                    <tr>
                        <td valign="top"><fmt:message key="feedbackcategory.description"/></td>
                        <td>
                            <form:textarea path="pojo.description" rows="5" cssStyle="width:98%;"/>
                            <form:errors path="pojo.description" cssClass="validateError"/>
                        </td>
                    </tr>

                    <tr>
                        <td></td>
                        <td>
                            <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                            <form:hidden path="pojo.feedbackCategoryID"/>
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