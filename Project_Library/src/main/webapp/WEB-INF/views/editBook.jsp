<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>도서 수정</title></head>
<body>
    <h2>✏️ 도서 수정</h2>

    <form action="<c:url value='/books/edit' />" method="post">
        <input type="hidden" name="bookId" value="${book.bookId}" />
        <label>제목: <input type="text" name="title" value="${book.title}" required></label><br/>
        <label>저자: <input type="text" name="author" value="${book.author}" required></label><br/>
        <label>출판사: <input type="text" name="publisher" value="${book.publisher}" required></label><br/>
        <label>출판일: <input type="date" name="pubDate" value="${book.pubDate}" required></label><br/>
        <label>이미지 경로(URL): <input type="text" name="imageUrl" value="${book.imageUrl}"></label><br/>
        <button type="submit">수정하기</button>
    </form>

    <p><a href="<c:url value='/books' />">← 목록으로</a></p>
</body>
</html>
