<%@ include file="/common/taglibs.jsp"%>

<div class="margin-bottom-30 about-me-container">
    <h2 class="title-v4"><fmt:message key="site.about.me"/></h2>
    <content:getConfigurationSite var="configuration"/>
    <oscache:cache key="site_configuration__about_me_cache" duration="3600">
        ${configuration.aboutMe}
    </oscache:cache>
</div>

