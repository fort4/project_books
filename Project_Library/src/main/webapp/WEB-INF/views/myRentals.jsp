<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>내 대여 목록</title></head>
<body>
    <h2>📄 내 대여 목록</h2>

    <table border="1">
        <tr>
            <th>도서번호</th>
            <th>아이디</th>
            <th>대여일</th>
            <th>반납일</th>
            <th>상태</th>
        </tr>
        <c:forEach var="r" items="${rentals}">
            <tr>
                <td><a href="<c:url value='/books/${r.bookId}' />">${r.bookId}</a></td>
                <td>${r.username}</td>
                <td>${r.rentalDate}</td>
                <td><c:out value="${r.returnDate != null ? r.returnDate : '-'}" /></td>
                <td>
                    <c:choose>
                        <c:when test="${r.returned}">반납완료</c:when>
                        <c:otherwise>대여중</c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </table>

    <p><a href="<c:url value='/books' />">← 도서 목록으로 돌아가기</a></p>
</body>
</html>
