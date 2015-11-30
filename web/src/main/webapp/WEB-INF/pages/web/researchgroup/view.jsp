<%@ include file="/common/taglibs.jsp"%>
<div class="content container content-container">
    <div class="page-wrapper">
        <c:set var="itemDataXML" value="${portal:parseContentXML(item.xmlData)}"/>

        <header class="page-heading clearfix">
            <h1 class="heading-title pull-left">${itemDataXML.header[0]}</h1>
            <div class="breadcrumbs pull-right">
                <ul class="breadcrumbs-list">
                    <li><a href="<c:url value="/index.html"/>"><fmt:message key="site.home"/></a><i class="fa fa-angle-right"></i></li>
                    <li style="text-transform: capitalize;"><span>${categoryObj.name}</span><i class="fa fa-angle-right"></i></li>
                    <li class="current" style="text-transform: capitalize;"><span>${currentCategory.name}</span></li>
                </ul>
            </div>
        </header>

        <div class="page-content">
            <div class="row page-row">
                <div class="courses-wrapper col-md-8 col-sm-7">
                    <div class="featured-courses tabbed-info page-row">
                        <ul class="nav nav-tabs">
                            <li class="active"><a style="font-size: 18px;" href="#tab1" data-toggle="tab"><fmt:message key="site.research.group.introduce"/></a></li>

                            <c:if test="${not empty itemDataXML.researchProjects && fn:length(itemDataXML.researchProjects) > 0}">
                                <li><a style="font-size: 18px;" href="#tab2" data-toggle="tab"><fmt:message key="site.research.group.project"/></a></li>
                            </c:if>

                            <c:if test="${not empty itemDataXML.members && fn:length(itemDataXML.members) > 0}">
                                <li><a style="font-size: 18px;" href="#tab3" data-toggle="tab"><fmt:message key="site.research.group.member"/></a></li>
                            </c:if>

                            <li><a style="font-size: 18px;" href="#tab4" data-toggle="tab"><fmt:message key="site.research.group.gallery"/></a></li>
                        </ul>

                        <div class="tab-content">
                            <div class="tab-pane active" id="tab1">
                                <div class="row">
                                    <div class="courses-wrapper col-md-12">
                                        ${itemDataXML.content[0]}
                                    </div>
                                </div>
                            </div>

                            <c:if test="${not empty itemDataXML.researchProjects && fn:length(itemDataXML.researchProjects) > 0}">
                                <div class="tab-pane" id="tab2">
                                    <div class="row">
                                        <div class="courses-wrapper col-md-12 item ">
                                            <c:forEach var="projectTitle" items="${itemDataXML.researchProjects}">
                                                <%--// get Project Obj from map--%>
                                                <c:set var="projectObj" value="${researchProjects[fn:toLowerCase(projectTitle)]}"/>

                                                <c:if test="${not empty projectObj && projectObj.contentID > 0}">
                                                    <c:set var="projectData" value="${portal:parseContentXML(projectObj.xmlData)}"/>
                                                    <seo:url value="${projectObj.title}" var="productUrl" prefix="/${productPrefixUrl}/${portal:convertStringToUrl(currentCategory.code)}/"/>

                                                    <div class="row page-row">
                                                        <div class="details col-md-9 col-sm-8 col-xs-6">
                                                            <div class="row page-row">
                                                                <figure class="thumb col-md-3 col-sm-4 col-xs-6">
                                                                    <c:set var="productThumbnails" value="/themes/site/images/images_not_available.png"/>
                                                                    <c:if test="${not empty projectObj.thumbnail}">
                                                                        <c:set var="productThumbnails" value="/repository${projectObj.thumbnail}"/>
                                                                    </c:if>
                                                                    <img class="img-responsive" src="${productThumbnails}" alt=""/>
                                                                </figure>

                                                                <div class="details col-md-9 col-sm-8 col-xs-6">
                                                                    <h4 class="title"><a href="${productUrl}">${projectData.header[0]}</a></h4>
                                                                    <div>
                                                                            ${projectData.description[0]}
                                                                    </div>
                                                                    <br />
                                                                    <a class="btn btn-theme read-more" href="${productUrl}"><fmt:message key="read.more.label"/><i class="fa fa-chevron-right"></i></a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                            <c:if test="${not empty itemDataXML.members && fn:length(itemDataXML.members) > 0}">
                                <div class="tab-pane" id="tab3">
                                    <div class="row">
                                        <div class="courses-wrapper col-md-12">
                                            <c:forEach var="personTitle" items="${itemDataXML.members}">
                                                <%--// get person object from map--%>
                                                <c:set var="personObj" value="${members[fn:toLowerCase(personTitle)]}"/>
                                                <c:if test="${not empty personObj && personObj.contentID > 0}">

                                                    <c:set var="personData" value="${portal:parseContentXML(personObj.xmlData)}"/>
                                                    <seo:url value="${personObj.title}"  var="personUrl" prefix="/${personObj.authoringTemplate.prefixUrl}/${portal:convertStringToUrl(personObj.category.code)}/"/>
                                                    <div class="row page-row">
                                                        <div class="details col-md-9 col-sm-8 col-xs-6">
                                                            <div class="row page-row">
                                                                <figure class="thumb col-md-3 col-sm-4 col-xs-6">
                                                                    <c:set var="avatar" value="/themes/site/images/avatar/anonymous.png"/>
                                                                    <c:if test="${not empty personObj.thumbnail}">
                                                                        <c:set var="avatar" value="/repository${personObj.thumbnail}"/>
                                                                    </c:if>
                                                                    <a href="${personUrl}"><img class="img-responsive" src="${avatar}" alt=""/></a>
                                                                </figure>

                                                                <div class="details col-md-9 col-sm-8 col-xs-6">
                                                                    <h4 class="title"><a href="${personUrl}">${personData.header[0]}</a></h4>
                                                                    <h5><fmt:message key="site.role"/>:</strong> ${personData.role[0]}</h5>
                                                                    <h6><fmt:message key="site.degree"/>: ${personData.degree[0]}</h6>
                                                                    <h6><fmt:message key="site.email"/>: <a href="mailto:${personData.email[0]}">${personData.email[0]}</a></h6>
                                                                    <c:if test="${not empty itemXMLData.phonenumb[0]}">--%>
                                                                        <h6><strong><fmt:message key="site.phone.number"/>:</strong> ${itemXMLData.phonenumb[0]}</h6>
                                                                    </c:if>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                            <div class="tab-pane" id="tab4">
                                <div class="row">
                                    <div class="courses-wrapper col-md-12 item ">
                                        <c:forEach var="imageUrl" items="${itemDataXML.galleryImages}">
                                            <c:url var="imgUrl" value="/repository${imageUrl}"/>
                                            <a class="prettyphoto col-md-4 col-sm-6 col-xs-12" rel="prettyPhoto[gallery]" href="${imgUrl}">
                                                <span class="pretty-photo-container">
                                                    <span class="pretty-photo-bg"></span>
                                                    <img class="img-responsive img-thumbnail" src="${imgUrl}?w=280=280=2" alt="" />
                                                </span>
                                            </a>
                                        </c:forEach>
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
        setSelectedMenu($('#navbar-collapse'), $('#${portal:convertStringToUrl(categoryObj.code)}'));
    });
    function setSelectedMenu(parent, element){
        $(parent).find('.active').removeClass('active');
        $(element).addClass('active');
    }
</script>


