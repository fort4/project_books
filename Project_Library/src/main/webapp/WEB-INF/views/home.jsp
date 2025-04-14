<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page session="true" %>
<%@ page import="com.fort4.dto.MemberDTO" %>
<%
    MemberDTO user = (MemberDTO) session.getAttribute("loginUser");
/*     if (user == null) {
        response.sendRedirect("/");
        return;
    } */
%>
<html>
<head><title>홈</title></head>
<body>
    <h2>어서 오세요, <%= user.getName() %> 님!</h2>
    <p>권한: <%= user.getRole() %></p>
    <a href="logout">로그아웃</a>
</body>
</html>
