<%@ include file="/common/taglibs.jsp"%>

<div class="margin-bottom-30">
    <h2 class="title-v4"><fmt:message key="site.recent.new"/> </h2>
    <content:getRecentNews pageSize="6" var="recentNews"/>
    <oscache:cache key="site_recent_news_cache" duration="3600">
        <c:forEach var="news" items="${recentNews}">
            <c:set var="newsThumbnailsUrl" value="/repository${news.thumbnails}"/>
            <seo:url value="${news.title}" var="newsUrl" prefix="/${news.category.prefixUrl}/${news.contentId}/"/>
            <div class="blog-thumb blog-thumb-circle margin-bottom-15">
                <div class="blog-thumb-hover">
                    <img class="rounded-x" src="${newsThumbnailsUrl}" alt="${news.title}">
                    <a class="hover-grad" href="${newsUrl}"><i class="fa fa-photo"></i></a>
                </div>
                <div class="blog-thumb-desc">
                    <h3><a href="${newsUrl}">${news.header}</a></h3>
                    <ul class="blog-thumb-info">
                        <li><fmt:formatDate pattern="dd-MM-yyyy" value="${news.publishedDate}"/></li>
                    </ul>
                </div>
            </div>
        </c:forEach>
    </oscache:cache>
</div>

