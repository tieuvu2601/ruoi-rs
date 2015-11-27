<%@ include file="/common/taglibs.jsp"%>
<c:choose>
    <c:when test="${fn:length(imageUrls) > 0}">
        <c:forEach var="imageUrl" items="${imageUrls}" varStatus="statusImage">
            <c:url var="imgUrl" value="/repository${imageUrl}"/>
            <a class="prettyphoto col-md-3 col-sm-3 col-xs-6" rel="prettyPhoto[gallery]" href="${imgUrl}" index="${statusImage.count}">
        <span class="pretty-photo-container">
            <span class="pretty-photo-bg"></span>
            <img class="img-responsive img-thumbnail" src="${imgUrl}?w=280&h=280&f=2" alt="" />
        </span>
            </a>
        </c:forEach>
        <script>
            $(document).ready(function() {
                $('a.prettyphoto').prettyPhoto();
                var isEnd = ${isEnd};
                if(isEnd){
                    $('#loadMore').remove();
                }
            });
        </script>
    </c:when>
    <c:otherwise>
    </c:otherwise>
</c:choose>


