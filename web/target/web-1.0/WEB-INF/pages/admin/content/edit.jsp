<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="content.management"/></title>
    <meta name="heading" content="Content Management"/>
    <link rel="stylesheet" type="text/css" href="<c:url value='/swfupload/default.css'/>" />
	<script type="text/javascript" src="<c:url value='/swfupload/swfupload.js' />"></script>
	<script type="text/javascript" src="<c:url value='/swfupload/fileprogress.js' />"></script>
	<script type="text/javascript" src="<c:url value='/swfupload/handlers.js' />"></script>
	<script type="text/javascript" src="<c:url value='/scripts/flash_detect_min.js' />"></script>
	<script type="text/javascript">
	<c:forEach items="${item.contentItem.items.item}" var="node">
	<c:if test="${node.itemType == 'IMAGE' or node.itemType == 'ATTACHMENT'}">
		var swfu_${node.itemKey};
	</c:if>
</c:forEach>
window.onload = function() {
	<c:forEach items="${item.contentItem.items.item}" var="node">
		<c:if test="${node.itemType == 'IMAGE' or node.itemType == 'ATTACHMENT'}">
			var settings${node.itemKey} = {
					flash_url : "<c:url value='/swfupload/swfupload.swf'/>",
					upload_url: "<c:url value='/ajax/content/uploadfile.html;jsessionid=${pageContext.session.id}'/>",
					post_params: {'nodename' : '${node.itemKey}', 'contentID': '${item.pojo.contentID}'},
					file_size_limit : "10 MB",
					file_types : "*.*",
					file_types_description : "All Files",
					file_upload_limit : ${node.maxOccurs},
					file_queue_limit : 0,
					custom_settings : {
						progressTarget : "fsUploadProgress_${node.itemKey }",
						cancelButtonId : "btnCancel"
					},
					debug: false,

					// Button settings
					button_image_url: "<c:url value='/swfupload/TestImageNoText_65x29.png'/>",
					button_width: "55",
					button_height: "29",
					button_placeholder_id: "spanButtonPlaceHolder_${node.itemKey}",
					button_text: 'Browse...',
					button_text_style: ".theFont { font-size: 22; }",
					button_text_left_padding: 2,
					button_text_top_padding: 3,
					
					// The event handler functions are defined in handlers.js
					file_queued_handler : fileQueued,
					file_queue_error_handler : fileQueueError,
					upload_start_handler : uploadStart,
					upload_progress_handler : uploadProgress,
					upload_error_handler : uploadError,
					upload_success_handler : uploadSuccess,
					upload_complete_handler : uploadComplete
				};
			swfu_${node.itemKey} = new SWFUpload(settings${node.itemKey});
	 	</c:if>
	</c:forEach>
	
  };

</script>
</head>
<div class="pathway">
    <fmt:message key="content.edit"/>
</div>
<c:url var="url" value="/admin/content/edit.html"/>
<c:url var="backUrl" value="/admin/content/list.html"/>

<div id="content">
    <form:form commandName="item" action="${url}" method="post" id="itemForm" enctype="multipart/form-data">
        <div class="box_container">
            <div class="header">
                <fmt:message key="content.management"/>
            </div>

            <div class="form">
                <table width="100%" cellpadding="0" cellspacing="0" border="0" class="table bright_blue_body">
                    <tr class="odd">
                        <td><fmt:message key="authoringtemplate.template"/></td>
                        <td>
                            <form:hidden path="pojo.authoringTemplate"/>
                            ${authoringTemplate.name}
                        </td>
                    </tr>
                    <tr class="even">
                        <td width="15%"><fmt:message key="content.title"/></td>
                        <td>
                            <form:input path="pojo.title" size="40" maxlength="160" cssStyle="width: 98%;" id="title"/>
                            <form:errors path="pojo.title" cssClass="validateError"/>
                        </td>
                    </tr>
                    <tr class="odd">
                        <td valign="top"><fmt:message key="content.keyword"/></td>
                        <td>
                            <form:textarea path="pojo.keyword" rows="3" cssStyle="width:98%" id="keyword"/>
                            <form:errors path="pojo.keyword" cssClass="validateError"/>
                        </td>
                    </tr>
                    <c:if test="${authoringTemplate.hasThumbnail == 'Y'}">
                    <tr class="even">
                        <td><fmt:message key="content.thumbnail"/></td>
                        <td>
                            <input type="file" name="thumbnailFile"/><i>(Kích thước chuẩn 410 x 390)</i>
                        </td>
                    </tr>
                    </c:if>

                    <tr class="odd">
                        <td><fmt:message key="content.accesspolicy"/></td>
                        <td>
                            <form:radiobutton path="pojo.accessPolicy" value="1"/><fmt:message key="content.accesspolicy.allowshare"/>
                            <form:radiobutton path="pojo.accessPolicy" value="2"/><fmt:message key="content.accesspolicy.notallowshare"/>
                        </td>
                    </tr>
                    <tr class="even">
                        <td><fmt:message key="content.displayorder"/></td>
                        <td>
                            <form:input path="pojo.displayOrder" size="40"/>
                        </td>
                    </tr>
                    <security:authorize ifAllGranted="FULL_ACCESS_RIGHT">
                        <tr class="even">
                            <td><fmt:message key="content.status"/></td>
                            <td>
                                <form:checkbox path="pojo.status" value="1"/>
                            </td>
                        </tr>
                    </security:authorize>
                    <security:authorize ifAllGranted="PUBLISHER">
                    <c:if test="${authoringTemplate.hasHotItem == 'Y'}">
                    <tr class="odd">
                        <td><fmt:message key="content.hot"/></td>
                        <td>
                            <form:checkbox path="pojo.hot" value="1"/>
                        </td>
                    </tr>
                    </c:if>
                    </security:authorize>
                    <c:if test="${authoringTemplate.hasDepartment == 'Y'}">
                    <c:if test="${fn:length(departments) > 0}">
                    <tr class="odd">
                        <td><fmt:message key="content.department"/></td>
                        <td>
                            <c:forEach items="${departments}" var="department">
                                <input type="checkbox" name="departmentIDs" value="${department.departmentID}" <c:if test="${not empty item.contentDepartmentMap[department.departmentID]}">checked</c:if>/>
                                ${department.name}<br/>
                            </c:forEach>
                        </td>
                    </tr>
                    </c:if>
                    </c:if>
                    <tr class="even">
                        <td><fmt:message key="content.category"/></td>
                        <td>
                            <c:forEach items="${categories}" var="category">
                                <input type="checkbox" name="categoryIDs" value="${category.categoryID}" <c:if test="${not empty item.contentCategoryMap[category.categoryID]}">checked</c:if>/>
                                ${category.name}<br/>
                            </c:forEach>
                        </td>
                    </tr>
                    <tr class="odd">
                        <td colspan="2"><fmt:message key="content.authoringcontent"/></td>
                    </tr>
                    <tr class="even">
                        <td colspan="2">
                            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                            	<% pageContext.setAttribute("newLineChar", "\n"); %> 
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
	                                            <c:if test="${node.itemType == 'IMAGE' or node.itemType == 'ATTACHMENT'}">
	                                            	<div><span id="spanButtonPlaceHolder_${node.itemKey }"></span></div>
	                                                 <div class="fieldset flash" id="fsUploadProgress_${node.itemKey }">
	                                                 	<span class="legend">Files</span>
	                                                 </div>
	                                             </c:if>
	                                             <c:set value="" var="constraintValues"/>
	                                             <c:forEach items="${authoringTemplateNodes}" var="aNode">
	                                             	<c:if test="${ node.itemKey eq aNode.name}">
	                                             		<c:set value="${aNode.constraintValues }" var="constraintValues"/>
	                                             	</c:if>
	                                             </c:forEach>
	                                             
	                                             <c:if test="${not empty  constraintValues && fn:length(constraintValues) > 0}">
	                                             		<c:set value="${fn:replace(constraintValues, newLineChar, ';')}" var="constraintValues"/>
	                                             		<c:set value="${fn:split(constraintValues,';') }" var="constraintValues"/>
                                             	</c:if>
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
	                                                        <c:choose>
                                                                 <c:when test="${not empty constraintValues && fn:length(constraintValues) > 0}">
	                                                                 <select name="${node.itemKey}">
                                                                         <c:if test="${not empty constraintValues}">
                                                                             <c:forEach items="${constraintValues}" var="c">
                                                                                 <c:if test="${not empty c}">
                                                                                 <option value="${c}" <c:if test="${c == itemValue}">selected</c:if>>${c}</option>
                                                                                 </c:if>
                                                                             </c:forEach>
                                                                         </c:if>
	                                                                 </select>
                                                                 </c:when>
                                                                 <c:otherwise>
                                                                     <input type="text" name="${node.itemKey}" value="${itemValue}"/>
                                                                 </c:otherwise>
                                                             </c:choose>
	                                                    </c:when>
	                                                    <c:when test="${node.itemType == 'PLAIN_TEXT'}">
	                                                        <c:choose>
                                                                <c:when test="${not empty constraintValues && fn:length(constraintValues) > 0}">
                                                                <select name="${node.itemKey}">
                                                                    <c:forEach items="${constraintValues}" var="c">
                                                                        <c:if test="${not empty c}">
                                                                        <option value="${c}" <c:if test="${c eq itemValue}">selected</c:if>>${c}</option>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </select>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <input type="text" name="${node.itemKey}" style="width:98%" value="${itemValue}"/>
                                                                </c:otherwise>
                                                            </c:choose>
	                                                    </c:when>
	                                                    <c:when test="${node.itemType == 'RICH_TEXT'}">
	                                                        <textarea cols="80" id="editor_${node.itemKey}" name="${node.itemKey}" rows="10">${itemValue}</textarea>
	                                                    </c:when>
	                                                    <c:when test="${node.itemType == 'IMAGE'}">
	                                                        <c:if test="${not empty itemValue}">
	                                                            <rep:href value="${itemValue}" var="imgURL"/>
	                                                            <br/>
	                                                             <div id="i_${node.itemKey }${statusIndex.index}"><img src="<c:url value="${imgURL}?w=100"/>" width="100" />&nbsp;<a onclick="deleteAttachmentItem('${node.itemKey }${statusIndex.index}')"><img style="margin-bottom:30px; cursor: pointer;" src="<c:url value='/swfupload/delete.png'/>" alt="Delete item"></a></div>
	                                                             <input type="hidden" name="oldNodeAttachementValues[${node.itemKey }]" value="${itemValue }" id="${node.itemKey }${statusIndex.index}">
	                                                        </c:if>
	
	                                                    </c:when>
	                                                    <c:when test="${node.itemType == 'ATTACHMENT'}">
	                                                        <c:if test="${not empty itemValue}">
	                                                            <div id="i_${node.itemKey }${statusIndex.index}"><rep:href value='${itemValue}' />&nbsp;<a onclick="deleteAttachmentItem('${node.itemKey }${statusIndex.index}')"><img src="<c:url value='/swfupload/delete.png'/>" alt="Delete item"></a></div>
	                                                            <input type="hidden" name="oldNodeAttachementValues[${node.itemKey }]" value="${itemValue }" id="${node.itemKey }${statusIndex.index}">
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
                            <security:authorize ifNotGranted="FULL_ACCESS_RIGHT">
                                <form:hidden path="pojo.status"/>
                            </security:authorize>
                            <form:hidden path="pojo.contentID"/>
                            <input type="button" value="<fmt:message key="button.save"/>" onclick="submitContentForm('insert-update')"/>
                            
                            <c:if test="${!empty param.approve and param.approve eq 'yes' }">
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
<script type='text/javascript'>
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
var timeout;
function submitContentForm(crudaction) {
	if(validateAuthoringForm()) {
		$('#crudaction').val(crudaction);
		$("#content").fadeTo('slow',.3);
		<c:forEach items="${item.contentItem.items.item}" var="node">
			<c:if test="${node.itemType == 'IMAGE' or node.itemType == 'ATTACHMENT'}">
				swfu_${node.itemKey}.startUpload();
			</c:if>
    	</c:forEach>
    	timeout = setTimeout(uploadCompletedTrigger, 2000);
	}
}
function uploadCompletedTrigger() {
	var isCompleted = true;
	<c:forEach items="${item.contentItem.items.item}" var="node">
		<c:if test="${node.itemType == 'IMAGE' or node.itemType == 'ATTACHMENT'}">
			if(swfu_${node.itemKey}.getStats().files_queued > 0) {
				isCompleted = false;
			}
		</c:if>
	</c:forEach>
	if(isCompleted) {
		clearTimeout(timeout);
		document.getElementById('itemForm').submit();
	}else {
		timeout = setTimeout(uploadCompletedTrigger, 2000);
	}
}

function uploadComplete(file) {
	if (this.getStats().files_queued > 0) {
		this.startUpload();
	}
}
function validateAuthoringForm() {
	var title = $('#title').val();
	var keyword = $('#keyword').val();
	if($.trim(title) == '') {
		jAlert('Vui lòng nhập tiêu đề tin', 'Thông báo');
		$('#title').focus();
		return false;
	}
	if($.trim(keyword) == '') {
		jAlert('Vui lòng nhập từ khóa của tin', 'Thông báo');
		$('#keyword').focus();
		return false;
	}
	return true;
}
function deleteAttachmentItem(itemID) {
	jConfirm('<fmt:message key="delete.confirm.one"/>', '<fmt:message key="delete.confirm.title"/>', function(r) {
	   if(r) {
		    var value = $('#' + itemID).val();
			$('#' + itemID).remove();
			$('#i_' + itemID).remove();
			$('#itemForm').append('<input type="hidden" name="deletedAttchments" value="' + value + '">');
	   }
	});
}
if(!FlashDetect.installed){
	jAlert("<fmt:message key='admin.browser.not.install.flash.warn'/>");     	
}
</script>