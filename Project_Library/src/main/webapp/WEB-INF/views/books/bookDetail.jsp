<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="isAdmin" value="${loginUser != null and loginUser.role == 'admin'}" />

<input type="hidden" id="bookId" value="${book.bookId}" />


<!-- displayImage & imgSrc 설정(이 부분은 공통) -->
<c:choose>
  <c:when test="${empty book.imageUrl}">
    <c:set var="displayImage" value="no-image.jpg" />
  </c:when>
  <c:otherwise>
    <c:set var="displayImage" value="${book.imageUrl}" />
  </c:otherwise>
</c:choose>
<c:url var="imgSrc" value="/resources/images/books/${displayImage}" />

<div class="container mt-5 mb-5">

  <div class="card shadow-sm border-0">
    <div class="card-body">

      <div class="row align-items-start">

        <!-- 왼쪽: 도서 이미지 -->
        <div class="col-md-4 text-center mb-4 mb-md-0">
          <img src="${ctx}/resources/images/books/${empty book.imageUrl ? 'no-image.jpg' : book.imageUrl}"
               alt="${book.title}"
               class="img-fluid rounded shadow-sm"
               style="max-height: 340px; object-fit: cover;" />
        </div>

        <!-- 오른쪽: 도서 상세 정보 -->
        <div class="col-md-8">

          <h4 class="fw-bold text-primary mb-3">${book.title}</h4>

          <ul class="list-group list-group-flush small mb-3">
            <li class="list-group-item"><strong>저자:</strong> ${book.author}</li>
            <li class="list-group-item"><strong>출판일:</strong> ${book.pubDate}</li>
            <li class="list-group-item"><strong>카테고리:</strong> ${book.categoryName}</li>
            <li class="list-group-item"><strong>가격:</strong> ${book.price}원</li>
            <li class="list-group-item"><strong>보유 수량:</strong> ${book.quantity}권</li>
            <li class="list-group-item"><strong>대여 상태:</strong>
              <c:choose>
                <c:when test="${book.rented}">🔒 대여중</c:when>
                <c:otherwise>✅ 대여 가능</c:otherwise>
              </c:choose>
            </li>
          </ul>

          <!-- 버튼 영역 (권한 구분 없이 모두 허용) -->
          <div class="mt-4 d-flex flex-wrap gap-2">

            <!-- 대여 버튼 -->
            <c:if test="${not empty loginUser}">
            <c:choose>
              <c:when test="${book.rented}">
                <button class="btn btn-secondary btn-sm" disabled>대여 불가</button>
              </c:when>
              <c:otherwise>
                <form action="${ctx}/rental/request" method="post" class="d-inline">
                  <input type="hidden" name="bookId" value="${book.bookId}" />
                  <button type="submit" class="btn btn-primary btn-sm">📚 대여 요청</button>
                </form>
              </c:otherwise>
            </c:choose>

            <!-- 찜 버튼 -->
	    	<button id="wishBtn"
		            class="btn btn-outline-danger"
		            data-book-id="${book.bookId}">
		        	❤️ 찜하기
		    </button>
		    </c:if>

            <!-- 관리자 기능 -->
            <c:if test="${loginUser != null && loginUser.role eq 'admin'}">
              <a href="${ctx}/admin/books/edit/${book.bookId}" class="btn btn-warning btn-sm">✏ 도서 수정</a>
              <form action="${ctx}/admin/books/delete/${book.bookId}" method="post" class="d-inline"
                    onsubmit="return confirm('정말 삭제하시겠습니까?');">
                <button type="submit" class="btn btn-danger btn-sm">🗑 삭제</button>
              </form>
            </c:if>
            
            <div class="mt-3 text-center">
				<button type="button" class="btn btn-outline-secondary btn-sm"
				        onclick="location.href='${ctx}/index'">
				    ← 메인으로
				</button>
		   	</div>

          </div>
        </div>

      </div>

    </div>
  </div>

</div>


<script>
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

 // 찜 버튼 상태 설정 + 이벤트 등록
    const wishBtn = document.getElementById("wishBtn");

    if (wishBtn) {
      // ① 초기 찜 상태 확인
      fetch(ctx + `/api/wishlist/check?bookId=${bookId}`)
        .then(res => res.text())
        .then(flag => {
          if (flag.trim() === "true") {
            wishBtn.classList.remove("btn-outline-danger");
            wishBtn.classList.add("btn-danger");
            wishBtn.innerText = "💔 찜 취소";
          } else {
            wishBtn.classList.remove("btn-danger");
            wishBtn.classList.add("btn-outline-danger");
            wishBtn.innerText = "❤️ 찜하기";
          }
        });

      // ② 클릭 시 토글 요청
      wishBtn.addEventListener("click", function () {
        fetch(ctx + "/api/wishlist/toggle", {
          method: "POST",
          headers: { "Content-Type": "application/x-www-form-urlencoded" },
          body: "bookId=" + bookId
        })
          .then(res => res.json())
          .then(data => {
            alert(data.message);
            if (data.status === "success") {
              // 메시지를 기준으로 버튼 상태 변경
              const isNowWished = data.message.includes("취소") === false; // → 찜 상태 유지 여부
              if (isNowWished) {
                wishBtn.classList.remove("btn-outline-danger");
                wishBtn.classList.add("btn-danger");
                wishBtn.innerText = "💔 찜 취소";
              } else {
                wishBtn.classList.remove("btn-danger");
                wishBtn.classList.add("btn-outline-danger");
                wishBtn.innerText = "❤️ 찜하기";
              }
            }
          });
      });
    }
    
});
</script>

