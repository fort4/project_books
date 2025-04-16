<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 도서 슬라이더 -->
<c:if test="${not empty topBooks}">
  <div id="topBooksCarousel" class="carousel slide mb-4" data-bs-ride="carousel">
  	<div class="text-center mt-3 mb-4">
		<h4>📊 가장 많이 대여된 책 Top 5</h4>
	</div>
    <div class="carousel-inner">
      <c:forEach var="book" items="${topBooks}" varStatus="status">
        <div class="carousel-item ${status.first ? 'active' : ''}">
          <div class="d-flex justify-content-center align-items-center flex-column">
			<img src="${empty book.imageUrl 
			            ? pageContext.request.contextPath.concat('/resources/images/no-image.jpg') 
			            : pageContext.request.contextPath.concat(book.imageUrl)}"
			     class="d-block"
			     alt="${book.title}"
			     style="max-height: 300px;"> <!-- 이미지 없으면 no-image 출력 -->
            <h5 class="mt-3">${book.title}</h5>
            <p class="text-muted">${book.author}</p>
          </div>
        </div>
      </c:forEach>

    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#topBooksCarousel" data-bs-slide="prev">
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="visually-hidden">이전</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#topBooksCarousel" data-bs-slide="next">
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="visually-hidden">다음</span>
    </button>
	</div>
  
</c:if>

<div class="container mt-5">
    <h2 class="mb-4 text-center">📚 도서 목록</h2>

    <!-- 검색 폼 -->
    <form method="get" action="<c:url value='/books' />" class="d-flex mb-4 justify-content-center">
        <input type="text" name="keyword" class="form-control w-50 me-2" placeholder="제목 또는 저자 검색" value="${param.keyword}" />
        <button type="submit" class="btn btn-outline-primary">🔍 검색</button>
    </form>
    
    <form method="get" action="<c:url value='/books' />" class="d-flex gap-3 mb-3 justify-content-center">
	  <!-- 카테고리 -->
	  <div>
	    <label for="categoryId" class="me-2">카테고리:</label>
	    <select name="categoryId" id="categoryId" class="form-select w-auto d-inline" onchange="this.form.submit()">
	      <option value="">전체</option>
	      <c:forEach var="c" items="${categories}">
	        <option value="${c.categoryId}" <c:if test="${categoryId == c.categoryId}">selected</c:if>>
	          ${c.name}
	        </option>
	      </c:forEach>
	    </select>
	  </div>

	  <!-- 정렬 / 페이지당 / 검색어 유지 -->
	  <input type="hidden" name="keyword" value="${keyword}" />
	  <input type="hidden" name="sort" value="${sort}" />
	  <input type="hidden" name="order" value="${order}" />
	  <input type="hidden" name="size" value="${size}" />
	</form>
    
    <!-- 드롭다운 -->
    <form method="get" action="${pageContext.request.contextPath}/books" class="mb-3">
    
      <!-- 정렬 기준 - 최신순 디폴트 -->
	  <div>
	    <label for="sort" class="me-2">정렬 기준:</label>
	    <select name="sort" id="sort" class="form-select w-auto d-inline" onchange="this.form.submit()">
	      <option value="date" <c:if test="${sort == 'date'}">selected</c:if>>최신순</option>
	      <option value="title" <c:if test="${sort == 'title'}">selected</c:if>>제목순</option>
	      <option value="author" <c:if test="${sort == 'author'}">selected</c:if>>저자순</option>
	    </select>
	  </div> 
	  <!-- 정렬 방향 - 내림차 디폴트로 해둠 -->
	  <div> 
	  <label for="order" class="me-2">정렬 방향:</label>
		<select name="order" id="order" class="form-select w-auto d-inline" onchange="this.form.submit()">
			<option value="desc" <c:if test="${order == 'desc'}">selected</c:if>>내림차순</option>
			<option value="asc" <c:if test="${order == 'asc'}">selected</c:if>>오름차순</option>
	    </select>
	  </div>
	  
	  <!-- 페이지당 도서 수 - 5권 해둠 -->
	  <div class="d-flex align-items-center">
	    <label for="size" class="me-2">페이지당 도서 수:</label>
	    <select name="size" id="size" class="form-select w-auto d-inline" onchange="this.form.submit()">
			<option value="5" <c:if test="${size == 5}">selected</c:if>>5권</option>
			<option value="10" <c:if test="${size == 10}">selected</c:if>>10권</option>
			<option value="25" <c:if test="${size == 25}">selected</c:if>>25권</option>
	    </select>
	  </div>
	  
	<!-- 검색어 유지 - form 분리되어 있으니 hidden으로 유지하기 -->
	<input type="hidden" name="keyword" value="${keyword}">
	<!-- 정렬 유지 - 얜 form안에 있으니 상관없긴 한데 일단 적어놓음 -->
	<%-- <input type="hidden" name="order" value="${order}"> --%>

	</form>
    
    <table class="table table-bordered table-hover align-middle text-center bg-white">
        <thead class="table-dark">
            <tr>
                <th>표지</th>
                <th>도서번호</th>
                <th>제목</th>
                <th>저자</th>
                <th>출판사</th>
                <th>출판일</th>
                <th>카테고리</th> 
                <th>대여상태</th>
                <c:if test="${loginUser.role == 'admin'}">
                    <th>관리</th>
                </c:if>
            </tr>
        </thead>
        
        <tbody>
            <c:forEach var="book" items="${books}">
                <tr>
                    <td>
                        <a href="<c:url value='/books/${book.bookId}' />">
                            <c:choose>
                                <c:when test="${not empty book.imageUrl}">
                                    <img src="<c:url value='${book.imageUrl}' />" width="100" height="140" alt="표지" />
                                </c:when>
                                <c:otherwise>
                                    <img src="<c:url value='/resources/images/no-image.jpg' />" width="100" height="140" alt="기본 이미지" />
                                </c:otherwise>
                            </c:choose>
                        </a>
                    </td>
                    <td>${book.bookId}</td>
                    <td>${book.title}</td>
                    <td>${book.author}</td>
                    <td>${book.publisher}</td>
                    <td>${book.pubDate}</td>
                    <td>${book.categoryName}</td>
                    <td>
                        <c:choose>
                            <c:when test="${book.rented}">대여중</c:when>
                            <c:otherwise>대여가능</c:otherwise>
                        </c:choose>
                    </td>
                    <c:if test="${loginUser.role == 'admin'}">
                        <td>
                            <a href="<c:url value='/books/edit/${book.bookId}' />" class="btn btn-sm btn-warning">✏️ 수정</a>
                            <a href="<c:url value='/books/delete/${book.bookId}' />"
                               class="btn btn-sm btn-danger"
                               onclick="return confirm('정말 삭제하시겠습니까?');">🗑 삭제</a>
                        </td>
                    </c:if>
                </tr>
            </c:forEach>
        </tbody>
    </table>
        
    <!-- 하단 페이지 버튼 -->
    <c:if test="${totalPages > 1}">
	  <nav>
	    <ul class="pagination justify-content-center">
	      <c:forEach begin="1" end="${totalPages}" var="p">
	        <li class="page-item ${currentPage == p ? 'active' : ''}">
			<a class="page-link"
			   href="${pageContext.request.contextPath}/books?page=${p}&size=${size}&sort=${sort}&order=${order}&keyword=${keyword}">
			   ${p}
			</a>
	        </li>
	      </c:forEach>
	    </ul>
	  </nav>
	</c:if>
    
</div>

