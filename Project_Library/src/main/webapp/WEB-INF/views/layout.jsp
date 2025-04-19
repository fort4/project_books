<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" scope="request" />
<html>
<head>
  <title>Bookey 서점</title>
  <!-- Bootstrap 5.3 + FontAwesome -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<script> const ctx = '${ctx}'; </script>
</head>
<body class="d-flex flex-column min-vh-100">

	<%-- 상단 바 --%>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />

	<!-- 플래시 메시지 -->
	<c:if test="${not empty successMsg}">
		<div class="alert alert-success alert-dismissible fade show" role="alert">
		  ${successMsg}
		  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		</div>
	</c:if>
	<c:if test="${not empty errorMsg}">
	    <div class="alert alert-danger">${errorMsg}</div>
	    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
	</c:if>
	
	<%-- 본문 콘텐츠 --%>
	<div class="container flex-grow-1 py-4">
	  <jsp:include page="/WEB-INF/views/${contentPage}.jsp" />
	</div>

	<%-- 하단 푸터 --%>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>