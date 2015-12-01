<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="user.management"/></title>
    <meta name="heading" content="User Management"/>
</head>

<c:url var="formUrl" value="/admin/user/edit.html"/>
<c:url var="backUrl" value="/admin/user/list.html"/>

<form:form commandName="item" action="${formUrl}" method="post" id="itemForm" enctype="multipart/form-data" cssClass="form-horizontal">
    <div class="small-header transition animated fadeIn">
        <div class="hpanel">
            <div class="panel-body">
                <div id="hbreadcrumb" class="pull-right">
                    <ol class="hbreadcrumb breadcrumb">
                        <li><a href="<c:url value="/admin/dashboard.html"/>">Dashboard</a></li>
                        <li>
                            <span><fmt:message key="user"/></span>
                        </li>
                        <li class="active">
                            <span><fmt:message key="user.management"/></span>
                        </li>
                    </ol>
                </div>
                <h2 class="font-light m-b-xs">
                    <c:choose>
                        <c:when test="${not empty item.pojo.userId}">
                            <fmt:message key="user.edit"/>
                        </c:when>
                        <c:otherwise>
                            <fmt:message key="user.add"/>
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
                            <fmt:message key="user.management"/>
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
                                    <form:input id="username" path="pojo.username" size="40" cssClass="form-control"/>
                                    <form:errors path="pojo.username" cssClass="validateError"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="user.password"/></label>
                                <div class="col-sm-8">
                                    <form:password id="password" path="pojo.password" size="40" cssClass="form-control"/>
                                    <form:errors path="pojo.password" cssClass="validateError"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="user.email"/></label>
                                <div class="col-sm-8">
                                    <form:input id="email" path="pojo.email" size="40" cssClass="form-control"/>
                                    <form:errors path="pojo.email" cssClass="validateError"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="user.firstname"/></label>
                                <div class="col-sm-8">
                                    <form:input id="firstName" path="pojo.firstName" size="40" cssClass="form-control"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="user.lastname"/></label>
                                <div class="col-sm-8">
                                    <form:input id="lastName" path="pojo.lastName" size="40" cssClass="form-control"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="user.displayname"/></label>
                                <div class="col-sm-8">
                                    <form:input id="displayName" path="pojo.displayName" size="40" cssClass="form-control"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="user.mobile"/></label>
                                <div class="col-sm-8">
                                    <form:input path="pojo.mobileNumber" size="40" cssClass="form-control"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="user.status"/></label>
                                <div class="col-sm-8">
                                    <form:radiobutton path="pojo.status" value="1" cssClass="radio-primary"/><fmt:message key="user.status.active"/>
                                    <form:radiobutton path="pojo.status" value="0" cssClass="radio-primary"/><fmt:message key="user.stauts.disable"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="user.fullaccess"/></label>
                                <div class="col-sm-8">
                                    <form:checkbox path="pojo.fullAccess" value="1"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="usergroup"/></label>
                                <div class="col-sm-8">
                                    <select name="pojo.userGroup.userGroupId" class="form-control">
                                        <c:forEach items="${userGroups}" var="usg">
                                            <option value="${usg.userGroupId}" <c:if test="${not empty item.pojo.userGroup && item.pojo.userGroup.userGroupId == usg.userGroupId}">selected</c:if>>${usg.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="user.form.avatar"/></label>
                                <div class="col-sm-8">
                                    <input type="file" name="fileItem" class="form-control"/>
                                    <c:if test="${!empty item.pojo.avatar }">
                                        <rep:href value="${item.pojo.avatar}" var="thumbnailURL"/>
                                        <img src="<c:url value="${thumbnailURL}?w=100"/>" style="max-width: 100px;max-height: 100px;"/>
                                    </c:if>
                                    <form:hidden path="pojo.avatar"/>
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
    <form:hidden path="pojo.userId"/>
</form:form>
<script>
    $(document).ready(function(){
//        setActiveMenu4Admin('#administration_menu', '#user_menu');
        $("#btnSave").click(function(){
            $("#crudaction").val("insert-update");
            $("#itemForm").submit();
        });
    });
</script>