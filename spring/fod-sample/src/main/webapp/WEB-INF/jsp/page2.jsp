<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
Parameter setted from ${p1}

<c:if test="${not empty result}">
    Some Errors Occured :
        <c:forEach items="${result}" var="err">
            ${err.objectName} : ${err.defaultMessage}
        </c:forEach>
</c:if>
</body>
</html>


