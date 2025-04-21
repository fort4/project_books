<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="bg-gray-900">
  <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
    <div class="flex items-center justify-between h-16">
      
      <!-- 로고 -->
      <div class="flex-shrink-0">
        <a href="${ctx}/index"
           class="text-white text-2xl font-bold hover:text-gray-300">
          📚 I-BOOKS
        </a>
      </div>

      <!-- 버튼 영역 -->
      <div class="flex items-center space-x-4">

        <!-- 알림 아이콘 (로그인한 사용자만 표시) -->
        <c:if test="${not empty loginUser}">
          <a href="${ctx}/member/notifications"
             class="relative text-white hover:text-gray-300">
            <i class="fas fa-bell fa-lg"></i>
            <span id="notiBadge"
                  class="hidden absolute top-0 right-0 transform translate-x-1/2 -translate-y-1/2 bg-red-500 text-xs text-white rounded-full px-1">
            </span>
          </a>
        </c:if>

        <c:choose>
          <c:when test="${not empty loginUser}">
            <!-- 로그인된 사용자: 드롭다운 -->
            <div class="relative">
              <button id="userMenuBtn"
                      class="flex items-center bg-green-600 hover:bg-green-700 text-white px-3 py-2 rounded-md focus:outline-none"
                      type="button">
                <i class="fas fa-user-check mr-2"></i>
                ${loginUser.name}
                <svg class="ml-1 h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                        d="M19 9l-7 7-7-7" />
                </svg>
              </button>
              <ul id="userMenu"
                  class="hidden absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-1 z-20">
                <li><a href="${ctx}/member/mybooks"
                       class="block px-4 py-2 text-gray-700 hover:bg-gray-100">나의 도서</a></li>
                <li><a href="${ctx}/member/wishlist"
                       class="block px-4 py-2 text-gray-700 hover:bg-gray-100">위시리스트</a></li>
                <li><a href="${ctx}/member/mypage"
                       class="block px-4 py-2 text-gray-700 hover:bg-gray-100">마이페이지</a></li>
                <li><hr class="border-gray-200 my-1"></li>
                <li>
                  <form action="${ctx}/member/logout" method="get">
                    <button type="submit"
                            class="w-full text-left px-4 py-2 text-gray-700 hover:bg-gray-100">
                      로그아웃
                    </button>
                  </form>
                </li>
              </ul>
            </div>
          </c:when>
          <c:otherwise>
            <!-- 비로그인 상태: 로그인 버튼 -->
            <a href="${ctx}/member/login"
               class="flex items-center bg-white bg-opacity-10 hover:bg-opacity-20 text-white px-3 py-2 rounded-md">
              <i class="fas fa-user mr-1"></i> 로그인
            </a>
          </c:otherwise>
        </c:choose>

        <!-- 관리자: 드롭다운 -->
        <c:if test="${not empty loginUser && loginUser.role == 'admin'}">
          <div class="relative">
            <button id="adminMenuBtn"
                    class="flex items-center bg-red-600 hover:bg-red-700 text-white px-3 py-2 rounded-md focus:outline-none"
                    type="button">
              <i class="fas fa-cogs"></i>
              <svg class="ml-1 h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M19 9l-7 7-7-7" />
              </svg>
            </button>
            <ul id="adminMenu"
                class="hidden absolute right-0 mt-2 w-56 bg-white rounded-md shadow-lg py-1 z-20">
              <li><a href="${ctx}/admin/books"
                     class="block px-4 py-2 text-gray-700 hover:bg-gray-100">📚 도서 관리</a></li>
              <li><a href="${ctx}/admin/books/add"
                     class="block px-4 py-2 text-gray-700 hover:bg-gray-100">➕ 도서 등록</a></li>
              <li><a href="${ctx}/admin/rental-requests"
                     class="block px-4 py-2 text-gray-700 hover:bg-gray-100">📋 대여 요청 관리</a></li>
              <li><a href="${ctx}/admin/members"
                     class="block px-4 py-2 text-gray-700 hover:bg-gray-100">👥 회원 관리</a></li>
              <li><a href="${ctx}/admin/dashboard"
                     class="block px-4 py-2 text-gray-700 hover:bg-gray-100">📊 대시보드</a></li>
              <li><a href="${ctx}/admin/notification/send"
                     class="block px-4 py-2 text-gray-700 hover:bg-gray-100">🔔 알림 전송</a></li>
            </ul>
          </div>
        </c:if>

      </div>
    </div>
  </div>
</nav>

<script>

document.getElementById('userMenuBtn')?.addEventListener('click', () => {
    document.getElementById('userMenu').classList.toggle('hidden');
  });
  document.getElementById('adminMenuBtn')?.addEventListener('click', () => {
    document.getElementById('adminMenu').classList.toggle('hidden');
  });

document.addEventListener("DOMContentLoaded", function () {
    fetch(`${ctx}/api/notification/unread-count`)
        .then(res => res.text())
        .then(count => {
            const badge = document.getElementById("notiBadge");
            if (parseInt(count) > 0) {
                badge.innerText = count;
                badge.style.display = "inline-block";
            } else {
                badge.style.display = "none";
            }
        });
});
</script>

