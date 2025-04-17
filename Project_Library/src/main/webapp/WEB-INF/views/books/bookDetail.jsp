<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container mt-4">
  <div class="row">
    <div class="col-md-4">
      <img src="<c:url value='/resources/images/${empty book.imageUrl ? "no-image.jpg" : book.imageUrl}' />" 
      	   style="height: 270px; object-fit: cover;" alt="${book.title}" class="img-fluid rounded border" />
    </div>
    <div class="col-md-8">
      <h3>${book.title}</h3>
      <p><strong>저자:</strong> ${book.author}</p>
      <p><strong>출판사:</strong> ${book.publisher}</p>
      <p><strong>출판일:</strong> ${book.pubDate}</p>
      <p><strong>카테고리:</strong> ${book.categoryName}</p>
      <p><strong>가격:</strong> <fmt:formatNumber value="${book.price}" type="currency" /></p>
      <p><strong>보유 수량:</strong> ${book.quantity}권</p>

	<c:if test="${myRental == null || myRental.isReturned == 'returned'}">
	  <button class="btn btn-success mt-3" id="rentBtn">📚 대여 요청</button>
	</c:if>
	<c:if test="${myRequest != null && myRequest.status == 'pending'}">
	  <button id="cancelBtn" class="btn btn-outline-danger mt-3">❌ 요청 취소</button>
	</c:if>
	
	<c:if test="${myRental != null && myRental.isReturned == 'rented'}">
	  <button class="btn btn-primary mt-3" id="returnBtn">📚 반납하기</button>
	  <button class="btn btn-secondary mt-3" id="extendBtn">⏳ 연장하기</button>
	</c:if>

	<c:if test="${loginUser.role == 'admin'}">
  	  <button class="btn btn-outline-danger">도서 삭제</button>
	</c:if>
	
    </div>
  </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
	const bookId = '${book.bookId}';
    const rentBtn = document.getElementById("rentBtn");
    const returnBtn = document.getElementById("returnBtn");

    if (rentBtn) {
        rentBtn.addEventListener("click", function () {
            fetch(`${ctx}/books/${bookId}/rent-ajax`, {
                method: "POST",
            })
            .then(res => res.json())
            .then(data => {
                alert(data.message);
                if (data.status === "success") {
                    location.reload();
                }
            });
        });
    }

    if (returnBtn) {
        returnBtn.addEventListener("click", function () {
            fetch(`${ctx}/books/${bookId}/return-ajax`, {
                method: "POST",
            })
            .then(res => res.json())
            .then(data => {
                alert(data.message);
                if (data.status === "success") {
                    location.reload();
                }
            });
        });
    }
    
    document.getElementById("cancelBtn")?.addEventListener("click", function () {
    	  fetch(`${ctx}/books/${bookId}/cancel-request`, { method: "POST" })
    	    .then(res => res.json())
    	    .then(data => {
    	      alert(data.message);
    	      if (data.status === "success") {
    	        location.reload();
    	      }
    	    });
    	});

});
</script>
