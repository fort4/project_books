<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container mt-5">
    <h3 class="mb-4">🔔 내 알림 목록</h3>

    <c:if test="${empty notifications}">
        <div class="alert alert-info">받은 알림이 없습니다.</div>
    </c:if>

    <c:if test="${not empty notifications}">
        <ul class="list-group">
            <!-- EL 2.2이상에서만 지원되는건지 삼항연산자 오류 ㅆㅂ; -->
			<c:forEach var="noti" items="${notifications}">
			    <c:set var="liClass" value="list-group-item clickable-noti d-flex justify-content-between align-items-center" />
			    <c:if test="${!noti.readed}">
			        <c:set var="liClass" value="${liClass} list-group-item-warning" />
			    </c:if>
			
			    <li class="${liClass}" data-id="${noti.notificationId}">
			        <div>
			            <span class="fw-bold">${noti.content}</span><br/>
			            <small class="text-muted">보낸이: ${noti.sender} | ${noti.createdAt}</small>
			        </div>
			
			        <c:if test="${!noti.readed}">
			            <span class="badge bg-danger">안읽음</span>
			        </c:if>
			        <c:if test="${noti.readed}">
			            <span class="badge bg-secondary">읽음</span>
			        </c:if>
			    </li>
			</c:forEach>
        </ul>
    </c:if>
</div>

<!-- 알림 클릭시 읽음처리용 -->
<script>
document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll(".clickable-noti").forEach(function (item) {
    item.addEventListener("click", function () {
      const id = this.dataset.id;
      if (!id) return;

      fetch(ctx + "/api/notification/read", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "notificationId=" + id
      }).then(res => res.json())
        .then(success => {
          if (success) location.reload();  // 성공 시 새로고침
        });
    });
  });
});
</script>
