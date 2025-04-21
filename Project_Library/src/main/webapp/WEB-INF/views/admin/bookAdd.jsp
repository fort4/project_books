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
	    <img id="preview" src="${ctx}/resources/images/books/no-image.jpg"
	         class="img-thumbnail" style="max-height: 200px;">
	  </div>
	  <input type="file" name="uploadFile" class="form-control" onchange="previewImage(event)">
	</div>
    <div class="text-end">
      <button type="submit" class="btn btn-primary">등록</button>
      <a href="${ctx}/admin/books" class="btn btn-secondary">취소</a>
    </div>
	    
  </form>
</div>

<script>
function previewImage(event) {
  const input = event.target;
  const preview = document.getElementById('preview');

  if (input.files && input.files[0]) {
    const reader = new FileReader();
    reader.onload = function (e) {
      preview.src = e.target.result;
    };
    reader.readAsDataURL(input.files[0]);
  } else {
    preview.src = '${ctx}/resources/images/books/no-image.jpg';
  }
}
</script>

