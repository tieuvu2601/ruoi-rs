<%@ include file="/common/taglibs.jsp"%>
<div style="width: 100%;margin-bottom:10px;">
    <table style="width: 100%">
        <tr>
            <th colspan="3" align="center">${content}</th>
        </tr>

    <c:forEach items="${displayResultItems}" var="item" varStatus="status">
        <tr>
            <td>${item.displayName}</td>
            <td><p style="width: ${item.pollValue}px; margin-left: 5px; background-color: ${Constants.MAP_POLL_RESULT_COLOR[status.index]}">&nbsp;</p></td>
            <td>${itemValues[status.index]}</td>
        </tr>
    </c:forEach>
    </table>
</div>