<!-- WEB-INF/views/include/header.jsp -->
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Bootstrap 5.3 CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

<!-- 컨텍스트 경로 변수 -->
<script>
    const ctx = '${pageContext.request.contextPath}';
</script>

<!-- 상단 네비게이션 -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
    <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/books">📚 도서 대여 시스템</a>
		
        <!-- 모바일 또는 작은화면용 메뉴 토글 -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMenu">
            <span class="navbar-toggler-icon"></span>
        </button>
		
        <!-- 메뉴 영역 -->
        <div class="collapse navbar-collapse justify-content-end" id="navbarMenu">
            <ul class="navbar-nav align-items-center">

        		<!-- 로그인 안 했을 때 -->
				<c:if test="${empty loginUser}">
					<li class="nav-item">
				    	<a class="nav-link" href="<c:url value='/index' />">로그인</a>
					</li>
					<li class="nav-item">
				    	<a class="nav-link" href="<c:url value='/join' />">회원가입</a>
					</li>
				</c:if>
				
				<!-- 로그인 한 경우 -->
				<c:if test="${not empty loginUser}">
					<li class="nav-item me-2">
						<span class="navbar-text text-light small">${loginUser.name}님</span>
					</li>
				
				<!-- 유저 -->
				<c:if test="${loginUser.role == 'user'}">
					<li class="nav-item"><a class="nav-link" href="<c:url value='/mypage' />">👤 마이페이지</a></li>
					<li class="nav-item"><a class="nav-link" href="<c:url value='/myrentals' />">📚 대여 목록</a></li>
				</c:if>
				
				<!-- 관리자 -->
				<c:if test="${loginUser.role == 'admin'}">
					<li class="nav-item"><a class="nav-link" href="<c:url value='/admin/members'/>">👥 회원 관리</a></li>
					<li class="nav-item"><a class="nav-link" href="<c:url value='/books/add'/>">➕ 도서 등록</a></li>
				</c:if>
				
				<!-- 로그아웃 -->
				<li class="nav-item">
				    <a class="nav-link text-warning" href="<c:url value='/logout'/>">🚪 로그아웃</a>
				</li>
				
                </c:if> <!-- 로그인 한 경우 -->
            </ul><!-- 내비바 끗 -->
        </div>
    </div>
</nav>
