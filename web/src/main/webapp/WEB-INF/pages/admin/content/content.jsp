<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="content.management"/></title>
    <meta name="heading" content="Content Management"/>
    <link rel="stylesheet" type="text/css" href="<c:url value='/swfupload/default.css'/>" />
    <style>
        div#wizardControl a {
            min-width: 15%;
        }
    </style>


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
                            file_size_limit : "500 MB",
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
<c:url var="formUrl" value="/admin/content/edit.html"/>
<c:url var="backUrl" value="/admin/content/list.html"/>

<form:form commandName="item" action="${formUrl}" method="post" id="itemForm" cssClass="form-horizontal" enctype="multipart/form-data">
    <div class="small-header transition animated fadeIn">
        <div class="hpanel">
            <div class="panel-body">
                <div id="hbreadcrumb" class="pull-right">
                    <ol class="hbreadcrumb breadcrumb">
                        <li><a href="<c:url value="/admin/dashboard.html"/>"><fmt:message key="admin.dashboard"/></a></li>
                        <li>
                            <span><fmt:message key="content.title"/></span>
                        </li>
                        <li class="active">
                            <span><fmt:message key="content.management"/></span>
                        </li>
                    </ol>
                </div>

                <h2 class="font-light m-b-xs">
                    <fmt:message key="content.edit"/>
                </h2>
            </div>
        </div>
    </div>

    <div class="content">
        <div class="row">
            <div class="col-lg-12">
                <div class="hpanel">
                    <div class="panel-heading">
                        <div class="panel-tools">
                            <a class="showhide"><i class="fa fa-chevron-up"></i></a>
                            <a class="closebox"><i class="fa fa-times"></i></a>
                        </div>
                        ADD OR EDIT CONTENT
                    </div>
                    <div class="panel-body">
                        <div class="text-center m-b-md" id="wizardControl">
                            <a class="btn btn-primary" index="0" data-toggle="tab" href="#step1">Choose Category and Type</a>
                            <a class="btn btn-default" index="1" data-toggle="tab" href="#step2" disabled>Basic Content</a>
                            <a class="btn btn-default" index="2" data-toggle="tab" href="#step3" disabled>Content Data</a>
                            <a class="btn btn-default product-container" index="3" data-toggle="tab" href="#step4" disabled>Product Content</a>
                            <a class="btn btn-default" index="4" data-toggle="tab" href="#step5" disabled>Action</a>
                        </div>

                        <div class="tab-content">
                            <div id="step1" class="p-m tab-pane active" index="0">
                                <div class="row">
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label"><fmt:message key="category.type.title"/></label>
                                        <div class="col-sm-7">
                                            <form:select path="pojo.categoryType.categoryTypeId" cssClass="form-control" id="categoryTypeId">
                                                <form:option value="-1"><fmt:message key="label.select"/></form:option>
                                                <form:options items="${categoryTypes}" itemValue="categoryTypeId" itemLabel="name"/>
                                            </form:select>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-2 control-label"><fmt:message key="category.title"/></label>
                                        <div class="col-sm-7">
                                            <form:select path="pojo.category.categoryId" cssClass="form-control" id="categoryId" onchange="loadAuthoringTemplate($(this).val())">
                                                <form:option value="-1"><fmt:message key="label.select"/></form:option>
                                                <c:forEach var="cat" items="${categories}">
                                                    <form:option value="${cat.categoryId}" authoringTemplateId="${cat.authoringTemplate.authoringTemplateId}" authoringTemplateName="${cat.authoringTemplate.name}">
                                                        <c:forEach begin="1" end="${cat.nodeLevel}">
                                                            - - -
                                                        </c:forEach>
                                                        ${cat.name}
                                                    </form:option>
                                                </c:forEach>
                                            </form:select>
                                        </div>
                                    </div>
                                </div>
                                <div class="text-right m-t-xs">
                                    <a class="btn btn-default prev" href="#"><fmt:message key="button.previous"/></a>
                                    <a class="btn btn-default next" href="#"><fmt:message key="button.next"/></a>
                                </div>
                            </div>

                            <div id="step2" class="p-m tab-pane" index="1">
                                <div class="row">
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label"><fmt:message key="content.header"/></label>
                                        <div class="col-sm-8">
                                            <form:input path="pojo.header" size="160" maxlength="255" cssClass="form-control" id="header"/>
                                            <form:errors path="pojo.header" cssClass="validateError"/>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-2 control-label"><fmt:message key="content.title.title"/></label>
                                        <div class="col-sm-8">
                                            <form:input path="pojo.title" size="160" maxlength="255" cssClass="form-control" id="title"/>
                                            <form:errors path="pojo.title" cssClass="validateError"/>
                                            <span class="help-block m-b-none">Title to using to seo. It should have length 160 character</span>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-2 control-label"><fmt:message key="content.keyword"/></label>
                                        <div class="col-sm-7">
                                            <form:input path="pojo.keyword"  size="160" maxlength="160" id="keyword" cssClass="form-control"/>
                                            <form:errors path="pojo.keyword" cssClass="validateError"/>
                                            <span class="help-block m-b-none">Key word to using to seo. It should have length 160 character</span>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-2 control-label"><fmt:message key="content.description"/></label>
                                        <div class="col-sm-7">
                                            <form:input path="pojo.description"  size="160" maxlength="160" id="description" cssClass="form-control"/>
                                            <form:errors path="pojo.description" cssClass="validateError"/>
                                            <span class="help-block m-b-none">Description to using to seo. It should have length 160 character</span>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-2 control-label"><fmt:message key="content.thumbnail"/></label>
                                        <div class="col-sm-7">
                                            <input type="file" name="thumbnailFile" id="thumbnailFile" class="form-control"/>
                                            <span class="help-block m-b-none">(Standard Size is 16 x 9 )</span>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-2 control-label"><fmt:message key="content.display.order"/></label>
                                        <div class="col-sm-7">
                                            <form:input path="pojo.displayOrder" size="40" id="displayOrder" cssClass="form-control"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="text-right m-t-xs">
                                    <a class="btn btn-default prev" href="#"><fmt:message key="button.previous"/></a>
                                    <a class="btn btn-default next" href="#"><fmt:message key="button.next"/></a>
                                </div>
                            </div>

                            <div id="step3" class="tab-pane authoring-template-container" index="2">
                                <div class="row m-t-lg m-b-lg authoring-template-content">
                                    <c:if test="${not empty item.pojo.authoringTemplate && item.pojo.authoringTemplate.authoringTemplateId > 0}">
                                        <table width="100%" class="table table-striped table-bordered table-hover no-footer">
                                            <tr>
                                                <th>
                                                    <fmt:message key="authoring.template.title"/>${authoringTemplate.name}
                                                    <input type="hidden" name="pojo.authoringTemplate.authoringTemplateId" id="authoringTemplateId" value="${authoringTemplate.authoringTemplateId}"/>
                                                </th>
                                            </tr>
                                            <c:if test="${not empty item.pojo.authoringTemplate && item.pojo.authoringTemplate.authoringTemplateId > 0}">
                                                <% pageContext.setAttribute("newLineChar", "\n"); %>
                                                <c:forEach items="${item.contentItem.items.item}" var="node">
                                                    <c:set var="minOccurs" value="${node.minOccurs}"/>
                                                    <c:set var="maxOccurs" value="${node.maxOccurs}"/>
                                                    <c:if test="${empty maxOccurs}">
                                                        <c:set var="maxOccurs" value="5"/>
                                                    </c:if>
                                                    <c:set var="cssClass" value=""/>
                                                    <c:if test="${minOccurs > 0 && (node.type == 'NUMERIC' || node.type == 'PLAIN_TEXT')}">
                                                        <c:set var="cssClass" value="required"/>
                                                    </c:if>

                                                    <tr><td>${node.displayName}</td></tr>
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
                                                                                <select name="${node.itemKey}"  class="form-control ${cssClass}">
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
                                                                                <select name="${node.itemKey}" class="form-control ${cssClass}">
                                                                                    <c:forEach items="${constraintValues}" var="c">
                                                                                        <c:if test="${not empty c}">
                                                                                            <option value="${c}" <c:if test="${c eq itemValue}">selected</c:if>>${c}</option>
                                                                                        </c:if>
                                                                                    </c:forEach>
                                                                                </select>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <input type="text" name="${node.itemKey}" class="form-control" value="${itemValue}"/>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </c:when>
                                                                    <c:when test="${node.itemType == 'RICH_TEXT'}">
                                                                        <textarea class="richTextEditor" cols="80" id="${statusIndex.index}_editor_${node.itemKey}" index="${statusIndex.index}" name="${node.itemKey}" rows="10">${itemValue}</textarea>
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
                                            </c:if>
                                        </table>
                                    </c:if>
                                </div>
                                <div class="text-right m-t-xs">
                                    <a class="btn btn-default prev" href="#"><fmt:message key="button.previous"/></a>
                                    <a class="btn btn-default next" href="#"><fmt:message key="button.next"/></a>
                                </div>
                            </div>

                            <div id="step4" class="tab-pane product-container" index="3" >
                                <div class="row text-center m-t-lg m-b-lg">
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label"><fmt:message key="content.location.text"/></label>
                                        <div class="col-sm-7">
                                            <form:input path="pojo.locationText" size="40" cssClass="form-control"/>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-2 control-label"><fmt:message key="content.location"/></label>
                                        <div class="col-sm-7">
                                            <form:select path="pojo.location.locationId" cssClass="form-control">
                                                <form:option value=""><fmt:message key="label.select"/></form:option>
                                                <form:options items="${locations}" itemLabel="name" itemValue="locationId"></form:options>
                                            </form:select>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-2 control-label"><fmt:message key="content.cost"/></label>
                                        <div class="col-sm-2">
                                            <form:input path="pojo.cost" size="40" id="product-cost" cssClass="form-control"/>
                                            <span class="help-block m-b-none">(trieu dong)</span>
                                        </div>

                                        <label class="col-sm-2 control-label"><fmt:message key="content.cost.unit"/></label>
                                        <div class="col-sm-2">
                                            <form:select path="pojo.unit" cssClass="form-control">
                                                <form:option value=""><fmt:message key="label.select"/></form:option>
                                                <form:option value="m2">Met vuong</form:option>
                                                <form:option value="unit">Can</form:option>
                                                <form:option value="hecta">Hecta</form:option>
                                            </form:select>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-2 control-label"></label>
                                        <div class="col-sm-7">
                                            <div class="checkbox"><label> <input type="checkbox" class="i-checks"> Hot Item </label></div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">productStatus</label>
                                        <div class="col-sm-7">
                                            <form:input path="pojo.productStatus" size="40" cssClass="form-control"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="text-right m-t-xs">
                                    <a class="btn btn-default prev" href="#"><fmt:message key="button.previous"/></a>
                                    <a class="btn btn-default next" href="#"><fmt:message key="button.next"/></a>
                                </div>
                            </div>

                            <div id="step5" class="tab-pane" index="5" >
                                <div class="row text-center m-t-lg m-b-lg">
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">productStatus</label>
                                        <div class="col-sm-7">
                                            <form:input path="pojo.productStatus" size="40" cssClass="form-control"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="text-right m-t-xs">
                                    <a class="btn btn-default prev" href="#"><fmt:message key="button.previous"/></a>
                                    <a class="btn btn-success submitWizard" href="#"><fmt:message key="button.save"/></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <form:hidden path="crudaction" id="crudaction"/>
    <form:hidden path="pojo.contentId"/>
</form:form>
<c:url var="prefixUrl" value="/" />
<script type='text/javascript'>
    $(document).ready(function(){
    //        setActiveMenu4Admin('#administration_menu', '#user_menu');

        wizardListener();

        $('.richTextEditor').each(function() {
            CKEDITOR.timestamp = new Date().getTime(); /*Used to debug*/
            CKEDITOR.replace($(this).attr('id'),{
                filebrowserBrowseUrl :'${prefixUrl}ckeditor442/filemanager/browser/default/browser.html?Connector=${prefixUrl}ckeditor442/filemanager/connectors/php/connector.html?preventCache=' + new Date().getTime(),
                filebrowserImageBrowseUrl : '${prefixUrl}ckeditor442/filemanager/browser/default/browser.html?Type=Image&Connector=${prefixUrl}ckeditor442/filemanager/connectors/php/connector.html?preventCache=' + new Date().getTime(),
                filebrowserFlashBrowseUrl :'${prefixUrl}ckeditor442/filemanager/browser/default/browser.html?Type=Flash&Connector=${prefixUrl}ckeditor442/filemanager/connectors/php/connector.html?preventCache=' + new Date().getTime(),
                filebrowserUploadUrl  :'${prefixUrl}ckeditor442/filemanager/connectors/php/upload.html?Type=File',
                filebrowserImageUploadUrl : '${prefixUrl}ckeditor442/filemanager/connectors/php/upload.html?Type=Image',
                filebrowserFlashUploadUrl : '${prefixUrl}ckeditor442/filemanager/connectors/php/upload.html?Type=Flash'

            });
        });

        $("#title").blur(function() {
            var titleString = convertUrlToTitle($(this).val());
            $(this).val(titleString);
        });

        $('.input-daterange').datepicker({
            format: "dd-mm-yyyy",
            singleDatePicker : true,
            showDropdowns: true
        });
    });

    function convertUrlToTitle(str){
        return  str.toLowerCase().replace('.html', '').replace(/[^a-zA-Z0-9 ]/g, " ").replace(/\s+/g, ' ');
    }


    var timeout;
    var errorMessage;


    function submitContentForm(crudaction) {
        $('#crudaction').val(crudaction);
        $("#content").fadeTo('slow',.3);
        <c:forEach items="${item.contentItem.items.item}" var="node">
        <c:if test="${node.itemType == 'IMAGE' or node.itemType == 'ATTACHMENT'}">
        swfu_${node.itemKey}.startUpload();
        </c:if>
        </c:forEach>
        timeout = setTimeout(uploadCompletedTrigger, 2000);
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

    function deleteAttachmentItem(itemID) {
        bootbox.confirm('<fmt:message key="delete.confirm"/>', function(r) {
           if(r) {
                var value = $('#' + itemID).val();
                $('#' + itemID).remove();
                $('#i_' + itemID).remove();
                $('#itemForm').append('<input type="hidden" name="deletedAttchments" value="' + value + '">');
           }
        });
    }

    if(!FlashDetect.installed){
        alert("<fmt:message key='admin.browser.not.install.flash.warn'/>");
    }

    function loadAuthoringTemplate(categoryId){
        if(categoryId != null && categoryId > 0){
            var optionSelected = $('#categoryId').find(":selected");
            var authoringTemplateName = $(optionSelected).attr("authoringTemplateName");
            var authoringTemplateId = $(optionSelected).attr("authoringTemplateId");
            $('#authoringTemplateLabel').text(authoringTemplateName);
            $('#authoringTemplateId').val(authoringTemplateId);
            loadAuthoringTemplateContent(categoryId);
        } else {
            $('#authoringTemplateLabel').empty();
            $('#authoringTemplateId').val('');
            $('.authoring-template-content').empty();
        }
    }

    function loadAuthoringTemplateContent(categoryId){
        if(categoryId != null && categoryId > 0){
            $.ajax({
                cache: false,
                type: "POST",
                dataType: 'HTML',
                data: {'categoryId': categoryId},
                url:  "<c:url value="/ajax/load-authoring-template-from-category.html"/>",
                success: function(res){
                    $('.authoring-template-content').html(res);
                    showHideProductTab();
                }
            });
        }
    }

    function showHideProductTab(){
        if($('#areProduct').val() == 1){
            $('.product-container').show();
        } else {
            $('.product-container').hide();
        }
    }

    function wizardListener(){
        $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
            $('a[data-toggle="tab"]').removeClass('btn-primary');
            $('a[data-toggle="tab"]').addClass('btn-default');
            $(this).removeClass('btn-default');
            $(this).addClass('btn-primary');
        });

        $('.next').click(function(){
            var nextId = $(this).parents('.tab-pane').next().attr("id");
            if(validateStep($(this))){
                $('[href=#'+nextId+']').removeAttr("disabled");
                $('[href=#'+nextId+']').removeClass("disabled");
                $('[href=#'+nextId+']').tab('show');
            } else {
                swal({
                    title: "Error!",
                    text: errorMessage,
                    type: "error"
                });
                $('[href=#'+nextId+']').attr("disabled", "disabled");
                $('[href=#'+nextId+']').addClass("disabled");
            }
        });

        $('.prev').click(function(){
            var prevId = $(this).parents('.tab-pane').prev().attr("id");
            $('[href=#'+prevId+']').tab('show');
        });

        $('.submitWizard').click(function(){
            var approve = $(".approveCheck").is(':checked');
            if(approve) {
                // Got to step 1
                $('[href=#step1]').tab('show');

                // Serialize data to post method
                var datastring = $("#simpleForm").serialize();

                // Show notification
                swal({
                    title: "Thank you!",
                    text: "You approved our example form!",
                    type: "success"
                });

            } else {
                // Show notification
                swal({
                    title: "Error!",
                    text: "You have to approve form checkbox.",
                    type: "error"
                });
            }
        });
    }

    function validateStep(element){
        var isValid  = false;
        var currentIndex = getIndexFromButton(element);
        if(currentIndex == 0){
            if($('#categoryTypeId').val() == null || $('#categoryTypeId').val() == undefined || $('#categoryTypeId').val() < 1 ){
                $('#categoryTypeId').addClass("error");
                errorMessage = "Please select category Type!";
            }else{
                $('#categoryTypeId').removeClass("error");
                errorMessage = "";
                if($('#categoryId').val() == null || $('#categoryId').val() == undefined || $('#categoryId').val() < 1 ){
                    $('#categoryId').addClass("error");
                    errorMessage = "Please select category!";
                } else {
                    $('#categoryId').removeClass("error");
                    errorMessage = "";
                    isValid = true;
                }
            }

        } else if(currentIndex == 1){
            if($('#title').val() == null || $('#title').val() == undefined || $('#title').val().trim() == ""){
                $('#title').addClass("error");
                errorMessage = "Please Enter title!";
            } else {
                $('#title').removeClass("error");
                errorMessage = "";
                if($('#keyword').val() == null || $('#keyword').val() == undefined || $('#keyword').val().trim() == ""){
                    $('#keyword').addClass("error");
                    errorMessage = "Please Enter Keyword!";
                } else {
                    $('#keyword').removeClass("error");
                    errorMessage = "";
                    if($('#description').val() == null || $('#description').val() == undefined || $('#description').val().trim() == "" ){
                        $('#keyword').addClass("error");
                        errorMessage = "Please Enter Description!";
                    } else {
                        $('#description').removeClass("error");
                        errorMessage = "";
                        isValid = true;
                    }
                }
            }
        }else if(currentIndex == 2){
            isValid = true;
            $('.form-control.required').each(function(){
                if($(this).val() == null || $(this).val() == undefined || $(this).val().trim() == ""){
                    $(this).addClass("error");
                    isValid = false;
                } else {
                    $(this).removeClass("error");
                }
            });
            if(isValid == true){
                errorMessage = "";
            } else {
                errorMessage = "Some field are empty. Please enter the value!";
            }
        } else if (currentIndex == 3){
            isValid = true;
            // check after
        } else if(currentIndex == 4){
            isValid = true;
        }
        return isValid;
    }

    function getIndexFromButton(btnElement){
        var currentTab = $(btnElement).closest('.tab-pane');
        return parseInt($(currentTab).attr("index"));
    }
</script>