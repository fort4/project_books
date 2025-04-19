<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-3">
  <div class="container-fluid">

    <!-- 로고 -->
    <div class="d-flex align-items-center">
      <a class="navbar-brand fw-bold" href="${ctx}/index">📚 Bookey</a>
    </div>

	<!-- 버튼 영역 -->
	<div class="d-flex align-items-center gap-2">
		<c:choose>
		    <c:when test="${not empty loginUser}">
		        <!-- 로그인된 사용자: 드롭다운 메뉴 -->
		        <div class="dropdown">
		            <button class="btn btn-outline-success dropdown-toggle" type="button" id="userMenu" data-bs-toggle="dropdown" aria-expanded="false">
		                <i class="fas fa-user-check"></i> ${loginUser.name}
		            </button>
		            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userMenu">
		                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/member/mypage">마이페이지</a></li>
		                <li><hr class="dropdown-divider"></li>
		                <li>
		                    <form action="${pageContext.request.contextPath}/member/logout" method="get" class="d-inline">
		                        <button type="submit" class="dropdown-item">로그아웃</button>
		                    </form>
		                </li>
		            </ul>
		        </div>
		    </c:when>
		    <c:otherwise>
		        <!-- 비로그인 상태: 로그인 버튼 -->
		        <a href="${pageContext.request.contextPath}/member/login" class="btn btn-outline-light">
		            <i class="fas fa-user"></i> 로그인
		        </a>
		    </c:otherwise>
		</c:choose>

		<!-- 관리자: 드롭다운 메뉴 -->
		  <c:if test="${not empty loginUser && loginUser.role == 'admin'}">
			<div class="dropdown">
			  <button class="btn btn-outline-danger dropdown-toggle" type="button" data-bs-toggle="dropdown">
			    <i class="fas fa-cogs"></i> 관리자
			  </button>
			  <ul class="dropdown-menu dropdown-menu-end">
			    <li><a class="dropdown-item" href="${ctx}/admin/books">📚 도서 관리</a></li>
			    <li><a class="dropdown-item" href="${ctx}/admin/books/add">➕ 도서 등록</a></li>
			    <li><a class="dropdown-item" href="${ctx}/admin/rental-requests">📋 대여 요청 관리</a></li>
			    <li><a class="dropdown-item" href="${ctx}/admin/members">👥 회원 관리</a></li>
			    <li><a class="dropdown-item" href="${ctx}/admin/dashboard">📊 대시보드</a></li>
			  </ul>
			</div>
		</c:if>


	</div>


</div>
</nav>

