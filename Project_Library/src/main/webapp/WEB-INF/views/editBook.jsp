<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>도서 수정</title>
</head>
<body>
    <h2>✏️ 도서 수정</h2>

    <form action="<c:url value='/books/edit' />" method="post" enctype="multipart/form-data">
        <input type="hidden" name="bookId" value="${book.bookId}" />

        <label>제목: <input type="text" name="title" value="${book.title}" required /></label><br/>
        <label>저자: <input type="text" name="author" value="${book.author}" required /></label><br/>
        <label>출판사: <input type="text" name="publisher" value="${book.publisher}" required /></label><br/>
        <label>출판일: <input type="date" name="pubDate" value="${book.pubDate}" required /></label><br/>
        <label>도서 이미지 업로드:
            <input type="file" id="uploadFile" />
        </label><br/>

        <input type="hidden" name="imageUrl" id="imageUrl" value="${book.imageUrl}" />

		<p>현재 이미지:
		    <img id="previewImage" 
		   		 src="${pageContext.request.contextPath}${book.imageUrl}" 
		   		 width="100"
		         alt="미리보기" />
		</p>

        <button type="submit">수정하기</button>
    </form>

    <p><a href="<c:url value='/books' />">← 목록으로 돌아가기</a></p>

    <!-- 이미지 업로드 스크립트 -->
    <script>
		// contextPath 변수로 뺌
		const ctx = '${pageContext.request.contextPath}';
		
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
    
</body>

</html>
