<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/WEB-INF/views/include/adminHeader.jsp" />

<div class="container my-4">
    <jsp:include page="/WEB-INF/views/${contentPage}.jsp" />
</div>

<jsp:include page="/WEB-INF/views/include/adminFooter.jsp" />
