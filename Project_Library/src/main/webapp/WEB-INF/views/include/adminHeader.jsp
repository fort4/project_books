<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
  <div class="container-fluid">
    <a class="navbar-brand" href="${ctx}/admin/dashboard">📊 관리자 대시보드</a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNavbar">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="adminNavbar">
      <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link" href="${ctx}/admin/books">📚 도서 관리</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${ctx}/admin/members">👤 회원 관리</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${ctx}/logout">🚪 로그아웃</a>
        </li>
      </ul>
    </div>
  </div>
</nav>
