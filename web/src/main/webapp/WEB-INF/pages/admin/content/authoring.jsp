﻿<%@ include file="/common/taglibs.jsp"%>

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
					post_params: {'nodename' : '${node.name}', 'authoringTemplateID': '${item.pojo.authoringTemplate.authoringTemplateID}','categoryID': '${item.pojo.category.categoryID}'},
					file_size_limit : "500 MB",
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
<c:url var="formUrl" value="/admin/content/authoring.html"/>
<c:url var="backUrl" value="/admin/content/list.html"/>

<form:form commandName="item" action="${formUrl}" method="post" id="itemForm" cssClass="form-horizontal" enctype="multipart/form-data">
    <div class="small-header transition animated fadeIn">
        <div class="hpanel">
            <div class="panel-body">
                <div id="hbreadcrumb" class="pull-right">
                    <ol class="hbreadcrumb breadcrumb">
                        <li><a href="<c:url value="/admin/dashboard.html"/>">Dashboard</a></li>
                        <li>
                            <span><fmt:message key="content"/></span>
                        </li>
                        <li class="active">
                            <span><fmt:message key="content.management"/></span>
                        </li>
                    </ol>
                </div>

                <h2 class="font-light m-b-xs">
                    <c:choose>
                        <c:when test="${not empty item.pojo.contentID}">
                            <fmt:message key="content.edit"/>
                        </c:when>
                        <c:otherwise>
                            <fmt:message key="content.add"/>
                        </c:otherwise>
                    </c:choose>
                </h2>
            </div>
        </div>
    </div>

    <div class="content animate-panel">
        <div>
            <div class="row">
                <div class="col-lg-12 animated-panel zoomIn" style="animation-delay: 0.2s;">
                    <div class="hpanel">
                        <div class="panel-heading">
                            <div class="panel-tools">
                                <a class="showhide"><i class="fa fa-chevron-up"></i></a>
                            </div>
                            <fmt:message key="content.management"/>
                        </div>

                        <div class="panel-body" style="display: block;">
                            <c:if test="${not empty messageResponse}">
                                <div class="alert alert-message
                                    <c:choose>
                                        <c:when test="${!empty success}">alert-success</c:when>
                                        <c:otherwise>alert-danger</c:otherwise>
                                    </c:choose>">
                                    <a class="close" data-dismiss="alert" href="#">&times;</a> ${messageResponse}
                                </div>
                            </c:if>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="authoringtemplate.template"/></label>
                                <div class="col-sm-8">
                                    <label class="col-sm-12 control-label text-default">${authoringTemplate.name}</label>

                                    <input type="hidden" name="pojo.authoringTemplate" value="${item.pojo.authoringTemplate.authoringTemplateID}" id="pojo_authoringTemplate"/>
                                    <form:hidden path="authoringTemplateID" id="authoringTemplateID"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="content.title"/></label>
                                <div class="col-sm-8">
                                    <form:input path="pojo.title" size="40" maxlength="160" cssClass="form-control" id="title"/>
                                    <form:errors path="pojo.title" cssClass="validateError"/>

                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="content.keyword"/></label>
                                <div class="col-sm-8">
                                    <form:textarea path="pojo.keyword" rows="3" cssStyle="resize: vertical" id="keyword" cssClass="form-control"/>
                                    <form:errors path="pojo.keyword" cssClass="validateError"/>
                                </div>
                            </div>

                            <c:if test="${authoringTemplate.hasThumbnail == 'Y'}">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label"><fmt:message key="content.thumbnail"/></label>
                                    <div class="col-sm-8">
                                        <input type="file" name="thumbnailFile" id="thumbnailFile" class="form-control"/> <i>(Kích thước chuẩn 410 x 390)</i>
                                    </div>
                                </div>
                            </c:if>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="content.accesspolicy"/></label>
                                <div class="col-sm-8">
                                    <form:radiobutton path="pojo.accessPolicy" value="1"/><fmt:message key="content.accesspolicy.allowshare"/><br />
                                    <form:radiobutton path="pojo.accessPolicy" value="2"/><fmt:message key="content.accesspolicy.notallowshare"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="content.displayorder"/></label>
                                <div class="col-sm-8">
                                    <form:input path="pojo.displayOrder" size="40" id="displayOrder" cssClass="form-control"/>
                                </div>
                            </div>

                            <c:if test="${authoringTemplate.hasHotItem == 'Y'}">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label"><fmt:message key="content.hot"/></label>
                                    <div class="col-sm-8">
                                        <form:checkbox path="pojo.hot" value="1" id="hot"/>
                                    </div>
                                </div>
                            </c:if>

                            <c:if test="${authoringTemplate.hasDepartment == 'Y'}">
                                <c:if test="${fn:length(departments) gt 0 }">
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label"><fmt:message key="content.department"/></label>
                                        <div class="col-sm-8">
                                            <c:forEach items="${departments}" var="department">
                                                <input type="checkbox" name="departmentIDs" value="${department.departmentID}"/>
                                                ${department.name}<br/>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </c:if>
                            </c:if>

                            <c:if test="${authoringTemplate.event == 'Y'}">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label"><fmt:message key="content.event"/></label>
                                    <div class="col-sm-5">
                                        <div class="input-daterange input-group" id="contentEvent">
                                            <input name="pojo.beginDate" class="input-sm form-control" id="beginDate" value="<fmt:formatDate value="${item.pojo.beginDate}" pattern="dd-mm-yyyy"/>"/>
                                            <span class="input-group-addon">to</span>
                                            <input name="pojo.endDate" class="input-sm form-control" id="endDate" value="<fmt:formatDate value="${item.pojo.endDate}" pattern="dd-mm-yyyy"/>"/>
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                            <div class="form-group">
                                <div class="col-sm-8 col-sm-offset-2">
                                    <security:authorize ifAnyGranted="AUTHOR,FULL_ACCESS_RIGHT">
                                        <input type="button" class="btn w-xs btn-primary" value="<fmt:message key="button.save"/>" onclick="submitAuthoringForm('insert-update');"/>
                                        <input type="button" class="btn w-xs btn-success" value="<fmt:message key="button.send"/>" onclick="submitAuthoringForm('insert-submit-content');"/>
                                        <a href="${backUrl}"class="btn w-xs btn-default"><fmt:message key="button.back"/></a>
                                    </security:authorize>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-12 animated-panel zoomIn" style="animation-delay: 0.2s;">
                    <div class="hpanel">
                        <div class="panel-heading">
                            <div class="panel-tools">
                                <a class="showhide"><i class="fa fa-chevron-up"></i></a>
                            </div>
                            <fmt:message key="content.authoringcontent"/>
                        </div>

                        <div class="panel-body" style="display: block;">
                            <table width="100%" class="table table-striped table-bordered table-hover no-footer">
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
                                                    <c:forEach begin="1" end="${maxOccurs}" step="1" varStatus="statusIndex">
                                                        <c:choose>
                                                            <c:when test="${node.type == 'BOOLEAN'}">
                                                                <input type="radio" name="${node.name}" value="1"/> <fmt:message key="boolean.true"/>
                                                                <input type="radio" name="${node.name}" value="0"/> <fmt:message key="boolean.false"/>
                                                            </c:when>

                                                            <c:when test="${node.type == 'NUMERIC'}">
                                                                <c:choose>
                                                                    <c:when test="${not empty constraintValues && fn:length(constraintValues) > 0}">
                                                                        <select name="${node.name}" class="form-control">
                                                                            <c:forEach items="${constraintValues}" var="constraintV">
                                                                                <option value="${constraintV}">${constraintV}</option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <input type="text" name="${node.name}" class="form-control"/>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </c:when>

                                                            <c:when test="${node.type == 'PLAIN_TEXT'}">
                                                                <c:choose>
                                                                    <c:when test="${not empty constraintValues && fn:length(constraintValues) > 0}">
                                                                        <select name="${node.name}" class="form-control">
                                                                            <c:forEach items="${constraintValues}" var="constraintV">
                                                                                <option value="${constraintV}">${constraintV}</option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <input type="text" name="${node.name}" class="form-control"/>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </c:when>

                                                            <c:when test="${node.type == 'RICH_TEXT'}">
                                                                <textarea class="richTextEditor" cols="80" id="${statusIndex.index}_editor_${node.name}" name="${node.name}" rows="10"></textarea>
                                                            </c:when>
                                                        </c:choose>
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <form:hidden path="crudaction" id="crudaction"/>
    <form:hidden path="pojo.contentID"/>
    <form:hidden path="categoryID" id="categoryID"/>
</form:form>
<c:url var="ckEditorPrefixURL" value="/"/>
<script>
    $(document).ready(function(){
//        setActiveMenu4Admin('#administration_menu', '#user_menu');

        $('.richTextEditor').each(function() {
            CKEDITOR.replace($(this).attr('id'),{
                filebrowserBrowseUrl :'${ckEditorPrefixURL}ckeditor/filemanager/browser/default/browser.html?Connector=${ckEditorPrefixURL}ckeditor/filemanager/connectors/php/connector.html?preventCache=' + new Date().getTime(),
                filebrowserImageBrowseUrl : '${ckEditorPrefixURL}ckeditor/filemanager/browser/default/browser.html?Type=Image&Connector=${ckEditorPrefixURL}ckeditor/filemanager/connectors/php/connector.html?preventCache=' + new Date().getTime(),
                filebrowserFlashBrowseUrl :'${ckEditorPrefixURL}ckeditor/filemanager/browser/default/browser.html?Type=Flash&Connector=${ckEditorPrefixURL}ckeditor/filemanager/connectors/php/connector.html?preventCache=' + new Date().getTime(),
                filebrowserUploadUrl  :'${ckEditorPrefixURL}ckeditor/filemanager/connectors/php/upload.html?Type=File',
                filebrowserImageUploadUrl : '${ckEditorPrefixURL}ckeditor/filemanager/connectors/php/upload.html?Type=Image',
                filebrowserFlashUploadUrl : '${ckEditorPrefixURL}ckeditor/filemanager/connectors/php/upload.html?Type=Flash'

            });
        });

        $('.input-daterange').datepicker({
            format: "dd-mm-yyyy",
            singleDatePicker : true,
            showDropdowns: true
        });

        $("#title").blur(function() {
            var titleString = convertUrlToTitle($(this).val());
            $(this).val(titleString);
        });
    });

    function convertUrlToTitle(str){
        return  str.toLowerCase().replace('.html', '').replace(/[^a-zA-Z0-9 ]/g, " ").replace(/\s+/g, ' ');
    }

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
        var title = convertUrlToTitle($('#title').val()); ;
        $('#title').val(title);

        var keyword = $('#keyword').val();
        if($.trim(title) == '') {
            alert('Vui lòng nhập tiêu đề tin - Thông báo');
            $('#title').focus();
            return false;
        }
        if($.trim(keyword) == '') {
            alert('Vui lòng nhập từ khóa của nội dung tin - Thông báo');
            $('#keyword').focus();
            return false;
        }
        return true;
    }
    if(!FlashDetect.installed){
        alert("<fmt:message key='admin.browser.not.install.flash.warn'/>");
    }
</script>