<%@ include file="/common/taglibs.jsp"%>

<head>
	<link rel="stylesheet" type="text/css" href="<c:url value='/swfupload/default.css'/>" />
	<script type="text/javascript" src="<c:url value='/swfupload/swfupload.js' />"></script>
	<script type="text/javascript" src="<c:url value='/swfupload/fileprogress.js' />"></script>
	<script type="text/javascript" src="<c:url value='/swfupload/handlers.js' />"></script>
	<script type="text/javascript" src="<c:url value='/scripts/flash_detect_min.js' />"></script>
    <title><fmt:message key="content.management"/></title>
    <meta name="heading" content="Content Management"/>
<script type="text/javascript">
<c:forEach items="${authoringTemplateNodes}" var="node">
	<c:if test="${node.type == 'IMAGE' or node.type == 'ATTACHMENT'}">
		var swfu_${node.name};
	</c:if>
</c:forEach>
window.onload = function() {
	<c:forEach items="${authoringTemplateNodes}" var="node">
		<c:if test="${node.type == 'IMAGE' or node.type == 'ATTACHMENT'}">
			var settings${node.name} = {
					flash_url : "<c:url value='/swfupload/swfupload.swf'/>",
					upload_url: "<c:url value='/ajax/content/uploadfile.html;jsessionid=${pageContext.session.id}'/>",
					post_params: {'nodename' : '${node.name}', 'authoringTemplateID': '${item.pojo.authoringTemplate.authoringTemplateID}'},
					file_size_limit : "200 MB",
					file_types : "*.*",
					file_types_description : "All Files",
					file_upload_limit : ${node.maxOccurs},
					file_queue_limit : 0,
					custom_settings : {
						progressTarget : "fsUploadProgress_${node.name }",
						cancelButtonId : "btnCancel"
					},
					debug: false,

					// Button settings
					button_image_url: "<c:url value='/swfupload/TestImageNoText_65x29.png'/>",
					button_width: "55",
					button_height: "29",
					button_placeholder_id: "spanButtonPlaceHolder_${node.name}",
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
			swfu_${node.name} = new SWFUpload(settings${node.name});
	 	</c:if>
	</c:forEach>
	
  };

</script>
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
<c:url var="url" value="/admin/content/authoring.html"/>
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
                            <input type="hidden" name="pojo.authoringTemplate" value="${item.pojo.authoringTemplate.authoringTemplateID}" id="pojo_authoringTemplate"/>
                            <form:hidden path="authoringTemplateID" id="authoringTemplateID"/>
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
                            <input type="file" name="thumbnailFile" id="thumbnailFile" /> <i>(Kích thước chuẩn 410 x 390)</i>
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
                            <form:input path="pojo.displayOrder" size="40" id="displayOrder"/>
                        </td>
                    </tr>
                    <c:if test="${authoringTemplate.hasHotItem == 'Y'}">
                    <tr class="odd">
                        <td><fmt:message key="content.hot"/></td>
                        <td>
                            <form:checkbox path="pojo.hot" value="1" id="hot"/>
                        </td>
                    </tr>
                    </c:if>
                    <c:if test="${authoringTemplate.hasDepartment == 'Y'}">
                    <c:if test="${fn:length(departments) gt 0 }">
	                    <tr class="even">
	                        <td><fmt:message key="content.department"/></td>
	                        <td>
	                            <c:forEach items="${departments}" var="department">
	                                <input type="checkbox" name="departmentIDs" value="${department.departmentID}" />
	                                ${department.name}<br/>
	                            </c:forEach>
	                        </td>
	                    </tr>
                    </c:if>
                    </c:if>
                    <c:if test="${fn:length(categories) gt 0 }">
	                    <tr class="even">
	                        <td><fmt:message key="content.category"/></td>
	                        <td>
	                            <c:forEach items="${categories}" var="category">
	                                <input type="checkbox" name="categoryIDs" value="${category.categoryID}" />
	                                ${category.name}<br/>
	                            </c:forEach>
	                        </td>
	                    </tr>
                    </c:if>
                    <tr class="<c:out value="${fn:length(categories) gt 0 ? 'odd' : 'even'}"/>" >
                        <td colspan="2"><fmt:message key="content.authoringcontent"/></td>
                    </tr>
                    <tr class="<c:out value="${fn:length(categories) gt 0 ? 'even' : 'odd'}"/>">
                        <td colspan="2">
                            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                            	<% pageContext.setAttribute("newLineChar", "\n"); %> 
                                <c:forEach items="${authoringTemplateNodes}" var="node">
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
                                            <c:choose>
	                                            <c:when test="${node.type == 'IMAGE' or node.type == 'ATTACHMENT'}">
	                                            	<div><span id="spanButtonPlaceHolder_${node.name }"></span></div>
	                                                 <div class="fieldset flash" id="fsUploadProgress_${node.name }">
	                                                 	<span class="legend">Files</span>
	                                                 </div>
	                                             </c:when>
	                                             <c:otherwise>
	                                             	<c:if test="${not empty  node.constraintValues && fn:length(node.constraintValues) > 0}">
	                                             		<c:set value="${fn:replace(node.constraintValues, newLineChar, ';')}" var="constraintValues"/>
	                                             		<c:set value="${fn:split(constraintValues,';') }" var="constraintValues"/>
	                                             	</c:if>
	                                             	<c:forEach begin="1" end="${maxOccurs}" step="1">
		                                                <c:choose>
		                                                    <c:when test="${node.type == 'BOOLEAN'}">
		                                                        <input type="radio" name="${node.name}" value="1"/> <fmt:message key="boolean.true"/>
		                                                        <input type="radio" name="${node.name}" value="0"/> <fmt:message key="boolean.false"/>
		                                                    </c:when>
		                                                    <c:when test="${node.type == 'NUMERIC'}">
                                                                <c:choose>
                                                                    <c:when test="${not empty constraintValues && fn:length(constraintValues) > 0}">
                                                                    <select name="${node.name}">
                                                                        <c:forEach items="${constraintValues}" var="const">
                                                                            <option value="${const}">${const}</option>
                                                                        </c:forEach>
                                                                    </select>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <input type="text" name="${node.name}"/>
                                                                    </c:otherwise>
                                                                </c:choose>
		                                                    </c:when>
		                                                    <c:when test="${node.type == 'PLAIN_TEXT'}">
		                                                        <c:choose>
                                                                    <c:when test="${not empty constraintValues && fn:length(constraintValues) > 0}">
                                                                    <select name="${node.name}">
                                                                        <c:forEach items="${constraintValues}" var="const">
                                                                            <option value="${const}">${const}</option>
                                                                        </c:forEach>
                                                                    </select>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <input type="text" name="${node.name}" style="width:98%"/>
                                                                    </c:otherwise>
                                                                </c:choose>
		                                                    </c:when>
		                                                    <c:when test="${node.type == 'RICH_TEXT'}">
		                                                        <textarea cols="80" id="editor_${node.name}" name="${node.name}" rows="10"></textarea>
		                                                    </c:when>
		                                                </c:choose>
		                                            </c:forEach>
	                                             </c:otherwise>
                                             </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </table>

                        </td>
                    </tr>

                    <tr class="<c:out value="${fn:length(categories) gt 0 ? 'even' : 'odd'}"/>">
                        <td></td>
                        <td>
                            <form:hidden path="crudaction" id="crudaction"/>
                            <form:hidden path="pojo.contentID"/>
                            <fmt:message key="content.approve" var="approveLabel"/>
							<security:authorize ifAllGranted="AUTHOR">
								<fmt:message key="button.send" var="approveLabel"/>
							</security:authorize>
                            
                            <input type="button" value="<fmt:message key="button.save"/>" onclick="submitAuthoringForm('insert-update');"/>
                            <input type="button" value="${approveLabel }" onclick="submitAuthoringForm('insert-submit-content');"/>
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
<c:forEach items="${authoringTemplateNodes}" var="node">
	<c:if test="${node.type == 'RICH_TEXT'}">
		CKEDITOR.replace( 'editor_${node.name}',
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
function submitAuthoringForm(crudaction) {
	if(validateAuthoringForm()) {
		$("#crudaction").val(crudaction);
		$("#content").fadeTo('slow',.3);
		<c:forEach items="${authoringTemplateNodes}" var="node">
			<c:if test="${node.type == 'IMAGE' or node.type == 'ATTACHMENT'}">
				swfu_${node.name}.startUpload();
			</c:if>
    	</c:forEach>
    	timeout = setTimeout(uploadCompletedTrigger, 2000);
	}
}
function uploadCompletedTrigger() {
	var isCompleted = true;
	<c:forEach items="${authoringTemplateNodes}" var="node">
		<c:if test="${node.type == 'IMAGE' or node.type == 'ATTACHMENT'}">
			if(swfu_${node.name}.getStats().files_queued > 0) {
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
		jAlert('Vui lòng nhập từ khóa của nội dung tin', 'Thông báo');
		$('#keyword').focus();
		return false;
	}
	return true;
}
if(!FlashDetect.installed){
	jAlert("<fmt:message key='admin.browser.not.install.flash.warn'/>");     	
}
</script>