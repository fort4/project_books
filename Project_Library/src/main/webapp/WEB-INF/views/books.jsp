<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>도서 목록</title>
</head>
<body>

	<!-- 로그인 유저 정보 & 로그아웃 버튼 -->
	<c:if test="${not empty loginUser}">
	    <div style="text-align: right;">
	        <span>${loginUser.name} 님 | </span>
			<a href="<c:url value='/myrentals' />">나의 대여 목록</a>
	        <a href="<c:url value='/logout' />">
	            <button>🚪 로그아웃</button>
	        </a>
	    </div>
	</c:if>

	<!-- 검색 폼 -->
	<form method="get" action="<c:url value='/books' />">
	    <input type="text" name="keyword" placeholder="제목 또는 저자 검색" value="${param.keyword}" />
	    <button type="submit">🔍 검색</button>
	</form>
	<br>
	
    <h2>📚 도서 목록</h2>
    <table border="1">
        <tr>
        	<th>표지</th>
            <th>도서번호</th>
            <th>제목</th>
            <th>저자</th>
            <th>출판사</th>
            <th>출판일</th>
            <th>대여상태</th>
            <c:if test="${loginUser.role == 'admin'}">
            <th>관리</th>
            </c:if>
        </tr>
        <c:forEach var="book" items="${books}">
            <tr>
				<td>
					<a href="<c:url value='/books/${book.bookId}' />">
                        <c:choose>
                            <c:when test="${not empty book.imageUrl}">
                                <img src="<c:url value='${book.imageUrl}' />" width="100" height="140" alt="표지" />
                            </c:when>
                            <c:otherwise>
                                <img src="<c:url value='/resources/images/no-image.jpg' />" width="100" height="140" alt="기본 이미지" />
                            </c:otherwise>
                        </c:choose>
					</a>
				</td>
                <td>${book.bookId}</td>
                <td>${book.title}</td>
                <td>${book.author}</td>
                <td>${book.publisher}</td>
                <td>${book.pubDate}</td>
                <td>
                    <c:choose>
                        <c:when test="${book.rented}">대여중</c:when>
                        <c:otherwise>대여가능</c:otherwise>
                    </c:choose>
                </td>
				<c:if test="${loginUser.role == 'admin'}">
				    <td>
				        <a href="<c:url value='/books/edit/${book.bookId}' />">✏️ 수정</a> |
				        <a href="<c:url value='/books/delete/${book.bookId}' />"
				           onclick="return confirm('정말 삭제하시겠습니까?');">🗑 삭제</a>
				    </td>
				</c:if>
            </tr>
            
		
        </c:forEach>
        
		<c:if test="${loginUser.role == 'admin'}">
			<p><a href="<c:url value='/books/add' />"><button>➕ 도서 등록</button></a></p>
		</c:if>
		
		
		
		
    </table>
    
	
</body>
</html>
