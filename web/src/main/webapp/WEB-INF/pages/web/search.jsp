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
    </style>
</head>
<body>
<div class="container content-sm">
    <div class="row">
        <div class="col-md-9 md-margin-bottom-50">
            <div class="table-responsive">
                <table class="table table-hover table-striped table-boxed" id="data-table">
                    <tr>
                        <td style="width: 5%">#</td>
                        <td>Link</td>
                        <td style="text-align: right;">Published Date</td>
                    </tr>
                    <c:forEach var="result" items="${item.listResult}" varStatus="itemStatus">
                        <c:set var="resultDataXML" value="${portal:parseContentXML(result.xmlData)}"/>
                        <seo:url value="${result.title}" var="resultUrl" prefix="/${result.category.prefixUrl}/${result.contentId}/"/>
                        <tr>
                            <td style="text-align: center;">${item.firstItem + itemStatus.count}</td>
                            <td><a href="${resultUrl}">${result.header}</a></td>
                            <td style="text-align: right;"><fmt:formatDate value="${result.publishedDate}" pattern="dd-MM-yyyy"/></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <ul class="pager pager-v4 pager-pagination">
                <c:set var="currentPagerNumber" value="${pageNumber}"/>
                <c:set var="seoURL" value=""/>
                <c:choose>
                    <c:when test="${pageNumber > 3}">
                        <li class="previous"><a class="page-number" pageNumb="1"><i class="fa fa-angle-double-left"></i></a></li>

                        <c:forEach begin="${pageNumber - 2}" end="${pageNumber + 2}" step="1" var="pageNumb">
                            <c:if test="${pageNumb <= maxPageNumber}">
                                <li <c:if test="${pageNumb == pageNumber}">class="active"</c:if>>
                                    <a class="page-number" pageNumb="${pageNumb}">${pageNumb}</a></li>
                                <c:set var="currentPagerNumber" value="${pageNumb}"/>
                            </c:if>
                        </c:forEach>

                        <c:if test="${maxPageNumber > currentPagerNumber}">
                            <li class="next"><a class="page-number" pageNumb="${maxPageNumber}"><i class="fa fa-angle-double-right"></i></a></li>
                        </c:if>
                    </c:when>

                    <c:otherwise>
                        <c:forEach begin="1" end="5" step="1" var="pageNumb">
                            <c:if test="${pageNumb <= maxPageNumber}">
                                <li <c:if test="${pageNumb == pageNumber}">class="active"</c:if>>
                                    <a class="page-number" pageNumb="${pageNumb}">${pageNumb}</a></li>
                                <c:set var="currentPagerNumber" value="${pageNumb}"/>
                            </c:if>
                        </c:forEach>
                        <c:if test="${maxPageNumber > currentPagerNumber}">
                            <li class="next"><a class="page-number" pageNumb="${maxPageNumber}"><i class="fa fa-angle-double-right"></i></a></li>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>

        <div class="col-md-3">
            <form:form method="post" commandName="item" action="${searchByKeyword}" id="searchFromInSite">
                <div class="form-group">
                    <label>Keyword or Title</label>
                    <form:input path="keyword" cssClass="form-control keyword-search" placeholder="Key word or title" id="keyword" />
                </div>

                <div class="form-group">
                    <label>From date</label>
                    <div class="input-group date">
                        <input type="text" id="fromDate" name="fromDate" class="form-control" value="<fmt:formatDate value="${item.fromDate}" pattern="dd/MM/yyyy"/>" data-date-format="dd/mm/yyyy"><span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
                    </div>
                </div>

                <div class="form-group date">
                    <label>To date</label>
                    <div class="input-group date">
                        <input type="text" id="toDate" name="toDate" class="form-control" value="<fmt:formatDate value="${item.toDate}" pattern="dd/MM/yyyy"/>" data-date-format="dd/mm/yyyy"><span class="input-group-addon"><i class="glyphicon glyphicon-th"></i></span>
                    </div>
                </div>
                <div class="">
                    <a id="btnFilter" class="btn-u btn-u-blue"><i class="fa fa-fw fa-search"></i> Search</a>
                    <a id="btnReset" class="btn-u btn-u-orange"><i class="fa fa-fw fa-refresh"></i> Reset</a>
                </div>

                <form:hidden path="crudaction" cssClass="crudaction" id="crudaction-search-page"/>
                <form:hidden path="pageNumber" id="pageNumber"/>
            </form:form>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function(){
        $('#fromDate').datepicker({});
        $('#toDate').datepicker({});

        $('.page-number').click(function(){
            var pageNumber = $(this).attr('pageNumb');
            $('#pageNumber').val(pageNumber);
            searchInSite(pageNumber);
        });

        $("#btnFilter").click(function(){
            searchInSite(1);
        });

        $('input.keyword-search').keypress(function (e) {
            if (e.which == 13) {
                searchInSite(1);
            }
        });

        $("#btnReset").click(function(){
            $(".form-control").each(function(){
                $(this).val('');
            });
        });
    });

    function searchInSite(pageNumber){
        $('#pageNumber').val(pageNumber);
        $('#crudaction-search-page').val("search");
        $("#searchFromInSite").submit();
    }
</script>
</body>
</html>


