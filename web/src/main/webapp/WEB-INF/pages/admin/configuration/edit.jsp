<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="configuration.management"/></title>
    <meta name="heading" content="<fmt:message key="configuration.management"/>"/>
</head>
<c:url var="formUrl" value="/admin/configuration/edit.html"/>
<c:url var="backUrl" value="/admin/content/list.html"/>

<form:form commandName="item" action="${formUrl}" method="post" id="itemForm" cssClass="form-horizontal">
    <div class="small-header transition animated fadeIn">
        <div class="hpanel">
            <div class="panel-body">
                <div id="hbreadcrumb" class="pull-right">
                    <ol class="hbreadcrumb breadcrumb">
                        <li><a href="<c:url value="/admin/dashboard.html"/>"><fmt:message key="admin.dashboard"/></a></li>
                        <li>
                            <span><fmt:message key="configuration.title"/></span>
                        </li>
                        <li class="active">
                            <span><fmt:message key="configuration.management"/></span>
                        </li>
                    </ol>
                </div>

                <h2 class="font-light m-b-xs">
                    <c:choose>
                        <c:when test="${not empty item.pojo.configurationId}">
                            <fmt:message key="configuration.edit"/>
                        </c:when>
                        <c:otherwise>
                            <fmt:message key="configuration.add"/>
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
                            <fmt:message key="configuration.management"/>
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
                                <label class="col-sm-2 control-label"><fmt:message key="configuration.hotline"/></label>
                                <div class="col-sm-8">
                                    <form:input path="pojo.hotLine" size="255" cssClass="form-control"/>
                                    <form:errors path="pojo.hotLine" cssClass="validateError"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="configuration.aboutme"/></label>
                                <div class="col-sm-5">
                                    <form:textarea path="pojo.aboutMe" cssClass="form-control richTextEditor" cssStyle="width: 98%; min-height: 100px"/>
                                    <form:errors path="pojo.aboutMe" cssClass="validateError"/>
                                </div>
                                <div class="col-sm-5" style="font-size: 80%">
                                    <i>
                                        &lt;div class="latest-news"&gt;<br/>
                                        &nbsp; &nbsp; &lt;img class="user-avatar" src="IMAGE_URL" alt=""&gt;<br/>
                                        &nbsp; &nbsp; &lt;h3&gt;AUTHOR_NAME&lt;/h3&gt;<br/>
                                        &nbsp; &nbsp; &lt;h4&gt;Phone Number: PHONE_NUMBER &lt;/h4&gt;<br/>
                                        &nbsp; &nbsp; &lt;h5&gt;Email: EMAIL@MAIL.COM&lt;/h5&gt;<br/>
                                        &nbsp; &nbsp; &lt;h5&gt;FaceBook Account: Account Facebook&lt;/h5&gt;<br/>
                                        &nbsp; &nbsp; &lt;h5&gt;SkypeAccount: SKYPE_ACCOUNT&lt;/h5&gt;<br/>
                                        &lt;/div&gt;<br/>
                                    </i>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="configuration.custom.css"/></label>
                                <div class="col-sm-8">
                                    <form:textarea path="pojo.customCSS" cssClass="form-control" cssStyle="width: 98%; min-height: 200px"/>
                                    <form:errors path="pojo.customCSS" cssClass="validateError"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-8 col-sm-offset-2">
                                    <a id="btnSave" class="btn w-xs btn-primary"><fmt:message key="button.save"/></a>
                                    <a href="${backUrl}"class="btn w-xs btn-default"><fmt:message key="button.back"/></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <form:hidden path="crudaction" id="crudaction"/>
    <form:hidden path="pojo.configurationId"/>
</form:form>
<c:url var="prefixUrl" value="/"/>
<script>
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

        $("#btnSave").click(function(){
            $("#crudaction").val("insert-update");
            $("#itemForm").submit();
        });
    });
</script>