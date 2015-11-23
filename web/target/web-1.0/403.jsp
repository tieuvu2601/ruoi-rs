<%@ include file="/common/taglibs.jsp"%>

<page:applyDecorator name="default">

<head>
    <title><fmt:message key="403.title"/></title>
    <meta name="heading" content="<fmt:message key='403.title'/>"/>
</head>

<div class="pathway"><fmt:message key='403.title'/></div>
<div id="content">
    <div>
        <fmt:message key="403.message">
            <fmt:param><c:url value="/"/></fmt:param>
        </fmt:message>
        <div class="clear"></div>
    </div>
    <br/>
</div>

</page:applyDecorator>