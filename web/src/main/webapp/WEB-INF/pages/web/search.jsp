<%@ include file="/common/taglibs.jsp"%>
<c:url var="searchByKeyword" value="/search.html"/>
<head>
    <title><fmt:message key="label.search"/></title>
    <meta name="heading" content="Home Page"/>

    <link rel="stylesheet" href="<c:url value="/themes/themeadmin/vendor/bootstrap/dist/css/bootstrap.css"/>"/>
    <link rel="stylesheet" href="<c:url value="/themes/themeadmin/vendor/bootstrap-datepicker-master/dist/css/bootstrap-datepicker3.min.css"/>"/>

    <script src="<c:url value="/themes/themeadmin/vendor/bootstrap/dist/js/bootstrap.min.js"/>"></script>
    <script src="<c:url value="/themes/themeadmin/vendor/moment/moment.js"/>"></script>
    <script src="<c:url value="/themes/themeadmin/vendor/bootstrap-datepicker-master/dist/js/bootstrap-datepicker.min.js"/>"></script>

    <style>
        a.page-number:hover{
            cursor: pointer;

        }
    </style>
</head>


<div class="content container">
    <div class="page-wrapper">
        <header class="page-heading clearfix">
            <h1 class="heading-title pull-left">Search in site</h1>
        </header>

        <div class="page-content">
            <div class="row">
                <article class="contact-form col-md-8 col-sm-7  page-row">
                    <div class="table-responsive">
                        <table class="table table-hover table-striped table-boxed" id="data-table">
                            <tr>
                                <td style="width: 5%">#</td>
                                <td>Link</td>
                                <td style="width: 20%">Published Date</td>
                            </tr>
                            <c:forEach var="result" items="${item.listResult}" varStatus="itemStatus">
                                <c:set var="resultDataXML" value="${portal:parseContentXML(result.xmlData)}"/>
                                <seo:url value="${result.title}" var="resultUrl" prefix="/${result.authoringTemplate.prefixUrl}/${portal:convertStringToUrl(result.category.code)}/"/>
                                <tr>
                                    <td style="text-align: center;">${item.firstItem + itemStatus.count}</td>
                                    <td><a href="${resultUrl}">${resultDataXML.header[0]}</a></td>
                                    <td><fmt:formatDate value="${result.publishedDate}" pattern="dd-MM-yyyy"/></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <ul class="pagination">
                        <c:set var="currentPagerNumber" value="${pageNumber}"/>
                        <c:set var="seoURL" value=""/>
                        <c:choose>
                            <c:when test="${pageNumber > 3}">
                                <li><a class="page-number" pageNumb="1"><i class="fa fa-angle-double-left"></i></a></li>

                                <c:forEach begin="${pageNumber - 2}" end="${pageNumber + 2}" step="1" var="pageNumb">
                                    <c:if test="${pageNumb <= maxPageNumber}">
                                        <li <c:if test="${pageNumb == pageNumber}">class="active"</c:if>>
                                            <a class="page-number" pageNumb="${pageNumb}">${pageNumb}</a></li>
                                        <c:set var="currentPagerNumber" value="${pageNumb}"/>
                                    </c:if>
                                </c:forEach>

                                <c:if test="${maxPageNumber > currentPagerNumber}">
                                    <li><a class="page-number" pageNumb="${maxPageNumber}"><i class="fa fa-angle-double-right"></i></a></li>
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
                                    <li><a class="page-number" pageNumb="${maxPageNumber}"><i class="fa fa-angle-double-right"></i></a></li>
                                </c:if>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </article>

                <aside class="page-sidebar  col-md-3 col-md-offset-1 col-sm-4 col-sm-offset-1">
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
                            <a id="btnFilter" class="btn btn-theme"><i class="fa fa-fw fa-search"></i> Search</a>
                            <a id="btnReset" class="btn btn-danger"><i class="fa fa-fw fa-refresh"></i> Reset</a>
                        </div>

                        <form:hidden path="crudaction" cssClass="crudaction" id="crudaction-search-page"/>
                        <form:hidden path="pageNumber" id="pageNumber"/>
                    </form:form>
                </aside>
            </div>
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

