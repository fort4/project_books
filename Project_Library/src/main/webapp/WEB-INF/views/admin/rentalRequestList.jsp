<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container mt-4">
  <h3 class="mb-4">📋 대여 요청 관리</h3>

  <table class="table table-bordered align-middle text-center">
    <thead class="table-light">
      <tr>
        <th>요청 ID</th>
        <th>도서 제목</th>
        <th>요청자</th>
        <th>요청일</th>
        <th>상태</th>
        <th>처리</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="r" items="${requests}">
        <tr>
          <td>${r.requestId}</td>
          <td>${r.bookTitle}</td>
          <td>${r.username}</td>
          <td>${r.requestDate}</td>
          <td>${r.status}</td>
          <td>
            <c:choose>
              <c:when test="${r.status == 'pending'}">
                <form action="${ctx}/admin/rental-requests/approve/${r.requestId}" method="post" style="display:inline;">
                  <button class="btn btn-success btn-sm">승인</button>
                </form>
                <form action="${ctx}/admin/rental-requests/reject/${r.requestId}" method="post" style="display:inline;">
                  <button class="btn btn-danger btn-sm">거절</button>
                </form>
              </c:when>
              <c:otherwise>
                <span class="text-muted">처리 완료</span>
              </c:otherwise>
            </c:choose>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</div>
