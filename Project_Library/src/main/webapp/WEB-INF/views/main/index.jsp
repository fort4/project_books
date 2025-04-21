<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 스타일 -->
<style>
  .swiper {
    width: 100%;
    height: 260px;
  }

  .swiper-slide {
    width: 200px; /* 반드시 고정 크기 */
    opacity: 0.4;
    transform: scale(0.85);
    transition: all 0.3s ease;
  }

  .swiper-slide-active {
    transform: scale(1.1);
    opacity: 1 !important;
    z-index: 2;
    border: 2px solid #4e73df;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
  }
</style>

<!-- Swiper 슬라이더 CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css"/>
<!-- 슬라이더 섹션 -->
<div class="row">

  <!-- 왼쪽: 슬라이더 영역(일단 약 65%로) -->
  <div class="col-lg-8 mt-2">
    <div class="swiper mySwiper mb-4">
      <div class="swiper-wrapper">
        <c:forEach var="book" items="${topBooks}">
          <div class="swiper-slide text-center">
            <img src="${ctx}/resources/images/books/${empty book.imageUrl ? 'no-image.jpg' : book.imageUrl}"
                 alt="${book.title}" class="img-fluid rounded shadow"
                 style="height: 180px; object-fit: cover;">
            <p class="mt-2 font-weight-bold small mb-0">${book.title}</p>
          </div>
        </c:forEach>
      </div>
      <div class="swiper-button-next"></div>
      <div class="swiper-button-prev"></div>
    </div>
  </div>
  <!-- 오른쪽 공지사항 + 이벤트 배너 -->
  <div class="col-lg-4 mt-2">
    
    <!-- 공지사항 박스 -->
    <div class="card shadow-sm mb-4">
      <div class="card-header py-2">
        <h6 class="m-0 font-weight-bold text-danger">📢 공지사항</h6>
      </div>
      <ul class="list-group list-group-flush small">
        <li class="list-group-item text-danger">📌 I-BOOKS 서비스 시작!</li>
        <li class="list-group-item text-muted">🛠 사이트 오류 수정 완료</li>
      </ul>
    </div>

    <!-- 이벤트 배너 -->
    <div class="card text-center bg-secondary text-white shadow-sm mb-4">
      <div class="card-body py-4">
        	🎉 이벤트/배너 자리
      </div>
    </div>

  </div>
</div>
<!-- Swiper JS -->
<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>


<!-- ---------------도서 목록----------------- -->

<!-- 도서 목록 -->
<section class="mb-5">
	<!-- 📚 도서 검색/필터 -->
	<form id="bookSearchForm" class="card card-body shadow-sm mb-4">
	  <div class="row gy-2 gx-3 align-items-center">
	
	    <!-- 카테고리 -->
	    <div class="col-md-auto">
	      <select name="categoryId" class="form-select form-select-sm">
	        <option value="">전체</option>
	        <c:forEach var="cat" items="${categories}">
	          <option value="${cat.categoryId}">${cat.name}</option>
	        </c:forEach>
	      </select>
	    </div>
	
	    <!-- 검색 input + 버튼 (input-group 사용) -->
	    <div class="col-md">
	      <div class="input-group input-group-sm px-2">
	        <input type="text" name="keyword" class="form-control" placeholder="도서 제목 검색">
	        <button type="submit" class="btn btn-outline-secondary ps-2">
	          <i class="fas fa-search"></i>
	        </button>
	      </div>
	    </div>
	
	    <!-- 정렬 옵션 3종 -->
	    <div class="col-md-auto ms-auto d-flex gap-2">
	      <select name="sort" class="form-select form-select-sm">
	        <option value="title">제목순</option>
	        <option value="pubDate">최신순</option>
	      </select>
	      <select name="order" class="form-select form-select-sm">
	        <option value="desc" selected>내림차순</option>
	        <option value="asc">오름차순</option>
	      </select>
	      <select name="size" class="form-select form-select-sm">
	        <option value="10">10개씩</option>
	        <option value="20">20개씩</option>
	        <option value="30">30개씩</option>
	      </select>
	    </div>
	
	  </div>
	</form>
	
	<!-- 📚 도서 목록 -->
	<div id="bookListContainer">
		<!-- AJAX 결과가 여기에 들어옴 -->
	</div>
	
</section> <!-- 도서목록 섹션 -->

<script>
/* 슬라이더용 기능 */
const swiper = new Swiper(".mySwiper", {
  slidesPerView: 3,
  centeredSlides: true,
  spaceBetween: 30,
  loop: true,
  autoplay: {
    delay: 2500,
    disableOnInteraction: false,
  },
  navigation: {
    nextEl: ".swiper-button-next",
    prevEl: ".swiper-button-prev",
  },
});

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

