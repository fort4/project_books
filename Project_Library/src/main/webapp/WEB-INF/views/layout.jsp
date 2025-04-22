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
<script src="${ctx}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<script>
	const ctx = '${ctx}';
	
	// 3초 후 서서히 사라지게(fadeOut)
	setTimeout(function () {
	  $(".alert").fadeTo(500, 0).slideUp(500, function () {
	    $(this).remove();
	  });
	}, 2000);
</script>
</head>
<body id="page-top" class="d-flex flex-column min-vh-100">
<!-- 전체 래퍼 -->
<div id="wrapper" class="flex-grow-1 d-flex flex-column">
	
	<!-- 컨텐츠 래퍼 -->
	<div id="content-wrapper" class="d-flex flex-column flex-grow-1">
		
		<%-- 상단 바 --%>
		<!-- InternalResourceViewResolver의 경로처리 위해 상대경로로 변경 -->
		<jsp:include page="include/header.jsp" />
	
		<!-- 플래시 메시지 -->
		<div class="container mt-1">
		  <c:if test="${not empty successMsg}">
		    <div class="alert alert-success alert-dismissible fade show small" role="alert">
		      ${successMsg}
		      <button type="button" class="close" data-dismiss="alert" aria-label="Close" style="margin-top: -6px;">
		        <span aria-hidden="true">&times;</span>
		      </button>
		    </div>
		  </c:if>
		
		  <c:if test="${not empty errorMsg}">
		    <div class="alert alert-danger alert-dismissible fade show small" role="alert">
		      ${errorMsg}
		      <button type="button" class="close" data-dismiss="alert" aria-label="Close" style="margin-top: -6px;">
		        <span aria-hidden="true">&times;</span>
		      </button>
		    </div>
		  </c:if>
		</div><!-- 플래시 메시지 -->
		
		<%-- 본문 콘텐츠 --%>
		<div class="container-fluid">
		  <jsp:include page="/WEB-INF/views/${contentPage}.jsp" />
		</div>
		
	</div><!-- 컨텐츠 래퍼 -->
</div><!-- 전체 래퍼 -->

<!-- 푸터 -->
<footer class="bg-white border-top py-3 text-center small text-muted shadow-sm">
    ⓒ 2025 I-BOOKS by KW. All rights reserved.
</footer>

<!-- JS Scripts -->
<script src="${ctx}/resources/vendor/jquery/jquery.min.js"></script>
<script src="${ctx}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${ctx}/resources/vendor/jquery-easing/jquery.easing.min.js"></script>
<script src="${ctx}/resources/js/sb-admin-2.min.js"></script>

</body>
</html>