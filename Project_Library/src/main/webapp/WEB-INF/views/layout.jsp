<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
  html, body {
    height: 100%;
    margin: 0;
  }

  .wrapper {
    min-height: 100%;
    display: flex;
    flex-direction: column;
  }

  .content {
    flex: 1;
  }
</style>

<!-- 공통 스크립트 -->
<script>
	const ctx = '<%= request.getContextPath() %>';
</script>

<div class="wrapper">

	<!-- 공통 헤더 -->
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	
	<!-- 본문 영역 -->
	<div class="container my-4">
	    <jsp:include page="/WEB-INF/views/${contentPage}.jsp" />
	</div>
	
	<!-- 공통 푸터 -->
	<!-- 나중에 푸터만 수정해서 액션태그 말고 지시어로 바꿀지 고민중 -->
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

</div>