<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container mt-5">
    <h2 class="mb-4 text-center">👤 회원 관리</h2>
	
	<!-- 🔍 검색 & 필터 Form -->
	<form class="row row-cols-auto g-3 align-items-center mb-4" method="get"
	      action="${ctx}/admin/members">
	
	    <!-- 🔍 키워드 -->
	    <div class="col">
	        <input type="text" name="keyword" class="form-control"
	               placeholder="아이디 or 이름" value="${condition.keyword}" />
	    </div>
	
	    <!-- 👤 역할 -->
	    <div class="col">
	        <select name="role" class="form-select">
	            <option value="">전체 역할</option>
	            <option value="user" ${condition.role == 'user' ? 'selected' : ''}>일반회원</option>
	            <option value="admin" ${condition.role == 'admin' ? 'selected' : ''}>관리자</option>
	        </select>
	    </div>
	
	    <!-- 🗑 탈퇴 상태 -->
	    <div class="col">
	        <select name="status" class="form-select">
	            <option value="">전체 상태</option>
	            <option value="active" ${condition.status == 'active' ? 'selected' : ''}>활성</option>
	            <option value="deleted" ${condition.status == 'deleted' ? 'selected' : ''}>탈퇴</option>
	        </select>
	    </div>
	
	    <!-- 검색 버튼 -->
	    <div class="col">
	        <button type="submit" class="btn btn-outline-primary">🔍 검색</button>
	    </div>
	</form><!-- 검색, 필터 폼 -->
	
    <table class="table table-bordered table-hover align-middle text-center">
        <thead class="table-dark">
            <tr>
                <th>아이디</th>
                <th>이름</th>
                <th>역할</th>
                <th>생년월일</th>
                <th>포인트</th>
                <th>탈퇴여부</th>
                <th>관리</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="member" items="${members}">
                <tr class="${member.deleted ? 'table-secondary' : ''}">
                    <td>${member.username}</td>
                    <td>${member.name}</td>
                    <td>
                        <span class="badge bg-${member.role == 'admin' ? 'danger' : 'success'}">
                            ${member.role}
                        </span>
                    </td>
                    <td>${member.birthDate}</td>
					<td>
				        <div class="text-center mb-2">
					        <strong class="text-primary">${member.points}P</strong>
					    </div>
					    <c:if test="${!member.deleted}">
					        <form method="post" action="${ctx}/admin/members/points" class="d-flex gap-1 justify-content-center">
					            <input type="hidden" name="username" value="${member.username}" />
					            <input type="number" name="points" class="form-control form-control-sm"
					                   style="width: 80px;" placeholder="+ or -" required />
					            <button type="submit" class="btn btn-sm btn-outline-success">적용</button>
					        </form>
					    </c:if>
					</td>
                    <td>
                        <c:choose>
                            <c:when test="${member.deleted}">
                                <span class="text-muted">탈퇴 (${member.deletedAt})</span>
                            </c:when>
                            <c:otherwise>
                                사용중
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                    	<div class="d-flex gap-2 justify-content-center align-items-center">
						    <button type="button" class="btn btn-sm btn-outline-primary"
						            onclick="openMemberDetail('${member.username}')">
						        상세
						    </button>
						    
                        <c:if test="${!member.deleted}">
                            <form method="post" action="${ctx}/admin/members/delete"
                                  class="d-inline m-0 p-0"
                                  onsubmit="return confirm('정말 탈퇴 처리하시겠습니까?')">
                                <input type="hidden" name="username" value="${member.username}" />
                                <button type="submit" class="btn btn-sm btn-outline-danger">탈퇴</button>
                            </form>
                        </c:if>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<!-- 회원 상세 모달 -->
<div class="modal fade" id="memberDetailModal" tabindex="-1" aria-labelledby="memberDetailModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="memberDetailModalLabel">회원 상세 정보</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
      </div>
      <div class="modal-body">
        <table class="table table-bordered">
          <tbody>
            <tr>
              <th>아이디</th><td id="detail-username"></td>
            </tr>
            <tr>
              <th>이름</th><td id="detail-name"></td>
            </tr>
            <tr>
              <th>역할</th><td id="detail-role"></td>
            </tr>
            <tr>
              <th>생년월일</th><td id="detail-birth"></td>
            </tr>
            <tr>
              <th>포인트</th><td id="detail-points"></td>
            </tr>
            <tr>
              <th>탈퇴여부</th><td id="detail-status"></td>
            </tr>
            <tr>
              <th>탈퇴일</th><td id="detail-deletedAt"></td>
            </tr>
          </tbody>
        </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<script>
function openMemberDetail(username) {
  fetch(ctx + '/api/admin/members/' + username)
    .then(res => res.json())
    .then(data => {
      // 값 채우기
      document.getElementById('detail-username').textContent = data.username;
      document.getElementById('detail-name').textContent = data.name;
      document.getElementById('detail-role').textContent = data.role;
      document.getElementById('detail-birth').textContent = data.birthDate;
      document.getElementById('detail-points').textContent = data.points;
      document.getElementById('detail-status').textContent = data.deleted ? '탈퇴됨' : '사용중';
      document.getElementById('detail-deletedAt').textContent = data.deletedAt || '-';

      // 모달 띄우기
      new bootstrap.Modal(document.getElementById('memberDetailModal')).show();
    })
    .catch(err => {
      alert("회원 정보를 불러오지 못했습니다.");
      console.error(err);
    });
}
</script>

