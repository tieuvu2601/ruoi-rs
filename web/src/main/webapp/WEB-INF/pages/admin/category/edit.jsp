<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="category.management"/></title>
    <meta name="heading" content="Category Management"/>
</head>
<c:url var="url" value="/admin/category/edit.html"/>
<c:url var="backUrl" value="/admin/category/list.html"/>

<form:form commandName="item" action="${formUrl}" method="post" id="itemForm" cssClass="form-horizontal">
    <div class="small-header transition animated fadeIn">
        <div class="hpanel">
            <div class="panel-body">
                <div id="hbreadcrumb" class="pull-right">
                    <ol class="hbreadcrumb breadcrumb">
                        <li><a href="<c:url value="/admin/dashboard.html"/>"><fmt:message key="admin.dashboard"/></a></li>
                        <li>
                            <span><fmt:message key="category.title"/></span>
                        </li>
                        <li class="active">
                            <span><fmt:message key="category.management"/></span>
                        </li>
                    </ol>
                </div>

                <h2 class="font-light m-b-xs">
                    <c:choose>
                        <c:when test="${not empty item.pojo.categoryId}">
                            <fmt:message key="category.edit"/>
                        </c:when>
                        <c:otherwise>
                            <fmt:message key="category.add"/>
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
                            <fmt:message key="category.management"/>
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
                                <label class="col-sm-2 control-label"><fmt:message key="category.parent"/></label>
                                <div class="col-sm-8">
                                    <form:select path="pojo.parent.categoryId" cssClass="form-control" id="parentCategoryId">
                                        <form:option value="" parentRootId="-1"><fmt:message key="label.select"/></form:option>
                                        <c:forEach var="cat" items="${categories}">
                                            <option value="${cat.categoryId}" <c:if test="${cat.categoryId == item.pojo.parent.categoryId}">selected</c:if>>
                                                <c:forEach begin="1" end="${cat.nodeLevel}">
                                                    - - -
                                                </c:forEach>
                                                    ${cat.name}
                                            </option>
                                        </c:forEach>
                                    </form:select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="category.code"/></label>
                                <div class="col-sm-8">
                                    <form:input path="pojo.code" size="40" cssClass="form-control"/>
                                    <form:errors path="pojo.code" cssClass="validateError"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="category.name"/></label>
                                <div class="col-sm-8">
                                    <form:input path="pojo.name" size="40" cssClass="form-control"/>
                                    <form:errors path="pojo.name" cssClass="validateError"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="category.prefix.url"/></label>
                                <div class="col-sm-8">
                                    <form:input path="pojo.prefixUrl" size="40" cssClass="form-control"/>
                                    <form:errors path="pojo.prefixUrl" cssClass="validateError"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="category.title.content"/></label>
                                <div class="col-sm-8">
                                    <form:input path="pojo.title" cssClass="form-control" size="160" maxlength="160"/>
                                    <form:errors path="pojo.title" cssClass="validateError"/>
                                    <span class="help-block m-b-none">Title to using to seo. It should has length 160 character</span>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="category.keyword"/></label>
                                <div class="col-sm-8">
                                    <form:input path="pojo.keyword" cssClass="form-control" size="160" maxlength="160"/>
                                    <form:errors path="pojo.keyword" cssClass="validateError"/>
                                    <span class="help-block m-b-none">Key word to using to seo. It should has length 160 character</span>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="category.description"/></label>
                                <div class="col-sm-8">
                                    <form:input path="pojo.description" cssClass="form-control" size="160" maxlength="160"/>
                                    <form:errors path="pojo.description" cssClass="validateError"/>
                                    <span class="help-block m-b-none">Description to using to seo. It should has length 160 character</span>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="category.display.order"/></label>
                                <div class="col-sm-8">
                                    <form:input path="pojo.displayOrder" size="20" cssClass="form-control"/>
                                    <form:errors path="pojo.displayOrder" cssClass="validateError"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="authoring.template.title"/></label>
                                <div class="col-sm-8">
                                    <form:select path="pojo.authoringTemplate.authoringTemplateId" cssClass="form-control">
                                        <form:option value=""><fmt:message key="label.select"/></form:option>
                                        <form:options itemValue="authoringTemplateId" itemLabel="name" items="${authoringTemplates}"/>
                                    </form:select>
                                    <form:errors path="pojo.authoringTemplate.authoringTemplateId" cssClass="validateError"/>
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
    <form:hidden path="pojo.categoryId"/>
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