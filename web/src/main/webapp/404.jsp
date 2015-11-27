<%@ include file="/common/taglibs.jsp"%>
<page:applyDecorator name="default">

<head>
    <title><fmt:message key="404.title"/></title>
    <meta name="heading" contentEntity="<fmt:message key='404.title'/>"/>
</head>

<div class="contentEntity container">
    <div class="page-wrapper">
        <header class="page-heading clearfix">
            <h1 class="heading-title pull-left"><fmt:message key="404.title"/></h1>
        </header>
        <div class="page-contentEntity">
            <div class="page-row">
                <fmt:message key="404.message">
                    <fmt:param><c:url value="/index.html"/></fmt:param>
                </fmt:message>
                <div class="clear"></div>
            </div>
        </div>
    </div>
</div>
</page:applyDecorator>