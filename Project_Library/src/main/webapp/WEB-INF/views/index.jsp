<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>도서 대여 시스템 - 로그인</title>
</head>
<body>
    <h2>로그인</h2>
    <form action="login" method="post">
        <label for="username">아이디:</label>
        <input type="text" name="username" required /><br />

        <label for="password">비밀번호:</label>
        <input type="password" name="password" required /><br />
        
        <button type="submit">로그인</button>
        <script>
			/* TODO: header나 common같은 공통include 파일 생성 후 전역 설정할 예정 */
			const ctx = '${pageContext.request.contextPath}';
		</script>
		<button type="button" onclick="location.href=ctx + '/join'">회원가입</button>
        <%-- <button type="button" onclick="location.href='<c:url value='/join' />'">회원가입</button> --%>
        
    </form>

    <c:if test="${not empty errorMsg}">
        <p style="color:red;">${errorMsg}</p>
    </c:if>
</body>
</html>
