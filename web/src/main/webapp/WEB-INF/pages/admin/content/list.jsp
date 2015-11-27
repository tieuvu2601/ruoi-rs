<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="contentEntity.management"/></title>
    <meta name="heading" contentEntity="Content Management"/>
    <style type="text/css">
        .toolbar a{
            padding-left: 3px;
        }
    </style>
</head>
<c:url var="formUrl" value="/admin/contentEntity/list.html"/>
<c:url var="addUrl" value="/admin/contentEntity/add.html"/>
<c:url var="editUrl" value="/admin/contentEntity/edit.html"/>
<c:url var="viewUrl" value="/admin/contentEntity/view.html"/>
<c:url var="approveUrl" value="/admin/contentEntity/approve.html"/>
<c:url var="trackingUrl" value="/admin/contentEntity/tracking.html"/>
<c:url var="approveFlowUrl" value="/admin/contentEntity/approveflow.html"/>
<fmt:message key="contentEntity.approve" var="approveLabel"/>
<security:authorize ifAllGranted="AUTHOR">
    <c:url var="approveFlowUrl" value="/admin/contentEntity/submit.html"/>
    <fmt:message key="button.send" var="approveLabel"/>
</security:authorize>

<div class="small-header transition animated fadeIn">
    <div class="hpanel">
        <div class="panel-body">
            <div id="hbreadcrumb" class="pull-right">
                <ol class="hbreadcrumb breadcrumb">
                    <li><a href="<c:url value="/admin/dashboard.html"/>">Dashboard</a></li>
                    <li>
                        <span><fmt:message key="contentEntity"/></span>
                    </li>
                    <li class="active">
                        <span><fmt:message key="contentEntity.management"/></span>
                    </li>
                </ol>
            </div>
            <h2 class="font-light m-b-xs">
                <fmt:message key="contentEntity.management"/>
            </h2>
        </div>
    </div>
</div>

<div class="contentEntity animate-panel">
    <form:form commandName="items" action="${formUrl}" method="post" id="listForm" cssClass="form-horizontal">
        <div>
            <div class="row">
                <div class="col-lg-12 animated-panel zoomIn" style="animation-delay: 0.2s;">
                    <div class="hpanel">
                        <div class="panel-heading">
                            <div class="panel-tools">
                                <a class="showhide"><i class="fa fa-chevron-up"></i></a>
                            </div>
                            <fmt:message key="contentEntity.management"/>
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
                                    <label class="col-sm-4 control-label"><fmt:message key="contentEntity.title"/></label>
                                    <div class="col-sm-8">
                                        <form:input path="pojo.title" size="40" cssClass="form-control" id="title"/>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label"><fmt:message key="authoringtemplate.template"/></label>
                                    <div class="col-sm-8">
                                        <select name="pojo.authoringTemplateEntity" id="authoringTemplateId" class="form-control">
                                            <option value=""><fmt:message key="label.all"/></option>
                                            <c:forEach items="${authoringTemplates}" var="authoringTemplateEntity">
                                                <option value="${authoringTemplateEntity.authoringTemplateID}" <c:if test="${authoringTemplateEntity.authoringTemplateID == items.pojo.authoringTemplateEntity.authoringTemplateID}">selected</c:if>>${authoringTemplateEntity.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label"><fmt:message key="contentEntity.keyword"/></label>
                                    <div class="col-sm-8">
                                        <form:input path="pojo.keyword" size="40" cssClass="form-control"/>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label"><fmt:message key="categoryEntity"/></label>
                                    <div class="col-sm-8">
                                        <select name="pojo.categoryEntity.categoryID" id="contentCategoryID" class="form-control">
                                            <option value=""><fmt:message key="label.all"/></option>
                                            <c:forEach items="${categories}" var="categoryEntity">
                                                <option value="${categoryEntity.categoryID}" <c:if test="${categoryEntity.categoryID == items.categoryID}">selected</c:if>>
                                                    <c:forEach begin="1" end="${categoryEntity.nodeLevel}">
                                                        - - -
                                                    </c:forEach>
                                                        ${categoryEntity.name}
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
                                            <security:authorize ifAnyGranted="FULL_ACCESS_RIGHT">
                                                <option value="-10" <c:if test="${empty items.pojo.status }">selected</c:if>><fmt:message key="label.all"/></option>
                                            </security:authorize>

                                            <security:authorize ifAnyGranted="AUTHOR,FULL_ACCESS_RIGHT">
                                                <option value="-2" <c:if test="${items.pojo.status eq -2 }">selected</c:if>><fmt:message key="contentEntity.save"/></option>
                                            </security:authorize>

                                            <security:authorize ifAnyGranted="AUTHOR,APPROVER,FULL_ACCESS_RIGHT">
                                                <option value="0" <c:if test="${items.pojo.status eq 0}">selected</c:if>><fmt:message key="contentEntity.waiting"/></option>
                                            </security:authorize>

                                            <security:authorize ifAnyGranted="APPROVER,PUBLISHER,FULL_ACCESS_RIGHT">
                                                <option value="1" <c:if test="${items.pojo.status eq 1}">selected</c:if>><fmt:message key="contentEntity.waiting.published"/></option>
                                            </security:authorize>

                                            <option value="2" <c:if test="${items.pojo.status eq 2 }">selected</c:if>><fmt:message key="contentEntity.published"/></option>

                                            <security:authorize ifAnyGranted="AUTHOR,APPROVER,FULL_ACCESS_RIGHT">
                                                <option value="-1" <c:if test="${items.pojo.status eq -1}">selected</c:if>><fmt:message key="contentEntity.reject.option"/></option>
                                            </security:authorize>
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
                            <fmt:message key="button.search"/>
                        </div>

                        <div class="panel-body" style="display: block;">
                            <div class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                                <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${formUrl}"
                                               partialList="true" sort="external" size="${items.totalItems}" defaultsort="2" uid="tableList" pagesize="${items.maxPageItems}"
                                               class="table table-striped table-bordered table-hover no-footer" export="false">

                                    <c:set var="disabled" value="false"/>
                                    <c:if test="${empty items.contentPublishedMap[tableList.contentID] or !items.contentPublishedMap[tableList.contentID]}">
                                        <c:set var="disabled" value="true"/>
                                    </c:if>

                                    <display:column headerClass="table_header" sortable="false" style="width: 3%" title="<input type=\"checkbox\" name=\"allCheck\" id=\"allCheck\" onclick=\"checkAll('listForm', 'checkList', this)\">">
                                        <input type="checkbox" <c:if test="${!empty disabled and disabled}">disabled="disabled"</c:if> id="chk${tableList.contentID }" name="checkList" value="${tableList.contentID}" onclick="checkAllIfOne('listForm', 'checkList', this, 'allCheck')">
                                    </display:column>

                                    <display:column headerClass="table_header" sortable="true" sortName="title" titleKey="contentEntity.title" style="width: 20%">
                                        <a href="${viewUrl}?pojo.contentID=${tableList.contentID }">${tableList.title}</a>
                                    </display:column>

                                    <display:column headerClass="table_header" titleKey="contentEntity.thumbnail" style="width: 10%">
                                        <c:if test="${not empty tableList.thumbnail}">
                                            <rep:href value="${tableList.thumbnail}" var="imgURL"/>
                                            <c:choose>
                                                <c:when test="${(tableList.createdBy.userID eq currentUserID) or (items.contentPublishedMap[tableList.contentID] eq true)}">
                                                    <img src="<c:url value="${imgURL}?w=100"/>" style="max-width: 100px;max-height: 100px;" onclick="showImageLarger(${tableList.contentID})"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="<c:url value="${imgURL}?w=100"/>" style="max-width: 100px;max-height: 100px;" />
                                                </c:otherwise>
                                            </c:choose>
                                        </c:if>
                                    </display:column>

                                    <display:column headerClass="table_header" titleKey="contentEntity.status" style="width: 10%">
                                        <c:choose>
                                            <c:when test="${tableList.status == Constants.CONTENT_SAVE}">
                                                <fmt:message key="contentEntity.save"/>
                                            </c:when>
                                            <c:when test="${tableList.status == Constants.CONTENT_WAITING_APPROVE}">
                                                <fmt:message key="contentEntity.waiting.approved"/>
                                            </c:when>
                                            <c:when test="${tableList.status == Constants.CONTENT_APPROVE}">
                                                <fmt:message key="contentEntity.waiting.published"/>
                                            </c:when>
                                            <c:when test="${tableList.status == Constants.CONTENT_PUBLISH}">
                                                <fmt:message key="contentEntity.published"/>
                                            </c:when>
                                            <c:otherwise>
                                                <fmt:message key="contentEntity.reject"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </display:column>

                                    <display:column headerClass="table_header" property="createdDate" sortable="true" sortName="createdDate" titleKey="createdDate" style="width: 20%" format="{0,date,dd/MM/yyyy HH:mm:ss}"/>

                                    <display:column headerClass="table_header" property="modifiedDate" sortable="true" sortName="modifiedDate" titleKey="modifiedDate" style="width: 20%" format="{0,date,dd/MM/yyyy HH:mm:ss}"/>

                                    <display:column sortable="false"  headerClass="table_header" url="/admin/contentEntity/edit.html" titleKey="action" style="width: 10%">
                                        <div class="toolbar">
                                            <a title="<fmt:message key="button.view"/>" href="${viewUrl}?pojo.contentID=${tableList.contentID }" class="edit"><i class="fa  fa-info-circle"></i></a>
                                            <c:choose>
                                                <c:when test="${tableList.status eq Constants.CONTENT_SAVE || tableList.status eq Constants.CONTENT_REJECT}">
                                                    <security:authorize ifAnyGranted="AUTHOR,FULL_ACCESS_RIGHT">
                                                        | <a title="<fmt:message key="contentEntity.edit"/>" href="${editUrl}?pojo.contentID=${tableList.contentID}" class="edit"><i class="fa fa-edit"></i></a>
                                                        | <a title="<fmt:message key="contentEntity.delete"/>" id="${tableList.contentID}" class="deleteLink"><i class="fa fa-remove"></i></a>
                                                    </security:authorize>
                                                </c:when>
                                            </c:choose>
                                        </div>
                                    </display:column>

                                    <display:setProperty name="paging.banner.item_name"><fmt:message key="contentEntity"/></display:setProperty>
                                    <display:setProperty name="paging.banner.items_name"><fmt:message key="contentEntity"/></display:setProperty>
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
            var categoryOptions = document.getElementById('contentCategoryID').options;
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

        function approve(contentID, decision){
            var list = document.getElementById('listForm').elements['checkList'];
            var listSize = list.length;
            for(i = 0; i < listSize; i++) {
                if (!list[i].disabled) {
                    list[i].checked = false;
                }
            }
            $("#chk"+contentID).attr('checked','checked');
            $('#crudaction').val(decision);
            $('#listForm').submit();
        }

        var nc = 0;

        function showImageLarger(contentID) {
            nc ++;
            var surl = '<c:url value="/ajax/crop.html"/>?contentID=' + contentID;
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