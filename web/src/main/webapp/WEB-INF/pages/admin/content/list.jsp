<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="content.management"/></title>
    <meta name="heading" content="Content Management"/>
    <style type="text/css">
        .toolbar a{
            padding-left: 3px;
        }
    </style>
</head>
<c:url var="formUrl" value="/admin/content/list.html"/>
<c:url var="addUrl" value="/admin/content/add.html"/>
<c:url var="editUrl" value="/admin/content/edit.html"/>
<c:url var="sendEmailUrl" value="/admin/content/send-email.html"/>
<c:url var="viewUrl" value="/admin/content/view.html"/>

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
                <fmt:message key="content.management"/>
            </h2>
        </div>
    </div>
</div>

<div class="content animate-panel">
    <form:form commandName="items" action="${formUrl}" method="post" id="listForm" cssClass="form-horizontal">
        <div>
            <div class="row">
                <div class="col-lg-12 animated-panel zoomIn" style="animation-delay: 0.2s;">
                    <div class="hpanel">
                        <div class="panel-heading">
                            <div class="panel-tools">
                                <a class="showhide"><i class="fa fa-chevron-up"></i></a>
                            </div>
                            <fmt:message key="button.search"/>
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

                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label"><fmt:message key="content.title"/></label>
                                    <div class="col-sm-8">
                                        <form:input path="pojo.title" size="40" cssClass="form-control" id="title"/>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label"><fmt:message key="authoring.template.title"/></label>
                                    <div class="col-sm-8">
                                        <select name="pojo.authoringTemplate" id="authoringTemplateId" class="form-control">
                                            <option value=""><fmt:message key="label.all"/></option>
                                            <c:forEach items="${authoringTemplates}" var="authoringTemplate">
                                                <option value="${authoringTemplate.authoringTemplateId}" <c:if test="${authoringTemplate.authoringTemplateId == items.pojo.authoringTemplate.authoringTemplateId}">selected</c:if>>${authoringTemplate.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label"><fmt:message key="content.keyword"/></label>
                                    <div class="col-sm-8">
                                        <form:input path="pojo.keyword" size="40" cssClass="form-control"/>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label"><fmt:message key="category.title"/></label>
                                    <div class="col-sm-8">
                                        <select name="pojo.category.categoryId" id="contentCategoryId" class="form-control">
                                            <option value=""><fmt:message key="label.all"/></option>
                                            <c:forEach items="${categories}" var="category">
                                                <option value="${category.categoryId}" <c:if test="${category.categoryId == items.categoryId}">selected</c:if>>
                                                    <c:forEach begin="1" end="${category.nodeLevel}">
                                                        - - -
                                                    </c:forEach>
                                                        ${category.name}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label"><fmt:message key="label.status"/></label>
                                    <div class="col-sm-8">
                                        <select name="pojo.status" id="status" class="form-control">
                                            <option value="-1" <c:if test="${empty items.pojo.status }">selected</c:if>><fmt:message key="label.all"/></option>
                                            <option value="0" <c:if test="${items.pojo.status eq 0 }">selected</c:if>><fmt:message key="content.saved"/></option>
                                            <option value="1" <c:if test="${items.pojo.status eq 1 }">selected</c:if>><fmt:message key="content.published"/></option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-12">
                                <div class="form-group">
                                    <div class="col-sm-8 col-sm-offset-2">
                                        <a class="btn btn-primary btnFilter"><fmt:message key="button.search"/></a>
                                    </div>
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
                                <security:authorize ifAnyGranted="AUTHOR,FULL_ACCESS_RIGHT">
                                    <a href="${addUrl}"><i class="fa fa-plus"></i> <fmt:message key="button.add"/></a>
                                </security:authorize>
                            </div>
                            <fmt:message key="content.list"/>
                            <a class="btn btn-primary" href="<c:url value="/admin/content/slider-manager.html"/>"></a>
                        </div>

                        <div class="panel-body" style="display: block;">
                            <div class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                                <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${formUrl}"
                                               partialList="true" sort="external" size="${items.totalItems}" defaultsort="2" uid="tableList" pagesize="${items.maxPageItems}"
                                               class="table table-striped table-bordered table-hover no-footer" export="false">

                                    <c:set var="disabled" value="false"/>
                                    <c:if test="${empty items.contentPublishedMap[tableList.contentId] or !items.contentPublishedMap[tableList.contentId]}">
                                        <c:set var="disabled" value="true"/>
                                    </c:if>

                                    <display:column headerClass="table_header" sortable="false" style="width: 3%" title="<input type=\"checkbox\" name=\"allCheck\" id=\"allCheck\" onclick=\"checkAll('listForm', 'checkList', this)\">">
                                        <input type="checkbox" <c:if test="${!empty disabled and disabled}">disabled="disabled"</c:if> id="chk${tableList.contentId }" name="checkList" value="${tableList.contentId}" onclick="checkAllIfOne('listForm', 'checkList', this, 'allCheck')">
                                    </display:column>

                                    <display:column headerClass="table_header" sortable="true" sortName="title" titleKey="content.title" style="width: 20%">
                                        <a href="${viewUrl}?pojo.contentId=${tableList.contentId }">${tableList.title}</a>
                                    </display:column>

                                    <display:column headerClass="table_header" titleKey="content.thumbnails" style="width: 10%">
                                        <c:if test="${not empty tableList.thumbnails}">
                                            <rep:href value="${tableList.thumbnails}" var="imgURL"/>
                                            <img src="<c:url value="${imgURL}?w=120"/>" style="max-width: 100px;max-height: 100px;" />
                                        </c:if>
                                    </display:column>

                                    <display:column headerClass="table_header" titleKey="content.status" style="width: 10%">
                                        <c:choose>
                                            <c:when test="${tableList.status == Constants.CONTENT_SAVE}">
                                                <fmt:message key="content.saved"/>
                                            </c:when>
                                            <c:when test="${tableList.status == Constants.CONTENT_PUBLISH}">
                                                <fmt:message key="content.published"/>
                                            </c:when>
                                        </c:choose>
                                    </display:column>

                                    <display:column headerClass="table_header" property="createdDate" sortable="true" sortName="createdDate" titleKey="createdDate" style="width: 20%" format="{0,date,dd/MM/yyyy HH:mm:ss}"/>

                                    <display:column headerClass="table_header" property="modifiedDate" sortable="true" sortName="modifiedDate" titleKey="modifiedDate" style="width: 20%" format="{0,date,dd/MM/yyyy HH:mm:ss}"/>

                                    <display:column sortable="false"  headerClass="table_header" url="/admin/content/edit.html" titleKey="action" style="width: 10%">
                                        <div class="toolbar">
                                            <a title="<fmt:message key="button.view"/>" href="${viewUrl}?pojo.contentId=${tableList.contentId}" class="edit"><i class="fa  fa-info-circle"></i></a>
                                            <security:authorize ifAnyGranted="CUSTOMER,FULL_ACCESS_RIGHT">
                                                <c:if test="${tableList.status == 1}">
                                                    | <a title="<fmt:message key="button.send.email"/>" href="${sendEmailUrl}?pojo.contentId=${tableList.contentId}" class="send-email"><i class="fa fa-envelope"></i></a>
                                                </c:if>
                                            </security:authorize>
                                            <security:authorize ifAnyGranted="AUTHOR,FULL_ACCESS_RIGHT">
                                                | <a title="<fmt:message key="button.edit"/>" href="${editUrl}?pojo.contentId=${tableList.contentId}" class="edit"><i class="fa fa-edit"></i></a>
                                                | <a title="<fmt:message key="button.delete"/>" id="${tableList.contentId}" class="deleteLink"><i class="fa fa-remove"></i></a>
                                            </security:authorize>
                                        </div>
                                    </display:column>

                                    <display:setProperty name="paging.banner.item_name"><fmt:message key="content.title"/></display:setProperty>
                                    <display:setProperty name="paging.banner.items_name"><fmt:message key="content.title"/></display:setProperty>
                                    <display:setProperty name="paging.banner.placement" value="bottom"/>
                                    <display:setProperty name="paging.banner.no_items_found" value=""/>
                                    <display:setProperty name="paging.banner.onepage" value=""/>
                                </display:table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    <form:hidden path="crudaction" id="crudaction"/>
</form:form>
</div>

<script type="text/javascript" charset="UTF-8">
    $(document).ready(function(){
        $(".deleteLink").click(function(){
            var id = $(this).attr("id");
            if (id != null && id != undefined){
                bootbox.confirm('<fmt:message key="delete.confirm"/>', function(r) {
                    if(r){
                        $("<input type='hidden' name='checkList' value='" + id + "'>").appendTo($("#listForm"));
                        $("#crudaction").val("delete");
                        $("#listForm").submit();
                    }
                });
            }
        });

        $(".btnFilter").click(function(){
            var titleString = convertUrlToTitle($('#title').val());
            $('#title').val(titleString);
            $("#listForm").submit();
        });

        $("#title").blur(function() {
            var titleString = convertUrlToTitle($(this).val());
            $(this).val(titleString);
        });

        $("#authoringTemplateId").change(function(){
            var value = $(this).val();
            var categoryOptions = document.getElementById('contentCategoryId').options;
            categoryOptions.length = 1;
            if(value != null && value != ''){
                jQuery.ajax({
                    url : '<c:url value="/ajax/loadCategoryByAuthoringTemplate.html"/>?au=' + value + '&dt=' + new Date().getTime(),
                    dataType: 'json',
                    success: function(data){
                        if (data.array != null) {
                            for (var i = 0; i < data.array.length; i++) {
                                var item = data.array[i];
                                categoryOptions[i + 1] = new Option(item[1], item[0]);
                            }
                        }
                    }
                });
            }
        });

        $("#btReject").click(function(){
            var fb = checkSelected4ConfirmDelete('listForm', 'checkList');
            if(fb) {
                submitForm("reject");
            }else{
                $("#hidenWarningLink").trigger('click');
            }
        });

        $("#btApprove").click(function(){
            var fb = checkSelected4ConfirmDelete('listForm', 'checkList');
            if(fb) {
                submitForm("approve");
            }else{
                $("#hidenWarningLink").trigger('click');
            }
        });

        function approve(contentId, decision){
            var list = document.getElementById('listForm').elements['checkList'];
            var listSize = list.length;
            for(i = 0; i < listSize; i++) {
                if (!list[i].disabled) {
                    list[i].checked = false;
                }
            }
            $("#chk"+contentId).attr('checked','checked');
            $('#crudaction').val(decision);
            $('#listForm').submit();
        }

        var nc = 0;

        function showImageLarger(contentId) {
            nc ++;
            var surl = '<c:url value="/ajax/crop.html"/>?contentId=' + contentId;
            $.ajax({
                type: 'GET',
                cache: false,
                url: surl,
                timeout: 30000,
                error: function(xhr, ajaxOptions, thrownError){ },
                success: function(data){
                    Sexy.vdata(data);
                }
            });
        }
    });

    function submitForm(crudaction){
        $('#crudaction').val(crudaction);
        $('#listForm').submit();
    }

    function convertUrlToTitle(str){
        return  str.toLowerCase().replace('.html', '').replace(/[^a-zA-Z0-9 ]/g, " ").replace(/\s+/g, ' ');
    }

</script>