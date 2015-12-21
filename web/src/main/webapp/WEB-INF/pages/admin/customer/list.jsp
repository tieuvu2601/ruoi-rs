<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="customer.management"/></title>
    <meta name="heading" content="<fmt:message key="customer.management"/>"/>
</head>
<c:url var="formUrl" value="/admin/customer/list.html"/>
<c:url var="editUrl" value="/admin/customer/edit.html"/>

<div class="small-header transition animated fadeIn">
    <div class="hpanel">
        <div class="panel-body">
            <div id="hbreadcrumb" class="pull-right">
                <ol class="hbreadcrumb breadcrumb">
                    <li><a href="<c:url value="/admin/dashboard.html"/>"><fmt:message key="admin.dashboard"/></a></li>
                    <li>
                        <span><fmt:message key="customer.title"/></span>
                    </li>
                    <li class="active">
                        <span><fmt:message key="customer.management"/></span>
                    </li>
                </ol>
            </div>
            <h2 class="font-light m-b-xs">
                <fmt:message key="customer.management"/>
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
                                    <label class="col-sm-4 control-label"><fmt:message key="customer.email"/></label>
                                    <div class="col-sm-8">
                                        <form:input path="pojo.email" size="100" cssClass="form-control"/>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label"><fmt:message key="customer.full.name"/></label>
                                    <div class="col-sm-8">
                                        <form:input path="pojo.fullName" size="255" cssClass="form-control"/>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label"><fmt:message key="customer.address"/></label>
                                    <div class="col-sm-8">
                                        <form:input path="pojo.address" size="255" cssClass="form-control"/>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label"><fmt:message key="customer.location"/></label>
                                    <div class="col-sm-8">
                                        <form:select path="pojo.location.locationId" cssClass="form-control">
                                            <form:option value="-1"><fmt:message key="label.all"/></form:option>
                                            <form:options items="${locations}" itemLabel="name" itemValue="locationId"></form:options>
                                        </form:select>
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
                                <a href="${importUrl}"class=""><i class="fa fa-caret-square-o-up"></i> <fmt:message key="button.import"/></a>
                                <a href="${exportUrl}"class=""><i class="fa fa-caret-square-o-down"></i> <fmt:message key="button.export"/></a>

                                <a href="${editUrl}"class=""><i class="fa fa-plus"></i> <fmt:message key="button.add"/></a>
                                <a class="showhide"><i class="fa fa-chevron-up"></i></a>
                            </div>
                            <fmt:message key="customer.list"/>
                        </div>
                        <div class="panel-body">
                            <div class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                                <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${formUrl}"
                                               partialList="true" sort="external" size="${items.totalItems}" defaultsort="2" uid="tableList" pagesize="${items.maxPageItems}"
                                               class="table table-striped table-bordered table-hover no-footer" export="false" excludedParams="crudaction">

                                    <display:column headerClass="table_header" sortable="false" style="width: 3%" title="<input type=\"checkbox\" name=\"allCheck\" id=\"allCheck\" onclick=\"checkAll('listForm', 'checkList', this)\">">
                                        <input type="checkbox" name="checkList" value="${tableList.customerId}" onclick="checkAllIfOne('listForm', 'checkList', this, 'allCheck')">
                                    </display:column>
                                    <display:column headerClass="table_header" property="fullName"      escapeXml="false"   sortable="true" sortName="fullName" titleKey="customer.full.name" style="width: 15%"/>
                                    <display:column headerClass="table_header" property="email"         escapeXml="true"    sortable="true" sortName="email" titleKey="customer.email" style="width: 15%"/>
                                    <display:column headerClass="table_header" property="phoneNumber"   escapeXml="true"    sortable="true" sortName="phoneNumber" titleKey="customer.phone.number" style="width: 15%"/>
                                    <display:column headerClass="table_header" property="address"       escapeXml="true"    sortable="true" sortName="address" titleKey="customer.address" style="width: 30%"/>
                                    <display:column headerClass="table_header" property="location.name" sortable="true"     sortName="location.name" titleKey="customer.location" style="width: 15%"/>
                                    <display:column headerClass="table_header" sortable="false" titleKey="label.actions" style="width: 7%; text-align: center;">
                                        <a href="${editUrl}?pojo.customerId=${tableList.customerId}"><i class="fa fa-edit"></i></a> |
                                        <a class="deleteLink" id="${tableList.customerId}"><i class="fa fa-remove"></i></a>
                                    </display:column>

                                    <display:setProperty name="paging.banner.item_name"><fmt:message key="customer.title"/></display:setProperty>
                                    <display:setProperty name="paging.banner.items_name"><fmt:message key="customer.title"/></display:setProperty>
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