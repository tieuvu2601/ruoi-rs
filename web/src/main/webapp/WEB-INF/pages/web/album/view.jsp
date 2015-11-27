<%@ include file="/common/taglibs.jsp"%>
<c:set var="itemDataXML" value="${portal:parseContentXML(item.xmlData)}"/>
<style>
</style>
<div class="contentEntity container">
    <div class="page-wrapper">
        <header class="page-heading clearfix">
            <h1 class="heading-title pull-left">${itemDataXML.header[0]}</h1>
            <div class="breadcrumbs pull-right">
                <ul class="breadcrumbs-list">
                    <li><a href="index.html"><fmt:message key="site.home"/></a><i class="fa fa-angle-right"></i></li>
                    <li style="text-transform: capitalize;"><span>${categoryEntityObj.name}</span><i class="fa fa-angle-right"></i></li>
                    <li class="current" style="text-transform: capitalize;"><span>${currentCategoryEntity.name}</span></li>
                </ul>
            </div>
        </header>

        <div class="page-contentEntity">
            <p>${itemDataXML.description[0]}</p>
            <div class="row page-row" id="list-image">
                <c:forEach var="imageUrl" items="${imageUrls}" varStatus="statusImage">
                    <c:url var="imgUrl" value="/repository${imageUrl}"/>
                    <a class="prettyphoto col-md-3 col-sm-3 col-xs-6" rel="prettyPhoto[gallery]" href="${imgUrl}" index="${statusImage.count}">
                        <span class="pretty-photo-container">
                            <span class="pretty-photo-bg"></span>
                            <img class="img-responsive img-thumbnail" src="${imgUrl}?w=280&h=280&f=2" alt="" />
                        </span>
                    </a>
                </c:forEach>
            </div>
            <button type="button" class="btn btn-primary btn-block btn-lg" id="loadMore" totalNumb="8"><i class="fa fa-refresh"></i> <fmt:message key="read.more.label"/></button>
        </div>
    </div>
    <input type="hidden" value="${item.contentID}" id="contentId">
</div>
<script>
    $(document).ready(function() {
        setSelectedMenu($('#navbar-collapse'), $('#${portal:convertStringToUrl(categoryEntityObj.code)}'));
        loadMore();

        $('#loadMore').on('click', function () {
            var x = 8;
            var contentId = $('#contentId').val();
            var totalNum = parseInt($('#loadMore').attr("totalNumb"));
            loadImageForSinglePage(contentId, totalNum , x);
        });
    });
    function setSelectedMenu(parent, element){
        $(parent).find('.active').removeClass('active');
        $(element).addClass('active');
    }

    function loadMore(){
        var size_li = $("#list-image a").length;
        var x = 8;
        $('#list-image a').hide();
        $('#list-image a:lt('+ x +')').show();


    }

    function loadImageForSinglePage(contentId, index, numberItem){
        $.ajax({
            method: "POST",
            url: "<c:url value="/ajax/get-image-by-index-in-contentEntity.html"/>",
            data: { contentId: contentId, index: index, number: numberItem },
            dataType : "HTML",
            success: function(data){
                $('#list-image').append(data);
                $('#loadMore').attr("totalNumb", index + numberItem);
            }
        });
    }

</script>
