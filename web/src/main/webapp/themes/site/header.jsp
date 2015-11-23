<%@ include file="/common/taglibs.jsp"%>
<%@ page trimDirectiveWhitespaces="true"%>
<c:url var="searchByKeyword" value="/search.html"/>
<header class="header">
    <div id="global-header">
        <div class="global-header-container">
            <div class="container">
                <div class="col-md-7">
                    <div id="top-logo" class="span4">
                        <a href="http://ntt.edu.vn/" target="_blank"><fmt:message key="main.school"/></a>
                    </div>
                </div>

                <div class="col-md-5">
                    <div class="header-flag" id="flag">
                        <a href="<c:url value="/"/>?locale=vi" title="<fmt:message key="site.language.vn"/>"><img class="img_flag" alt="vi" src="<c:url value='/upload/images/vn_flag.png'/>"></a>
                        <a href="<c:url value="/"/>?locale=en" title="<fmt:message key="site.language.english"/>"><img class="img_flag"  alt="en" src="<c:url value='/upload/images/us_flag.png'/>" class="over"></a>
                    </div>

                    <div class="pull-right header-search-page">
                        <form:form cssClass="search-in-page-form" id="searchFormHeader" action="${searchByKeyword}" method="post">
                            <input title="Enter the terms you wish to search for." class="form-control search-term" placeholder="Search this site..." type="text" name="keyword" value="">
                            <a class="search-btn" onclick="searchByKeyword()"><i class="fa fa-fw fa-search"></i></a>
                            <input type="hidden" name="crudaction" id="crudaction-header"/>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>

        <div class="header-main container">
            <h1 class="logo col-md-12 col-sm-12">
                <a href="<c:url value="/index.html"/>"><img id="logo" src="<c:url value="/themes/site/images/logo.png"/>" alt="Logo"> <span id="logo_text_header"><fmt:message key="main.faculty"/></span></a>
            </h1>
        </div>
    </div>
</header>
<script>
    $(document).ready(function(){
        $('input.search-term').keypress(function (e) {
            if (e.which == 13) {
                searchByKeyword();
            }
        });
    });


    function searchByKeyword(){
        $('#crudaction-header').val("search");
        $('#searchFormHeader').submit();

    }
</script>