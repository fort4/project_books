<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- 대여 목록 -->
<div class="card">
    <div class="card-body">
        <h5 class="card-title">📚 내 대여 목록</h5>
        <table class="table">
            <thead>
                <tr>
                    <th>도서 제목</th>
                    <th>대여일</th>
                    <th>반납일</th>
                    <th>남은 대여 기간</th>
                    <th>상태</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="rental" items="${rentals}">
                    <tr>
                        <td>${rental.bookTitle}</td>
                        <td>${rental.rentalDate}</td>
                        <td>
                            <c:choose>
                                <c:when test="${empty rental.returnDate}">-</c:when>
                                <c:otherwise>${rental.returnDate}</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
							<input type="hidden"
							       class="rental-date"
							       data-book-id="${rental.bookId}"
							       data-return-date="${rental.returnDateIso}"
							       value="${rental.rentalDateIso}" />
						    <span class="remaining-time" data-book-id="${rental.bookId}">없음</span>
                        </td>
						<td>
						    <c:choose>
						        <c:when test="${rental.isReturned eq 'returned'}">
						            	✅ 반납완료
						        </c:when>
						        <c:otherwise>
						            	📖 대여중<br/>
						            <!-- 반납/연장 버튼 -->
						            <div class="mt-3">
						                <!-- 반납 버튼 -->
						                <form method="post" action="${ctx}/books/${rental.bookId}/return-ajax" style="display:inline;">
						                    <button type="button"
						                            data-book-id="${rental.bookId}"
						                            class="btn btn-sm btn-outline-primary me-2 return-btn">
						                       	 📚 도서 반납
						                    </button>
						                </form>
						                <!-- 연장 버튼 -->
						                <form method="post" action="${ctx}/books/${rental.bookId}/extend-ajax" style="display:inline;">
						                    <button type="button"
						                            data-book-id="${rental.bookId}"
						                            class="btn btn-sm btn-outline-secondary extend-btn">
						                        	⏳ 대여 연장
						                    </button>
						                </form>
						                <!-- 도서 ID 전달용 hidden input -->
						                <input type="hidden" id="bookId" value="${rental.bookId}" />
						            </div>
						        </c:otherwise>
						    </c:choose>
						</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
    
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
	  console.log("🔧 remaining-time 스크립트 (타임스탬프 방식) 시작");

	  // 남은 대여일(ms 차) → "X일 Y시간" 문자열
	  function formatRemaining(diffMs) {
	    if (diffMs <= 0) return "만료됨";
	    const days  = Math.floor(diffMs / (1000 * 60 * 60 * 24));
	    const hours = Math.floor((diffMs % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
	    return days + "일 " + hours + "시간";
	  }

	  document.querySelectorAll(".rental-date").forEach(function(input, idx) {
	    const bookId    = input.dataset.bookId;
	    const rentalIso = input.value;                          // ex: "2025-04-20T15:38:22"
	    const dueIso    = input.dataset.returnDate;             // ex: "2025-04-27T15:38:22" or ""
	    
	    // 1) ISO → ms (UTC 기준)
	    const rentalMs = Date.parse(rentalIso);
	    
	    // 2) dueMs 결정: 연장(dueIso) 있으면 그걸, 없으면 +7일
	    const dueMs = dueIso
	      ? Date.parse(dueIso)
	      : rentalMs + 7 * 24 * 60 * 60 * 1000;

	    // 3) 남은 ms 차 계산
	    const diffMs = dueMs - Date.now();

	    // 4) 화면에 반영
	    const selector = '.remaining-time[data-book-id="' + bookId + '"]';
	    const target   = document.querySelector(selector);
	    if (target) {
	      const text = formatRemaining(diffMs);
	      console.log(`📌 [${idx}] bookId=${bookId}`, "rentalMs=", rentalMs, 
	                  "dueMs=", dueMs, "diffMs=", diffMs, "→", text);
	      target.textContent = text;
	    }
	  });

    
    // 버튼 처리
    document.querySelectorAll(".return-btn").forEach(btn => {
        btn.addEventListener("click", function () {
            const bookId = btn.dataset.bookId;
            if (!confirm("도서를 반납하시겠습니까?")) return;
            btn.disabled = true;

            fetch(ctx + "/books/" + bookId + "/return-ajax", { method: "POST" })
                .then(res => res.json())
                .then(data => {
                    alert(data.message);
                    if (data.status === "success") location.reload();
                    else btn.disabled = false;
                })
                .catch(err => {
                    alert("요청 실패");
                    btn.disabled = false;
                });
        });
    });

    document.querySelectorAll(".extend-btn").forEach(btn => {
        btn.addEventListener("click", function () {
            const bookId = btn.dataset.bookId;
            if (!confirm("대여 기간을 연장하시겠습니까?")) return;
            btn.disabled = true;

            fetch(ctx + "/books/" + bookId + "/extend-ajax", { method: "POST" })
                .then(res => res.json())
                .then(data => {
                    alert(data.message);
                    if (data.status === "success") location.reload();
                    else btn.disabled = false;
                })
                .catch(err => {
                    alert("요청 실패");
                    btn.disabled = false;
                });
        });
    });
    //console.log("remaining-time 스크립트 종료");
});
</script>
    
    