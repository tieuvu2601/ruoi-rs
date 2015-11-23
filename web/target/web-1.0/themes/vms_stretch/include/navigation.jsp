<%@ taglib prefix="oscache" uri="http://www.opensymphony.com/oscache" %>
<%@page trimDirectiveWhitespaces="true"%>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript" src="<c:url value='/scripts/easySlider1.7.js'/>"></script>
<div class="logo">
    <a href="<c:url value="/trang-chu.html"/>"><img src="<c:url value="/themes/vms_stretch/images/WNB_logo-Mobifone-220x70px.png"/>"/></a>
</div>
<content:findDepartment var="departments"/>
<div class="navigation">
    <ul>
        <li><a href="<c:url value="/tin-tuc/tin-trung-tam.html"/>"  <c:if test="${currentCategory.code ==  'tin-trung-tam'}">class="selected"</c:if>><fmt:message key="home.company"/></a></li>
        <li class="space"></li>
        <li><a href="<c:url value="/tin-tuc/phong-ban.html"/>"><fmt:message key="home.department"/></a>
            <div class="department_items myCorner" data-corner="bottom 10px">
                <ul>
                   <c:forEach items="${departments}" var="department">
                       <c:if test="${empty department.isBranch || department.isBranch == 0}">
                           <seo:url value="${department.name}" prefix="/phong-ban/${department.departmentID}/" var="departmentURL"/>
                           <li><a href="<c:url value="${departmentURL}"/>">${department.name}</a></li>
                       </c:if>
                   </c:forEach>
                </ul>
                <div class="clear"></div>
            </div>
        </li>
        <li class="space"></li>
        <li><a href="<c:url value="/tin-tuc/chi-nhanh.html"/>"><fmt:message key="home.agent"/></a>
            <div class="department_items myCorner" data-corner="bottom 10px">
                <ul>
                   <c:forEach items="${departments}" var="department">
                       <c:if test="${department.isBranch == 1}">
                           <seo:url value="${department.name}" prefix="/chi-nhanh/${department.departmentID}/" var="departmentURL"/>
                           <li><a href="<c:url value="${departmentURL}"/>">${department.name}</a></li>
                       </c:if>
                   </c:forEach>
                </ul>
                <div class="clear"></div>
            </div>
        </li>
        <li class="space"></li>
        <li style="width:100px;"><a href="<c:url value="/tin-tuc/tin-kinh-doanh.html"/>" <c:if test="${currentCategory.code ==  'tin-kinh-doanh'}">class="selected"</c:if>><fmt:message key="home.business"/></a></li>
        <li class="space"></li>
        <li style="width:100px;"><a href="<c:url value="/tin-tuc/cong-nghe-ky-thuat.html"/>" <c:if test="${currentCategory.code ==  'cong-nghe-ky-thuat'}">class="selected"</c:if>><fmt:message key="home.it"/></a></li>
        <li class="space"></li>
        <li style="width:90px;"><a href="<c:url value="/tin-tuc/cham-soc-khach-hang.html"/>" <c:if test="${currentCategory.code ==  'cham-soc-khach-hang'}">class="selected"</c:if>><fmt:message key="home.care"/></a></li>
        <li class="space"></li>
        <li style="width:80px;"><a href="/dien-dan" ><fmt:message key="home.forum"/></a></li>
        <li class="space"></li>
        <oscache:cache key="APPLICATION_MENU_ITEMS" duration="7200">
        <li id="applicationMenuItem"><a href="#" class="application" onmouseover="addClass('applicationMenuItem', 'selected')"><fmt:message key="home.application"/></a>
            <content:findCategoryByAuthoringTemplate authoringCode="ung-dung" var="applicationCategories"/>
            <div class="container myCorner" data-corner="bottom 10px">
                <div id="sub_items" class="myCorner" data-corner="bl 10px" >
                    <ul>
                    <c:forEach items="${applicationCategories}" var="category" varStatus="status">
                        <li id="${status.index + 1}"  style="height: ${fn:length(applicationCategories)*30 + 20}px;" onmouseover="keepColorMouseOver(this)" onmouseout="returnColorMouseOver(this)">
                            <div class="sub_items_body" style="overflow:auto; height: ${fn:length(applicationCategories)*30 + 10}px; " >
                                <content:findByCategory category="${category.code}" begin="0" pageSize="9999" var="applications"/>
                                <c:forEach items="${applications}" var="application">
                                    <c:set var="applicationContent" value="${portal:parseContentXML(application.xmlData)}"/>
                                    <a href="${applicationContent['url'][0]}" target="_blank" title="${application.title}"><str:truncateNicely lower="20" upper="45" appendToEnd="...">${application.title}</str:truncateNicely><c:if test="${not empty applicationContent['IsNew'][0] && applicationContent['IsNew'][0] == '1'}"><img src="<c:url value="/themes/vms_stretch/images/new.png"/>"/></c:if></a>

                                </c:forEach>
                            </div>
                        </li>
                    </c:forEach>
                    </ul>
                </div>
                <div id="category_items" style="height: ${fn:length(applicationCategories)*30}px;" class="myCorner" data-corner="br 10px">
                    <ul>
                        <c:forEach items="${applicationCategories}" var="category" varStatus="status">
                        <li id="controls${status.index + 1}" onmouseover="changeColorMouseOver(this)" onmouseout="changeColorMouseOut(this)"  rel="${status.index}"><a  href="#" id="application_cat_${category.categoryID}">${category.name}</a></li>
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
            slidebg: false,
            height: ${fn:length(applicationCategories)*30}
        });
    });

    function changeColorMouseOver(object)
    {
        var currentId = $(object).attr('id');
        document.getElementById(currentId).style.backgroundColor="#2D7CCD";
    }
    function changeColorMouseOut(object)
    {
        var currentId = $(object).attr('id');
        document.getElementById(currentId).style.backgroundColor="#2B659F";
    }
    function keepColorMouseOver(object)
    {
        var currentId = 'controls' + ($(object).attr('id'));
        document.getElementById(currentId).style.backgroundColor="#2D7CCD";
    }
    function returnColorMouseOver(object)
    {
        var currentId = 'controls' + ($(object).attr('id'));
        document.getElementById(currentId).style.backgroundColor="#2B659F";
    }
</script>