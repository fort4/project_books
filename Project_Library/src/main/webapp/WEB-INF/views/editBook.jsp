<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/WEB-INF/views/include/header.jsp" />

<div class="container mt-5">
    <h2 class="mb-4 text-center">✏️ 도서 수정</h2>

    <form action="${pageContext.request.contextPath}/books/edit" method="post" enctype="multipart/form-data" class="p-4 border rounded bg-light">

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

        <!-- 출판일 -->
        <div class="mb-3">
            <label class="form-label">출판일</label>
            <input type="date" name="pubDate" class="form-control" value="${book.pubDate}" required />
        </div>

        <!-- 카테고리 -->
        <div class="mb-3">
            <label class="form-label">카테고리</label>
            <select name="categoryId" class="form-select">
                <option value="">-- 선택 --</option>
                <c:forEach var="c" items="${categories}">
                    <option value="${c.categoryId}" <c:if test="${book.categoryId == c.categoryId}">selected</c:if>>
                        ${c.name}
                    </option>
                </c:forEach>
            </select>
        </div>

        <!-- 이미지 업로드 -->
        <div class="mb-3">
            <label class="form-label">도서 이미지 업로드</label>
            <input type="file" id="uploadFile" class="form-control" />
        </div>

        <input type="hidden" name="imageUrl" id="imageUrl" value="${book.imageUrl}" />

        <!-- 이미지 미리보기 -->
        <div class="mb-3">
            <label class="form-label">현재 이미지</label><br/>
            <img id="previewImage"
                 src="${pageContext.request.contextPath}${book.imageUrl}"
                 width="100"
                 class="border p-1 rounded"
                 alt="미리보기" />
        </div>

        <!-- 등록 버튼 -->
        <div class="text-center">
            <button type="submit" class="btn btn-success">수정하기</button>
        </div>
    </form>

    <div class="mt-3 text-center">
        <a href="${pageContext.request.contextPath}/books" class="btn btn-secondary">← 목록으로 돌아가기</a>
    </div>
</div>

<script>
	<!-- 이미지 업로드 스크립트 -->
    document.getElementById("uploadFile").addEventListener("change", function () {
        const file = this.files[0];
        if (!file) return;

        const formData = new FormData();
        formData.append("uploadFile", file);

        fetch(ctx + "/upload/image", {
            method: "POST",
            body: formData
        })
        .then(res => res.text())
        .then(path => {
            document.getElementById("imageUrl").value = path;
            document.getElementById("previewImage").src = ctx + path;
            alert("이미지 업로드 완료!");
        })
        .catch(err => {
            console.error("업로드 실패", err);
            alert("이미지 업로드 실패");
        });
    });
</script>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
