<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<h5 class="mt-4">🗑 논리 삭제된 도서 목록</h5>

<c:if test="${empty deletedBooks}">
  <p class="text-muted">삭제된 도서가 없습니다.</p>
</c:if>

<table class="table table-bordered table-sm">
  <thead>
    <tr>
      <th>제목</th>
      <th>저자</th>
      <th>삭제일</th> <!-- 나중에 삭제일자 필드 생기면 표시 -->
      <th>관리</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="book" items="${deletedBooks}">
      <tr>
        <td>
		  ${book.title}
		</td>
        <td>${book.author}</td>
        <td>
          <!-- 복구 -->
          <form method="post" action="${ctx}/admin/books/restore" class="d-inline">
            <input type="hidden" name="bookId" value="${book.bookId}" />
            <button type="submit" class="btn btn-sm btn-success">복구</button>
          </form>

          <!-- 영구 삭제 -->
          <form method="post" action="${ctx}/admin/books/delete"
                class="d-inline"
                onsubmit="return confirm('정말 완전히 삭제하시겠습니까?')">
            <input type="hidden" name="bookId" value="${book.bookId}" />
            <button type="submit" class="btn btn-sm btn-danger">삭제</button>
          </form>
        </td>
        <td>
   		<c:choose>
		  <c:when test="${book.isDeleted == 1}">
		    <span class="badge bg-danger ms-1">
			<c:if test="${not empty book.deletedAt}">
			  ${fn:substring(book.deletedAt, 0, 10)}
			</c:if>
		      일 삭제됨
		    </span>
		  </c:when>
		</c:choose>
        </td>
      </tr>
    </c:forEach>
  </tbody>
</table>
