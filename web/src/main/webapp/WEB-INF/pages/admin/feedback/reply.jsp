<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="feedbackcategory.management"/></title>
    <meta name="heading" content="Feedback Category Management"/>
</head>
<div class="pathway">
   <c:choose>
       <c:when test="${1 == 1}">
           <fmt:message key="feedbackreply.edit"/>
       </c:when>
       <c:otherwise>
           <fmt:message key="feedbackreply.add"/>
       </c:otherwise>
   </c:choose>
</div>
<c:url var="url" value="/admin/feedback/edit.html"/>
<c:url var="backUrl" value="/admin/feedback/list.html"/>
<c:url var="replyUrl" value="/admin/feedback/reply.html"/>

<div id="content">
    <form:form commandName="item" action="${replyUrl}" method="post" id="itemForm">
        <div class="box_container">
            <div class="header">
                <fmt:message key="feedbackcategory.management"/>
            </div>

            <div class="form">
                <table width="100%" cellpadding="5" cellspacing="5" border="0">
                    <tr>
                        <td valign="top"><fmt:message key="feedback.content"/></td>
                        <td>
                            <form:textarea path="feedback.content" readonly="true" rows="5" cssStyle="width:98%;"/>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="box_container" >
                <display:table name="item.listResult" cellspacing="0" cellpadding="0" requestURI="${url}"
                               partialList="true" sort="external" size="${item.totalItems}" defaultsort="2" uid="tableList" pagesize="${item.maxPageItems}" class="table bright_blue_body" export="false" excludedParams="crudaction">
                    <display:column headerClass="table_header"  escapeXml="false" sortable="true" titleKey="feedbackreply.content" style="width: 15%" >
                        <a href="${editUrl}?pojo.feedbackReplyID=${tableList.feedbackReplyID}">${tableList.content}</a>
                    </display:column>
                    <display:column headerClass="table_header" property="createdBy.username"  escapeXml="false" sortable="true" sortName="createdBy.username" titleKey="feedback.username" style="width: 15%" />
                    <display:column headerClass="table_header" escapeXml="false" sortable="true" sortName="createdDate" titleKey="feedback.createdDate" style="width: 15%" >
                        <fmt:formatDate pattern="dd-MM-yyyy" value="${tableList.createdDate}"></fmt:formatDate>
                    </display:column>

                    <display:setProperty name="paging.banner.item_name"><fmt:message key="feedbackreply"/></display:setProperty>
                    <display:setProperty name="paging.banner.items_name"><fmt:message key="feedbackreply"/></display:setProperty>
                    <display:setProperty name="paging.banner.placement" value="bottom"/>
                    <display:setProperty name="paging.banner.no_items_found" value=""/>
                    <display:setProperty name="paging.banner.onepage" value=""/>
                </display:table>
                <div class="clear"></div>
            </div>

            <div class="form">
                <table width="100%" cellpadding="5" cellspacing="5" border="0">
                    <tr>
                        <td valign="top"><fmt:message key="feedback.content"/></td>
                        <td>
                            <form:textarea path="pojo.content" rows="5" cssStyle="width:98%;"/>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <form:hidden path="crudaction" id="crudaction" value="reply"/>
                            <form:hidden path="feedback.feedbackID" id="feedbackID" value="${feedback.feedbackID}"/>
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