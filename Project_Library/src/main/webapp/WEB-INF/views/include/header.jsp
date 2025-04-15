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

        <div class="collapse navbar-collapse justify-content-end">
            <ul class="navbar-nav">

                <!-- 로그인 안 했을 때 -->
                <c:if test="${empty loginUser}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/index">로그인</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/join">회원가입</a>
                    </li>
                </c:if>

                <!-- 일반 회원 메뉴 -->
                <c:if test="${loginUser.role == 'user'}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/mypage">마이페이지</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/myrentals">내 대여 목록</a>
                    </li>
                </c:if>

                <!-- 관리자 메뉴 -->
                <c:if test="${loginUser.role == 'admin'}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/members">회원 관리</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/books/add">도서 등록</a>
                    </li>
                </c:if>

                <!-- 로그인 유저 공통 로그아웃 -->
                <c:if test="${not empty loginUser}">
                    <li class="nav-item">
                        <a class="nav-link text-warning" href="${pageContext.request.contextPath}/logout">로그아웃</a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>
