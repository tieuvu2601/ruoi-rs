<%@ include file="/common/taglibs.jsp" %>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK" %>
	
<c:url value="/repository" var="hrefFile"/>
<html>

<head>
    <title></title>
    <c:url value="/" var="preUrl"/>
    <script type="text/javascript">
    	var preUrl='${preUrl}';
    </script>
</head>
<body>
      <textarea cols="80" id="EditorDefault" name="EditorDefault" rows="10"></textarea>
      
      <rep:href servletName="${hrefFile}"  value="7_by_Natsia.jpg" /> 
      <script type="text/javascript">
	      CKEDITOR.replace( 'EditorDefault',
		            {
		                filebrowserBrowseUrl :'${preUrl}ckeditor/filemanager/browser/default/browser.html?Connector=${preUrl}ckeditor/filemanager/connectors/php/connector.html?preventCache=' + new Date().getTime(),
		                filebrowserImageBrowseUrl : '${preUrl}ckeditor/filemanager/browser/default/browser.html?Type=Image&Connector=${preUrl}ckeditor/filemanager/connectors/php/connector.html?preventCache=' + new Date().getTime(),
		                filebrowserFlashBrowseUrl :'${preUrl}ckeditor/filemanager/browser/default/browser.html?Type=Flash&Connector=${preUrl}ckeditor/filemanager/connectors/php/connector.html?preventCache=' + new Date().getTime(),
					    filebrowserUploadUrl  :'${preUrl}ckeditor/filemanager/connectors/php/upload.html?Type=File',
					    filebrowserImageUploadUrl : '${preUrl}ckeditor/filemanager/connectors/php/upload.html?Type=Image',
					    filebrowserFlashUploadUrl : '${preUrl}ckeditor/filemanager/connectors/php/upload.html?Type=Flash'
		
			});
    </script>
</body>
</html>