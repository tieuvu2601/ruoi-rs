<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="feedback.management"/></title>
    <meta name="heading" contentEntity="<fmt:message key="feedback.management"/>"/>
</head>

<c:url var="formUrl" value="/admin/feedback/list.html"/>
<c:url var="replyUrl" value="/admin/feedback/reply.html"/>

<div class="small-header transition animated fadeIn">
    <div class="hpanel">
        <div class="panel-body">
            <div id="hbreadcrumb" class="pull-right">
                <ol class="hbreadcrumb breadcrumb">
                    <li><a href="<c:url value="/admin/dashboard.html"/>">Dashboard</a></li>
                    <li>
                        <span><fmt:message key="feedback"/></span>
                    </li>
                    <li class="active">
                        <span><fmt:message key="feedback.management"/></span>
                    </li>
                </ol>
            </div>
            <h2 class="font-light m-b-xs">
                <fmt:message key="feedback.management"/>
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
                                    <label class="col-sm-4 control-label"><fmt:message key="feedback.title"/></label>
                                    <div class="col-sm-8">
                                        <form:input path="pojo.title" size="40" cssClass="form-control"/>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label"><fmt:message key="label.status"/></label>
                                    <div class="col-sm-8">
                                        <select name="pojo.status" class="form-control">
                                            <option value="" <c:if test="${empty items.pojo.status}">selected</c:if>><fmt:message key="label.all"/></option>
                                            <option value="0" <c:if test="${items.pojo.status == 0}">selected</c:if>><fmt:message key="status.new"/></option>
                                            <option value="1" <c:if test="${items.pojo.status == 1}">selected</c:if>><fmt:message key="status.replied"/></option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label"><fmt:message key="feedback.createddate"/></label>
                                    <div class="col-sm-8 ">
                                        <div class="input-group date">
                                            <input type="text" id="fromDate" name="fromDate" class="form-control" data-date-format="dd/mm/yyyy"><span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label"><fmt:message key="feedback.categoryEntity"/></label>
                                    <div class="col-sm-8">
                                        <select path="pojo.feedbackCategory" class="form-control">
                                            <option value="" <c:if test="${empty items.pojo.feedbackCategory}">selected</c:if>><fmt:message key="label.all"/></option>
                                            <c:forEach items="${feedbackCategories}" var="categoryEntity">
                                                <option value="${categoryEntity.feedbackCategoryID}" <c:if test="${items.pojo.feedbackCategory.feedbackCategoryID == categoryEntity.feedbackCategoryID}">selected</c:if>>${categoryEntity.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label"><fmt:message key="toDate" /></label>
                                    <div class="col-sm-8">
                                        <div class="input-group date">
                                            <input type="text" id="toDate" name="toDate" data-date-format="dd/mm/yyyy" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label"><fmt:message key="feedback.department"/></label>
                                    <div class="col-sm-8">
                                        <select path="pojo.department" class="form-control">
                                            <option value="" <c:if test="${empty items.pojo.department}">selected</c:if>><fmt:message key="label.all"/></option>
                                            <c:forEach items="${departments}" var="department">
                                                <option value="${department.departmentID}" <c:if test="${items.pojo.department.departmentID == department.departmentID}">selected</c:if>>${department.name}</option>
                                            </c:forEach>
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
                <div class="col-lg-12 animated-panel zoomIn" style="animation-delay: 0.1s;">
                    <div class="hpanel">
                        <div class="panel-heading">
                            <div class="panel-tools">
                                <a href="${editUrl}"class=""><i class="fa fa-plus"></i> <fmt:message key="button.add"/></a>
                                <a class="showhide"><i class="fa fa-chevron-up"></i></a>
                            </div>
                            <fmt:message key="roleEntity.list"/>
                        </div>
                        <div class="panel-body">
                            <div class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                                <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${formUrl}"
                                               partialList="true" sort="external" size="${items.totalItems}" defaultsort="2" uid="tableList" pagesize="${items.maxPageItems}"
                                               class="table table-striped table-bordered table-hover no-footer" export="false" excludedParams="crudaction">
                                    <display:column headerClass="table_header" sortable="false" style="width: 3%" title="<input type=\"checkbox\" name=\"allCheck\" id=\"allCheck\" onclick=\"checkAll('listForm', 'checkList', this)\">">
                                        <input type="checkbox" name="checkList" value="${tableList.feedbackID}" onclick="checkAllIfOne('listForm', 'checkList', this, 'allCheck')">
                                    </display:column>
                                    <display:column headerClass="table_header" property="title"  escapeXml="false" sortable="true" sortName="code" titleKey="feedback.name" style="width: 15%"/>
                                    <display:column headerClass="table_header" escapeXml="false" sortable="true" sortName="createdBy.createdBy.displayName" titleKey="feedback.createdby" style="width: 25%">
                                        ${tableList.createdBy.displayName} (${tableList.createdBy.username})
                                    </display:column>

                                    <display:column sortable="false"  headerClass="table_header" titleKey="action" style="width: 20%">

                                        <a href="${replyUrl}?pojo.feedbackID=${tableList.feedbackID}"><i class="fa fa-reply"></i></a> |
                                        <a class="deleteLink" id="${tableList.feedbackID}"><i class="fa fa-remove"></i></a>
                                    </display:column>
                                    <display:setProperty name="paging.banner.item_name"><fmt:message key="feedback"/></display:setProperty>
                                    <display:setProperty name="paging.banner.items_name"><fmt:message key="feedback"/></display:setProperty>
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

<script type="text/javascript">
    $(document).ready(function(){
        $('#fromDate').datepicker({});
        $('#toDate').datepicker({});

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
            $("#listForm").submit();
        });
    });
</script>
