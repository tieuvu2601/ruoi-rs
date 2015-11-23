<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="category.management"/></title>
    <meta name="heading" content="Category Management"/>
</head>
<div class="pathway">
   <c:choose>
       <c:when test="${not empty item.pojo.categoryID}">
           <fmt:message key="category.edit"/>
       </c:when>
       <c:otherwise>
           <fmt:message key="category.add"/>
       </c:otherwise>
   </c:choose>
</div>
<c:url var="url" value="/admin/category/edit.html"/>
<c:url var="backUrl" value="/admin/category/list.html"/>

<div id="content">
    <form:form commandName="item" action="${url}" method="post" id="itemForm">
        <div class="box_container">
            <div class="header">
                <fmt:message key="category.management"/>
            </div>

            <div class="form">
                <table width="100%" cellpadding="5" cellspacing="5" border="0">
                    <tr>
                        <td width="15%"><fmt:message key="category.code"/></td>
                        <td>
                            <form:input path="pojo.code" size="40"/>
                            <form:errors path="pojo.code" cssClass="validateError"/>
                        </td>

                    </tr>
                    <tr>
                        <td><fmt:message key="category.name"/></td>
                        <td>
                            <form:input path="pojo.name" size="40"/>
                            <form:errors path="pojo.name" cssClass="validateError"/>
                        </td>

                    </tr>
                    <tr>
                        <td valign="top"><fmt:message key="category.keyword"/></td>
                        <td>
                            <form:textarea path="pojo.keyword" rows="3" cssStyle="width:98%;"/>
                            <form:errors path="pojo.keyword" cssClass="validateError"/>
                        </td>

                    </tr>
                    <tr>
                        <td valign="top"><fmt:message key="category.description"/></td>
                        <td>
                            <form:textarea path="pojo.description" rows="5" cssStyle="width:98%;"/>
                            <form:errors path="pojo.description" cssClass="validateError"/>
                        </td>
                    </tr>
                    <tr>
                        <td><fmt:message key="category.displayorder"/></td>
                        <td>
                            <form:input path="pojo.displayOrder" size="20"/>
                            <form:errors path="pojo.displayOrder" cssClass="validateError"/>
                        </td>
                    </tr>
                    <tr>
                        <td  valign="top"><fmt:message key="category.authoringtemplate"/></td>
              	        <td>
                            <c:forEach items="${authoringtemplates}" var="aut">
                                <input type="radio" name="pojo.authoringTemplate" value="${aut.authoringTemplateID}" <c:if test="${aut.authoringTemplateID == item.pojo.authoringTemplate.authoringTemplateID}">checked</c:if> />${aut.name}<br/>
                            </c:forEach>
                            <form:errors path="pojo.authoringTemplate" cssClass="validateError"/>
              	        </td>
                    </tr>
                    <tr>
                        <td valign="top"><fmt:message key="category.renderingtemplate"/></td>
              	        <td>
                              <c:forEach items="${renderingtemplates}" var="cnt">
                                  <input type="radio" name="pojo.renderingTemplate" value="${cnt.renderingTemplateID}" <c:if test="${cnt.renderingTemplateID == item.pojo.renderingTemplate.renderingTemplateID}">checked</c:if> />${cnt.name}<br/>
                             </c:forEach>

                            <form:errors path="pojo.renderingTemplate" cssClass="validateError"/>
              	        </td>
                    </tr>

                    <tr>
                        <td></td>
                        <td>
                            <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                            <form:hidden path="pojo.categoryID"/>
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