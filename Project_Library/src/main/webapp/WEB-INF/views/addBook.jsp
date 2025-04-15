<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<title>도서 등록</title>
</head>
<body>
    <h2>📘 새 도서 등록</h2>

    <form action="<c:url value='/books/add' />" method="post" enctype="multipart/form-data">
        <label>제목: <input type="text" name="title" required></label><br/>
        <label>저자: <input type="text" name="author" required></label><br/>
        <label>출판사: <input type="text" name="publisher" required></label><br/>
        <label>출판일: <input type="date" name="pubDate" required></label><br/>
        <label>도서 이미지 업로드:
            <input type="file" id="uploadFile" />
        </label><br/>

        <input type="hidden" name="imageUrl" id="imageUrl" />

        <!-- 미리보기 -->
        <p>이미지 미리보기:
			<img id="previewImage"
			     src="${pageContext.request.contextPath}/resources/images/no-image.jpg"
			     width="100"
			     alt="미리보기" />
        </p>
        
        <button type="submit">등록하기</button>
    </form>

    <p><a href="<c:url value='/books' />">← 목록으로 돌아가기</a></p>
    
	<!-- 업로드 처리 스크립트 -->
    <script>
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
