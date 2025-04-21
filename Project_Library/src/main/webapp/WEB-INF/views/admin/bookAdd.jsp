<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container mt-4">
  <h3 class="mb-4">📘 새 도서 등록</h3>

  <form action="${ctx}/admin/books/add" method="post" enctype="multipart/form-data"
        class="border p-4 rounded bg-light">

    <!-- 제목 -->
    <div class="mb-3">
      <label class="form-label">제목</label>
      <input type="text" name="title" class="form-control" required>
    </div>

    <!-- 저자 -->
    <div class="mb-3">
      <label class="form-label">저자</label>
      <input type="text" name="author" class="form-control" required>
    </div>

    <!-- 출판사 -->
    <div class="mb-3">
      <label class="form-label">출판사</label>
      <input type="text" name="publisher" class="form-control" required>
    </div>

    <!-- 출판일 -->
    <div class="mb-3">
      <label class="form-label">출판일</label>
      <input type="date" name="pubDate" class="form-control" required>
    </div>

    <!-- 가격 -->
    <div class="mb-3">
      <label class="form-label">가격</label>
      <input type="number" name="price" class="form-control" min="0" required>
    </div>

    <!-- 수량 -->
    <div class="mb-3">
      <label class="form-label">수량</label>
      <input type="number" name="quantity" class="form-control" min="1" required>
    </div>

    <!-- 카테고리 -->
    <div class="mb-3">
      <label class="form-label">카테고리</label>
      <select name="categoryId" class="form-select" required>
        <option value="">카테고리 선택</option>
        <c:forEach var="cat" items="${categories}">
          <option value="${cat.categoryId}">${cat.name}</option>
        </c:forEach>
      </select>
    </div>

    <!-- 이미지 -->
	<div class="mb-3">
	  <label class="form-label">도서 이미지</label>
	  <div class="mb-2">
	    <img id="bookImage" src="${ctx}/resources/images/books/no-image.jpg"
	         class="img-thumbnail" style="max-height: 200px;">
	  </div>
	  
	  	<!-- 새 이미지 업로드 -->
	<div class="mt-3 d-flex align-items-center mb-2" style="max-width: 280px;">
	  <input type="file"
	         name="uploadFile"
	         accept="image/*"
	         class="form-control-file"
	         onchange="previewBookImage(event)">
	</div>
	<button type="button" class="btn btn-danger mb-2"
	        onclick="deleteBookImage(${book.bookId})">
	  🗑 이미지 삭제
	</button><br>
	</div>
    <div class="text-end">
      <button type="submit" class="btn btn-primary">등록</button>
      <a href="${ctx}/admin/books" class="btn btn-secondary">취소</a>
    </div>
	    
  </form>
</div>

<script>
//파일 선택 즉시 미리보기
function previewBookImage(event) {
    const file = event.target.files[0];
    if (!file) return;
    // URL.createObjectURL로 브라우저 메모리 상에 임시 URL 생성
    const url = URL.createObjectURL(file);
    // img#bookImage의 src를 바꿔서 즉시 미리보기
    const img = document.getElementById("bookImage");
    // 메모리 해제 위해 load 후 revoke 해주기
    img.src = url;
    img.onload = () => URL.revokeObjectURL(url);
}

function deleteBookImage(bookId) {
  if (!confirm("정말 이미지를 삭제하시겠습니까?")) return;

  fetch(`${ctx}/admin/books/${bookId}/delete-image`, {
    method: "POST",
    headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    },
    body: ""
  })
  .then(res => {
    if (res.ok) {
      alert("이미지가 삭제되었습니다.");
      location.reload(); // 또는 썸네일만 교체
    } else {
      alert("삭제에 실패했습니다.");
    }
  });
}
</script>

