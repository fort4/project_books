<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>회원 관리</title>
    <style>
        .badge { padding: 4px 10px; border-radius: 10px; font-weight: bold; color: white; }
        .badge-user { background-color: #3498db; }
        .badge-admin { background-color: #e67e22; }
        .badge-deleted { background-color: gray; }
    </style>
</head>
<body>
    <h2>👥 전체 회원 목록</h2>
    <table border="1">
        <tr>
            <th>아이디</th>
            <th>이름</th>
            <th>생년월일</th>
            <th>권한</th>
            <th>탈퇴여부</th>
            <th>탈퇴일자</th>
        </tr>
        <c:forEach var="m" items="${members}">
            <tr>
                <td>${m.username}</td>
                <td>${m.name}</td>
                <td>${m.birthDate}</td>
                <td>
                    <c:choose>
                        <c:when test="${m.role == 'admin'}"><span class="badge badge-admin">관리자</span></c:when>
                        <c:when test="${m.role == 'user'}"><span class="badge badge-user">일반회원</span></c:when>
                        <c:otherwise><span class="badge">Unknown</span></c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${m.deleted}">
                            <span class="badge badge-deleted">탈퇴</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge" style="background-color: green;">정상</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:out value="${m.deletedAt != null ? m.deletedAt : '-'}" />
                </td>
            </tr>
        </c:forEach>
    </table>

    <p><a href="<c:url value='/books' />">← 도서 목록으로</a></p>
</body>
</html>
