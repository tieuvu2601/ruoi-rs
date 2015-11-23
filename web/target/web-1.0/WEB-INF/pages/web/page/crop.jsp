<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp"%>

<style type="text/css">
	.hight-light{
		border:solid 1px red;
		z-index: 75557;
	}
</style>
<div id="tabs" style="width: 90%; height: 100%">
	<ul>
		<li><a href="#tabs-1" id="tb-1">Cắt ảnh</a></li>
		<li><a href="#tabs-2" id="tb-2">Chỉnh kích thước</a></li>
	</ul>
	<div id="tabs-1">
	    <form action="<c:url value="/admin/content/cropList.html"/>" id="cropFrom">
	        <rep:href value="${item.thumbnail}" var="imgURL"/>
	        <img src="<c:url value="${imgURL}"/>" id="jcrop_target"/>
	        <div style="clear:both;margin-top: 8px;">
	        	<input type="submit" value="Cắt ảnh" /><i>(Kích thước chuẩn: 410x390)</i>
	        </div>
	        <input type="hidden" id="contentID" name="pojo.contentID" value="${item.contentID}" />
	        <input type="hidden" id="cropX" name="pojo.cropX" />
	        <input type="hidden" id="cropY" name="pojo.cropY"/>
	        <input type="hidden" id="cropWidth" name="pojo.cropWidth"/>
	        <input type="hidden" id="cropHeight" name="pojo.cropHeight"/>
	        <input type="hidden" name="crudaction" id="crudaction" value="crop" />
	    </form>
    </div>
    <div id="tabs-2" style="display:none;">
    	<form action="<c:url value="/admin/content/cropList.html"/>" id="resizeFrom">
	        <rep:href value="${item.thumbnail}" var="imgURL"/>
	        <img src="<c:url value="${imgURL}"/>" id="resize_target" />
	        <input type="hidden" id="contentID" name="pojo.contentID" value="${item.contentID}" />
	        <div style="clear:both;margin-top: 8px;line-height: 26px;">
	        	<div><input type="text" name="imgWidth" id="imgWidth" style="width:30px;" /> x <input type="text" name="imgHeight" id="imgHeight" style="width:30px;" /></div>
        		<div><i>(Kích thước chuẩn: 410x390)</i></div>
	        	<input type="submit" value="Hiệu chỉnh" />
	        	<input type="hidden" id="crudaction" name="crudaction" value="resize" />
	        </div>
	    </form>
    </div>
</div>
<script type="text/javascript">

$('#imgWidth,#imgHeight').keyup(function () {
    s=$(this).val();
    if (!/^\d*\.?\d*$/.test(s)) $(this).val(s.substr(0,s.length-1));
});

function showCoords(c)
{
    $('#cropX').val(c.x);
    $('#cropY').val(c.y);
    $('#cropWidth').val(c.w);
    $('#cropHeight').val(c.h);
};

$(function(){
	
	$("#tabs" ).tabs();
	$("#tb-1").click(function(){
		$("#tabs-1").attr("style", "display:block;");
		$("#tabs-2").attr("style", "display:none;");
	});
	$("#tb-2").click(function(){
		$("#tabs-2").attr("style", "display:block;");
		$("#tabs-1").attr("style", "display:none;");
	});
    $('#jcrop_target').Jcrop({
        onChange: showCoords,
        onSelect: showCoords
    });
    
    $("#jcrop_target").load(function(){
    	
    	var imgW = GetImageWidth($(this).attr('src'));
    	var imgH = GetImageHeight($(this).attr('src'));
    	
    	$("#resize_target").css("width", imgW);
        $("#resize_target").css("height", imgH);
        $("#resize_target" ).parent().css("width", imgW);
        $("#resize_target" ).parent().css("height", imgH);
        $("#imgWidth" ).val(imgW);
        $("#imgHeight" ).val(imgH);	
    });
    
    $("#resize_target").resizable({ 
    	 helper: "hight-light",
    	 ghost: true,
    	 resize: function(event, ui) {
    		$( "#imgWidth" ).val($(this).width());
    	    $( "#imgHeight" ).val($(this).height());
    	 }
   	 });
});

function GetImageWidth(imgSrc) 
{
    var img = new Image();
    img.src = imgSrc;
    return img.width;
} 

function GetImageHeight(imgSrc) 
{
    var img = new Image();
    img.src = imgSrc;
    return img.height;
} 

</script>