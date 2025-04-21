<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 탑바 -->
<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 shadow">
  <div class="container-fluid">

    <!-- 왼족 로고 -->
      <a class="navbar-brand font-weight-bold text-primary" href="${ctx}/index">
      	📚 I-BOOKS
      </a>
      
    <!-- 중앙: 검색창 (mr-auto로 왼쪽 정렬) -->
	<form action="${ctx}/books/search" method="get" 
		  class="d-none d-sm-inline-block form-inline ml-3 mr-auto w-50"
		  style="margin-top: 18px;">
	  <div class="input-group w-100">
	    <input type="text" name="keyword" class="form-control bg-light border-0 small"
	           placeholder="책을 검색해 보세요..." />
	    <div class="input-group-append">
	      <button class="btn btn-primary" type="submit">
	        <i class="fas fa-search fa-sm"></i>
	      </button>
	    </div>
	  </div>
	</form>
	
	<!-- 오른쪽: 알림/유저/관리자/로그인 -->
	<ul class="navbar-nav align-items-center">

    <!-- 알림 아이콘 -->
    <c:if test="${not empty loginUser}">
      <li class="nav-item dropdown no-arrow mx-2">
        <a class="nav-link" href="${ctx}/member/notifications">
          <i class="fas fa-bell fa-fw text-gray-600"></i>
          <span id="notiBadge" class="badge badge-danger badge-counter" style="display: none;"></span>
        </a>
      </li>
    </c:if>
    
    <!-- 회원 드롭다운 -->
    <c:if test="${not empty loginUser}">
      <li class="nav-item dropdown no-arrow mx-2">
        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown">
          <span class="mr-2 d-none d-lg-inline text-gray-600 small">${loginUser.name}</span>
          <i class="fas fa-user-check fa-sm text-gray-600"></i>
        </a>
        <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
          <a class="dropdown-item" href="${ctx}/member/mybooks"><i class="fas fa-book mr-2 text-gray-400"></i> 나의 도서</a>
          <a class="dropdown-item" href="${ctx}/member/wishlist"><i class="fas fa-heart mr-2 text-gray-400"></i> 위시리스트</a>
          <a class="dropdown-item" href="${ctx}/member/mypage"><i class="fas fa-user mr-2 text-gray-400"></i> 마이페이지</a>
          <div class="dropdown-divider"></div>
          <form action="${ctx}/member/logout" method="get">
            <button class="dropdown-item"><i class="fas fa-sign-out-alt mr-2 text-gray-400"></i> 로그아웃</button>
          </form>
        </div>
      </li>
    </c:if>
	  
    <!-- 관리자 드롭다운 -->
    <c:if test="${not empty loginUser && loginUser.role == 'admin'}">
      <li class="nav-item dropdown no-arrow mx-2">
        <a class="nav-link dropdown-toggle" href="#" id="adminDropdown" role="button" data-toggle="dropdown">
          <i class="fas fa-cogs fa-lg text-danger"></i>
        </a>
        <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="adminDropdown">
          <a class="dropdown-item" href="${ctx}/admin/books">📚 도서 관리</a>
          <a class="dropdown-item" href="${ctx}/admin/books/add">➕ 도서 등록</a>
          <a class="dropdown-item" href="${ctx}/admin/rental-requests">📋 대여 요청 관리</a>
          <a class="dropdown-item" href="${ctx}/admin/members">👥 회원 관리</a>
          <a class="dropdown-item" href="${ctx}/admin/dashboard">📊 대시보드</a>
          <a class="dropdown-item" href="${ctx}/admin/notification/send">🔔 알림 전송</a>
        </div>
      </li>
    </c:if>
    
    <!-- 로그인 버튼 (로그인 상태에서 숨김) -->
    <c:if test="${empty loginUser}">
      <li class="nav-item mx-2">
        <a href="${ctx}/member/login" class="btn btn-outline-primary">
          <i class="fas fa-sign-in-alt"></i> 로그인
        </a>
      </li>
    </c:if>

    </ul>
  </div>
</nav>


<script>
document.addEventListener("DOMContentLoaded", function () {
    fetch(`${ctx}/api/notification/unread-count`)
        .then(res => res.text())
        .then(count => {
            const badge = document.getElementById("notiBadge");
            if (parseInt(count) > 0) {
                badge.innerText = count;
                badge.style.display = "inline-block";
            } else {
                badge.style.display = "none";
            }
        });
});
</script>

