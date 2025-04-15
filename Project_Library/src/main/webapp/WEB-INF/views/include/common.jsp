<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script>
    // 컨텍스트 경로 변수(모든 JSP에서 사용 가능)
    const ctx = '${pageContext.request.contextPath}';

    // 로그인 유저 이름(있는 경우에만)
    <c:if test="${not empty loginUser}">
        const loginUserName = '${loginUser.name}';
        const loginUserRole = '${loginUser.role}';
    </c:if>
    
</script>
