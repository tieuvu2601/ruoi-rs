<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="authoring.template.management"/></title>
    <meta name="heading" content="<fmt:message key="authoring.template.management"/>"/>
</head>
<c:url var="formUrl" value="/admin/authoringtemplate/list.html"/>
<c:url var="editUrl" value="/admin/authoringtemplate/edit.html"/>
<c:url var="accessUrl" value="/admin/authoringtemplate/access.html"/>

<div class="small-header transition animated fadeIn">
    <div class="hpanel">
        <div class="panel-body">
            <div id="hbreadcrumb" class="pull-right">
                <ol class="hbreadcrumb breadcrumb">
                    <li><a href="<c:url value="/admin/dashboard.html"/>"><fmt:message key="admin.dashboard"/></a></li>
                    <li>
                        <span><fmt:message key="authoring.template.title"/></span>
                    </li>
                    <li class="active">
                        <span><fmt:message key="authoring.template.management"/></span>
                    </li>
                </ol>
            </div>
            <h2 class="font-light m-b-xs">
                <fmt:message key="authoring.template.management"/>
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
                                    <label class="col-sm-4 control-label"><fmt:message key="authoring.template.code"/></label>
                                    <div class="col-sm-8">
                                        <form:input path="pojo.code" size="40" cssClass="form-control"/>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label"><fmt:message key="authoring.template.name"/></label>
                                    <div class="col-sm-8">
                                        <form:input path="pojo.name" size="40" cssClass="form-control"/>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="form-group">
                                    <div class="col-sm-8 col-sm-offset-4">
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
                            <fmt:message key="authoring.template.list"/>
                        </div>
                        <div class="panel-body">
                            <div class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                                <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${formUrl}"
                                               partialList="true" sort="external" size="${items.totalItems}" defaultsort="2" uid="tableList" pagesize="${items.maxPageItems}"
                                               class="table table-striped table-bordered table-hover no-footer" export="false" >
                                    <display:column headerClass="table_header" sortable="false" style="width: 3%" title="<input type=\"checkbox\" name=\"allCheck\" id=\"allCheck\" onclick=\"checkAll('listForm', 'checkList', this)\">">
                                        <input type="checkbox" name="checkList" value="${tableList.authoringTemplateId}" onclick="checkAllIfOne('listForm', 'checkList', this, 'allCheck')">
                                    </display:column>

                                    <display:column headerClass="table_header" property="code" escapeXml="false" sortable="true" sortName="code" titleKey="authoring.template.code" style="width: 10%"/>
                                    <display:column headerClass="table_header" property="name" escapeXml="true" sortable="true" sortName="name" titleKey="authoring.template.name" style="width: 25%"/>
                                    <display:column headerClass="table_header" property="createdDate" sortable="true" sortName="createdDate" titleKey="authoring.template.created.date" style="width: 12%" format="{0,date,dd/MM/yyyy}"/>
                                    <display:column headerClass="table_header" property="modifiedDate" sortable="true" sortName="modifiedDate" titleKey="authoring.template.modified.date" style="width: 12%" format="{0,date,dd/MM/yyyy}"/>

                                    <display:column sortable="false"  headerClass="table_header" url="/admin/authoringtemplate/edit.html"
                                                    titleKey="label.actions" style="width: 10%">
                                        <a href="${editUrl}?pojo.authoringTemplateId=${tableList.authoringTemplateId}"><i class="fa fa-edit"></i></a> |
                                        <a class="deleteLink" id="${tableList.authoringTemplateId}"><i class="fa fa-remove"></i></a>
                                    </display:column>
                                    <display:setProperty name="paging.banner.item_name"><fmt:message key="authoring.template.title"/></display:setProperty>
                                    <display:setProperty name="paging.banner.items_name"><fmt:message key="authoring.template.title"/></display:setProperty>
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
