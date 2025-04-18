<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container mt-5">
    <h2 class="mb-4 text-center">📕 도서 수정</h2>

    <form action="${pageContext.request.contextPath}/admin/books/edit" method="post" enctype="multipart/form-data" class="p-4 border rounded bg-light">
        
        <input type="hidden" name="bookId" value="${book.bookId}" />
        
        <!-- 제목 -->
        <div class="mb-3">
            <label class="form-label">제목</label>
            <input type="text" name="title" class="form-control" value="${book.title}" required />
        </div>

        <!-- 저자 -->
        <div class="mb-3">
            <label class="form-label">저자</label>
            <input type="text" name="author" class="form-control" value="${book.author}" required />
        </div>

        <!-- 출판사 -->
        <div class="mb-3">
            <label class="form-label">출판사</label>
            <input type="text" name="publisher" class="form-control" value="${book.publisher}" required />
        </div>

        <!-- 출간일 -->
        <div class="mb-3">
            <label class="form-label">출간일</label>
            <input type="date" name="pubDate" class="form-control" value="${book.pubDate}" required />
        </div>

        <!-- 가격 -->
        <div class="mb-3">
            <label class="form-label">가격</label>
            <input type="number" name="price" class="form-control" value="${book.price}" required />
        </div>

        <!-- 수량 -->
        <div class="mb-3">
            <label class="form-label">수량</label>
            <input type="number" name="quantity" class="form-control" value="${book.quantity}" required />
        </div>

        <!-- 카테고리 -->
        <div class="mb-3">
            <label class="form-label">카테고리</label>
            <select name="categoryId" class="form-select" required>
                <c:forEach var="cat" items="${categories}">
                    <option value="${cat.categoryId}" ${cat.categoryId == book.categoryId ? 'selected' : ''}>${cat.name}</option>
                </c:forEach>
            </select>
        </div>

		<!-- 기존 이미지 -->
		<div class="mb-3">
		    <label class="form-label">기존 이미지</label><br>
		    <img id="preview"
		         src="<c:url value='/resources/images/books/${empty book.imageUrl ? "no-image.jpg" : book.imageUrl}'/>"
		         alt="미리보기"
		         style="height:150px; border: 1px solid #ccc; padding: 5px;" />
		</div>

		<!-- 새 이미지 업로드 -->
		<div class="mb-3">
		    <label class="form-label">새 이미지 업로드 (선택)</label>
		    <input type="file"
		           name="uploadFile"
		           class="form-control"
		           accept="image/*"
		           onchange="previewImage(event)" />
		</div>

        <button type="submit" class="btn btn-primary">수정 완료</button>
        <a href="${pageContext.request.contextPath}/books/${book.bookId}" class="btn btn-secondary">취소</a>

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
