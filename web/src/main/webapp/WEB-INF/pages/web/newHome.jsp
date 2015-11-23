<%@ taglib prefix="oscache" uri="http://www.opensymphony.com/oscache" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="content container">
    <div class="row cols-wrapper">
        <div class="col-md-3 welcome-container static-containers">
            <content:findByContentTitle title="welcome" var="welcome"/>
            <oscache:cache key="welcome_home_${welcome.contentID}_${welcome.modifiedDate}" duration="1">
                <c:set var="welcomeData" value="${portal:parseContentXML(welcome.xmlData)}"/>
                <div class="static-container">
                    <h3><span class="line">${welcomeData.header[0]}</span></h3>
                    <div class="static-content">
                        ${welcomeData.content[0]}
                    </div>
                </div>
            </oscache:cache>
        </div>

        <div class="col-md-9">
            <div class="row">
                <div class="col-md-12">
                    <div id="promo-slider" class="slider flexslider">
                        <content:findByContentTitle title="homeSlider" var="homeSlider"/>
                        <oscache:cache key="slide_home_${homeSlider.contentID}_${homeSlider.modifiedDate}" duration="1">
                            <c:set var="sliderData" value="${portal:parseContentXML(homeSlider.xmlData)}"/>
                            <c:set var="headerSlider" value="${sliderData.header}"/>
                            <c:set var="footerSlider" value="${sliderData.footer}"/>
                            <c:set var="sliderUrl" value="${sliderData.sliderUrl}"/>

                            <ul class="slides">
                                <c:forEach begin="0" end="3" var="indexSlider">
                                    <c:if test="${not empty sliderUrl[indexSlider]}">
                                        <li>
                                            <img src="<c:url value="/repository${sliderUrl[indexSlider]}"/>"  alt="" />
                                            <p class="flex-caption">
                                                <c:if test="${not empty headerSlider[indexSlider]}">
                                                    <span class="main" >${headerSlider[indexSlider]}</span>
                                                </c:if>
                                                <c:if test="${not empty footerSlider[indexSlider]}">
                                                    <br />
                                                    <span class="secondary clearfix" >${footerSlider[indexSlider]}</span>
                                                </c:if>
                                            </p>
                                        </li>
                                    </c:if>
                                </c:forEach>
                            </ul>
                        </oscache:cache>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row cols-wrapper">
        <div class="col-md-3 information-container static-containers">
            <content:findByContentTitle title="information" var="information"/>
            <oscache:cache key="information_home__${information.contentID}_${information.modifiedDate}" duration="1">
                <c:set var="informationData" value="${portal:parseContentXML(information.xmlData)}"/>
                <div class="static-container">
                    <h3><span class="line">${informationData.header[0]}</span></h3>
                    <div class="static-content">
                        ${informationData.content[0]}
                    </div>
                </div>
            </oscache:cache>
        </div>

        <div class="col-md-3 academic-programs-container static-containers">
            <content:findByContentTitle title="academic programs" var="academicProgram"/>
            <oscache:cache key="academic_program_home_${academicProgram.contentID}_${academicProgram.modifiedDate}" duration="1">
                <c:set var="academicProgramData" value="${portal:parseContentXML(academicProgram.xmlData)}"/>
                <div class="static-container">
                    <h3><span class="line">${academicProgramData.header[0]}</span></h3>
                    <div class="static-content">
                            ${academicProgramData.content[0]}
                    </div>
                </div>
            </oscache:cache>
        </div>

        <div class="col-md-3">
            <content:findByCategory category="recent news" begin="0" pageSize="9" var="recentNews"/>
            <c:set var="numberOfItemInContainer" value="3"/>
            <section class="news">
                <h1 class="section-heading text-highlight"><span class="line"><fmt:message key="site.news"/></span></h1>

                <div class="carousel-controls">
                    <a class="prev" href="#news-carousel" data-slide="prev"><i class="fa fa-caret-left"></i></a>
                    <a class="next" href="#news-carousel" data-slide="next"><i class="fa fa-caret-right"></i></a>
                </div>

                <div class="section-content clearfix">
                    <div id="news-carousel" class="news-carousel carousel slide">
                        <div class="carousel-inner">
                            <oscache:cache key="news_${recentNews[0].contentID}_${recentNews[0].modifiedDate}" duration="1">
                                <c:forEach var="news" items="${recentNews}" varStatus="status">
                                    <c:set var="newXMLData" value="${portal:parseContentXML(news.xmlData)}"/>
                                    <seo:url value="${news.title}" var="newUrl" prefix="/${news.authoringTemplate.prefixUrl}/${portal:convertStringToUrl(news.category.code)}/"/>

                                    <c:if test="${status.index % numberOfItemInContainer == 0}">
                                        <div class="item <c:if test="${status.index == 0}">active</c:if>">
                                    </c:if>

                                    <div class="col-md-12 news-item">
                                        <h2 class="title"><a href="${newUrl}">${newXMLData.header[0]}</a></h2>
                                        <c:set var="thumbnailUrl" value="/themes/site/images/images_not_available.png"/>
                                        <c:if test="${not empty news.thumbnail}">
                                            <c:set var="thumbnailUrl" value="/repository${news.thumbnail}?w=100&h=100&f=2"/>
                                        </c:if>
                                        <img class="thumb" src="${thumbnailUrl}" alt=""/>
                                        <p>${newXMLData.shotdescription[0]}</p>
                                    </div>

                                    <c:if test="${status.index % numberOfItemInContainer == (numberOfItemInContainer - 1)}">
                                        </div>
                                    </c:if>

                                    <c:if test="${status.index == fn:length(recentNews) && status.index % numberOfItemInContainer != (numberOfItemInContainer - 1)}">
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </oscache:cache>
                        </div>
                    </div>
                    <div class="news-footer">
                        <seo:url value="recent news" var="seoURL" prefix="/news/news-events/"/>
                        <a class="read-more" href="${seoURL}"><fmt:message key="site.all.new"/><i class="fa fa-chevron-right"></i></a>
                    </div>
            </section>
        </div>

        <div class="col-md-3">
            <section class="events">
                <h1 class="section-heading text-highlight"><span class="line"><fmt:message key="site.events"/></span></h1>
                <content:findByEventTypeWithMaxItem eventType="upcoming" begin="0" pageSize="3" var="events"/>
                <div class="section-content">
                    <c:forEach var="event" items="${events}">
                        <c:set var="eventData" value="${portal:parseContentXML(event.xmlData)}"/>
                        <fmt:formatDate var="eventBeginDate" value="${event.beginDate}" pattern="dd-MM-yyyy"/>
                        <div class="event-item">
                            <p class="date-label">
                                <span class="month">${portal:getDateVariableByIndexAndParameter(eventBeginDate, 1, "-")}</span>
                                <span class="date-number">${portal:getDateVariableByIndexAndParameter(eventBeginDate, 0, "-")}</span>
                            </p>
                            <div class="details">
                                <seo:url value="${event.title}" var="eventURL" prefix="/${event.authoringTemplate.prefixUrl}/${portal:convertStringToUrl(event.category.code)}/"/>
                                <h2 class="title"><a href="${eventURL}">${eventData.header[0]}</a></h2>
                                <p class="time"><i class="fa fa-clock-o"></i>${eventData.beginTime[0]} - ${eventData.endTime[0]}</p>
                                <p class="location"><i class="fa fa-map-marker"></i>${eventData.location[0]}</p>
                            </div>
                        </div>
                    </c:forEach>
                    <seo:url value="upcoming events" var="eventsURL" prefix="/upcoming/news-events/"/>
                    <a class="read-more" href="${eventsURL}"><fmt:message key="site.all.event"/><i class="fa fa-chevron-right"></i></a>
                </div>
            </section>
        </div>
    </div>

    <div class="row cols-wrapper">
        <div class="col-md-3 research-themes static-containers">
            <content:findByContentTitle title="research themes" var="researchThemes"/>
            <oscache:cache key="research_themes_home_${researchThemes.contentID}_${researchThemes.modifiedDate}" duration="1">
                <c:set var="researchThemesData" value="${portal:parseContentXML(researchThemes.xmlData)}"/>
                <div class="static-container">
                    <h3><span class="line">${researchThemesData.header[0]}</span></h3>
                    <div class="static-content">
                        ${researchThemesData.content[0]}
                    </div>
                </div>
            </oscache:cache>
        </div>

        <div class="col-md-9">
            <section class="news">
                <content:findByPrefixUrlCategory prefixUrl="researches" begin="0" pageSize="3" var="researchProject"/>
                <h1 class="section-heading text-highlight"><span class="line"><fmt:message key="site.research.project"/></span></h1>
                <c:if test="${fn:length(researchProject) > 3}">
                    <div class="carousel-controls">
                        <a class="prev" href="#research-carousel" data-slide="prev"><i class="fa fa-caret-left"></i></a>
                        <a class="next" href="#research-carousel" data-slide="next"><i class="fa fa-caret-right"></i></a>
                    </div>
                </c:if>
                <div class="section-content clearfix">
                    <div id="research-carousel" class="news-carousel carousel slide">
                        <div class="carousel-inner">
                            <div class="item active">
                                <oscache:cache key="news_${researchProject[0].contentID}_${researchProject[0].modifiedDate}" duration="1">
                                    <c:forEach var="project" items="${researchProject}">
                                        <c:set var="projectData" value="${portal:parseContentXML(project.xmlData)}"/>
                                        <seo:url value="${project.title}" var="projectUrl" prefix="/${project.authoringTemplate.prefixUrl}/${portal:convertStringToUrl(project.category.parentCategory.code)}/"/>
                                        <div class="col-md-4 research-item">
                                            <h2 class="title"><a href="${projectUrl}">${projectData.header[0]}</a></h2>

                                            <c:set var="thumbnailUrl" value="/themes/site/images/images_not_available.png"/>
                                            <c:if test="${not empty project.thumbnail}">
                                                <c:set var="thumbnailUrl" value="/repository${project.thumbnail}?w=242&h=252&f=2"/>
                                            </c:if>
                                            <img class="thumb" src="${thumbnailUrl}" alt=""/>

                                            <p>${projectData.description[0]}</p>
                                            <a class="read-more" href="${projectUrl}"><fmt:message key="site.read.more"/><i class="fa fa-chevron-right"></i></a>
                                        </div>
                                    </c:forEach>
                                </oscache:cache>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
</div>
<script>
    $(document).ready(function() {
        setSelectedMenu($('#navbar-collapse'), $('#home'));
    });
    function setSelectedMenu(parent, element){
        $(parent).find('.active').removeClass('active');
        $(element).addClass('active');
    }

</script>