<%@page trimDirectiveWhitespaces="true"%>
<%@ include file="/common/taglibs.jsp" %>
<div id="footercontent" class="box_wrapper">
    <ul>
        <li>
            <div class="title">
                Sơ Đồ Site
            </div>
            <div class="body">
                <ul>
                    <li>&rsaquo; <a href="<c:url value="/tin-tuc/tin-trung-tam.html"/>">Trung tâm</a></li>
                    <li>&rsaquo; <a href="<c:url value="/tin-tuc/phong-ban.html"/>">Phòng ban</a></li>
                    <li>&rsaquo; <a href="<c:url value="/tin-tuc/chi-nhanh.html"/>">Chi nhánh</a></li>
                    <li>&rsaquo; <a href="<c:url value="/tin-tuc/tin-kinh-doanh.html"/>">Kinh doanh</a></li>
                    <li>&rsaquo; <a href="<c:url value="/tin-tuc/cong-nghe-ky-thuat.html"/>">Kỹ thuật</a></li>
                    <li>&rsaquo; <a href="<c:url value="/tin-tuc/cham-soc-khach-hang.html"/>">Chăm sóc khách hàng</a></li>
                </ul>
            </div>
        </li>
        <li>
            <div class="title">
                Lưu trữ tin
            </div>
            <div class="body">
                <ul>
                    <c:set var="initDate" value="<%=new java.util.Date()%>"/>
                    <c:forEach begin="0" end="5" var="index">
                        <c:set var="now" value="${portal:addMonth(initDate, -1 * index)}"/>
                        <fmt:formatDate value="${now}" var="month" pattern="MM-yyyy"/>
                        <li>&rsaquo; <a href="<c:url value="/tin-luu-tru/${month}.html"/>">Tháng ${month}</a></li>
                    </c:forEach>

                </ul>
            </div>
        </li>
        <li>
            <div class="title">
               <fmt:message key="home.topviews" />
            </div>
            <div class="body">
                <ul>
                    <content:findTopViews authoringCode="tin-tuc" pageSize="6" var="contents"/>
                    <c:if test="${not empty contents}">
                        <c:forEach items="${contents}" var="content" varStatus="status">
                            <seo:url value="${content.title}" var="seoURL" prefix="/tin-doc-nhieu/${content.contentID}/"/>
                            <li>&rsaquo; <a href="<c:url value="${seoURL}"/>"><str:truncateNicely lower="24" upper="26" appendToEnd="...">${content.title}</str:truncateNicely></a></li>
                        </c:forEach>
                    </c:if>

                </ul>
            </div>
        </li>
        <li>
            <div class="title">
                <fmt:message key="home.topcomments" />
            </div>
            <div class="body">
                <ul>
                    <content:findTopComments authoringCode="tin-tuc" pageSize="6" var="contents"/>
                    <c:if test="${not empty contents}">
                        <c:forEach items="${contents}" var="content" varStatus="status">
                            <seo:url value="${content.title}" var="seoURL" prefix="/tin-doc-nhieu/${content.contentID}/"/>
                            <li>&rsaquo; <a href="<c:url value="${seoURL}"/>"><str:truncateNicely lower="22" upper="23" appendToEnd="...">${content.title}</str:truncateNicely> (${content.noOfComments})</a>
                            </li>
                        </c:forEach>
                    </c:if>
                </ul>
            </div>
        </li>
    </ul>

    <a name="hidenWarningLink" id="hidenWarningLink" style="display: none;" ></a>
    <a name="deleteConfirmLink" id="deleteConfirmLink" style="display: none;"></a>
    <div class="clear"></div>
</div>