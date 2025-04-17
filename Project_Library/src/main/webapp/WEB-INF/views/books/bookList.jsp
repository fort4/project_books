<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="row row-cols-2 row-cols-md-5 g-4">
  <c:forEach var="book" items="${books}">
    <div class="col">
      <div class="card h-100">
        <c:choose>
          <c:when test="${empty book.imageUrl}">
            <img src="${pageContext.request.contextPath}/resources/images/default-book.png"
                 class="card-img-top"
                 style="height: 220px; object-fit: contain;">
          </c:when>
          <c:otherwise>
            <img src="${book.imageUrl}"
                 class="card-img-top"
                 style="height: 220px; object-fit: contain;">
          </c:otherwise>
        </c:choose>
        <div class="card-body">
          <h6 class="card-title">${book.title}</h6>
          <p class="card-text small">${book.author}</p>
        </div>
      </div>
    </div>
  </c:forEach>
</div>
