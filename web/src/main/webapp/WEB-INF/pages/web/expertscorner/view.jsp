<%@ include file="/common/taglibs.jsp"%>
<div class="contentEntity container contentEntity-container">
    <div class="page-wrapper">
        <c:set var="itemXMLData" value="${portal:parseContentXML(item.xmlData)}"/>
        <header class="page-heading clearfix">
            <h1 class="heading-title pull-left">${itemXMLData.header[0]}</h1>
            <div class="breadcrumbs pull-right">
                <ul class="breadcrumbs-list">
                    <li><a href="<c:url value="/index.html"/>"><fmt:message key="site.home"/></a><i class="fa fa-angle-right"></i></li>
                    <li style="text-transform: capitalize;"><span>${categoryEntityObj.name}</span><i class="fa fa-angle-right"></i></li>
                    <c:if test="${ not empty currentCategoryEntity && currentCategoryEntity.categoryID > 0}">
                        <li class="current" style="text-transform: capitalize;"><span>${currentCategoryEntity.name}</span></li>
                    </c:if>
                </ul>
            </div>
        </header>
        <div class="page-contentEntity">
            <div class="row page-row">
                <div class="section-contentEntity col-md-8 col-sm-7">
                    <div class="row">
                        <div class="section-contentEntity col-md-12">
                            <article class="welcome">
                                ${itemXMLData.contentEntity[0]}
                            </article>
                        </div>
                    </div>

                    <div class="row">
                        <div class="flexslider" style="width: 640px; margin: 0 auto;">
                            <ul class="slides">
                                <c:forEach var="youtubeUrl" items="${itemXMLData.youTubeUrls}" varStatus="status">
                                    <c:set var="isBeginFile" value="false"/>
                                    <li>
                                        <video width="640" height="360" preload="none">
                                            <source type="video/youtube" src="${youtubeUrl}" />
                                        </video>
                                    </li>
                                </c:forEach>

                                <c:forEach var="videoUrl" items="${itemXMLData.videos}" varStatus="urlStatus">
                                    <li>
                                        <video width="640" height="360" preload="none">
                                            <source type="video/youtube" src="<c:url value="/repository${videoUrl}"/>" />
                                        </video>
                                    </li>
                                </c:forEach>
                            </ul>
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
        $('video,audio').mediaelementplayer({
            enableAutosize: true,
            pauseOtherPlayers: true
        });

        $(".flexslider").flexslider({
            animation: "slide",
            useCSS: false,
            animationLoop: true,
            smoothHeight: true,
            slideshow : false,
            video : true
        });

    });
    function setSelectedMenu(parent, element){
        $(parent).find('.active').removeClass('active');
        $(element).addClass('active');
    }
</script>
