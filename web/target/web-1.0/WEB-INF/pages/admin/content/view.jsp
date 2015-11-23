<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="content.management"/></title>
    <meta name="heading" content="Content Management"/>
    <link rel="stylesheet" type="text/css" href="<c:url value='/swfupload/default.css'/>" />
	<script type="text/javascript" src="<c:url value='/swfupload/swfupload.js' />"></script>
	<script type="text/javascript" src="<c:url value='/swfupload/fileprogress.js' />"></script>
	<script type="text/javascript" src="<c:url value='/swfupload/handlers.js' />"></script>
	
</head>
<div class="pathway">
    <fmt:message key="content.edit"/>
</div>
<c:url var="url" value="/admin/content/view.html"/>
<c:url var="backUrl" value="/admin/content/list.html"/>

<div id="content">
<c:if test="${empty ITEM_NOT_FOUND }">
    <form:form commandName="item" action="${url}" method="post" id="itemForm">
        <div class="box_container">
            <div class="header">
                <fmt:message key="content"/>
            </div>
            <div class="form">
                <table width="100%" cellpadding="0" cellspacing="0" border="0" class="table bright_blue_body">
                    <tr class="odd">
                        <td><fmt:message key="authoringtemplate.template"/></td>
                        <td>
                            <form:hidden path="pojo.authoringTemplate"/>
                            ${item.pojo.authoringTemplate.name}
                        </td>
                    </tr>
                    <tr class="even">
                        <td width="15%"><fmt:message key="content.title"/></td>
                        <td>${item.pojo.title }</td>
                    </tr>
                    <tr class="odd">
                        <td valign="top"><fmt:message key="content.keyword"/></td>
                        <td>${item.pojo.keyword }</td>
                    </tr>
                    <c:if test="${authoring.hasThumbnail == 'Y'}">
                    <tr class="even">
                        <td><fmt:message key="content.thumbnail"/></td>
                        <td>
                        	<rep:href value="${item.pojo.thumbnail}" var="imgURL"/>
                            <img src="<c:url value="${imgURL }"/>?w=100&h=120" />
                        </td>
                    </tr>
                    </c:if>

                    <tr class="odd">
                        <td><fmt:message key="content.accesspolicy"/></td>
                        <td>
                        	<c:if test="${item.pojo.accessPolicy eq 1 }"><fmt:message key="content.accesspolicy.allowshare"/></c:if>
                        	<c:if test="${item.pojo.accessPolicy eq 2 }"><fmt:message key="content.accesspolicy.notallowshare"/></c:if>
                        </td>
                    </tr>
                    <tr class="even">
                        <td><fmt:message key="content.displayorder"/></td>
                        <td>${item.pojo.displayOrder }</td>
                    </tr>
                    <c:if test="${authoring.hasHotItem == 'Y'}">
                    <tr class="odd">
                        <td><fmt:message key="content.hot"/></td>
                        <td>
                            <c:choose>
                            	<c:when test="${item.pojo.hot eq 1}"><fmt:message key="boolean.true"/></c:when>
                            	<c:otherwise><fmt:message key="boolean.false"/></c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    </c:if>
                    <tr class="even">
                        <td><fmt:message key="content.category"/></td>
                        <td>
                        	<ul>
	                            <c:forEach items="${categories}" var="category">
	                                <li>${category.name}</li>
	                            </c:forEach>
                            </ul>
                        </td>
                    </tr>
                    <tr class="odd">
                        <td colspan="2"><fmt:message key="content.authoringcontent"/></td>
                    </tr>
                    <tr class="even">
                        <td colspan="2">
                            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                <c:forEach items="${item.contentItem.items.item}" var="node">
                                    <c:set var="minOccurs" value="${node.minOccurs}"/>
                                    <c:set var="maxOccurs" value="${node.maxOccurs}"/>
                                    <c:if test="${empty maxOccurs}">
                                        <c:set var="maxOccurs" value="5"/>
                                    </c:if>
                                    <tr>
                                        <td><b>${node.displayName}</b>:</td>
                                    </tr>
                                    <tr>
                                        <td>
	                                            <c:forEach begin="1" end="${maxOccurs}" step="1" varStatus="statusIndex">
	                                                <c:set var="itemValue" value=""/>
	                                                <c:if test="${statusIndex.index <= fn:length(node.itemValue)}">
	                                                    <c:set var="itemValue" value="${node.itemValue[statusIndex.index - 1]}"/>
	                                                </c:if>
	                                                <c:choose>
	                                                    <c:when test="${node.itemType == 'BOOLEAN'}">
	                                                        <c:if test="${itemValue == 1}"><fmt:message key="boolean.true"/></c:if> 
	                                                        <c:if test="${itemValue == 0}"><fmt:message key="boolean.false"/></c:if>
	                                                    </c:when>
	                                                    <c:when test="${node.itemType == 'NUMERIC'}">
	                                                        ${itemValue}/><br/>
	                                                    </c:when>
	                                                    <c:when test="${node.itemType == 'PLAIN_TEXT'}">
	                                                        ${itemValue}<br/>
	                                                    </c:when>
	                                                    <c:when test="${node.itemType == 'RICH_TEXT'}">
	                                                        ${itemValue}
	                                                    </c:when>
	                                                    <c:when test="${node.itemType == 'IMAGE'}">
	                                                        <c:if test="${not empty itemValue}">
	                                                            <rep:href value="${itemValue}" var="imgURL"/>
	                                                            <br/>
	                                                             <div id="i_${node.itemKey }${statusIndex.index}"><img src="<c:url value="${imgURL}?w=100"/>" width="100" />&nbsp;</div>
	                                                        </c:if>
	
	                                                    </c:when>
	                                                    <c:when test="${node.itemType == 'ATTACHMENT'}">
	                                                        <c:if test="${not empty itemValue}">
	                                                            <div id="i_${node.itemKey }${statusIndex.index}"><rep:href value='${itemValue}' />&nbsp;</div>
	                                                        </c:if>
	                                                    </c:when>
	                                                </c:choose>
	                                            </c:forEach>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </table>

                        </td>
                    </tr>
                </table>
            </div>
        </div>
        
        <c:if test="${!empty listSms }">
        	<div class="pathway"><fmt:message key="content.sms.relation"/></div>
	        <div class="box_container" style="margin-top:10px;">
	            <div class="form">
	                <table width="100%" cellpadding="0" cellspacing="0" border="0" class="table bright_blue_body">
	                	<tr>
	                		<td class="table_header" width="30%"><fmt:message key="user.mobile"/></td>
	                		<td class="table_header">Nội dung</td>
                            <td class="table_header"><fmt:message key="user.status"/></td>
	                		<td class="table_header" width="30%"><fmt:message key="createdDate"/></td>
	                	</tr>
	                	<c:forEach items="${listSms }" var="sms" varStatus="count">
	                		<c:set var="css" value="${count.index / 2 eq 0 ? 'odd' : 'even'}"/>
		                    <tr class="${css }">
		                    	<td>${sms.mobileNumber }</td>
		                    	<td>
                                    ${sms.smsContent}
		                    	</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${sms.status == 1}">
                                            Đã gửi
                                        </c:when>
                                        <c:otherwise>
                                            Chưa gửi
                                        </c:otherwise>
                                    </c:choose>
                                </td>
		                    	<td>
		                    		<fmt:formatDate value="${sms.createdDate }" pattern="dd/MM/yyyy HH:mm:ss"/>
		                    	</td>
		                    </tr>
	                    </c:forEach>
	                </table>
				</div>
        	</div>
        </c:if>
        
        <c:if test="${not empty messageResponse}">
            <div style="text-align: left; color: red;margin:10px;">
                <label>${messageResponse}</label>
            </div>
        </c:if>
        
        <div style="margin-top:10px;">
        	<table width="100%"><tr><td>
        		<form:hidden path="crudaction" id="crudaction"/>
					<form:hidden path="pojo.contentID"/>
					
					<c:if test="${!empty canApprove and canApprove eq true }">
						<security:authorize ifNotGranted="PUBLISHER,AUTHOR">
							<input type="button" value="<fmt:message key="content.approve"/>" onclick="submitContentForm('accept');"/>
						</security:authorize>
						<security:authorize ifAllGranted="AUTHOR">
							<input type="button" value="<fmt:message key="button.send"/>" onclick="submitContentForm('approve');"/>
						</security:authorize>
						
						<c:if test="${item.pojo.createdBy.userID != currentUserID }">
							<input type="button" value="<fmt:message key="content.reject"/>" onclick="submitContentForm('reject');"/>
						</c:if>
						
					</c:if>
					<input type="button" value="<fmt:message key="button.back"/>" onclick="document.location.href='${backUrl}';"/>
        	</td></tr></table>
        </div>
        
    </form:form>
</c:if>
<c:if test="${!empty ITEM_NOT_FOUND }">
	<div style="margin: 100px; text-align: center; font-size: 30px;">${ITEM_NOT_FOUND}</div>
	<div><input type="button" value="<fmt:message key="button.back"/>" onclick="document.location.href='${backUrl}';"/></div>
</c:if>
</div>
<script type='text/javascript'>
function submitContentForm(crudaction) {
	$('#crudaction').val(crudaction);
	$('#itemForm').submit();
}
</script>