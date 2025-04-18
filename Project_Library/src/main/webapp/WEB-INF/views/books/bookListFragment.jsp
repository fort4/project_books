<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- 
<table class="table table-bordered table-hover align-middle text-center bg-white">
    <thead class="table-dark">
        <tr>
            <th>표지</th>
            <th>도서번호</th>
            <th>제목</th>
            <th>저자</th>
            <th>출판사</th>
            <th>출판일</th>
            <th>카테고리</th>
            <th>대여상태</th>
            <c:if test="${loginUser.role == 'admin'}">
                <th>관리</th>
            </c:if>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="book" items="${books}">
            <tr>
                <td>
                    <a href="<c:url value='/books/${book.bookId}' />">
                        <c:choose>
                            <c:when test="${not empty book.imageUrl}">
                                <img src="<c:url value='${book.imageUrl}' />" width="100" height="140" />
                            </c:when>
                            <c:otherwise>
                                <img src="<c:url value='/resources/images/no-image.jpg' />" width="100" height="140" />
                            </c:otherwise>
                        </c:choose>
                    </a>
                </td>
                <td>${book.bookId}</td>
                <td>${book.title}</td>
                <td>${book.author}</td>
                <td>${book.publisher}</td>
                <td>${book.pubDate}</td>
                <td>${book.categoryName}</td>
                <td>
                    <c:choose>
                        <c:when test="${book.rented}">대여중</c:when>
                        <c:otherwise>대여가능</c:otherwise>
                    </c:choose>
                </td>
                <c:if test="${loginUser.role == 'admin'}">
                    <td>
                        <a href="<c:url value='/books/edit/${book.bookId}' />" class="btn btn-sm btn-warning">✏️ 수정</a>
                        <a href="<c:url value='/books/delete/${book.bookId}' />"
                           class="btn btn-sm btn-danger"
                           onclick="return confirm('정말 삭제하시겠습니까?');">🗑 삭제</a>
                    </td>
                </c:if>
            </tr>
        </c:forEach>
    </tbody>
</table>

<!-- 하단 페이징 -->
<c:if test="${totalPages > 1}">
    <nav>
        <ul class="pagination justify-content-center">
            <c:forEach begin="1" end="${totalPages}" var="p">
                <li class="page-item ${currentPage == p ? 'active' : ''}">
                    <a class="page-link" href="#" onclick="goPage(${p}); return false;">${p}</a>
                </li>
            </c:forEach>
        </ul>
    </nav>
</c:if> --%>
