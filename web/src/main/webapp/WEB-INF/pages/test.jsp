<%@ include file="/common/taglibs.jsp" %>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK" %>
	
<html>

<head>
    <title>Test Sms</title>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#btSend").click(function(){
				var phone = $("#phone").val();
				var message = $("#message").val();
				var url = "<c:url value='/ajax/message.html'/>?phone="+phone+"&message="+message;
				$.getJSON(url, function(data){
			        if(data.success){
			            jAlert(data.message, "Result Response");
			        }
			    });
			});
		});
	</script>
</head>
<body>
	<table width="100%">
		<tr>
			<td width="120px;">Phone number:</td>
			<td><input type="text" id="phone" value="${userEntity.phone}"/></td>
		</tr>
		<tr>
			<td>Message:</td>
			<td>
				<input type="text" id="message"/>
				<span style="color:#858585;">Syntax:[ContenID Decision], Decision:A=approve,R=reject</span>
			</td>
		</tr>
		<tr>
			<td></td>
			<td><input type="button" id="btSend" value="Send"/></td>
		</tr>
    </table>
</body>
</html>
