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
            <div class="text-center m-b-md" id="wizardControl">

                <a class="btn btn-primary" href="#step1" data-toggle="tab">Step 1 - Personal data</a>
                <a class="btn btn-default" href="#step2" data-toggle="tab">Step 2 - Payment data</a>
                <a class="btn btn-default" href="#step3" data-toggle="tab">Step 3 - Approval</a>

            </div>

            <div class="tab-content">
                <div id="step1" class="p-m tab-pane active">

                    <div class="row">
                        <div class="col-lg-3 text-center">
                            <i class="pe-7s-user fa-5x text-muted"></i>
                            <p class="small m-t-md">
                                <strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard.
                                <br/><br/>Lorem Ipsum has been the industry's dummy text of the printing and typesetting
                            </p>
                        </div>
                        <div class="col-lg-9">
                            <div class="row">
                                <div class="form-group col-lg-12">
                                    <label>Username</label>
                                    <input type="" value="" id="" class="form-control" name="username" placeholder="username">
                                </div>
                                <div class="form-group col-lg-6">
                                    <label>Password</label>
                                    <input type="password" value="" id="" class="form-control" name="" placeholder="******" name="password">
                                </div>
                                <div class="form-group col-lg-6">
                                    <label>Company</label>
                                    <input type="text" value="" id="" class="form-control" name="" placeholder="Company Name" name="company">
                                </div>
                                <div class="form-group col-lg-6">
                                    <label>Email Address</label>
                                    <input type="" value="" id="" class="form-control" name="" placeholder="user@email.com" name="email">
                                </div>
                                <div class="form-group col-lg-6">
                                    <label>Country</label>
                                    <input type="text" value="" id="" class="form-control" name="" name="country" placeholder="UK">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="text-right m-t-xs">
                        <a class="btn btn-default prev" href="#">Previous</a>
                        <a class="btn btn-default next" href="#">Next</a>
                    </div>

                </div>

                <div id="step2" class="p-m tab-pane">

                    <div class="row">
                        <div class="col-lg-3 text-center">
                            <i class="pe-7s-credit fa-5x text-muted"></i>
                            <p class="small m-t-md">
                                <strong>It is a long</strong> established fact that a reader will be distracted by the readable
                                <br/><br/>Many desktop publishing packages and web page editors now use
                            </p>
                        </div>
                        <div class="col-lg-9">
                            <div class="row">
                                <div class="form-group col-lg-12">
                                    <label>Name on Card</label>
                                    <input type="" value="" id="" class="form-control" name="card_name">
                                </div>
                                <div class="form-group col-lg-6">
                                    <label>Card Number</label>
                                    <input type="text" value="" id="" class="form-control" name="" name="card_number">
                                </div>
                                <div class="form-group col-lg-6">
                                    <label>Billing Address</label>
                                    <input type="text" value="" id="" class="form-control" name="" name="billing_address">
                                </div>
                                <div class="form-group col-lg-12">
                                    <div class="row">
                                        <div class="col-xs-4 form-group">
                                            <label>CVC</label>
                                            <input class="form-control" placeholder="ex. 381"  type="text" name="cvc">
                                        </div>
                                        <div class="col-xs-4 form-group">
                                            <label>Expiration</label>
                                            <input class="form-control" placeholder="MM" type="text" name="expire_month">
                                        </div>
                                        <div class="col-xs-4 form-group">
                                            <label></label>
                                            <input class="form-control" placeholder="YYYY" type="text" name="expire_year">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="text-right m-t-xs">
                        <a class="btn btn-default prev" href="#">Previous</a>
                        <a class="btn btn-default next" href="#">Next</a>
                    </div>

                </div>
                <div id="step3" class="tab-pane">
                    <div class="row text-center m-t-lg m-b-lg">
                        <div class="col-lg-12">
                            <i class="pe-7s-check fa-5x text-muted"></i>
                            <p class="small m-t-md">
                                <strong>There are many</strong> variations of passages of Lorem Ipsum available, but the majority have suffered
                            </p>
                        </div>
                        <div class="checkbox col-lg-12">
                            <input type="checkbox" class="i-checks approveCheck" name="approve">
                            Approve this form
                        </div>
                    </div>
                    <div class="text-right m-t-xs">
                        <a class="btn btn-default prev" href="#">Previous</a>
                        <a class="btn btn-default next" href="#">Next</a>
                        <a class="btn btn-success submitWizard" href="#">Submit</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <form:hidden path="crudaction" id="crudaction"/>
    <security:authorize ifNotGranted="FULL_ACCESS_RIGHT">
        <form:hidden path="pojo.status"/>
    </security:authorize>
    <form:hidden path="pojo.contentID"/>
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
    var title = convertUrlToTitle($('#title').val());
    $('#title').val(title);

	var keyword = $('#keyword').val();
	if($.trim(title) == '') {
		alert('Vui lòng nhập tiêu đề tin - Thông báo');
		$('#title').focus();
		return false;
	}
	if($.trim(keyword) == '') {
        alert('Vui lòng nhập từ khóa của tin - Thông báo');
		$('#keyword').focus();
		return false;
	}
	return true;
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

function wizardListener(){
    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        $('a[data-toggle="tab"]').removeClass('btn-primary');
        $('a[data-toggle="tab"]').addClass('btn-default');
        $(this).removeClass('btn-default');
        $(this).addClass('btn-primary');
    })

    $('.next').click(function(){
        var nextId = $(this).parents('.tab-pane').next().attr("id");
        $('[href=#'+nextId+']').tab('show');
    })

    $('.prev').click(function(){
        var prevId = $(this).parents('.tab-pane').prev().attr("id");
        $('[href=#'+prevId+']').tab('show');
    })

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
    })
}
</script>