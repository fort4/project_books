<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>회원가입</title></head>
<body>
    <h2>📋 회원가입</h2>

    <form action="<c:url value='/join' />" method="post">
        <label>아이디: <input type="text" name="username" required /></label><br/>
        <label>비밀번호: <input type="password" name="password" required /></label><br/>
        <label>이름: <input type="text" name="name" required /></label><br/>
        <label>생년월일: <input type="date" name="birthDate" required /></label><br/>
        <button type="submit">가입하기</button>
    </form>
	
	<script>
		/* TODO: header나 common같은 공통include 파일 생성 후 전역 설정할 예정 */
    	const ctx = '${pageContext.request.contextPath}';
	</script>

	<button type="button" onclick="location.href=ctx + '/index'">
	    로그인으로 돌아가기
	</button>


</body>
</html>
