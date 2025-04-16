<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<title>마이페이지</title>
<style>
    .badge {
        display: inline-block;
        padding: 4px 10px;
        font-size: 13px;
        border-radius: 10px;
        color: white;
        font-weight: bold;
    }
    .badge-user {
        background-color: #3498db; /* 파란색 */
    }
    .badge-admin {
        background-color: #e67e22; /* 주황색 */
    }
</style>
</head>
<body>
    <h2>👤 마이페이지</h2>

    <ul>
        <li><strong>아이디:</strong> ${user.username}</li>
        <li><strong>이름:</strong> ${user.name}</li>
        <li><strong>생년월일:</strong> ${user.birthDate}</li>
        <li><strong>권한:</strong>
		    <c:choose>
		        <c:when test="${user.role == 'admin'}">
		        	<span class="badge badge-admin">관리자</span>
		        </c:when>
		        <c:when test="${user.role == 'user'}">
		        	<span class="badge badge-user">일반회원</span>
		        </c:when>
		        <c:otherwise>
		        	<span class="badge" style="background-color: gray;">알 수 없음</span>
		        </c:otherwise>
		    </c:choose>
		</li>
    </ul>

    <p>
        <a href="<c:url value='/myrentals' />">📄 내 대여 목록 보기</a>
    </p>
    <p>
        <a href="<c:url value='/books' />">← 도서 목록으로 돌아가기</a>
    </p>
    
    <p><a href="<c:url value='/mypage/password' />">🔑 비밀번호 변경</a></p>
	<p><a href="<c:url value='/mypage/delete' />" style="color:red;">⚠️ 회원 탈퇴</a></p>
    
</body>
</html>
