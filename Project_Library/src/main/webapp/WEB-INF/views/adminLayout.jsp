<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" scope="request"  />
<script>
  const ctx = '${ctx}';
</script>

<!-- 관리자 헤더 -->
<jsp:include page="/WEB-INF/views/include/adminHeader.jsp" />

<!-- 본문 컨텐츠 -->
<div class="container">
    <jsp:include page="/WEB-INF/views/${contentPage}.jsp" />
</div>

<!-- 관리자 푸터 -->
<jsp:include page="/WEB-INF/views/include/adminFooter.jsp" />
