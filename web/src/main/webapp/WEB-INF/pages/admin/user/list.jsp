﻿<%@ include file="/common/taglibs.jsp"%>
<head>
    <title><fmt:message key="userEntity.management"/></title>
    <meta name="heading" contentEntity="<fmt:message key="userEntity.management"/>"/>
</head>
<c:url var="formUrl" value="/admin/user/list.html"/>
<c:url var="editUrl" value="/admin/user/edit.html"/>
<c:url var="accessUrl" value="/admin/user/access.html"/>
<c:url var="departmentACLUrl" value="/admin/user/departmentACL.html"/>
<div class="small-header transition animated fadeIn">
    <div class="hpanel">
        <div class="panel-body">
            <div id="hbreadcrumb" class="pull-right">
                <ol class="hbreadcrumb breadcrumb">
                    <li><a href="<c:url value="/admin/dashboard.html"/>">Dashboard</a></li>
                    <li>
                        <span><fmt:message key="userEntity"/></span>
                    </li>
                    <li class="active">
                        <span><fmt:message key="userEntity.management"/></span>
                    </li>
                </ol>
            </div>
            <h2 class="font-light m-b-xs">
                <fmt:message key="userEntity.management"/>
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
                            Filter
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
                                    <label class="col-sm-4 control-label"><fmt:message key="userEntity.username"/></label>
                                    <div class="col-sm-8"><form:input path="pojo.username" size="40" cssClass="form-control"/></div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-4 control-label"><fmt:message key="usergroup"/></label>
                                    <div class="col-sm-8">
                                        <select name="pojo.userGroupEntity.userGroupID" class="form-control">
                                            <option value=""><fmt:message key="userEntity.usergroup.select" /></option>
                                            <c:forEach var="group" items="${userGroups }">
                                                <option value="${group.userGroupID }" <c:if test="${items.pojo.userGroupEntity.userGroupID eq group.userGroupID }">selected="selected"</c:if>>${group.name }</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label"><fmt:message key="userEntity.firstname"/></label>
                                    <div class="col-sm-8"><form:input path="pojo.firstName" size="40" cssClass="form-control"/></div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-4 control-label"><fmt:message key="userEntity.lastname"/></label>
                                    <div class="col-sm-8"><form:input path="pojo.lastName" size="40" cssClass="form-control"/></div>
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
                            <fmt:message key="userEntity.list"/>
                        </div>
                        <div class="panel-body">
                            <div class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                                <display:table name="items.listResult" cellspacing="0" cellpadding="0" requestURI="${formUrl}"
                                               partialList="true" sort="external" size="${items.totalItems}" defaultsort="2" uid="tableList" pagesize="${items.maxPageItems}"
                                               class="table table-striped table-bordered table-hover no-footer"  export="false" excludedParams="crudaction">
                                    <display:column headerClass="table_header" sortable="false" style="width: 3%" title="<input type=\"checkbox\" name=\"allCheck\" id=\"allCheck\" onclick=\"checkAll('listForm', 'checkList', this)\">">
                                        <input type="checkbox" name="checkList" value="${tableList.userID}" onclick="checkAllIfOne('listForm', 'checkList', this, 'allCheck')">
                                    </display:column>

                                    <display:column headerClass="table_header" property="firstName" escapeXml="true" sortable="true" sortName="firstName" titleKey="userEntity.firstname" style="width: 15%"/>
                                    <display:column headerClass="table_header" property="lastName" escapeXml="true" sortable="true" sortName="lastName" titleKey="userEntity.lastname" style="width: 20%"/>
                                    <display:column headerClass="table_header" property="displayName" escapeXml="false" sortable="true" sortName="displayName" titleKey="userEntity.displayname" style="width: 25%" />
                                    <display:column headerClass="table_header" property="userGroupEntity.name" escapeXml="true" sortable="true" sortName="userGroupEntity.name" titleKey="userEntity.usergroup" style="width: 25%"/>
                                    <display:column sortable="false"  headerClass="table_header" titleKey="label.options" style="width: 12%; text-align: center;">
                                        <a title="Phân quyền phòng ban" href="${departmentACLUrl}?userID=${tableList.userID}"><i class="fa fa-legal"></i></a> |
                                        <a title="Phân quyền ứng dụng" href="${accessUrl}?pojo.userID=${tableList.userID}"><i class="fa fa-key"></i></a> |
                                        <a href="${editUrl}?pojo.userID=${tableList.userID}"><i class="fa fa-edit"></i></a> |
                                        <a id="${tableList.userID}" class="deleteLink"><i class="fa fa-remove"></i></a>
                                    </display:column>
                                    <display:setProperty name="paging.banner.item_name"><fmt:message key="userEntity"/></display:setProperty>
                                    <display:setProperty name="paging.banner.items_name"><fmt:message key="userEntity"/></display:setProperty>
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

