<%@ include file="/common/taglibs.jsp"%>
<c:url var="searchUrl" value="/search.html"/>
<div class="blog-topbar">
    <div class="container">
        <div class="row">
            <div class="col-sm-8 col-xs-8">
                <div class="row">
                    <div class="col-sm-12 col-xs-12">
                        <div class="topbar-search-block">
                            <div class="">
                                <form action="${searchUrl}" class="search-form-container">
                                    <input type="text" name="keyword" class="form-control" placeholder="Search" id="keyword">
                                    <div class="search-close"><i class="icon-close"></i></div>
                                    <input type="hidden" name="crudaction" value="search">
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%--<div class="col-sm-4 col-xs-4 clearfix">--%>
                <%--<i class="fa fa-search search-btn pull-right"></i>--%>
                <%--<ul class="topbar-list topbar-log_reg pull-right visible-sm-block visible-md-block visible-lg-block">--%>
                    <%--<li class="cd-log_reg home"><a class="cd-signin" href="javascript:void(0);">Login</a></li>--%>
                    <%--<li class="cd-log_reg"><a class="cd-signup" href="javascript:void(0);">Register</a></li>--%>
                <%--</ul>--%>
            <%--</div>--%>
        </div>
    </div>
</div>