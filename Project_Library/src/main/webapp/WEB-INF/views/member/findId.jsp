<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>아이디 찾기</title>
    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <h2 class="text-center mb-4">아이디 찾기</h2>

    <div class="row justify-content-center">
        <div class="col-md-6">
            <form action="${pageContext.request.contextPath}/find-id" method="post" class="card p-4 shadow-sm">
                <div class="mb-3">
                    <label for="name" class="form-label">이름</label>
                    <input type="text" class="form-control" name="name" required>
                </div>

                <div class="mb-3">
                    <label for="birthDate" class="form-label">생년월일</label>
                    <input type="date" class="form-control" name="birthDate" required>
                </div>

                <button type="submit" class="btn btn-primary w-100">아이디 찾기</button>
            </form>

            <c:if test="${not empty foundId}">
                <div class="alert alert-success mt-4 text-center">
                    회원님의 아이디는 <strong>${foundId}</strong> 입니다.
                </div>
            </c:if>

            <c:if test="${not empty errorMsg}">
                <div class="alert alert-danger mt-4 text-center">
                    ${errorMsg}
                </div>
            </c:if>

            <div class="text-center mt-3">
                <a href="${pageContext.request.contextPath}/index" class="text-decoration-none">로그인 화면으로 돌아가기</a>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS (선택) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
