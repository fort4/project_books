<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 도서 슬라이더 -->
<%-- <c:if test="${not empty topBooks}">
  <div id="topBooksCarousel" class="carousel slide mb-4" data-bs-ride="carousel">
  	<div class="text-center mt-3 mb-4">
		<h4>📊 가장 많이 대여된 책 Top 5</h4>
	</div>
    <div class="carousel-inner">
      <c:forEach var="book" items="${topBooks}" varStatus="status">
        <div class="carousel-item ${status.first ? 'active' : ''}">
          <div class="d-flex justify-content-center align-items-center flex-column">
			<img src="${empty book.imageUrl 
			            ? pageContext.request.contextPath.concat('/resources/images/no-image.jpg') 
			            : pageContext.request.contextPath.concat(book.imageUrl)}"
			     class="d-block"
			     alt="${book.title}"
			     style="max-height: 300px;">
            <h5 class="mt-3">${book.title}</h5>
            <p class="text-muted">${book.author}</p>
          </div>
        </div>
      </c:forEach>

    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#topBooksCarousel" data-bs-slide="prev">
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="visually-hidden">이전</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#topBooksCarousel" data-bs-slide="next">
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="visually-hidden">다음</span>
    </button>
	</div>
  
</c:if> --%>
<!-- 도서 슬라이더 -->

<div class="container mt-5">
  <h2 class="mb-4 text-center">📚 도서 목록</h2>

<!-- 기능 폼 -->
<form id="bookSearchForm" method="get" class="mb-4">
  <div class="d-flex justify-content-center gap-3 flex-wrap">

	<!-- 검색창 -->
	<input type="text" name="keyword" class="form-control w-50" placeholder="제목 또는 저자 검색" value="${keyword}" />
	
	<!-- 카테고리 -->
	<select name="categoryId" id="categoryId" class="form-select w-auto">
			<option value="">전체</option>
		<c:forEach var="c" items="${categories}">
			<option value="${c.categoryId}" <c:if test="${categoryId == c.categoryId}">selected</c:if>>
			${c.name}
			</option>
		</c:forEach>
	</select>
	
	<!-- 정렬 -->
	<select name="sort" id="sort" class="form-select w-auto">
		<option value="date" <c:if test="${sort == 'date'}">selected</c:if>>최신순</option>
		<option value="title" <c:if test="${sort == 'title'}">selected</c:if>>제목순</option>
		<option value="author" <c:if test="${sort == 'author'}">selected</c:if>>저자순</option>
	</select>
	
	<!-- 정렬 방향 -->
	<select name="order" id="order" class="form-select w-auto">
		<option value="desc" <c:if test="${order == 'desc'}">selected</c:if>>내림차순</option>
		<option value="asc" <c:if test="${order == 'asc'}">selected</c:if>>오름차순</option>
	</select>
	
	<!-- 페이지당 도서 수 -->
	<select name="size" id="size" class="form-select w-auto">
		<option value="5" <c:if test="${size == 5}">selected</c:if>>5권</option>
		<option value="10" <c:if test="${size == 10}">selected</c:if>>10권</option>
		<option value="25" <c:if test="${size == 25}">selected</c:if>>25권</option>
	</select>
	
	<button type="submit" class="btn btn-outline-primary">🔍 검색</button>
  </div>
</form>
<!-- 기능폼 -->
    
   <div id="bookList">
	   <!-- 최초 로드시 랜더링용  -->
	   <jsp:include page="bookListFragment.jsp" />
   </div> <!-- bookList -->
    
</div> <!-- 도서 목록 전체 div -->


<script>
document.addEventListener("DOMContentLoaded", function () {
  
  const tbody = document.getElementById("bookList");
  const form = document.getElementById("bookSearchForm");
  
  // get요청(submit) 막아놓음
  form.addEventListener("submit", function (e) {
    e.preventDefault();
    fetchBookList();
  });
  
  // 해당요소 없으면 실행 중단
  if (!form || !tbody) return;

  ['categoryId', 'sort', 'order', 'size'].forEach(id => {
    const el = document.getElementById(id);
    if (el) {
      el.addEventListener("change", fetchBookList);
    }
  });

  function fetchBookList() {
	  const formData = new FormData(form);
	  const params = new URLSearchParams(formData);
	  const url = ctx + '/books/ajax?' + params.toString();

	  fetch(url)
	    .then(res => res.text())
	    .then(html => {
	      document.getElementById("bookList").innerHTML = html;
	    })
	    .catch(err => console.error("AJAX 오류", err));
  }

  window.goPage = function (page) {
    const input = document.createElement("input");
    input.type = "hidden";
    input.name = "page";
    input.value = page;
    form.appendChild(input);
    fetchBookList();
    form.removeChild(input);
  }
  
});
</script>

