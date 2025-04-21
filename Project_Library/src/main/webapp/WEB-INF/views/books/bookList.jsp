<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 도서 목록 카드 -->
<div class="row row-cols-2 row-cols-lg-5 g-4 mt-4">
  <c:forEach var="book" items="${books}">
	<div class="col mt-3">
	  <div class="card h-100 shadow-sm border-0" style="cursor:pointer;" onclick="goToDetail('${book.bookId}')">
	    <img src="<c:url value='/resources/images/books/${empty book.imageUrl ? "no-image.jpg" : book.imageUrl}' />"
	         class="card-img-top w-100" alt="${book.title}"
	         style="height: 260px; object-fit: cover;" />
	    <div class="card-body px-2 py-3 text-center">
	      <h6 class="card-title text-truncate mb-1 fw-bold">${book.title}</h6>
	      <small class="text-muted">${book.author}</small>
	    </div>
	  </div>
	</div>
  </c:forEach>
</div>

<!-- 페이징 -->
<c:if test="${total > 0}">
  <nav class="d-flex justify-content-center mt-4">
    <ul class="pagination justify-content-center">

      <!-- 이전 페이지 그룹 -->
      <c:if test="${currentGroup > 1}">
        <li class="page-item">
          <a class="page-link" href="#" onclick="goPage(${(currentGroup - 1) * groupSize}); return false;">&lt;</a>
        </li>
      </c:if>

      <!-- 현재 그룹 페이지 번호 -->
      <c:forEach var="i" begin="${startPage}" end="${endPage}">
        <li class="page-item ${i == currentPage ? 'active' : ''}">
          <a class="page-link" href="#" onclick="goPage(${i}); return false;">${i}</a>
        </li>
      </c:forEach>

      <!-- 다음 페이지 그룹 -->
      <c:if test="${endPage < totalPages}">
        <li class="page-item">
          <a class="page-link" href="#" onclick="goPage(${endPage + 1}); return false;">&gt;</a>
        </li>
      </c:if>

    </ul>
  </nav>
</c:if>


