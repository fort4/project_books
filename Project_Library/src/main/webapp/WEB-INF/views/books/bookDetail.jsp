<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="isAdmin" value="${loginUser != null and loginUser.role == 'admin'}" />

<!-- displayImage & imgSrc 설정(이 부분은 공통) -->
<c:choose>
  <c:when test="${empty book.imageUrl}">
    <c:set var="displayImage" value="no-image.jpg" />
  </c:when>
  <c:otherwise>
    <c:set var="displayImage" value="${book.imageUrl}" />
  </c:otherwise>
</c:choose>
<c:url var="imgSrc" value="/resources/images/books/${displayImage}" />

<div class="container mt-4">
  <div class="row">
    <!-- (1) 공통: 모든 사용자에게 보여줄 이미지 -->
    <div class="col-md-4">
      <img id="bookImage"
           src="${imgSrc}"
           style="height:270px;object-fit:cover;"
           alt="${book.title}"
           class="img-fluid rounded border mb-3" />
    </div>
    
    <div class="col-md-8">
      <h3>${book.title}</h3>
      <p><strong>저자:</strong> ${book.author}</p>
      <p><strong>출판사:</strong> ${book.publisher}</p>
      <p><strong>출판일:</strong> ${book.pubDate}</p>
      <p><strong>카테고리:</strong> ${book.categoryName}</p>
      <p><strong>가격:</strong> <fmt:formatNumber value="${book.price}" type="currency" /></p>
      <p><strong>보유 수량:</strong> ${book.quantity}권</p>
	
	<c:if test="${not isAdmin}">
	<!-- (2) 일반 사용자용 기능 -->
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
	</c:if>
	
	<!-- (3) 관리자 전용 기능들 -->
	<c:if test="${isAdmin}">
	  <form action="${ctx}/admin/books/${book.bookId}/upload-image" 
	  		method="post" 
	  		enctype="multipart/form-data" 
	  		class="mt-4">
          <input type="file"
                 name="imageFile"
                 accept="image/*"
                 class="form-control mb-2"
                 required
                 onchange="previewBookImage(event)" />
	    <button type="submit" class="btn btn-primary">🖼 이미지 업로드</button>
	  </form>
	
	  <form action="${ctx}/admin/books/${book.bookId}/delete-image" method="post" class="mt-2">
	    <button type="submit" class="btn btn-danger">🗑 이미지 삭제</button>
	  </form>
	  
	  <button type="button" class="btn btn-outline-danger" onclick="confirmDelete()">도서 삭제</button>
	</c:if>
	  	  
    </div>
  </div>
    <div class="mt-3 text-center">
		<button type="button" class="btn btn-outline-secondary btn-sm"
		        onclick="location.href='${pageContext.request.contextPath}/index'">
		    ← 메인으로 돌아가기
		</button>
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

// 파일 선택 즉시 preview
function previewBookImage(event) {
  const file = event.target.files[0];
  if (!file) return;
  // URL.createObjectURL로 브라우저 메모리 상에 임시 URL 생성
  const url = URL.createObjectURL(file);
  // img#bookImage의 src를 바꿔서 즉시 미리보기
  const img = document.getElementById("bookImage");
  img.src = url;
  // 메모리 해제를 위해 load 후 revoke 해주기
  img.onload = () => URL.revokeObjectURL(url);
}
</script>
