<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
body {
	background: url('<c:url value="/resources/images/bg-library.jpg" />') no-repeat center center;
	background-attachment: scroll;
	background-size: cover;
}
  
body::before {
	content: "";
	position: fixed;
	top: 0; left: 0;
	width: 100%; height: 100%;
	background: rgba(0, 0, 0, 0.5); /* 어두운 오버레이 */
	z-index: -1;
}
  
.card {
	background-color: rgba(255, 255, 255, 0.97);
	border-radius: 1rem;
	box-shadow: 0 4px 16px rgba(0,0,0,0.2);
}
  
</style>


<c:if test="${not empty loginUser}">
    <script>location.href = '${pageContext.request.contextPath}/books';</script>
</c:if>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

<div class="container d-flex justify-content-center align-items-center" style="min-height: 80vh;">
    <div class="card shadow rounded" style="max-width: 420px; width: 100%;">
        <div class="card-body">
            <h3 class="text-center mb-4">
                <i class="fa-solid fa-lock text-warning me-2"></i>로그인
            </h3>

            <c:if test="${not empty errorMsg}">
                <div class="alert alert-danger" role="alert">${errorMsg}</div>
            </c:if>
            <c:if test="${not empty successMsg}">
                <div class="alert alert-success" role="alert">${successMsg}</div>
            </c:if>

            <form method="post" action="<c:url value='/login' />">
                <div class="mb-3">
                    <label class="form-label">아이디</label>
                    <input type="text" name="username" class="form-control" placeholder="아이디 입력" required autofocus />
                </div>
                <div class="mb-3">
                    <label class="form-label">비밀번호</label>
                    <input type="password" name="password" class="form-control" placeholder="비밀번호 입력" required />
                </div>
                <button type="submit" class="btn btn-primary w-100 fw-bold">로그인</button>
            </form>

            <div class="mt-4 text-center">
                <a href="<c:url value='/join' />" class="btn btn-outline-secondary btn-sm">회원가입</a>
            </div>

            <div class="mt-3 text-center small">
                <a href="${pageContext.request.contextPath}/find-id" class="me-2">아이디 찾기</a> |
                <a href="#" onclick="alert('비밀번호를 잊으셨다면 관리자에게 문의해주세요.\n이메일: admin@library.com'); return false;">비밀번호 찾기</a>
            </div>
        </div>
    </div>
</div>
