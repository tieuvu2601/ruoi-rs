<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="opinion.management"/></title>
    <meta name="heading" content="<fmt:message key="opinion.management"/>"/>
</head>

<c:url var="formUrl" value="/admin/opinion/view.html"/>
<c:url var="backUrl" value="/admin/opinion/list.html"/>

<form:form commandName="item" action="${formUrl}" method="post" id="itemForm" cssClass="form-horizontal">
    <div class="small-header transition animated fadeIn">
        <div class="hpanel">
            <div class="panel-body">
                <div id="hbreadcrumb" class="pull-right">
                    <ol class="hbreadcrumb breadcrumb">
                        <li><a href="<c:url value="/admin/dashboard.html"/>">Dashboard</a></li>
                        <li>
                            <span><fmt:message key="opinion"/></span>
                        </li>
                        <li class="active">
                            <span><fmt:message key="opinion.management"/></span>
                        </li>
                    </ol>
                </div>

                <h2 class="font-light m-b-xs">
                    <fmt:message key="opinion.view"/>
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
                            <fmt:message key="opinion.management"/>
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
                                <label class="col-sm-2 control-label"><fmt:message key="opinion.name"/></label>
                                <div class="col-sm-8">
                                    <label class="col-sm-12 control-label text-default">${item.pojo.userName}</label>
                                    <form:hidden path="pojo.userName"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="opinion.email"/></label>
                                <div class="col-sm-8">
                                    <label class="col-sm-12 control-label text-default">${item.pojo.email}</label>
                                    <form:hidden path="pojo.email"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="opinion.phone.number"/></label>
                                <div class="col-sm-8">
                                    <label class="col-sm-12 control-label text-default">${item.pojo.phoneNumber}</label>
                                    <form:hidden path="pojo.phoneNumber"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="opinion.title"/></label>
                                <div class="col-sm-8">
                                    <label class="col-sm-12 control-label text-default">${item.pojo.title}</label>
                                    <form:hidden path="pojo.title"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="opinion.description"/></label>
                                <div class="col-sm-8">
                                    <label class="col-sm-12 control-label text-default">${item.pojo.description}</label>
                                    <form:hidden path="pojo.description"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-8 col-sm-offset-2">
                                    <c:if test="${item.pojo.status == 0}">
                                        <a id="btnSave" class="btn w-xs btn-primary">Resolved</a>
                                    </c:if>
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
    <form:hidden path="pojo.opinionID"/>
</form:form>
<script>
    $(document).ready(function(){
//        setActiveMenu4Admin('#administration_menu', '#user_menu');
        $("#btnSave").click(function(){
            $("#crudaction").val("resolved");
            $("#itemForm").submit();
        });
    });
</script>