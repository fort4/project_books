/**
 * 
 */
document.addEventListener("DOMContentLoaded", function () {
    const bookIdEl = document.getElementById("bookId");
    if (!bookIdEl) return;

    const bookId = bookIdEl.value;

    const actions = [
        { id: "returnBtn", url: `${ctx}/books/${bookId}/return-ajax`, confirmMsg: "도서를 반납하시겠습니까?" },
        { id: "extendBtn", url: `${ctx}/books/${bookId}/extend-ajax`, confirmMsg: "대여 기간을 연장하시겠습니까?" }
    ];

    actions.forEach(({ id, url, confirmMsg }) => {
        const btn = document.getElementById(id);
        if (!btn) return;

        btn.addEventListener("click", function () {
            if (!confirm(confirmMsg)) return;

            btn.disabled = true;

            fetch(url, { method: "POST" })
                .then(res => res.json())
                .then(data => {
                    alert(data.message);
                    if (data.status === "success") {
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
    });
});
