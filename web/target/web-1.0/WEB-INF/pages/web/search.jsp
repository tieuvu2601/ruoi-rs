<%@ include file="/common/taglibs.jsp"%>
<head>
    <title><fmt:message key="label.search"/></title>
    <meta name="heading" content="Home Page"/>

</head>
<c:url var="url" value="/tim-kiem.html"/>
<body class="sub_page">
	<div class="sub_page_panel">
		<div class="box_wrapper">
			<form:form method="post" commandName="item" action="${url}" id="frmSearch">
				<div class="sub_page_title"><fmt:message key="label.search"/></div>
				<div class="sub_page_content">
					<div class="col w_2-3">
						<div id="component-1" class="row">
							<div class="detail_two_cols_skin">
								<div>
	                                <table width="100%" cellpadding="5" cellspacing="5" border="0" style="margin-bottom: 10px;">
							    		<tr>
							    			<td><fmt:message key="content.title"/></td>
							                <td><form:input path="pojo.title" size="40" value="${item.pojo.title }" style="height: 20px; width: 180px;border: 1px solid #C9C9C9;"/></td>

                                            <td><fmt:message key="content.keyword"/></td>
							                <td><form:input path="pojo.keyword" size="40" value="${item.pojo.keyword }" style="height: 20px; width: 180px;border: 1px solid #C9C9C9;"/></td>
							    		</tr>
							    		<tr>
							    			<td><fmt:message key="authoringtemplate.template"/></td>
							                <td>
							                    <select name="authoringTemplateID" id="authoringTemplateId" style="height: 20px; width: 180px;border: 1px solid #C9C9C9;">
							                        <option value=""><fmt:message key="label.all"/></option>
							                        <c:forEach items="${authoringTemplates}" var="authoringTemplate">
							                            <option value="${authoringTemplate.authoringTemplateID}" <c:if test="${authoringTemplate.authoringTemplateID eq item.authoringTemplateID}">selected</c:if>>${authoringTemplate.name}</option>
							                        </c:forEach>
							                    </select>
							                </td>
                                            <td>
							                    <fmt:message key="category"/>
							                </td>
							                <td>
							                    <select name="categoryID" id="contentCategoryID" style="height: 20px; width: 180px;border: 1px solid #C9C9C9;">
							                        <option value=""><fmt:message key="label.all"/></option>
							                        <c:forEach items="${categories}" var="category">
							                            <option value="${category.categoryID}" <c:if test="${category.categoryID eq item.categoryID}">selected</c:if>>${category.name}</option>
							                        </c:forEach>
							                    </select>
							                </td>
							    		</tr>
                                        <tr>
                                            <td>Từ ngày</td>
                                            <td colspan="3"><input type="text" name="fromDate" id="fromDate" size="10" style="width:80px;" maxlength="10" value="<fmt:formatDate value="${item.fromDate}" pattern="dd/MM/yyyy"/>"/> đến <input type="text" name="toDate" id="toDate" size="10" style="width:80px;" maxlength="10" value="<fmt:formatDate value="${item.toDate}" pattern="dd/MM/yyyy"/>"/></td>
                                        </tr>
							    		<tr>
							               <td></td>
							               <td colspan="3">
							                   <form:hidden path="crudaction" id="crudaction" value="search"/>
							                   <input type="submit" value="<fmt:message key="button.search"/>" />
							               </td>
							           </tr>
							    	</table>
                                    <div class="clear"></div>
	                            </div>
	                            <div class="clear"></div>
	                            <c:if test="${!empty item.crudaction }">
		                            <div class="body myCorner" data-corner="bottom 5px">
	                                	<div class="body_content">

                                            <display:table name="item.listResult" cellspacing="0" cellpadding="0" style="margin-bottom: 2.5em;" requestURI="${url}"
                                                 size="${item.totalItems}" partialList="true" sort="external" uid="tableList" pagesize="${item.maxPageItems}" class="table bright_blue_body" export="false">
                                                 <display:column>
                                                     <div>
                                                        <seo:url prefix="/tim-kiem/${tableList.contentID}/${tableList.authoringTemplate.code }/" value="${tableList.title}" var="seoURL"/>
                                                        <div class="title">
                                                            <a href="<c:url value="${seoURL}"/>" >${tableList.title}</a>
                                                            <span class="modified_date"><fmt:formatDate value="${tableList.modifiedDate}" pattern="dd/MM/yyyy"/></span>
                                                        </div>
                                                        <div class="text">
                                                            <div class="brief">
                                                                <c:set var="contentItemContent" value="${portal:parseContentXML(tableList.xmlData)}"/>
                                                                ${contentItemContent['brief'][0]}
                                                                <p style="margin-top:10px;"><a href="<c:url value="${seoURL}"/>"><img src="<c:url value="/themes/vms_stretch/images/detail_button.png"/>"/></a></p>
                                                            </div>
                                                        </div>
                                                        <div class="clear"></div>
                                                     </div>
                                                 </display:column>

                                                <div class="clear"></div>
                                                <display:setProperty name="paging.banner.item_name"><fmt:message key="content"/></display:setProperty>
                                                <display:setProperty name="paging.banner.items_name"><fmt:message key="content"/></display:setProperty>
                                                <display:setProperty name="paging.banner.placement" value="bottom"/>
                                                <display:setProperty name="paging.banner.no_items_found" value=""/>
                                                <display:setProperty name="paging.banner.onepage" value=""/>
                                                <display:setProperty name="paging.banner.group_size" value="5"/>
                                                <display:setProperty name="paging.banner.some_items_found"><span class="pagebanner">Hiển thị {2} đến {3} của {0}.</span> </display:setProperty>
                                                <display:setProperty name="paging.banner.all_items_found"><span class="pagelinks">{0} nội dung được tìm thấy.</span> </display:setProperty>
                                            </display:table>
									    	<div class="clear"></div>
	                                	</div>
	                               	</div>
                               	</c:if>
						    </div>
						</div>
					</div>
					
					<div class="col w_1-3 right_column">
	                    <div id="component-3">
	                        <content:findByAuthoringTemplate authoringCode="quang-cao" begin="0" pageSize="2" var="quangcaos"/>
	                        <div class="small_light_skin">
	                            <div class="header">Quảng Cáo</div>
	                            <div class="body">
	                                <ul>
	                                    <c:forEach items="${quangcaos}" var="contentItem">
	                                        <c:set var="contentItemContent" value="${portal:parseContentXML(contentItem.xmlData)}"/>
	                                        <c:choose>
	                                            <c:when test="${not empty contentItemContent['image'][0]}">
	                                                <rep:href value="${contentItemContent['image'][0]}" var="itemURL" />
	                                            </c:when>
	                                            <c:otherwise>
	                                                <c:set var="itemURL" value="${contentItemContent['url'][0]}"/>
	                                            </c:otherwise>
	                                        </c:choose>
	                                        <li>
	                                            <c:choose>
	                                                <c:when test="${contentItemContent['dataType'][0] == 'Video'}">
	                                                    <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0" width="280" height="190" id="FLVPlayer">
	                                                      <param name="movie" value="<c:url value="/scripts/flash/FLVPlayer_Progressive.swf"/>" />
	                                                      <param name="salign" value="lt" />
	                                                      <param name="quality" value="high" />
	                                                      <param name="scale" value="exactfit" />
	                                                      <param name="FlashVars" value="&MM_ComponentVersion=1&skinName=/js/Corona_Skin_3&streamName=${itemURL}&autoPlay=false&autoRewind=false" />
	                                                      <embed src="<c:url value="/scripts/flash/FLVPlayer_Progressive.swf"/>" flashvars="&MM_ComponentVersion=1&skinName=/scripts/flash/Corona_Skin_3&streamName=${itemURL}&autoPlay=false&autoRewind=false" quality="high" scale="exactfit" width="280" height="190" name="FLVPlayer" salign="LT" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
	                                                    </object>
	                                                </c:when>
	                                                <c:when test="${contentItemContent['dataType'][0] == 'Flash'}">
	                                                    <object width="280" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000">
	                                                      <param value="${itemURL}" name="movie">
	                                                      <param value="high" name="quality">
	                                                      <param value="transparent" name="wmode">
	                                                      <embed width="280" allowscriptaccess="crossDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" quality="high" src="${itemURL}" wmode="transparent">
	                                                    </object>
	                                                </c:when>
	                                                <c:when test="${contentItemContent['dataType'][0] == 'Image'}">
	                                                    <c:choose>
	                                                		<c:when test="${!empty contentItemContent['url'][0]}">
	                                                			<a href="${contentItemContent['url'][0]}" target="_blank"><img src="<c:url value="${itemURL}"/>" width="280"/></a>
	                                                		</c:when>
	                                                		<c:otherwise>
	                                                			<img src="<c:url value="${itemURL}"/>" width="280"/>
	                                                		</c:otherwise>
	                                                	</c:choose>
	                                                </c:when>
	                                            </c:choose>
	                                        </li>
	                                    </c:forEach>
	                                </ul>
	                            </div>
	                           <div class="footer"></div>
	                        </div>
	                    </div>
                        <security:authorize ifAllGranted="LOGON">
	                    <div id="component-6">
	                       <div class="thongbao_skin">
	                            <div class="header">Thông báo</div>
	                            <div class="body myCorner" data-corner="tr br 5px">
	                                <ul>
	                                    <content:findByAuthoringTemplate authoringCode="thong-bao" begin="0" pageSize="10" var="thongbaos"/>
	                                    <c:forEach items="${thongbaos}" var="contentItem">
	                                    <seo:url prefix="/thong-bao/${contentItem.contentID}/" value="${contentItem.title}" var="seoURL"/>
	                                    <li>
	                                        <div class="calendar">
	                                            <fmt:formatDate value="${contentItem.modifiedDate}" pattern="dd"/><br/>
	                                            <fmt:formatDate value="${contentItem.modifiedDate}" pattern="MM"/>
	                                        </div>
	                                        <div class="text">
	                                            <a href="<c:url value="${seoURL}"/>">${contentItem.title}</a>
	                                        </div>
	                                        <div class="clear"></div>
	                                    </li>
	                                    </c:forEach>
	
	                                </ul>
	                            </div>
	                           <div class="footer"></div>
	                        </div>
	                    </div>
                        </security:authorize>
	                    <div id="component-7">
	                       <div class="document_skin">
	                            <div class="header">Tài Liệu Hướng Dẫn</div>
	                            <div class="body myCorner" data-corner="tr br 5px">
	                                <ul>
	                                    <content:findByAuthoringTemplate authoringCode="tai-lieu" begin="0" pageSize="10" var="tailieu"/>
	                                    <c:forEach items="${tailieu}" var="contentItem">
	                                    <c:set var="iconTaiLieu" value="${portal:parseContentXML(contentItem.xmlData)}"/>
	                                    <rep:href value="${iconTaiLieu['file'][0]}" var="download" />
	                                    <li>
	                                        <div class="text">
	                                            <a href="<c:url value="${download}"/>">${contentItem.title}</a>
	                                        </div>
	                                        <div class="icon">
	                                            <c:choose>
	                                                <c:when test="${fn:contains(iconTaiLieu['file'][0],'.pdf') }">
	                                                    <img src="<c:url value="/themes/vms/images/pdf.gif" />" alt="">
	                                                </c:when>
	                                                <c:when test="${fn:contains(iconTaiLieu['file'][0],'.doc') }">
	                                                    <img src="<c:url value="/themes/vms/images/word.gif" />" alt="">
	                                                </c:when>
	                                                <c:when test="${fn:contains(iconTaiLieu['file'][0],'.xls') }">
	                                                    <img src="<c:url value="/themes/vms/images/excel.gif" />" alt="">
	                                                </c:when>
	                                                <c:otherwise>
	                                                        <img src="<c:url value="/themes/vms/images/attachment.gif" />" alt="">
	                                                </c:otherwise>
	                                            </c:choose>
	                                        </div>
	                                        <div class="clear"></div>
	                                    </li>
	                                    </c:forEach>
	
	                                </ul>
	                            </div>
	                           <div class="footer"></div>
	                        </div>
	                    </div>
                        <div id="component-8">
                            <div class="document_skin">
                                <div class="header">Liên kết web</div>
                                <div class="body myCorner" data-corner="tr br 5px">
                                    <content:findByAuthoringTemplate authoringCode="lien-ket-web" begin="0" pageSize="10" var="lienketwebs"/>
                                    <div align="center">
                                        <select id="webLink" onchange="launchExternalSite(this.value)" class="cboWebLink">
                                            <option value="">Liên kết website</option>
                                            <c:forEach items="${lienketwebs}" var="lienket">
                                                <c:set var="lienketContent" value="${portal:parseContentXML(lienket.xmlData)}"/>
                                                <option value="${lienketContent['link'][0]}">${lienket.title}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="footer"></div>
                            </div>
                        </div>
	                    <div id="component-9">
	                       <div class="no_skin">
	                            <div class="header"></div>
	                            <div class="body">
	                                <div class="online_statistic">
	                                    Đang trực tuyến: ${userOnlineCounter}<br/>
	                                    Lượt truy cập: ${totalVisitors}
	
	                                </div>
	                            </div>
	                           <div class="footer"></div>
	                        </div>
	                    </div>
	
	                </div>
				</div>
				<script type="text/javascript">
				$(function(){
					$("#authoringTemplateId").change(function(){
						var value = $(this).val();
						var categoryOptions = document.getElementById('contentCategoryID').options;
						categoryOptions.length = 1;
						if(value != null && value != ''){
							jQuery.ajax({
								url : '<c:url value="/ajax/loadCategoryByAuthoringTemplate.html"/>?au=' + value + '&dt=' + new Date().getTime(),
								dataType: 'json',
								success: function(data){
									if (data.array != null) {
						    			for (var i = 0; i < data.array.length; i++) {
						    				var item = data.array[i];
						    				categoryOptions[i + 1] = new Option(item[1], item[0]);
						    			}	    				
					    			}
								}
							});
						}
					});	
				});
                $(document).ready(function() {
                    $("#fromDate" ).datepicker({
                            showOn: "button", buttonImageOnly: true, buttonImage: '<c:url value="/themes/vms_stretch/images/iconCalendar.png"/>',
                            dateFormat : 'dd/mm/yy',
                            onSelect: function (selectedDateTime){
                                var dateFmt = 'mm/dd/yy';
                                var start = $(this).datetimepicker('getDate');
                                var end = new Date(start.getTime() + (1000 * 86400 * 7));
                                $('#toDate').val($.datepicker.formatDate(dateFmt, end, dateFmt));
                            }
                    });
                    $("#toDate" ).datepicker({ showOn: "button", buttonImageOnly: true, buttonImage: '<c:url value="/themes/vms_stretch/images/iconCalendar.png"/>', dateFormat:'dd/mm/yy' });

                });
				</script>
			</form:form>
		</div>
		<div class="clear"></div>
	</div>
</body>

