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

        #searchFromInSite input.error{
            border: 1px solid #c7254e;
        }
    </style>
</head>
<body>
<div class="container content-sm">
    <div class="row">
        <div class="col-md-9">
            <c:choose>
                <c:when test="${fn:length(mapResult) > 0}">
                    <div class="tab-v4 margin-bottom-10">
                        <c:forEach var="contentMap" items="${mapResult}">
                            <c:set var="authoringType" value="${contentMap.key}"/>
                            <c:set var="contentList" value="${contentMap.value}"/>
                            <div class="tab-heading">
                                <h2>${authoringType}</h2>
                            </div>
                            <div class="tab-content">
                                <c:forEach var="news" varStatus="newsStatus" items="${contentList}">
                                    <seo:url value="${news.title}" var="newsUrl" prefix="/${news.category.prefixUrl}/${news.contentId}/"/>
                                    <c:set var="newsThumbnailUrl" value="/repository${news.thumbnails}"/>
                                    <c:if test="${newsStatus.index %2 == 0}">
                                        <div class="row">
                                    </c:if>
                                    <div class="col-sm-6">
                                        <div class="blog-thumb margin-bottom-20">
                                            <c:if test="${not empty news.thumbnails}">
                                                <div class="blog-thumb-hover">
                                                    <img src="${newsThumbnailUrl}" alt="${news.title}">
                                                    <a class="hover-grad" href="${newsUrl}">
                                                        <c:choose>
                                                            <c:when test="${news.authoringTemplate.areProduct == 1}">
                                                                <i class="fa fa-home"></i>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <i class="fa fa-photo"></i>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </a>
                                                </div>
                                            </c:if>

                                            <div class="blog-thumb-desc">
                                                <h3><a href="${newsUrl}">${news.header}</a></h3>
                                                <ul class="blog-thumb-info">
                                                    <li>${news.createdBy.displayName}</li>
                                                    <li><fmt:formatDate pattern="dd-MM-yyyy" value="${news.publishedDate}"/></li>
                                                    <c:if test="${news.authoringTemplate.areProduct == 1}">
                                                        <li class="product-cost">
                                                        <span>
                                                            ${portal:getNumberOfCost(news.cost)}${' '}
                                                            <c:choose>
                                                                <c:when test="${news.cost >= 1000}">
                                                                    <fmt:message key="site.content.cost.billion"/>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <fmt:message key="site.content.cost.million"/>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                        </li>
                                                    </c:if>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <c:if test="${newsStatus.index %2 == 1 || newsStatus.index == (fn:length(contentList) - 1)}">
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </c:forEach>
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
                </c:when>
                <c:otherwise>
                    <h3><fmt:message key="site.empty.data"/></h3>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="col-md-3">
            <form:form method="post" commandName="item" action="${searchByKeyword}" id="searchFromInSite">
                <div class="form-group">
                    <label>Keyword or Title</label>
                    <form:input path="keyword" cssClass="form-control keyword-search" placeholder="Key word or title" id="keyword"/>
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

    function validateFormBeforeSubmit(){
        var isValid = false;
        if(($('#searchFromInSite').find('#keyword').val() == null || $('#searchFromInSite').find('#keyword').val() == undefined || $.trim($('#searchFromInSite').find('#keyword').val()) == "")
                && ($('#searchFromInSite').find('#fromDate').val() == null || $('#searchFromInSite').find('#fromDate').val() == undefined || $.trim($('#searchFromInSite').find('#fromDate').val()) == "")
                && ($('#searchFromInSite').find('#toDate').val() == null || $('#searchFromInSite').find('#toDate').val() == undefined || $.trim($('#searchFromInSite').find('#toDate').val()) == "")){
            $('#searchFromInSite').find('#keyword').addClass('error');
        } else {
            $('#searchFromInSite').find('#keyword').removeClass('error');
            isValid = true;
        }
        return isValid;
    }

    function searchInSite(pageNumber){
        $('#pageNumber').val(pageNumber);
        $('#crudaction-search-page').val("search");
        if(validateFormBeforeSubmit()){
            $("#searchFromInSite").submit();
        }
    }
</script>
</body>
</html>


