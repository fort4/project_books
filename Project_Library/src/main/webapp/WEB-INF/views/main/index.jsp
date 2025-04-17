<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 추천 도서 슬라이드 -->
<section class="mb-5">
  <h3 class="mb-3">📘 추천 도서</h3>
  <div id="topBookCarousel" class="carousel slide" data-bs-ride="carousel">
    <div class="carousel-inner">
      <c:forEach var="book" items="${topBooks}" varStatus="status">
        <div class="carousel-item ${status.first ? 'active' : ''}">
          <div class="d-flex justify-content-center">
            <img src="${book.imageUrl != null ? book.imageUrl : '/resources/images/default-book.png'}"
                 class="d-block" alt="${book.title}" style="height: 300px;">
          </div>
          <div class="carousel-caption d-none d-md-block">
            <h5>${book.title}</h5>
            <p>${book.author}</p>
          </div>
        </div>
      </c:forEach>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#topBookCarousel" data-bs-slide="prev">
      <span class="carousel-control-prev-icon"></span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#topBookCarousel" data-bs-slide="next">
      <span class="carousel-control-next-icon"></span>
    </button>
  </div>
</section>

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
  <div class="row row-cols-2 row-cols-md-5 g-4">
    <c:forEach var="book" items="${latestBooks}">
      <div class="col">
        <div class="card h-100">
          <img src="${book.imageUrl != null ? book.imageUrl : '/resources/images/default-book.png'}"
               class="card-img-top" style="height: 220px; object-fit: contain;">
          <div class="card-body">
            <h6 class="card-title">${book.title}</h6>
            <p class="card-text small">${book.author}</p>
          </div>
        </div>
      </div>
    </c:forEach>
  </div>
</section>
