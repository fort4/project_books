<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-3">
  <div class="container-fluid">

    <!-- [1] 로고 -->
    <div class="d-flex align-items-center">
      <a class="navbar-brand fw-bold" href="${ctx}/index">📚 Bookey</a>
    </div>

    <!-- [2] 검색창 -->
    <div class="d-flex align-items-center mx-auto" style="width: 340px; height: 38px; line-height: 30px; margin-top: 15px; font-size: 14px;">
      <form class="d-flex w-100" action="${ctx}/books" method="get">
        <input class="form-control" name="keyword" type="search" placeholder="도서 검색">
        <button class="btn btn-outline-light ms-2" type="submit">
          <i class="fas fa-search"></i>
        </button>
      </form>
    </div>

    <!-- [3] 버튼들 -->
    <div class="d-flex align-items-center gap-2">
      <a href="${ctx}/wishlist" class="btn btn-outline-warning" title="찜 목록">
        <i class="fas fa-star"></i>
      </a>
      <a href="${ctx}/cart" class="btn btn-outline-info" title="장바구니">
        <i class="fas fa-shopping-cart"></i>
      </a>
      <c:choose>
        <c:when test="${empty loginUser}">
			<a href="${ctx}/login" class="btn btn-outline-light">
			  <i class="fas fa-user"></i> 로그인
			</a>
        </c:when>
        <c:otherwise>
			<a href="${ctx}/member/mypage" class="btn btn-outline-success">
			  <i class="fas fa-user-check"></i> 마이페이지
			</a>
        </c:otherwise>
      </c:choose>
    </div>

  </div>
</nav>

