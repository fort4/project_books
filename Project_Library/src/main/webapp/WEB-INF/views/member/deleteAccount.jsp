<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
</head>
<body>

<h2>⚠️ 회원 탈퇴</h2>
<form method="post" action="<c:url value='/mypage/delete' />">
    <label>비밀번호 확인: <input type="password" name="password" required /></label><br/>
    <button type="submit" onclick="return confirm('정말 탈퇴하시겠습니까?')">탈퇴하기</button>
    <p><a href="<c:url value='/mypage' />">← 마이 페이지로 돌아가기</a></p>
</form>
<c:if test="${not empty errorMsg}">
    <p style="color:red;">${errorMsg}</p>
</c:if>

</body>
</html>