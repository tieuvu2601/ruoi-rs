<%@ include file="/common/taglibs.jsp"%>
<c:url var="searchByKeyword" value="/search.html"/>
<html>
<head>
    <title><fmt:message key="label.search"/></title>
    <meta name="description" content="<fmt:message key="label.search"/>">
    <meta name="keywords" content="<fmt:message key="label.search"/>">

    <link rel="stylesheet" href="<c:url value="/themes/admin/vendor/bootstrap-datepicker-master/dist/css/bootstrap-datepicker3.min.css"/>"/>
    <script src="<c:url value="/themes/admin/vendor/bootstrap-datepicker-master/dist/js/bootstrap-datepicker.min.js"/>"></script>
    <style>
        a.page-number:hover{
            cursor: pointer;

        }
        ul.site-map-container {
            padding: 0;
            margin: 0;
            list-style: none;
        }
        ul.site-map-container span.site-map-header{
            width: 100%;
            float: left;

        }
        li.site-map-item {
            width: 50%;
            float: left;
        }
    </style>
    </head>
<body>
<div class="container content-sm">
    <div class="row">
        <div class="col-md-12 md-margin-bottom-50">
            <div class="table-responsive">
                <table class="table table-hover table-boxed" id="data-table">
                    <tbody>
                    <c:forEach var="category" items="${categoryResult}" varStatus="categoryStatus">
                        <tr>
                            <td>
                                <span class="site-map-header">
                                    <c:if test="${not empty category.parent && category.parent.categoryId > 0}">
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    </c:if>
                                    <strong>${category.name}</strong></span>
                            </td>
                            <td></td>
                        </tr>
                        <c:set var="listContent" value="${mapContentResult[category.categoryId]}"/>
                        <c:forEach var="item" varStatus="itemStatus" items="${listContent}">
                            <seo:url value="${item.title}" var="resultUrl" prefix="/${item.category.prefixUrl}/${item.contentId}/"/>
                            <tr>
                                <td>
                                    <c:if test="${not empty item.category.parent && item.category.parent.categoryId > 0}">
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    </c:if>
                                    &nbsp;&nbsp;&nbsp;<a href="${resultUrl}">${item.header}</a>
                                </td>
                                <td style="text-align: right;">
                                    <fmt:formatDate value="${item.publishedDate}" pattern="dd-MM-yyyy"/>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>


