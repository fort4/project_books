<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<title>도서 등록</title>
</head>
<body>
    <h2>📘 새 도서 등록</h2>

    <form action="<c:url value='/books/add' />" method="post">
        <label>제목: <input type="text" name="title" required></label><br/>
        <label>저자: <input type="text" name="author" required></label><br/>
        <label>출판사: <input type="text" name="publisher" required></label><br/>
        <label>출판일: <input type="date" name="pubDate" required></label><br/>
        <label>이미지 경로(URL): <input type="text" name="imageUrl" placeholder="/resources/images/book.jpg"></label><br/>
        <button type="submit">등록하기</button>
    </form>

    <p><a href="<c:url value='/books' />">← 목록으로 돌아가기</a></p>
</body>
</html>
