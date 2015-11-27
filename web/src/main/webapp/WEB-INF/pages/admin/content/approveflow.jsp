<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="contentEntity.management"/></title>
    <meta name="heading" contentEntity="Content Management"/>
</head>
<div class="pathway">
    <fmt:message key="contentEntity.edit"/>
</div>
<c:url var="url" value="/admin/contentEntity/approveflow.html"/>
<c:url var="backUrl" value="/admin/contentEntity/list.html"/>

<div id="contentEntity">
    <form:form commandName="item" action="${url}" method="post" id="itemForm" enctype="multipart/form-data">
        <div class="box_container">
            <div class="header">
                <fmt:message key="contentEntity.management"/>
            </div>

            <div class="form">
                <table width="100%" cellpadding="0" cellspacing="0" border="0" class="table bright_blue_body">
                    <tr class="odd">
                        <td><fmt:message key="authoringtemplate.template"/></td>
                        <td>
                            <form:hidden path="pojo.authoringTemplateEntity"/>
                            ${authoringTemplateEntity.name}
                        </td>
                    </tr>
                    <tr class="even">
                        <td width="15%"><fmt:message key="contentEntity.title"/></td>
                        <td>
                            <form:input path="pojo.title" size="40" cssStyle="width: 98%;"/>
                            <form:errors path="pojo.title" cssClass="validateError"/>
                        </td>
                    </tr>
                    <tr class="odd">
                        <td valign="top"><fmt:message key="contentEntity.keyword"/></td>
                        <td>
                            <form:textarea path="pojo.keyword" rows="3" cssStyle="width:98%"/>
                            <form:errors path="pojo.keyword" cssClass="validateError"/>
                        </td>
                    </tr>
                    <tr class="even">
                        <td><fmt:message key="contentEntity.thumbnail"/></td>
                        <td>
                            <input type="file" name="thumbnailFile"/>
                        </td>
                    </tr>


                    <tr class="odd">
                        <td><fmt:message key="contentEntity.accesspolicy"/></td>
                        <td>
                            <form:radiobutton path="pojo.accessPolicy" value="1"/><fmt:message key="contentEntity.accesspolicy.allowshare"/>
                            <form:radiobutton path="pojo.accessPolicy" value="2"/><fmt:message key="contentEntity.accesspolicy.notallowshare"/>
                        </td>
                    </tr>
                    <tr class="even">
                        <td><fmt:message key="contentEntity.displayorder"/></td>
                        <td>
                            <form:input path="pojo.displayOrder" size="40"/>
                        </td>
                    </tr>
                    <tr class="odd">
                        <td><fmt:message key="contentEntity.hot"/></td>
                        <td>
                            <form:checkbox path="pojo.hot" value="1"/>
                        </td>
                    </tr>
                    <tr class="even">
                        <td><fmt:message key="contentEntity.categoryEntity"/></td>
                        <td>
                            <c:forEach items="${categories}" var="categoryEntity">
                                <input type="checkbox" name="categoryIDs" value="${categoryEntity.categoryID}" <c:if test="${not empty item.contentCategoryMap[categoryEntity.categoryID]}">checked</c:if>/>
                                ${categoryEntity.name}<br/>
                            </c:forEach>
                        </td>
                    </tr>
                    <tr class="odd">
                        <td colspan="2"><fmt:message key="contentEntity.authoringcontent"/></td>
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
                                        <td>${node.displayName} <c:if test="${minOccurs > 0}"><span class="required">*</span></c:if></td>
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
                                                        <input type="radio" name="${node.itemKey}" value="1" <c:if test="${itemValue == 1}">selected</c:if>/> <fmt:message key="boolean.true"/>
                                                        <input type="radio" name="${node.itemKey}" value="0" <c:if test="${itemValue == 0}">selected</c:if>/> <fmt:message key="boolean.false"/>
                                                    </c:when>
                                                    <c:when test="${node.itemType == 'NUMERIC'}">
                                                        <input type="text" name="${node.itemKey}" value="${itemValue}"/>
                                                    </c:when>
                                                    <c:when test="${node.itemType == 'PLAIN_TEXT'}">
                                                        <input type="text" name="${node.itemKey}" style="width:98%" value="${itemValue}"/>
                                                    </c:when>
                                                    <c:when test="${node.itemType == 'RICH_TEXT'}">
                                                    	<c:out value="${itemValue}" escapeXml="false"/>
                                                        <textarea cols="80" id="editor_${node.itemKey}" name="${node.itemKey}" rows="10">${itemValue}</textarea>
                                                    </c:when>
                                                    <c:when test="${node.itemType == 'IMAGE'}">
                                                        <input type="file" name="${node.itemKey}"/>
                                                        <c:if test="${not empty itemValue}">
                                                            <rep:href value="${itemValue}" var="imgURL"/>
                                                            <br/>
                                                            <img src="${imgURL}?w=100" width="100"/>
                                                        </c:if>

                                                    </c:when>
                                                    <c:when test="${node.itemType == 'ATTACHMENT'}">
                                                        <input type="file" name="${node.itemKey}"/>
                                                        <c:if test="${not empty itemValue}">
                                                            <rep:href value="${itemValue}"/>
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

                    <tr class="even">
                        <td></td>
                        <td>
                            <form:hidden path="crudaction" id="crudaction"/>
                            <form:hidden path="pojo.contentID"/>
                            <fmt:message key="contentEntity.approve" var="submitLabel"/>
                            <security:authorize ifAnyGranted="AUTHOR">
                            	<fmt:message key="button.send" var="submitLabel"/>
                            </security:authorize>
                            <input type="button" value="${submitLabel}" onclick="submitForm('approve');"/>
                            <security:authorize ifAnyGranted="APPROVER,EDITOR,PUBLISHER">
                            	<input type="button" value="<fmt:message key="contentEntity.reject"/>" onclick="submitForm('reject');"/>
                            </security:authorize>
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
<c:url var="prefixURL" value="/" />
<script type="text/javascript">
<c:forEach items="${item.contentItem.items.item}" var="node">
	<c:if test="${node.itemType == 'RICH_TEXT'}">
		CKEDITOR.replace( 'editor_${node.itemKey}',
	            {
	                filebrowserBrowseUrl :'${prefixURL}ckeditor/filemanager/browser/default/browser.html?Connector=${prefixURL}ckeditor/filemanager/connectors/php/connector.html?preventCache=' + new Date().getTime(),
	                filebrowserImageBrowseUrl : '${prefixURL}ckeditor/filemanager/browser/default/browser.html?Type=Image&Connector=${prefixURL}ckeditor/filemanager/connectors/php/connector.html?preventCache=' + new Date().getTime(),
	                filebrowserFlashBrowseUrl :'${prefixURL}ckeditor/filemanager/browser/default/browser.html?Type=Flash&Connector=${prefixURL}ckeditor/filemanager/connectors/php/connector.html?preventCache=' + new Date().getTime(),
				    filebrowserUploadUrl  :'${prefixURL}ckeditor/filemanager/connectors/php/upload.html?Type=File',
				    filebrowserImageUploadUrl : '${prefixURL}ckeditor/filemanager/connectors/php/upload.html?Type=Image',
				    filebrowserFlashUploadUrl : '${prefixURL}ckeditor/filemanager/connectors/php/upload.html?Type=Flash'
	
		});
	</c:if>
</c:forEach>
    function submitForm(stas){
        $('#crudaction').val(stas);
        $('#itemForm').submit();
    }
</script>