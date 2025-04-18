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
  <!-- 공통 버튼: 찜 / 장바구니 -->
  <c:if test="${not empty loginUser && loginUser.role == 'user'}">
    <a href="${ctx}/wishlist" class="btn btn-outline-warning" title="찜 목록">
      <i class="fas fa-star"></i>
    </a>
    <a href="${ctx}/cart" class="btn btn-outline-info" title="장바구니">
      <i class="fas fa-shopping-cart"></i>
    </a>
  </c:if>

  <!-- 일반 사용자: 마이페이지 -->
  <c:if test="${not empty loginUser && loginUser.role == 'user'}">
    <a href="${ctx}/member/mypage" class="btn btn-outline-success">
      <i class="fas fa-user-check"></i> 마이페이지
    </a>
  </c:if>

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

  <!-- 로그인/로그아웃 -->
  <c:choose>
    <c:when test="${empty loginUser}">
      <a href="${ctx}/login" class="btn btn-outline-light">
        <i class="fas fa-user"></i> 로그인
      </a>
    </c:when>
    <c:otherwise>
      <a href="${ctx}/logout" class="btn btn-outline-secondary">
        <i class="fas fa-sign-out-alt"></i> 로그아웃
      </a>
    </c:otherwise>
  </c:choose>
</div>


  </div>
</nav>

