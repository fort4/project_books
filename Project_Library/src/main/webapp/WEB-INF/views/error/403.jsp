<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container mt-5 text-center">
  <h1 class="display-4 text-danger">🚫 403 Forbidden</h1>
  <p class="lead">이 페이지에 접근할 수 있는 권한이 없습니다.</p>
  <a href="${pageContext.request.contextPath}/index" class="btn btn-primary mt-3">🏠 메인으로 이동</a>
</div>
