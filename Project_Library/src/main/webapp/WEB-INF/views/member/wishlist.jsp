<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container mt-5">
    <h3 class="mb-4">❤️ 찜한 도서 목록</h3>

    <c:if test="${empty wishlist}">
        <div class="alert alert-info">찜한 도서가 없습니다.</div>
    </c:if>

    <div class="row row-cols-2 row-cols-md-4 g-4">
        <c:forEach var="book" items="${wishlist}">
            <div class="col">
                <div class="card h-100">
                    <img src="<c:url value='/resources/images/books/${empty book.imageUrl ? "no-image.jpg" : book.imageUrl}'/>"
                         class="card-img-top" style="height: 200px; object-fit: cover;">
                    <div class="card-body text-center">
                        <h6 class="card-title mb-2">${book.title}</h6>
                        <a href="${ctx}/books/${book.bookId}" class="btn btn-outline-primary btn-sm mb-2">📘 상세보기</a>
                        <button class="btn btn-outline-danger btn-sm cancel-wish-btn" data-book-id="${book.bookId}">💔 찜 취소</button>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<%-- <script src="${ctx}/resources/js/wishlist.js"></script> --%>
<script>
document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(".cancel-wish-btn").forEach(btn => {
        btn.addEventListener("click", function () {
            const bookId = btn.dataset.bookId;
            if (!confirm("정말 찜을 취소하시겠습니까?")) return;

            fetch(ctx + "/api/wishlist/remove", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: "bookId=" + bookId
            })
            .then(res => res.json())
            .then(data => {
                alert(data.message);
                if (data.status === "success") location.reload();
            })
            .catch(err => {
                alert("요청 실패");
            });
        });
    });
});
</script>
