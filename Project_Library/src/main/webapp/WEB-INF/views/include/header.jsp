<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Bootstrap 5.3 + FontAwesome -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
<!-- 폰트 -->
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">

<style>
  body {
    font-family: 'Noto Sans KR', sans-serif;
  }
  
  .navbar {
    backdrop-filter: blur(6px);
    background-color: rgba(33, 37, 41, 0.9) !important;
  }

  .nav-link:hover {
    color: #ffc107 !important;
  }

  .navbar-brand {
    font-weight: bold;
    letter-spacing: 0.5px;
  }
</style>

<nav class="navbar navbar-expand-lg navbar-dark mb-4 shadow-sm">
  <div class="container-fluid">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/books">
      <i class="fa-solid fa-book"></i> 도서 대여 시스템
    </a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMenu">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse justify-content-end" id="navbarMenu">
      <ul class="navbar-nav align-items-center">

        <c:if test="${empty loginUser}">
          <li class="nav-item"><a class="nav-link" href="<c:url value='/index' />">로그인</a></li>
          <li class="nav-item"><a class="nav-link" href="<c:url value='/join' />">회원가입</a></li>
        </c:if>

        <c:if test="${not empty loginUser}">
          <li class="nav-item me-3">
            <span class="navbar-text text-light fw-bold">
              	👋 ${loginUser.name}님
            </span>
          </li>

          <c:if test="${loginUser.role == 'user'}">
            <li class="nav-item"><a class="nav-link" href="<c:url value='/mypage' />"><i class="fa-solid fa-user"></i> 마이페이지</a></li>
            <li class="nav-item"><a class="nav-link" href="<c:url value='/myrentals' />"><i class="fa-solid fa-bookmark"></i> 대여 목록</a></li>
          </c:if>

          <c:if test="${loginUser.role == 'admin'}">
            <li class="nav-item"><a class="nav-link" href="<c:url value='/admin/members'/>"><i class="fa-solid fa-users-gear"></i> 회원 관리</a></li>
            <li class="nav-item"><a class="nav-link" href="<c:url value='/books/add'/>"><i class="fa-solid fa-plus"></i> 도서 등록</a></li>
          </c:if>

          <li class="nav-item">
            <a class="nav-link text-warning" href="<c:url value='/logout'/>"><i class="fa-solid fa-right-from-bracket"></i> 로그아웃</a>
          </li>
        </c:if>

      </ul>
    </div>
  </div>
</nav>
