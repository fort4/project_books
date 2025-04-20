/**
 * 상세 도서
 */
document.addEventListener("DOMContentLoaded", function () {
    const bookIdEl = document.getElementById("bookId");
    if (!bookIdEl) return;

    const bookId = bookIdEl.value;

    const actions = [
        { id: "rentBtn",    url: ctx + `/books/${bookId}/rent-ajax`,     confirmMsg: "도서 대여를 신청하시겠습니까?" },
        { id: "cancelBtn",  url: ctx + `/books/${bookId}/cancel-request`, confirmMsg: "대여 요청을 취소하시겠습니까?" },
        { id: "returnBtn",  url: ctx + `/books/${bookId}/return-ajax`,    confirmMsg: "도서를 반납하시겠습니까?" },
        { id: "extendBtn",  url: ctx + `/books/${bookId}/extend-ajax`,    confirmMsg: "대여 기간을 연장하시겠습니까?" }
    ];

    actions.forEach(({ id, url, confirmMsg }) => {
        const btn = document.getElementById(id);
        if (btn) {
            btn.addEventListener("click", function () {
                if (confirmMsg && !confirm(confirmMsg)) return;
                btn.disabled = true;

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
    }); // action.forEach

    // 찜 상태 확인
    const wishBtn = document.getElementById("wishBtn");
    if (wishBtn) {
        fetch(ctx + `/api/wishlist/check?bookId=${bookId}`)
            .then(res => res.text())
            .then(flag => {
                if (flag === "true") {
                    wishBtn.classList.remove("btn-outline-danger");
                    wishBtn.classList.add("btn-danger");
                    wishBtn.innerText = "💔 찜 취소";
                }
            });
        // 찜 등록/해제 요청
        wishBtn.addEventListener("click", function () {
            const isCancel = wishBtn.innerText.includes("취소");

            fetch(ctx + `/api/wishlist/${isCancel ? "remove" : "add"}`, {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: "bookId=" + bookId
            })
                .then(res => res.json())
                .then(data => {
                    alert(data.message);
                    if (data.status === "success") {
                        if (isCancel) {
                            wishBtn.classList.remove("btn-danger");
                            wishBtn.classList.add("btn-outline-danger");
                            wishBtn.innerText = "❤️ 찜하기";
                        } else {
                            wishBtn.classList.remove("btn-outline-danger");
                            wishBtn.classList.add("btn-danger");
                            wishBtn.innerText = "💔 찜 취소";
                        }
                    }
                });
        });
    }
});

// 파일 선택 즉시 미리보기
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