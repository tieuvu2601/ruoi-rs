<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="renderingtemplate.management"/></title>
    <meta name="heading" content="Rendering Template Management"/>
</head>
<div class="pathway">
   <c:choose>
       <c:when test="${not empty item.pojo.renderingTemplateID}">
           <fmt:message key="renderingtemplate.edit"/>
       </c:when>
       <c:otherwise>
           <fmt:message key="renderingtemplate.add"/>
       </c:otherwise>
   </c:choose>
</div>
<c:url var="url" value="/admin/renderingtemplate/edit.html"/>
<c:url var="backUrl" value="/admin/renderingtemplate/list.html"/>

<div id="content">
    <form:form commandName="item" action="${url}" method="post" id="itemForm" enctype="multipart/form-data">
        <div class="box_container">
            <div class="header">
                <fmt:message key="renderingtemplate.management"/>
            </div>

            <div class="form">
                <table width="100%" cellpadding="0" cellspacing="0" border="0" class="table bright_blue_body">
                    <tr class="odd">
                        <td width="15%"><fmt:message key="renderingtemplate.code"/></td>
                        <td>
                            <form:input path="pojo.code" size="40"/>
                            <form:errors path="pojo.code" cssClass="validateError"/>
                        </td>
                    </tr>
                    <tr class="even">
                        <td><fmt:message key="renderingtemplate.name"/></td>
                        <td>
                            <form:input path="pojo.name" size="40"/>
                            <form:errors path="pojo.name" cssClass="validateError"/>
                        </td>
                    </tr>
                    <tr class="odd" >
                        <td colspan="2"><fmt:message key="renderingtemplate.template"/></td>
                    </tr>
                    <tr class="even">
                        <td colspan="2">
                            <form:textarea path="pojo.templateContent" rows="10" cssStyle="width:100%;height: 500px;"></form:textarea>
                            <form:errors path="pojo.templateContent" cssClass="validateError"/>
                        </td>
                    </tr>

                    <tr class="odd">
                        <td></td>
                        <td>
                            <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                            <form:hidden path="pojo.renderingTemplateID"/>
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