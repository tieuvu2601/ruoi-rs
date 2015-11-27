<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="categoryEntity.management"/></title>
    <meta name="heading" contentEntity="Category Management"/>
</head>
<c:url var="url" value="/admin/categoryEntity/edit.html"/>
<c:url var="backUrl" value="/admin/categoryEntity/list.html"/>

<form:form commandName="item" action="${formUrl}" method="post" id="itemForm" cssClass="form-horizontal">
    <div class="small-header transition animated fadeIn">
        <div class="hpanel">
            <div class="panel-body">
                <div id="hbreadcrumb" class="pull-right">
                    <ol class="hbreadcrumb breadcrumb">
                        <li><a href="<c:url value="/admin/dashboard.html"/>">Dashboard</a></li>
                        <li>
                            <span><fmt:message key="categoryEntity"/></span>
                        </li>
                        <li class="active">
                            <span><fmt:message key="categoryEntity.management"/></span>
                        </li>
                    </ol>
                </div>

                <h2 class="font-light m-b-xs">
                    <c:choose>
                        <c:when test="${not empty item.pojo.categoryID}">
                            <fmt:message key="categoryEntity.edit"/>
                        </c:when>
                        <c:otherwise>
                            <fmt:message key="categoryEntity.add"/>
                        </c:otherwise>
                    </c:choose>
                </h2>
            </div>
        </div>
    </div>

    <div class="contentEntity animate-panel">
        <div>
            <div class="row">
                <div class="col-lg-12 animated-panel zoomIn" style="animation-delay: 0.2s;">
                    <div class="hpanel">
                        <div class="panel-heading">
                            <div class="panel-tools">
                                <a class="showhide"><i class="fa fa-chevron-up"></i></a>
                            </div>
                            <fmt:message key="categoryEntity.management"/>
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
                                <label class="col-sm-2 control-label"><fmt:message key="categoryEntity.parent"/></label>
                                <div class="col-sm-8">
                                    <form:select path="pojo.parentCategoryEntity.categoryID" cssClass="form-control" onchange="setParentRootIdForCategory()" id="parentCategoryID">
                                        <form:option value="" parentRootId="-1"><fmt:message key="categoryEntity.choose.parent"/></form:option>
                                        <c:forEach var="cat" items="${categories}">
                                            <c:set var="parentRootID" value="-1"/>
                                            <c:if test="${not empty cat.parentRootId && cat.parentRootId > 0}">
                                                <c:set var="parentRootID" value="${cat.parentRootId}"/>
                                            </c:if>
                                            <option value="${cat.categoryID}" parentRootId="${parentRootID}" <c:if test="${cat.categoryID == item.pojo.parentCategoryEntity.categoryID}">selected</c:if>>
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
                                <label class="col-sm-2 control-label"><fmt:message key="categoryEntity.code"/></label>
                                <div class="col-sm-8">
                                    <form:input path="pojo.code" size="40" cssClass="form-control"/>
                                    <form:errors path="pojo.code" cssClass="validateError"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="categoryEntity.name"/></label>
                                <div class="col-sm-8">
                                    <form:input path="pojo.name" size="40" cssClass="form-control"/>
                                    <form:errors path="pojo.name" cssClass="validateError"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="categoryEntity.prefixurl"/></label>
                                <div class="col-sm-8">
                                    <form:input path="pojo.prefixUrl" size="40" cssClass="form-control"/>
                                    <form:errors path="pojo.prefixUrl" cssClass="validateError"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="categoryEntity.keyword"/></label>
                                <div class="col-sm-8">
                                    <form:input path="pojo.keyword" size="40" cssClass="form-control"/>
                                    <form:errors path="pojo.keyword" cssClass="validateError"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="categoryEntity.description"/></label>
                                <div class="col-sm-8">
                                    <form:textarea path="pojo.description" rows="5" cssStyle="resize: vertical" cssClass="form-control"/>
                                    <form:errors path="pojo.description" cssClass="validateError"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="categoryEntity.displayorder"/></label>
                                <div class="col-sm-8">
                                    <form:input path="pojo.displayOrder" size="20" cssClass="form-control"/>
                                    <form:errors path="pojo.displayOrder" cssClass="validateError"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="categoryEntity.authoringtemplate"/></label>
                                <div class="col-sm-8">
                                    <form:select path="pojo.authoringTemplateEntity.authoringTemplateID" cssClass="form-control">
                                        <form:option value=""><fmt:message key="label.select"/></form:option>
                                        <form:options itemValue="authoringTemplateID" itemLabel="name" items="${authoringtemplates}"/>
                                    </form:select>
                                    <form:errors path="pojo.authoringTemplateEntity.authoringTemplateID" cssClass="validateError"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="categoryEntity.renderingtemplate"/></label>
                                <div class="col-sm-8">
                                    <form:select path="pojo.renderingTemplate.renderingTemplateID" cssClass="form-control">
                                        <form:option value=""><fmt:message key="label.select"/></form:option>
                                        <form:options itemValue="renderingTemplateID" itemLabel="name" items="${renderingtemplates}"/>
                                    </form:select>
                                    <form:errors path="pojo.renderingTemplate.renderingTemplateID" cssClass="validateError"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label"><fmt:message key="categoryEntity.language.eng"/></label>
                                <div class="col-sm-8">
                                    <form:checkbox path="pojo.eng"/>
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
    <form:hidden path="pojo.categoryID"/>
    <form:hidden path="pojo.parentRootID" id="parentRootID"/>
</form:form>
<script>
    $(document).ready(function(){
//        setActiveMenu4Admin('#administration_menu', '#user_menu');
        $("#btnSave").click(function(){
            $("#crudaction").val("insert-update");
            $("#itemForm").submit();
        });


    });

    function setParentRootIdForCategory(){
        var parentRootIDElement =  $('#parentRootID');
        var parentRootID = $("select#parentCategoryID option:selected").attr('parentRootId');
        if(parentRootID != null && parentRootID != undefined && parentRootID > 0){
            $(parentRootIDElement).val(parentRootID);
        } else {
            $(parentRootIDElement).val("-1");
        }
    }
</script>