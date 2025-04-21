<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" scope="request" />
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <!-- SB Admin 2 Styles -->
  <link href="${ctx}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
  <link href="${ctx}/resources/css/sb-admin-2.min.css" rel="stylesheet">
  <title>I-BOOKS</title>
  
<script> const ctx = '${ctx}'; </script>
</head>
<body id="page-top">
<!-- 전체 래퍼 -->
<div id="wrapper">
	
	<!-- 사이드 바 -->
	<%-- <jsp:include page="/include/sidebar.jsp" /> --%>
	
	<!-- 컨텐츠 래퍼 -->
	<div id="content-wrapper" class="d-flex flex-column">
		<div id="content">
		
			<%-- 상단 바 --%>
			<!-- InternalResourceViewResolver의 경로처리 위해 상대경로로 변경 -->
			<jsp:include page="include/header.jsp" />
		
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
			<div class="container-fluid">
			  <jsp:include page="/WEB-INF/views/${contentPage}.jsp" />
			</div>
		
			<%-- 하단 푸터 --%>
			<jsp:include page="include/footer.jsp" />
		
		</div>
</div>
</div><!-- 전체 래퍼 -->

<!-- top 스크롤 버튼 -->
<a class="scroll-to-top rounded" href="#page-top">
  <i class="fas fa-angle-up"></i>
</a>

<!-- JS Scripts(순서 맞춤) -->
<script src="${ctx}/resources/vendor/jquery/jquery.min.js"></script>
<script src="${ctx}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${ctx}/resources/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="${ctx}/resources/js/sb-admin-2.min.js"></script>

</body>
</html>