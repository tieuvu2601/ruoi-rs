<%@ include file="/common/taglibs.jsp"%>

<div class="margin-bottom-30 about-me-container">
    <h2 class="title-v4"><fmt:message key="site.about.me"/></h2>
    <div class="latest-news">
        <img class="user-avatar" src="<c:url value="/themes/site/img/blog/img1.jpg"/>" alt="">
        <h3><a href="/index.html"><fmt:message key="site.author.name"/></a></h3>
        <h4><fmt:message key="site.phone.number"/>: <strong style="color: #c7254e"><fmt:message key="site.author.phonenumber"/></strong></h4>
        <h5><fmt:message key="site.email"/>: <strong><fmt:message key="site.author.email"/></strong></h5>
        <h5><fmt:message key="site.facebook.account"/>: <strong><a href="<fmt:message key="site.author.facebook"/>" target="_blank"><fmt:message key="site.author.name"/></a></strong></h5>
        <h5><fmt:message key="site.skype.account"/>: <strong><fmt:message key="site.author.skype"/></strong></h5>
    </div>
</div>

