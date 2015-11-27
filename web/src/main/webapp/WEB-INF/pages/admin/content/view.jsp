<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="contentEntity.management"/></title>
    <meta name="heading" contentEntity="Content Management"/>
    <link rel="stylesheet" type="text/css" href="<c:url value='/swfupload/default.css'/>" />
	<script type="text/javascript" src="<c:url value='/swfupload/swfupload.js' />"></script>
	<script type="text/javascript" src="<c:url value='/swfupload/fileprogress.js' />"></script>
	<script type="text/javascript" src="<c:url value='/swfupload/handlers.js' />"></script>
	
</head>

<c:url var="formUrl" value="/admin/contentEntity/view.html"/>
<c:url var="backUrl" value="/admin/contentEntity/list.html"/>

<form:form commandName="item" action="${formUrl}" method="post" id="itemForm" cssClass="form-horizontal">
    <div class="small-header transition animated fadeIn">
        <div class="hpanel">
            <div class="panel-body">
                <div id="hbreadcrumb" class="pull-right">
                    <ol class="hbreadcrumb breadcrumb">
                        <li><a href="<c:url value="/admin/dashboard.html"/>">Dashboard</a></li>
                        <li>
                            <span><fmt:message key="contentEntity"/></span>
                        </li>
                        <li class="active">
                            <span><fmt:message key="contentEntity.management"/></span>
                        </li>
                    </ol>
                </div>
                <h2 class="font-light m-b-xs">
                    <fmt:message key="contentEntity.management"/>
                </h2>
            </div>
        </div>
    </div>

    <div class="contentEntity animate-panel">
        <div>
            <c:if test="${empty ITEM_NOT_FOUND}">
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

                                <table width="100%" class="table table-striped table-bordered table-hover no-footer">
                                    <tr>
                                        <td style="width: 20%; vertical-align: middle; text-align: right">
                                            <fmt:message key="authoringtemplate.template"/>
                                        </td>
                                        <td>
                                            ${item.pojo.authoringTemplateEntity.name}
                                            <form:hidden path="pojo.authoringTemplateEntity"/>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td style="width: 20%; vertical-align: middle; text-align: right">
                                            <fmt:message key="contentEntity.title"/>
                                        </td>
                                        <td>
                                            ${item.pojo.title}
                                        </td>
                                    </tr>

                                    <tr>
                                        <td style="width: 20%; vertical-align: middle; text-align: right">
                                            <fmt:message key="contentEntity.keyword"/>
                                        </td>
                                        <td>
                                            ${item.pojo.keyword}
                                        </td>
                                    </tr>

                                    <c:if test="${authoring.hasThumbnail == 'Y'}">
                                        <tr>
                                            <td style="width: 20%; vertical-align: middle; text-align: right">
                                                <fmt:message key="contentEntity.thumbnail"/>
                                            </td>
                                            <td>
                                                <rep:href value="${item.pojo.thumbnail}" var="imgURL"/>
                                                <label class="col-sm-12 control-label text-default"><img src="<c:url value="${imgURL}"/>?w=100&h=120"/></label>
                                            </td>
                                        </tr>
                                    </c:if>

                                    <tr>
                                        <td style="width: 20%; vertical-align: middle; text-align: right">
                                            <fmt:message key="contentEntity.accesspolicy"/>
                                        </td>
                                        <td>
                                            <c:if test="${item.pojo.accessPolicy eq 1 }"><fmt:message key="contentEntity.accesspolicy.allowshare"/></c:if>
                                            <c:if test="${item.pojo.accessPolicy eq 2 }"><fmt:message key="contentEntity.accesspolicy.notallowshare"/></c:if>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td style="width: 20%; vertical-align: middle; text-align: right">
                                            <fmt:message key="contentEntity.displayorder"/>
                                        </td>
                                        <td>
                                                ${item.pojo.displayOrder}
                                        </td>
                                    </tr>

                                    <c:if test="${authoring.hasHotItem == 'Y'}">
                                        <tr>
                                            <td style="width: 20%; vertical-align: middle; text-align: right">
                                                <fmt:message key="contentEntity.hot"/>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${item.pojo.hot eq 1}"><fmt:message key="boolean.true"/></c:when>
                                                    <c:otherwise><fmt:message key="boolean.false"/></c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:if>

                                    <tr>
                                        <td style="width: 20%; vertical-align: middle; text-align: right">
                                            <fmt:message key="contentEntity.categoryEntity"/>
                                        </td>
                                        <td>
                                            <ul>
                                                <c:forEach items="${categories}" var="categoryEntity">
                                                    <li>${categoryEntity.name}</li>
                                                </c:forEach>
                                            </ul>
                                        </td>
                                    </tr>
                                </table>

                                <div class="form-group">
                                    <div class="col-sm-8 col-sm-offset-2">
                                        <c:choose>
                                            <c:when test="${item.pojo.status eq -2}">
                                                <security:authorize ifAnyGranted="AUTHOR,FULL_ACCESS_RIGHT">
                                                    <c:if test="${item.pojo.createdBy.userID eq currentUserID}">
                                                        <input class="btn w-xs btn-success" type="button" value="<fmt:message key="button.send"/>" onclick="submitContentForm('send')"/>
                                                    </c:if>
                                                </security:authorize>
                                            </c:when>

                                            <c:when test="${item.pojo.status eq 0}">
                                                <security:authorize ifAnyGranted="APPROVER,FULL_ACCESS_RIGHT">
                                                    <input class="btn w-xs btn-success" type="button" value="<fmt:message key="button.approve"/>" onclick="submitContentForm('approve');"/>

                                                    <input class="btn w-xs btn-danger2" type="button" value="<fmt:message key="contentEntity.reject"/>" onclick="submitContentForm('reject');"/>
                                                </security:authorize>
                                            </c:when>

                                            <c:when test="${item.pojo.status eq 1}">
                                                <security:authorize ifAnyGranted="PUBLISHER,FULL_ACCESS_RIGHT">
                                                    <input class="btn w-xs btn-success" type="button" value="<fmt:message key="button.public"/>" onclick="submitContentForm('public');"/>

                                                    <input class="btn w-xs btn-danger2" type="button" value="<fmt:message key="contentEntity.reject"/>" onclick="submitContentForm('reject');"/>
                                                </security:authorize>
                                            </c:when>

                                            <c:when test="${item.pojo.status eq 2}">
                                                <security:authorize ifAnyGranted="PUBLISHER,FULL_ACCESS_RIGHT">
                                                    <input class="btn w-xs btn-danger2" type="button" value="<fmt:message key="button.unpublic"/>" onclick="submitContentForm('reject');"/>
                                                </security:authorize>
                                            </c:when>

                                        </c:choose>
                                        <a href="${backUrl}" class="btn w-xs btn-default"><fmt:message key="button.back"/></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-12 animated-panel zoomIn" style="animation-delay: 0.2s;">
                        <div class="hpanel">
                            <div class="panel-heading">
                                <div class="panel-tools">
                                    <a class="showhide"><i class="fa fa-chevron-up"></i></a>
                                </div>
                                <fmt:message key="contentEntity.authoringcontent"/>
                            </div>

                            <div class="panel-body" style="display: block;">
                                <div class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                                    <table width="100%" class="table table-striped table-bordered table-hover no-footer">
                                        <c:forEach items="${item.contentItem.items.item}" var="node">
                                            <c:set var="minOccurs" value="${node.minOccurs}"/>
                                            <c:set var="maxOccurs" value="${node.maxOccurs}"/>
                                            <c:if test="${empty maxOccurs}">
                                                <c:set var="maxOccurs" value="5"/>
                                            </c:if>
                                            <tr>
                                                <td style="width: 20%; vertical-align: middle; text-align: right"><b>${node.displayName}</b>:</td>
                                                <td>
                                                    <c:forEach begin="1" end="${maxOccurs}" step="1" varStatus="statusIndex">
                                                        <c:set var="itemValue" value=""/>
                                                        <c:if test="${statusIndex.index <= fn:length(node.itemValue)}">
                                                            <c:set var="itemValue" value="${node.itemValue[statusIndex.index - 1]}"/>
                                                        </c:if>
                                                        <c:choose>
                                                            <c:when test="${node.itemType == 'BOOLEAN'}">
                                                                <c:if test="${itemValue == 1}"><fmt:message key="boolean.true"/></c:if>
                                                                <c:if test="${itemValue == 0}"><fmt:message key="boolean.false"/></c:if>
                                                            </c:when>
                                                            <c:when test="${node.itemType == 'NUMERIC'}">
                                                                ${itemValue}/><br/>
                                                            </c:when>
                                                            <c:when test="${node.itemType == 'PLAIN_TEXT'}">
                                                                ${itemValue}<br/>
                                                            </c:when>
                                                            <c:when test="${node.itemType == 'RICH_TEXT'}">
                                                                ${itemValue}
                                                            </c:when>
                                                            <c:when test="${node.itemType == 'IMAGE'}">
                                                                <c:if test="${not empty itemValue}">
                                                                    <rep:href value="${itemValue}" var="imgURL"/>
                                                                    <br/>
                                                                    <div id="i_${node.itemKey }${statusIndex.index}"><img src="<c:url value="${imgURL}?w=100"/>" width="100" />&nbsp;</div>
                                                                </c:if>

                                                            </c:when>
                                                            <c:when test="${node.itemType == 'ATTACHMENT'}">
                                                                <c:if test="${not empty itemValue}">
                                                                    <div id="i_${node.itemKey }${statusIndex.index}"><rep:href value='${itemValue}' />&nbsp;</div>
                                                                </c:if>
                                                            </c:when>
                                                        </c:choose>
                                                    </c:forEach>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
            <c:if test="${!empty ITEM_NOT_FOUND }">
                <div style="margin: 100px; text-align: center; font-size: 30px;">${ITEM_NOT_FOUND}</div>
                <div><input type="button" value="<fmt:message key="button.back"/>" onclick="document.location.href='${backUrl}';"/></div>
            </c:if>
        </div>
    </div>
    <form:hidden path="crudaction" id="crudaction"/>
    <form:hidden path="pojo.contentID"/>
</form:form>
<script type='text/javascript'>
    function submitContentForm(crudaction) {
        $('#crudaction').val(crudaction);
        $('#itemForm').submit();
    }
</script>
