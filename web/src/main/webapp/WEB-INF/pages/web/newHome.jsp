<%@ taglib prefix="oscache" uri="http://www.opensymphony.com/oscache" %>
<%@ include file="/common/taglibs.jsp"%>
<div class="content container">
    <div class="row cols-wrapper">
        <div class="col-md-3 welcome-container static-containers">
            Asadasd
        </div>

        <div class="col-md-9">
            <div class="row">
                <div class="col-md-12">
                    <div id="promo-slider" class="slider flexslider">
                        sadasdd
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row cols-wrapper">
        <div class="col-md-3 information-container static-containers">
            dasdasdasd
        </div>

        <div class="col-md-3 academic-programs-container static-containers">
            asdasdasd
        </div>

        <div class="col-md-3">
            sadasdqwdeasd
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
           dsadasd
        </div>

        <div class="col-md-9">
            <section class="news">
               sadasdasdasdasd
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