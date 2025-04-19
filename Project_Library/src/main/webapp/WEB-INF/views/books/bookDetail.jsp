<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="isAdmin" value="${loginUser != null and loginUser.role == 'admin'}" />
<input type="hidden" id="bookId" value="${book.bookId}" />


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
      <div class="d-flex justify-content-between align-items-center">
        <h3>${book.title}</h3>
        <c:if test="${isAdmin}">
          <div>
            <div class="d-flex flex-row gap-2">
              <a href="${pageContext.request.contextPath}/admin/books/edit/${book.bookId}"
			   class="btn btn-outline-secondary btn-sm d-inline-flex align-items-center justify-content-center px-3"
			   style="height:38px;">✏️ 수정</a>
              <form action="${ctx}/admin/books/delete/${book.bookId}" method="post" class="d-inline"
                    onsubmit="return confirm('정말 삭제하시겠습니까?');">
                <button type="submit" class="btn btn-outline-danger btn-sm">🗑 삭제</button>
              </form>
            </div>
          </div>
        </c:if>
      </div>
      <p><strong>저자:</strong> ${book.author}</p>
      <p><strong>출판사:</strong> ${book.publisher}</p>
      <p><strong>출판일:</strong> ${book.pubDate}</p>
      <p><strong>카테고리:</strong> ${book.categoryName}</p>
      <p><strong>가격:</strong> <fmt:formatNumber value="${book.price}" type="currency" /></p>
      <p><strong>보유 수량:</strong> ${book.quantity}권</p>

	
	<!-- (2) 일반 사용자용 기능 -->
	<c:if test="${not isAdmin}">
	    <c:if test="${empty book.myRental and empty book.myRequest}">
	        <button class="btn btn-success mt-3" id="rentBtn">📚 대여 요청</button>
	    </c:if>
	    <c:if test="${not empty book.myRequest and book.myRequest.status eq 'pending'}">
	        <button id="cancelBtn" class="btn btn-outline-danger mt-3">❌ 요청 취소</button>
	    </c:if>
	    <c:if test="${not empty book.myRental and book.myRental.isReturned eq 'rented'}">
	        <button class="btn btn-primary mt-3" id="returnBtn">📚 도서 반납</button>
	        <button class="btn btn-secondary mt-3" id="extendBtn">⏳ 대여 연장</button>
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
	    <button type="submit" class="btn btn-primary">🖼 업로드</button>
	  </form>
	
	  <form action="${ctx}/admin/books/${book.bookId}/delete-image" method="post" class="mt-2">
	    <button type="submit" class="btn btn-danger">🗑 삭제</button>
	  </form>
	</c:if><!-- 관리자 전용 기능 if -->
	  	  
  </div>
    
  </div>
    <div class="mt-3 text-center">
		<button type="button" class="btn btn-outline-secondary btn-sm"
		        onclick="location.href='${pageContext.request.contextPath}/index'">
		    ← 메인으로
		</button>
   	</div>
   	
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const bookIdEl = document.getElementById("bookId");
    if (!bookIdEl) return;

    const bookId = bookIdEl.value;

    const actions = [
        { id: "rentBtn",    url: `${ctx}/books/${bookId}/rent-ajax`,     confirmMsg: "도서 대여를 신청하시겠습니까?" },
        { id: "cancelBtn",  url: `${ctx}/books/${bookId}/cancel-request`, confirmMsg: "대여 요청을 취소하시겠습니까?" },
        { id: "returnBtn",  url: `${ctx}/books/${bookId}/return-ajax`,    confirmMsg: "도서를 반납하시겠습니까?" },
        { id: "extendBtn",  url: `${ctx}/books/${bookId}/extend-ajax`,    confirmMsg: "대여 기간을 연장하시겠습니까?" }
    ];

    actions.forEach(({ id, url, confirmMsg }) => {
        const btn = document.getElementById(id);
        if (btn) {
            btn.addEventListener("click", function () {
                if (confirmMsg && !confirm(confirmMsg)) return;

                btn.disabled = true;  // 중복 클릭 방지

                fetch(url, { method: "POST" })
                    .then(res => res.json())
                    .then(data => {
                        alert(data.message);
                        if (data.status === 'success') {
                            location.reload();
                        } else {
                            btn.disabled = false;
                        }
                    })
                    .catch(err => {
                        alert("요청 중 오류가 발생했습니다.");
                        console.error(err);
                        btn.disabled = false;
                    });
            });
        }
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
