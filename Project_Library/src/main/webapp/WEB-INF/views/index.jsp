<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${not empty loginUser}">
    <script>
        location.href = '${pageContext.request.contextPath}/books';
    </script>
</c:if>

<div class="container mt-5" style="max-width: 400px;">
    <h2 class="text-center mb-4">🔐 로그인</h2>

    <c:if test="${not empty errorMsg}">
        <div class="alert alert-danger" role="alert">${errorMsg}</div>
    </c:if>
    <c:if test="${not empty successMsg}">
        <div class="alert alert-success" role="alert">${successMsg}</div>
    </c:if>

    <form method="post" action="<c:url value='/login' />">
        <div class="mb-3">
            <label for="username" class="form-label">아이디</label>
            <input type="text" name="username" class="form-control" required />
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">비밀번호</label>
            <input type="password" name="password" class="form-control" required />
        </div>
        <button type="submit" class="btn btn-primary w-100">로그인</button>
    </form>

    <div class="mt-3 text-center">
        <a href="<c:url value='/join' />">
            <button class="btn btn-outline-secondary btn-sm">회원가입</button>
        </a>
    </div>

    <div class="mt-2 text-center">
        <a href="${pageContext.request.contextPath}/find-id">아이디 찾기</a> |
        <a href="#" onclick="alert('비밀번호를 잊으셨다면 관리자에게 문의해주세요.\n이메일: admin@library.com'); return false;">비밀번호 찾기</a>
    </div>
</div>
