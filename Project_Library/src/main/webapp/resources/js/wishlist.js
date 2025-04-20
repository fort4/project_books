/**
 * 위시리스트
 */
document.addEventListener("DOMContentLoaded", function () {
    const ctx = '${pageContext.request.contextPath}';
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
                if (data.status === "success") {
                    location.reload();
                }
            });
        });
    });
});