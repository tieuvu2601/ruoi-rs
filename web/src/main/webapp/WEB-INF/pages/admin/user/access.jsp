<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="role.management"/></title>
    <meta name="heading" content="<fmt:message key="role.management"/>"/>
</head>
<c:url var="backUrl" value="/admin/user/list.html"/>
<c:url var="formUrl" value="/admin/user/access.html"/>

<form:form commandName="item" action="${formUrl}" method="post" id="itemForm" cssClass="form-horizontal">
    <div class="small-header transition animated fadeIn">
        <div class="hpanel">
            <div class="panel-body">
                <div id="hbreadcrumb" class="pull-right">
                    <ol class="hbreadcrumb breadcrumb">
                        <li><a href="<c:url value="/admin/dashboard.html"/>"><fmt:message key="admin.dashboard"/></a></li>
                        <li>
                            <span><fmt:message key="user"/></span>
                        </li>
                        <li class="active">
                            <span><fmt:message key="user.management"/></span>
                        </li>
                    </ol>
                </div>
                <h2 class="font-light m-b-xs">
                    <fmt:message key="user.access"/>
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
                            Information
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
                                <label class="col-sm-2 control-label"><fmt:message key="user.username"/></label>
                                <div class="col-sm-8">
                                    <label class="col-sm-12 control-label text-default">${item.pojo.username}</label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="user.displayname"/></label>
                                <div class="col-sm-8">
                                    <label class="col-sm-12 control-label text-default">${item.pojo.displayName}</label>
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

            <div class="row">
                <div class="col-lg-12 animated-panel zoomIn" style="animation-delay: 0.1s;">
                    <div class="hpanel">
                        <div class="panel-heading">
                            <div class="panel-tools">
                                <a class="showhide"><i class="fa fa-chevron-up"></i></a>
                            </div>
                            <fmt:message key="user.list"/>
                        </div>
                        <div class="panel-body">
                            <div class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                                <display:table name="item.roleBean.listResult" cellspacing="0" cellpadding="0" requestURI="${url}"
                                               excludedParams="crudaction" partialList="true" sort="external" size="${item.roleBean.totalItems}" defaultsort="2" uid="tableList" pagesize="${item.roleBean.maxPageItems}"
                                               class="table table-striped table-bordered table-hover no-footer" export="false">

                                    <display:column headerClass="table_header" sortable="false" style="width: 3%" title="<input type=\"checkbox\" name=\"allCheck\" id=\"allCheck\" onclick=\"checkAll('itemForm', 'roleBean.checkList', this)\">">
                                        <input type="checkbox" name="roleBean.checkList" value="${tableList.roleId}" onclick="checkAllIfOne('listForm', 'checkList', this, 'allCheck')"<c:if test="${item.roleMap[tableList.roleId] eq true}">checked="true"</c:if>>
                                    </display:column>

                                    <display:column headerClass="table_header"  escapeXml="false" sortable="true" sortName="role" titleKey="role.role" style="width: 10%" >
                                        ${tableList.role}
                                    </display:column>

                                    <display:column headerClass="table_header" property="name" escapeXml="true" sortable="true" sortName="name" titleKey="role.name" style="width: 10%"/>

                                    <display:column headerClass="table_header" property="description" escapeXml="true" sortable="true" sortName="description" titleKey="role.description" style="width: 27%"/>

                                    <display:setProperty name="paging.banner.item_name"><fmt:message key="role"/></display:setProperty>
                                    <display:setProperty name="paging.banner.items_name"><fmt:message key="role"/></display:setProperty>
                                    <display:setProperty name="paging.banner.placement" value="bottom"/>
                                    <display:setProperty name="paging.banner.no_items_found" value=""/>
                                    <display:setProperty name="paging.banner.onepage" value=""/>
                                    <display:setProperty name="basic.msg.empty_list" value="" />
                                    <display:setProperty name="basic.msg.empty_list_row" value=""/>
                                </display:table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <form:hidden path="crudaction" id="crudaction"/>
    <form:hidden path="pojo.userId"/>
    <form:hidden path="roleBean.firstItem"/>
</form:form>


<script type="text/javascript">
    $(document).ready(function(){
//        setActiveMenu4Admin('#administration_menu', '#user_menu');
        $("#btnSave").click(function(){
            $("#crudaction").val("access");
            $("#itemForm").submit();
        });
    });
</script>
