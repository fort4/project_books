<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-3">
  <div class="container-fluid d-flex justify-content-between align-items-center">

    <!-- 로고 -->
    <a class="navbar-brand fw-bold me-4" href="${ctx}/index">📚 Bookey</a>

    <!-- 검색창 (넓게) -->
    <form class="d-flex flex-grow-1 me-4" action="${ctx}/books" method="get">
      <input class="form-control me-2" type="search" name="keyword" placeholder="도서 검색" style="min-width: 300px;">
      <button class="btn btn-outline-light" type="submit"><i class="fas fa-search"></i></button>
    </form>

    <!-- 기능 버튼 (찜, 장바구니, 마이페이지) -->
    <div class="d-flex align-items-center gap-2">
      <a href="${ctx}/wishlist" class="btn btn-outline-warning" title="찜 목록">
        <i class="fas fa-star"></i>
      </a>
      <a href="${ctx}/cart" class="btn btn-outline-info" title="장바구니">
        <i class="fas fa-shopping-cart"></i>
      </a>
      <c:choose>
        <c:when test="${empty loginUser}">
          <a href="${ctx}/member/login" class="btn btn-outline-light" title="로그인">
            <i class="fas fa-user"></i>
          </a>
        </c:when>
        <c:otherwise>
          <a href="${ctx}/member/mypage" class="btn btn-outline-success" title="마이페이지">
            <i class="fas fa-user-check"></i>
          </a>
        </c:otherwise>
      </c:choose>
    </div>

  </div>
</nav>
