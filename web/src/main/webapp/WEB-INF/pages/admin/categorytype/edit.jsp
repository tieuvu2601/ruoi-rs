<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="category.type.management"/></title>
    <meta name="heading" content="Category Management"/>
</head>
<c:url var="url" value="/admin/category-type/edit.html"/>
<c:url var="backUrl" value="/admin/category-type/list.html"/>

<form:form commandName="item" action="${formUrl}" method="post" id="itemForm" cssClass="form-horizontal">
    <div class="small-header transition animated fadeIn">
        <div class="hpanel">
            <div class="panel-body">
                <div id="hbreadcrumb" class="pull-right">
                    <ol class="hbreadcrumb breadcrumb">
                        <li><a href="<c:url value="/admin/dashboard.html"/>"><fmt:message key="admin.dashboard"/></a></li>
                        <li>
                            <span><fmt:message key="category.type.management"/></span>
                        </li>
                        <li class="active">
                            <span><fmt:message key="category.type.management"/></span>
                        </li>
                    </ol>
                </div>

                <h2 class="font-light m-b-xs">
                    <c:choose>
                        <c:when test="${not empty item.pojo.categoryTypeId}">
                            <fmt:message key="category.type.edit"/>
                        </c:when>
                        <c:otherwise>
                            <fmt:message key="category.type.add"/>
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
                            <fmt:message key="category.type.management"/>
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
                                <label class="col-sm-2 control-label"><fmt:message key="category.type.code"/></label>
                                <div class="col-sm-8">
                                    <form:input path="pojo.code" size="40" cssClass="form-control"/>
                                    <form:errors path="pojo.code" cssClass="validateError"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="category.type.name"/></label>
                                <div class="col-sm-8">
                                    <form:input path="pojo.name" size="40" cssClass="form-control"/>
                                    <form:errors path="pojo.name" cssClass="validateError"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="category.type.unit"/></label>
                                <div class="col-sm-8">
                                    <form:input path="pojo.unit" size="40" cssClass="form-control"/>
                                    <form:errors path="pojo.unit" cssClass="validateError"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="category.type.description"/></label>
                                <div class="col-sm-8">
                                    <form:textarea path="pojo.description" rows="5" cssStyle="resize: vertical" cssClass="form-control"/>
                                    <form:errors path="pojo.description" cssClass="validateError"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="category.type.display.order"/></label>
                                <div class="col-sm-8">
                                    <form:input path="pojo.displayOrder" size="20" cssClass="form-control"/>
                                    <form:errors path="pojo.displayOrder" cssClass="validateError"/>
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
    <form:hidden path="pojo.categoryTypeId"/>
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