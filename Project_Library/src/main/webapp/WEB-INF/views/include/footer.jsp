<!-- footer.jsp -->
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<footer class="bg-dark text-light py-3 mt-5">
    <div class="container text-center">
        <small>
            &copy; <c:out value="${pageContext.request.serverName}" /> 도서 대여 시스템 |
            Made by <strong>fort4</strong> |
            <c:out value="<%= java.time.LocalDate.now().getYear() %>" />
        </small>
    </div>
</footer>

<!-- Bootstrap JS (선택) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
