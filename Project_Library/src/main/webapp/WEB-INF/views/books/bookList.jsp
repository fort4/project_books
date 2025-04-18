<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 도서 목록 카드 -->
<div class="row row-cols-2 row-cols-md-5 g-4 mb-4">
  <c:forEach var="book" items="${books}">
    <div class="col">
      <div class="card h-100 shadow-sm border-0" style="cursor: pointer;" onclick="goToDetail(${book.bookId})">
        <!-- 이미지 영역: 반응형 정사각형 -->
        <c:set var="displayImage" value="${empty book.imageUrl ? 'no-image.jpg' : book.imageUrl}" />
        <c:url var="imgUrl" value="/resources/images/books/${displayImage}" />

		<div class="ratio ratio-2x3" style="min-height: 200px;">
		  <img src="<c:out value='${imgUrl}'/>"
		       class="card-img-top object-fit-cover w-100 h-100 rounded-top"
		       alt="${book.title}" />
		</div>

        <!-- 텍스트 영역 -->
		<div class="card-body text-center p-2">
			<div class="fw-semibold text-truncate small" title="${book.title}">${book.title}</div>
			<div class="text-muted text-truncate" style="font-size: 0.75rem;" title="${book.author}">${book.author}</div>
		</div>
      </div><!-- 카드 -->
    </div>
  </c:forEach>
</div>

<!-- 페이징 -->
<c:if test="${total > 0}">
  <nav class="d-flex justify-content-center">
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


