<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="row mb-5">
  <!-- 📚 슬라이더 (좌측 2/3) -->
  <div class="col-md-8">
    <c:if test="${not empty topBooks}">
      <div id="topBooksCarousel" class="carousel slide" data-bs-ride="carousel">
        <div class="text-center mb-3">
          <h5 class="fw-bold">📊 가장 많이 대여된 책 Top 5</h5>
        </div>
        <div class="carousel-inner">
          <c:forEach var="book" items="${topBooks}" varStatus="status">
            <c:set var="displayImage" value="${empty book.imageUrl ? 'default-book.png' : book.imageUrl}" />
            <c:url var="imgUrl" value="/resources/images/books/${displayImage}" />
            <div class="carousel-item ${status.first ? 'active' : ''}">
              <div class="d-flex justify-content-center align-items-center flex-column">
                <img src="${imgUrl}" class="d-block"
                     alt="${book.title}"
                     style="max-height: 220px; object-fit: contain;">
                <h6 class="mt-2 mb-0">${book.title}</h6>
                <small class="text-muted">${book.author}</small>
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
  </div> <!-- 슬라이더 버튼 -->

  <!-- 📢 공지 + 🎉 광고 -->
  <div class="col-md-4 d-flex flex-column justify-content-between">
    <!-- 공지사항 -->
    <div class="mb-3">
      <h6 class="fw-bold mb-2">📢 공지사항</h6>
      <ul class="list-group list-group-flush small">
        <li class="list-group-item">📌 I-BOOKS 서비스 시작!</li>
        <li class="list-group-item">🛠 사이트 오류 수정 완료</li>
      </ul>
    </div>
    <!-- 광고 영역 -->
    <div class="bg-secondary text-white text-center p-3 rounded" style="min-height: 100px;">
      🎉 이벤트/배너 자리
    </div>
  </div> <!-- 공지, 광고 div -->
  
</div> <!-- 상단 메인 div -->

<!-- ---------------도서 목록----------------- -->

<!-- 도서 목록 -->
<section class="mb-5">
<!-- 📚 도서 검색/필터 -->
<form id="bookSearchForm" class="mb-3">
	  <!-- 🔎 검색 줄 -->
	<div class="d-flex align-items-center gap-2 mb-2">
	  <!-- 카테고리 -->
	  <select name="categoryId" class="form-select form-select-sm" style="width: 120px;">
	    <option value="">전체</option>
	    <c:forEach var="cat" items="${categories}">
	      <option value="${cat.categoryId}">${cat.name}</option>
	    </c:forEach>
	  </select>
	
	  <!-- 검색 input -->
	  <div class="flex-grow-1 position-relative">
	    <input type="text" name="keyword" class="form-control form-control-sm" placeholder="도서 제목 검색" />
	    <!-- 검색 버튼 -->
	    <button type="submit" class="btn btn-sm btn-outline-secondary position-absolute top-0 end-0 me-1 mt-1">
	      <i class="fas fa-search"></i>
	    </button>
	  </div>
	</div>
	
	<!-- 🔽 정렬 옵션 -->
	<div class="d-flex justify-content-end gap-2">
	  <select name="sort" class="form-select form-select-sm" style="width: 120px;">
	    <option value="title">제목순</option>
	    <option value="pubDate">최신순</option>
	  </select>
	
	  <select name="order" class="form-select form-select-sm" style="width: 120px;">
	    <option value="desc" selected>내림차순</option>
	    <option value="asc">오름차순</option>
	  </select>
	
	  <select name="size" class="form-select form-select-sm" style="width: 100px;">
	      <option value="10">10개씩</option>
	      <option value="20">20개씩</option>
	      <option value="30">30개씩</option>
	    </select>
	  </div>
</form>


	<!-- 📚 도서 목록 -->
	<div id="bookListContainer">
		<!-- AJAX 결과가 여기에 들어옴 -->
	</div>
	
</section> <!-- 도서목록 섹션 -->



<script>
document.addEventListener("DOMContentLoaded", function () {
	  const form = document.getElementById("bookSearchForm");

	  function fetchBookList (pageNum = 1) {
	    const formData = new FormData(form);
	    formData.set("page", pageNum);
	    const params = new URLSearchParams(formData);
	    const url = ctx + "/books/ajax?" + params.toString();
	    
	    fetch(url)
	      .then(res => res.text())
	      .then(html => {
	        document.getElementById("bookListContainer").innerHTML = html;
	      });
	  }

	  // 초기 로딩
	  fetchBookList();

	  // 폼 제출 시 검색
	  form.addEventListener("submit", function (e) {
	    e.preventDefault();
	    fetchBookList(1);
	  });

	  // 옵션 변경 시 자동 반영
	  ["categoryId", "sort", "size"].forEach(name => {
	    const el = form.querySelector(`[name="${name}"]`);
	    if (el) {
	      el.addEventListener("change", () => fetchBookList(1));
	    }
	  });

	  // 페이지 이동
	  window.goPage = function (pageNum) {
	    fetchBookList(pageNum);
	  };

	  // 도서 상세 이동
	  window.goToDetail = function (bookId) {
	    location.href = ctx + "/books/" + bookId;
	  };
	});
</script>

