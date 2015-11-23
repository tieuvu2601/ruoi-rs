<%@page trimDirectiveWhitespaces="true"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript" src="<c:url value='/scripts/easySlider1.7.js'/>"></script>

<div class="logo">
    <a href="<c:url value="/dai-ly.html"/>"><img src="<c:url value="/themes/vms_stretch/images/logo.png"/>"/></a>
</div>
<content:findDepartment var="departments"/>
<div class="navigation">
    <ul>
        <li><a href="<c:url value="/daily/index.html"/>"><fmt:message key="home.agent"/></a>
            <div class="department_items myCorner" data-corner="bottom 10px">
                <ul>
                    <c:forEach items="${departments}" var="department">
                        <c:if test="${department.isBranch == 1}">
                            <seo:url value="${department.name}" prefix="/daily/chi-nhanh/${department.departmentID}/" var="departmentURL"/>
                            <li><a href="<c:url value="${departmentURL}"/>">${department.name}</a></li>
                        </c:if>
                    </c:forEach>
                </ul>
                <div class="clear"></div>
            </div>
        </li>
        <li class="space"></li>
        <oscache:cache key="SHOPPER_NAVIGATION_APPLICATION_ITEM_1" duration="7200">

        <li id="applicationMenuItem" style="padding-left: 570px;" ><a href="#" class="application" onmouseover="addClass('applicationMenuItem', 'selected')"><fmt:message key="home.application"/></a>
            <content:findCategoryByAuthoringTemplate authoringCode="ung-dung" var="applicationCategories"/>
            <div class="container myCorner" data-corner="bottom 10px">
                <div id="sub_items" class="myCorner" data-corner="bl 10px">
                    <ul>
                    <c:forEach items="${applicationCategories}" var="category">
                        <li>
                            <div class="sub_items_body">
                                <content:findByCategory category="${category.code}" begin="0" pageSize="9999" var="applications"/>
                                <c:forEach items="${applications}" var="application">
                                    <c:set var="applicationContent" value="${portal:parseContentXML(application.xmlData)}"/>
                                    <a href="${applicationContent['url'][0]}" target="_blank" title="${applicationContent['name'][0]}"><str:truncateNicely lower="20" upper="45" appendToEnd="...">${applicationContent['name'][0]}</str:truncateNicely></a>

                                </c:forEach>
                            </div>
                        </li>
                    </c:forEach>
                    </ul>
                </div>
                <div id="category_items" class="myCorner" data-corner="br 10px">
                    <ul>
                        <c:forEach items="${applicationCategories}" var="category" varStatus="status">
                        <li id="controls${status.index + 1}" rel="${status.index}"><a href="#" id="application_cat_${category.categoryID}">${category.name}</a></li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="clear"></div>
            </div>
        </li>
        </oscache:cache>
    </ul>
</div>
<script type="text/javascript" language="javascript">
    $(document).ready(function(){
        $("#sub_items").easySlider({
            auto: false,
            continuous: true,
            speed: 1,
            slidebg: false
        });
    });
</script>
