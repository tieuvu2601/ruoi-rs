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
                            post_params: {'nodename' : '${node.itemKey}', 'contentId': '${item.pojo.contentId}'},
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
                                <label class="col-sm-2 control-label"><fmt:message key="category.title"/></label>
                                <div class="col-sm-8">
                                    <form:select path="pojo.category.categoryId" cssClass="form-control">
                                        <c:forEach var="cat" items="${categories}">
                                            <form:option value="${cat.categoryId}">
                                                <c:forEach begin="1" end="${cat.nodeLevel}"> - - - </c:forEach> ${cat.name}
                                                <%--<c:if test="${cat.categoryId eq item.pojo.category.categoryId}">selected</c:if>--%>
                                            </form:option>
                                        </c:forEach>
                                    </form:select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="authoring.template.title"/></label>
                                <div class="col-sm-8">
                                    <label class="col-sm-12 control-label text-default">${authoringTemplate.name}</label>
                                    <form:hidden path="pojo.authoringTemplate.authoringTemplateId" id="authoringTemplateId"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="content.header"/></label>
                                <div class="col-sm-8">
                                    <form:input path="pojo.header" size="160" maxlength="255" cssClass="form-control" id="header-content"/>
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
                                <div class="col-sm-8">
                                    <form:input path="pojo.keyword"  size="160" maxlength="160" id="keyword" cssClass="form-control"/>
                                    <form:errors path="pojo.keyword" cssClass="validateError"/>
                                    <span class="help-block m-b-none">Key word to using to seo. It should have length 160 character</span>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="content.description"/></label>
                                <div class="col-sm-8">
                                    <form:input path="pojo.description"  size="160" maxlength="255" id="description" cssClass="form-control"/>
                                    <form:errors path="pojo.description" cssClass="validateError"/>
                                    <span class="help-block m-b-none">Description to using to seo. It should have length 160 character</span>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="content.thumbnails"/></label>
                                <div class="col-sm-4">
                                    <input type="file" name="thumbnailFile" id="thumbnailFile" class="form-control"/>
                                    <span class="help-block m-b-none">(Standard Size is 16 x 9 )</span>
                                </div>
                                <c:if test="${not empty item.pojo.thumbnails}">
                                    <div class="col-sm-4">
                                        <rep:href value="${item.pojo.thumbnails}" var="imgURL"/>
                                        <img src="<c:url value="${imgURL}?w=100"/>" style="max-width: 100px; max-height: 100px;" />
                                    </div>
                                </c:if>

                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="content.display.order"/></label>
                                <div class="col-sm-8">
                                    <form:input path="pojo.displayOrder" size="40" id="displayOrder" cssClass="form-control"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-8 col-sm-offset-2">
                                    <c:choose>
                                        <c:when test="${item.pojo.status eq 0}">
                                            <input class="btn w-xs btn-primary" type="button" value="<fmt:message key="button.save"/>" onclick="submitContentForm('content-update')"/>

                                            <input class="btn w-xs btn-success" type="button" value="<fmt:message key="button.post"/>" onclick="submitContentForm('content-post')"/>
                                        </c:when>

                                        <c:when test="${item.pojo.status == 1}">
                                            <input class="btn w-xs btn-primary" type="button" value="<fmt:message key="button.save"/>" onclick="submitContentForm('content-post')"/>
                                            <input class="btn w-xs btn-danger" type="button" value="<fmt:message key="button.remove"/>" onclick="submitContentForm('content-update')"/>
                                        </c:when>
                                    </c:choose>
                                    <a href="${backUrl}" class="btn w-xs btn-default"><fmt:message key="button.back"/></a>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-8 col-sm-offset-2">
                                    <div class="checkbox"><label><form:checkbox path="moveToTop" value="1"/><fmt:message key="content.move.to.top"/></label></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <c:if test="${authoringTemplate.areProduct == 1}">
                <div class="row">
                    <div class="col-lg-12 animated-panel zoomIn" style="animation-delay: 0.2s;">
                        <div class="hpanel">
                            <div class="panel-heading">
                                <div class="panel-tools">
                                    <a class="showhide"><i class="fa fa-chevron-up"></i></a>
                                </div>
                                <fmt:message key="content.product.information"/>
                            </div>

                            <div class="panel-body" style="display: block;">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label"><fmt:message key="category.type.title"/></label>
                                    <div class="col-sm-8">
                                        <form:select path="pojo.categoryType.categoryTypeId" cssClass="form-control">
                                            <form:options items="${categoryTypes}" itemLabel="name" itemValue="categoryTypeId"/>
                                        </form:select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 control-label"><fmt:message key="content.location.text"/></label>
                                    <div class="col-sm-8">
                                        <form:input path="pojo.locationText" size="40" cssClass="form-control"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 control-label"><fmt:message key="content.location"/></label>
                                    <div class="col-sm-8">
                                        <form:select path="pojo.location.locationId" cssClass="form-control">
                                            <form:option value="">Select</form:option>
                                            <form:options items="${locations}" itemLabel="name" itemValue="locationId"></form:options>
                                        </form:select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 control-label"><fmt:message key="content.area"/></label>
                                    <div class="col-sm-8">
                                        <form:input path="pojo.area" size="40" cssClass="form-control"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 control-label"><fmt:message key="content.total.area"/></label>
                                    <div class="col-sm-8">
                                        <form:input path="pojo.totalArea" size="40" cssClass="form-control"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 control-label"><fmt:message key="content.area.ratio"/></label>
                                    <div class="col-sm-8">
                                        <form:input path="pojo.areaRatio" size="40" cssClass="form-control"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 control-label"><fmt:message key="content.number.of.block"/></label>
                                    <div class="col-sm-8">
                                        <form:input path="pojo.numberOfBlock" size="40" cssClass="form-control"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 control-label"><fmt:message key="content.cost"/></label>
                                    <div class="col-sm-4">
                                        <form:input path="pojo.cost" size="40" id="product-cost" cssClass="form-control"/>
                                    </div>

                                    <label class="col-sm-2 control-label"><fmt:message key="content.cost.unit"/></label>
                                    <div class="col-sm-2">
                                        <form:select path="pojo.unit" cssClass="form-control">
                                            <form:option value=""><fmt:message key="label.select"/></form:option>
                                            <form:option value="m2"><fmt:message key="content.cost.unit.m2"/></form:option>
                                            <form:option value="unit"><fmt:message key="content.cost.unit.unit"/></form:option>
                                            <form:option value="hecta"><fmt:message key="content.cost.unit.hecta"/></form:option>
                                        </form:select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="col-sm-8 col-sm-offset-2">
                                        <div class="checkbox"><label> <form:checkbox path="pojo.hotItem" value="1"/><fmt:message key="content.is.hot.product"/></label></div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="col-sm-8 col-sm-offset-2">
                                        <div class="checkbox"><label> <form:checkbox path="pojo.productStatus" value="1"/><fmt:message key="content.is.new.product"/></label></div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="col-sm-8 col-sm-offset-2">
                                        <div class="checkbox"><label> <form:checkbox path="pojo.slide" value="1"/><fmt:message key="content.slider"/></label></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

            <div class="row">
                <div class="col-lg-12 animated-panel zoomIn" style="animation-delay: 0.2s;">
                    <div class="hpanel">
                        <div class="panel-heading">
                            <div class="panel-tools">
                                <a class="showhide"><i class="fa fa-chevron-up"></i></a>
                            </div>
                            <fmt:message key="content.authoring.content"/>
                        </div>

                        <div class="panel-body" style="display: block;">
                            <table class="table table-striped table-bordered table-hover no-footer">
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
                                                                <select name="${node.itemKey}"  class="form-control">
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
                                                                <select name="${node.itemKey}" class="form-control">
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
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <form:hidden path="crudaction" id="crudaction"/>
    <form:hidden path="pojo.contentId"/>
    <form:hidden path="authoringTemplateId" id="authoringTemplateId"/>
    <form:hidden path="categoryId" id="categoryId"/>
</form:form>
<c:url var="prefixUrl" value="/" />
<script type='text/javascript'>
    $(document).ready(function(){
    //        setActiveMenu4Admin('#administration_menu', '#user_menu');

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

    //    $("#title").blur(function() {
    //        var titleString = convertUrlToTitle($(this).val());
    //        $(this).val(titleString);
    //    });

    //    $('.input-daterange').datepicker({
    //        format: "dd-mm-yyyy",
    //        singleDatePicker : true,
    //        showDropdowns: true
    //    });

        $("#product-cost").TouchSpin({
            initval: 0,
            max: 1000000000,
            postfix : "(Trieu Dong)"
        });
    });

    function convertUrlToTitle(str){

        return  str.toLowerCase().replace('.html', '').replace(/[^a-zA-Z0-9 ]/g, " ").replace(/\s+/g, ' ');
    }


    var timeout;
    function submitContentForm(crudaction) {

        if(validateContentData()) {
            $('#crudaction').val(crudaction);
            $("#content").fadeTo('slow',.3);
            <c:forEach items="${item.contentItem.items.item}" var="node">
                <c:if test="${node.itemType == 'IMAGE' or node.itemType == 'ATTACHMENT'}">
                    swfu_${node.itemKey}.startUpload();
                </c:if>
            </c:forEach>
            timeout = setTimeout(uploadCompletedTrigger, 2000);
        } else {
            swal({
                title: "Error!",
                text: errorMessage,
                type: "error"
            });
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

    var errorMessage;
    function validateContentData(){
        var isValid = false;
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
                    if($('#header-content').val() == null || $('#header-content').val() == undefined || $('#header-content').val().trim() == ""){
                        $('#header-content').addClass("error");
                        errorMessage = "Please Enter Header!";
                    } else {
                        $('#header-content').removeClass("error");
                        errorMessage = "";
                        isValid = true;
                    }
                }
            }
        }
        return isValid;
    }

    if(!FlashDetect.installed){
        swal({
            title: "Error!",
            text: "<fmt:message key='admin.browser.not.install.flash.warn'/>",
            type: "error"
        });
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
</script>