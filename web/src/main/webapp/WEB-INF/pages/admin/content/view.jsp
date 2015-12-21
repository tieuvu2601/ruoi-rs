<%@ include file="/common/taglibs.jsp"%>

<head>
    <title><fmt:message key="content.management"/></title>
    <meta name="heading" content="Content Management"/>
	<style>
        .content-title{
            width: 20%;
            vertical-align: middle;
            text-align: right;
        }
	</style>
</head>

<c:url var="formUrl" value="/admin/content/view.html"/>
<c:url var="backUrl" value="/admin/content/list.html"/>

<form:form commandName="item" action="${formUrl}" method="post" id="itemForm" cssClass="form-horizontal">
    <div class="small-header transition animated fadeIn">
        <div class="hpanel">
            <div class="panel-body">
                <div id="hbreadcrumb" class="pull-right">
                    <ol class="hbreadcrumb breadcrumb">
                        <li><a href="<c:url value="/admin/dashboard.html"/>"><fmt:message key="admin.dashboard"/></a></li>
                        <li>
                            <span><fmt:message key="content.title"/></span>
                        </li>
                        <li class="active">
                            <span><fmt:message key="content.management"/></span>
                        </li>
                    </ol>
                </div>
                <h2 class="font-light m-b-xs">
                    <fmt:message key="content.management"/>
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
                            <fmt:message key="content.information"/>
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
                                    <td class="content-title"><fmt:message key="content.title.title"/></td>
                                    <td class="content-content">${item.pojo.title}</td>
                                </tr>
                                <tr>
                                    <td class="content-title"><fmt:message key="content.header"/></td>
                                    <td class="content-content">${item.pojo.header}</td>
                                </tr>
                                <tr>
                                    <td class="content-title"><fmt:message key="content.keyword"/></td>
                                    <td class="content-content">${item.pojo.keyword}</td>
                                </tr>
                                <tr>
                                    <td class="content-title"><fmt:message key="content.description"/></td>
                                    <td class="content-content">${item.pojo.description}</td>
                                </tr>
                                <tr>
                                    <td class="content-title"><fmt:message key="content.thumbnails"/></td>
                                    <td class="content-content">
                                        <rep:href value="${item.pojo.thumbnails}" var="imgURL"/>
                                        <label class="col-sm-12 control-label text-default"><img src="<c:url value="${imgURL}"/>?w=120"/></label>
                                    </td>
                                </tr>

                                <c:if test="${item.pojo.authoringTemplate.areProduct == 1}">
                                    <tr>
                                        <td class="content-title"><fmt:message key="content.location.text"/></td>
                                        <td class="content-content">${item.pojo.locationText}</td>
                                    </tr>
                                    <tr>
                                        <td class="content-title"><fmt:message key="content.location"/></td>
                                        <td class="content-content">${item.pojo.location.name}</td>
                                    </tr>
                                    <tr>
                                        <td class="content-title"><fmt:message key="content.area"/></td>
                                        <td class="content-content">${item.pojo.area}</td>
                                    </tr>
                                    <tr>
                                        <td class="content-title"><fmt:message key="content.total.area"/></td>
                                        <td class="content-content">${item.pojo.totalArea}</td>
                                    </tr>
                                    <tr>
                                        <td class="content-title"><fmt:message key="content.area.ratio"/></td>
                                        <td class="content-content">${item.pojo.areaRatio}</td>
                                    </tr>
                                    <tr>
                                        <td class="content-title"><fmt:message key="content.number.of.block"/></td>
                                        <td class="content-content">${item.pojo.numberOfBlock}</td>
                                    </tr>
                                    <tr>
                                        <td class="content-title"><fmt:message key="content.cost"/></td>
                                        <td class="content-content">${item.pojo.cost}</td>
                                    </tr>
                                    <tr>
                                        <td class="content-title"><fmt:message key="content.is.hot.product"/></td>
                                        <td class="content-content">${item.pojo.hotItem}</td>
                                    </tr>
                                    <tr>
                                        <td class="content-title"><fmt:message key="content.is.new.product"/></td>
                                        <td class="content-content">${item.pojo.productStatus}</td>
                                    </tr>
                                </c:if>
                            </table>

                            <div class="form-group">
                                <div class="col-sm-8 col-sm-offset-2">
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
                            <fmt:message key="content.authoring.content"/>
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
        </div>
    </div>
    <form:hidden path="crudaction" id="crudaction"/>
    <form:hidden path="pojo.contentId"/>
</form:form>
<script type='text/javascript'>
    function submitContentForm(crudaction) {
        $('#crudaction').val(crudaction);
        $('#itemForm').submit();
    }
</script>
