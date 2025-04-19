/**
 * 알림 전송
 */
function toggleTargetId(value) {
  const box = document.getElementById("targetIdBox");
  const input = box.querySelector("input");

  if (value === "all") {
    box.style.display = "none";
    input.disabled = true;  // 브라우저 유효성 검사에서 제외됨
    input.value = "";       // 혹시 값이 남아있을 수 있으니 초기화
  } else {
    box.style.display = "block";
    input.disabled = false; // 다시 활성화
  }
}

document.getElementById("notificationForm").addEventListener("submit", function (e) {
	  e.preventDefault();

	  const formData = new FormData(this);
	  const params = new URLSearchParams(formData);

	  fetch(`${ctx}/admin/notification/send`, {
	    method: "POST",
	    headers: { "Content-Type": "application/x-www-form-urlencoded" },
	    body: params.toString()
	  })
	    .then(res => res.json())
	    .then(data => {
	      alert(data.message);
	      if (data.status === "success") location.reload();
	    });
	});