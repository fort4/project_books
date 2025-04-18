<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container mt-5">
    <h2 class="mb-4 text-center">👤 회원 관리</h2>

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
                    <td>${member.points}</td>
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
                        <c:if test="${!member.deleted}">
                            <form method="post"
                                  action="${ctx}/admin/members/delete"
                                  onsubmit="return confirm('정말 탈퇴 처리하시겠습니까?')">
                                <input type="hidden" name="username" value="${member.username}" />
                                <button type="submit" class="btn btn-sm btn-outline-danger">탈퇴</button>
                            </form>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
