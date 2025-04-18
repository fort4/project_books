<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 도서 슬라이더 -->
<c:if test="${not empty topBooks}">
  <div id="topBooksCarousel" class="carousel slide mb-4" data-bs-ride="carousel">
    <div class="text-center mt-3 mb-4">
      <h4>📊 가장 많이 대여된 책 Top 5</h4>
    </div>
    <div class="carousel-inner">
      <c:forEach var="book" items="${topBooks}" varStatus="status">
        <c:set var="imgUrl" value="${empty book.imageUrl 
            ? pageContext.request.contextPath.concat('/resources/images/books/default-book.png') 
            : pageContext.request.contextPath.concat(book.imageUrl)}" />

        <div class="carousel-item ${status.first ? 'active' : ''}">
          <div class="d-flex justify-content-center align-items-center flex-column">
            <img src="${imgUrl}" class="d-block" alt="${book.title}" style="max-height: 300px;">
            <h5 class="mt-3">${book.title}</h5>
            <p class="text-muted">${book.author}</p>
          </div>
        </div>
      </c:forEach>
    </div>

	<!-- 이전 버튼 -->
	<button class="carousel-control-prev" type="button" onclick="this.blur()" data-bs-target="#topBooksCarousel" data-bs-slide="prev"
	        style="width: auto; height: auto; top: 50%; transform: translateY(-50%); left: 10px;">
	  <span class="btn btn-dark rounded-circle d-flex justify-content-center align-items-center"
	        style="width: 40px; height: 40px;">
	    <i class="fas fa-chevron-left text-white"></i>
	  </span>
	  <span class="visually-hidden">이전</span>
	</button>
	
	<!-- 다음 버튼 -->
	<button class="carousel-control-next" type="button" onclick="this.blur()" data-bs-target="#topBooksCarousel" data-bs-slide="next"
	        style="width: auto; height: auto; top: 50%; transform: translateY(-50%); right: 10px;">
	  <span class="btn btn-dark rounded-circle d-flex justify-content-center align-items-center"
	        style="width: 40px; height: 40px;">
	    <i class="fas fa-chevron-right text-white"></i>
	  </span>
	  <span class="visually-hidden">다음</span>
	</button>
  </div>
</c:if>

<!-- 공지사항 / 광고 -->
<section class="mb-5 row">
  <div class="col-md-8">
    <h5 class="mb-3">📢 공지사항</h5>
    <ul class="list-group">
      <li class="list-group-item">📌 Bookey가 서비스 시작되었습니다.</li>
      <li class="list-group-item">🛠 4/17일 사이트 오류를 수정하였습니다.</li>
    </ul>
  </div>
  <div class="col-md-4">
    <h5 class="mb-3">🎉 광고 칸</h5>
    <div class="p-3 bg-secondary text-white text-center">이벤트 또는 배너 자리</div>
  </div>
</section>

<!-- 도서 목록 -->
<section>
  <h3 class="mb-4">📚 도서 목록</h3>
  <div id="bookListContainer">
  <!-- 들어오는 곳 -->
  </div>
</section>


<script>
/* 도서목록 ajax 처리 */
document.addEventListener("DOMContentLoaded", function () {
  fetch(`${ctx}/books/ajax`)
    .then(res => res.text())
    .then(html => {
      document.getElementById("bookListContainer").innerHTML = html;
    });
});

/* 페이지 번호 클릭시 ajax 목록 새로고침 */
function goPage(pageNum) {
    const form = document.getElementById("bookSearchForm"); // 기존 검색 폼이 있다면
    const formData = new FormData(form);
    formData.set("page", pageNum); // 페이지 번호 설정
    const params = new URLSearchParams(formData);
    // TL 충돌 ㅈ같네
    const url = ctx + "/books/ajax?" + params.toString();

    fetch(url)
      .then(res => res.text())
      .then(html => {
        document.getElementById("bookListContainer").innerHTML = html;
      });
}

/* 도서 상세페이지 동작 */
function goToDetail(bookId) {
	  location.href = ctx + "/books/" + bookId;
	}
</script>

