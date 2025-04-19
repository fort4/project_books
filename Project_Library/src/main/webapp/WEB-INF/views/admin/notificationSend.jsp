<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container mt-5">
    <h3 class="mb-4">📢 관리자 알림 발송</h3>

    <c:if test="${not empty successMsg}">
        <div class="alert alert-success">${successMsg}</div>
    </c:if>
    <c:if test="${not empty errorMsg}">
        <div class="alert alert-danger">${errorMsg}</div>
    </c:if>

    <form action="${ctx}/admin/notification/send" id="notificationForm" method="post" class="border p-4 rounded bg-light">
        <!-- 대상 구분 -->
        <div class="mb-3">
            <label class="form-label">대상 유형</label>
            <select name="targetType" class="form-select" required onchange="toggleTargetId(this.value)">
                <option value="user">특정 사용자</option>
                <option value="all">전체 사용자</option>
            </select>
        </div>

        <!-- 특정 사용자 ID -->
        <div class="mb-3" id="targetIdBox">
            <label class="form-label">대상 사용자 ID</label>
            <input type="text" name="targetId" class="form-control" placeholder="username을 입력하세요" required />
        </div>

        <!-- 알림 내용 -->
        <div class="mb-3">
            <label class="form-label">내용</label>
            <textarea name="content" rows="4" class="form-control" required></textarea>
        </div>

        <!-- 제출 버튼 -->
        <button type="submit" class="btn btn-primary">📨 알림 보내기</button>
    </form>
</div>

<script src="${ctx}/resources/js/admin/notification.js"></script>
