<%@ include file="/common/taglibs.jsp"%>
<div class="contentEntity container contentEntity-container">
    <div class="page-wrapper">
        <c:set var="itemDataXML" value="${portal:parseContentXML(item.xmlData)}"/>

        <header class="page-heading clearfix">
            <h1 class="heading-title pull-left">${itemDataXML.header[0]}</h1>
            <div class="breadcrumbs pull-right">
                <ul class="breadcrumbs-list">
                    <li><a href="<c:url value="/index.html"/>"><fmt:message key="site.home"/></a><i class="fa fa-angle-right"></i></li>
                    <li style="text-transform: capitalize;"><span>${categoryEntityObj.name}</span><i class="fa fa-angle-right"></i></li>
                    <li class="current" style="text-transform: capitalize;"><span>${currentCategoryEntity.name}</span></li>
                </ul>
            </div>
        </header>

        <div class="page-contentEntity">
            <div class="row page-row">
                <div class="courses-wrapper col-md-8 col-sm-7">
                    <div class="featured-courses tabbed-info page-row">
                        <ul class="nav nav-tabs">
                            <li class="active"><a style="font-size: 18px;" href="#tab1" data-toggle="tab"><fmt:message key="site.collaboration.introduce"/></a></li>
                            <li><a style="font-size: 18px;" href="#tab2" data-toggle="tab"><fmt:message key="site.collaboration.contribution"/></a></li>
                            <li><a style="font-size: 18px;" href="#tab3" data-toggle="tab"><fmt:message key="site.collaboration.about"/></a></li>
                        </ul>

                        <div class="tab-contentEntity">
                            <div class="tab-pane active" id="tab1">
                                <div class="row">
                                    <div class="courses-wrapper col-md-12">
                                        ${itemDataXML.introduce[0]}
                                    </div>
                                </div>
                            </div>

                            <div class="tab-pane active" id="tab2">
                                <div class="row">
                                    <div class="courses-wrapper col-md-12">
                                        ${itemDataXML.contentEntity[0]}
                                    </div>
                                </div>
                            </div>

                            <div class="tab-pane active" id="tab3">
                                <div class="row">
                                    <div class="courses-wrapper col-md-12">
                                        ${itemDataXML.about[0]}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <jsp:include page="../static/rightmenuinsinglepage.jsp"/>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function() {
        setSelectedMenu($('#navbar-collapse'), $('#${portal:convertStringToUrl(categoryEntityObj.code)}'));
    });
    function setSelectedMenu(parent, element){
        $(parent).find('.active').removeClass('active');
        $(element).addClass('active');
    }
</script>


