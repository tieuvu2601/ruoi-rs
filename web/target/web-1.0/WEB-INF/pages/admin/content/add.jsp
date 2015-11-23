<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="content.management"/></title>
    <meta name="heading" content="Content Management"/>
</head>
<div class="pathway">
   <c:choose>
       <c:when test="${not empty item.pojo.contentID}">
           <fmt:message key="content.edit"/>
       </c:when>
       <c:otherwise>
           <fmt:message key="content.add"/>
       </c:otherwise>
   </c:choose>
</div>
<c:url var="url" value="/admin/content/add.html"/>
<c:url var="backUrl" value="/admin/content/list.html"/>

<div id="content">
    <form:form commandName="item" action="${url}" method="post" id="itemForm">
        <div class="box_container">
            <div class="header">
                <fmt:message key="content.management"/>
            </div>

            <div class="form">
                <table width="100%" cellpadding="5" cellspacing="5" border="0">
                    <tr>
                        <td><fmt:message key="authoringtemplate.template"/></td>
                        <td>
                            <form:select path="pojo.authoringTemplate">
                                <form:options items="${authoringTemplates}" itemLabel="name" itemValue="authoringTemplateID"/>
                            </form:select>
                        </td>
                    </tr>

                    <tr>
                        <td></td>
                        <td>
                            <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                            <input type="button" value="<fmt:message key="button.next"/>" onclick="$('#itemForm').submit();"/>
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