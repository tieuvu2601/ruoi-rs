<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="page.management"/></title>
    <meta name="heading" contentEntity="<fmt:message key="page.management"/>"/>
</head>
<div class="pathway">
   <c:choose>
       <c:when test="${not empty item.pojo.pageID}">
           <fmt:message key="page.edit"/>
       </c:when>
       <c:otherwise>
           <fmt:message key="page.add"/>
       </c:otherwise>
   </c:choose>
</div>
<c:url var="url" value="/admin/page/edit.html"/>
<c:url var="backUrl" value="/admin/page/list.html"/>

<div id="contentEntity">
    <form:form commandName="item" action="${url}" method="post" id="itemForm">
        <div class="box_container">
            <div class="header">
                <fmt:message key="page.management"/>
            </div>

            <div class="form">
                <table width="100%" cellpadding="5" cellspacing="5" border="0">
                    <tr>
                        <td width="15%"><fmt:message key="page.code"/></td>
                        <td>
                            <form:input path="pojo.code" size="40"/>
                            <form:errors path="pojo.code" cssClass="validateError"/>
                        </td>

                    </tr>
                    <tr>
                        <td><fmt:message key="page.title"/></td>
                        <td>
                            <form:input path="pojo.title" cssStyle="width:98%;"/>
                            <form:errors path="pojo.title" cssClass="validateError"/>
                        </td>

                    </tr>
                    <tr>
                        <td valign="top"><fmt:message key="page.keyword"/></td>
                        <td>
                            <form:textarea path="pojo.keyword" rows="3" cssStyle="width:98%;"/>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <form:hidden path="crudaction" id="crudaction" value="insert-update"/>
                            <form:hidden path="pojo.pageID"/>
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
        <div class="box_container">
            <div class="header">
                <fmt:message key="page.management"/>
            </div>

            <div class="form">
                <table width="100%" cellpadding="5" cellspacing="5" border="0">
                    <tr>
                        <td width="15%"><fmt:message key="page.layout"/></td>
                        <td>
                            <form:radiobutton path="layout" value="onecolumn"/> <fmt:message key="page.layout.onecolumn"/>
                            <form:radiobutton path="layout" value="twocolumn"/> <fmt:message key="page.layout.twocolumn"/>
                            <form:radiobutton path="layout" value="threecolumn"/> <fmt:message key="page.layout.threecolumn"/>
                            <form:errors path="layout" cssClass="validateError"/>
                        </td>

                    </tr>
                    <tr>
                        <td width="15%"><fmt:message key="page.theme"/></td>
                        <td>
                            <form:select path="theme">
                                <form:option value="vms">VMS</form:option>
                            </form:select>
                            <form:errors path="theme" cssClass="validateError"/>
                        </td>

                    </tr>
                   <tr>
                       <td colspan="2"><fmt:message key="page.xml"/></td>
                   </tr>
                   <tr>
                       <td colspan="2">
                           <form:textarea path="pojo.xmlData" rows="5" cssStyle="width:100%;height:300px;"></form:textarea>
                       </td>
                   </tr>
                    <tr>
                        <td colspan="2">
                            <div class="designer_container">

                            </div>
                        </td>
                    </tr>
                </table>
            </div>

        </div>
    </form:form>
</div>