<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>도서 상세 정보</title></head>
<body>
    <h2>📖 도서 상세 정보</h2>
    
    <!-- 도서 이미지 출력  -->
	<c:choose>
		<c:when test="${not empty book.imageUrl}">
			<img src="<c:url value='${book.imageUrl}' />" width="120" height="160" alt="표지" />
		</c:when>
		<c:otherwise>
			<img src="<c:url value='/resources/images/no-image.jpg' />" width="120" height="160" alt="기본 이미지" />
		</c:otherwise>
	</c:choose>
	
	<!-- 도서 정보 -->
    <ul>
        <li><strong>제목:</strong> ${book.title}</li>
        <li><strong>저자:</strong> ${book.author}</li>
        <li><strong>출판사:</strong> ${book.publisher}</li>
        <li><strong>출판일:</strong> ${book.pubDate}</li>
	</ul>
	<!-- 대여 상태 표시 -->
	<p><strong>대여 상태:</strong> 
	  <c:choose>
	    <c:when test="${book.rented}">대여중</c:when>
	    <c:otherwise>대여가능</c:otherwise>
	  </c:choose>
	</p>
	
	<!-- 대여 / 반납 / 연장 버튼 -->
	<div id="rentalButtons">
	  <c:choose>
	    <c:when test="${book.rented}">
	      <c:if test="${rental != null && rental.extendCount == 0}">
	        <!-- 연장 -->
	        <form method="post" action="${ctx}/books/${book.bookId}/extend">
	          <button type="submit" class="btn btn-outline-warning">📅 연장하기</button>
	        </form>
	      </c:if>
	
	      <!-- 반납 (AJAX) -->
	      <button id="returnBtn" class="btn btn-outline-danger">📤 반납하기</button>
	
	    </c:when>
	
	    <c:otherwise>
	      <!-- 대여 (AJAX) -->
	      <button id="rentBtn" class="btn btn-outline-primary">📚 대여하기</button>
	    </c:otherwise>
	  </c:choose>
	</div>


    <!-- 메시지 표시 -->
    <c:if test="${not empty successMsg}">
        <p style="color: green;">${successMsg}</p>
    </c:if>
    <c:if test="${not empty errorMsg}">
        <p style="color: red;">${errorMsg}</p>
    </c:if>

    <!-- 뒤로가기 -->
    <p><a href="<c:url value='/books' />">← 도서 목록으로 돌아가기</a></p>
    
<script>
document.addEventListener("DOMContentLoaded", function () {
    const bookId = ${book.bookId};
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
});
</script>
    
    
</body>
</html>
