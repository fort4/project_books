<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    .login-container {
      max-width: 400px;
      margin: 80px auto;
      padding: 30px;
    }
    .btn-login {
      background-color: #999;
      color: white;
    }
    .btn-login:hover {
      background-color: #777;
    }
    .sns-btn img {
      width: 40px;
      height: 40px;
      margin: 0 6px;
    }
    .login-logo {
      font-weight: bold;
      font-size: 22px;
      text-align: center;
      margin-bottom: 30px;
    }
</style>

<div class="login-container border rounded shadow-sm p-4 bg-white">

  <div class="login-logo">
    <img src="${ctx}/resources/images/book-logo.png" alt="Logo" height="40" />
    <div class="mt-2">I-<span style="color:green">BOOKS</span></div>
  </div>

  <form action="${ctx}/member/login" method="post">
    <input type="text" name="username" class="form-control mb-2" value="${cookie.saveId.value}" placeholder="아이디" required />
    <div class="input-group mb-1">
	  <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호" required />
	  <button class="btn btn-outline-secondary" type="button" id="togglePassword">
	  	<i class="fas fa-eye-slash"></i>
	  </button>
    </div>
    
    <div class="col p-1">
      <input type="checkbox" name="saveId" id="saveId" ${not empty cookie.saveId ? 'checked' : ''} />
      <label for="saveId" class="ms-1">아이디 저장</label>
      
	  <input type="checkbox" name="rememberMe" id="rememberMe" />
	  <label for="rememberMe">자동 로그인</label>
    </div>
    
    <div class="form-group mb-2">
    <button type="submit" class="btn btn-primary btn-sm btn-block w-100 py-2">로그인</button>
    </div>
    
	<div class="form-group">
	<a href="${ctx}/signup" class="btn btn-outline-secondary btn-sm btn-block w-100 py-2">회원가입</a>
	</div>
  </form>

  <div class="text-center mt-3 mb-3">
    <div>
      <a href="${ctx}/member/find-id" class="text-decoration-none small me-2">아이디 찾기</a> |
      <a href="#" class="text-decoration-none small ms-2"
	     onclick="alert('비밀번호 분실 시 관리자에게 문의하시기 바랍니다.'); return false;">
	     비밀번호 찾기
	  </a>
    </div>
  </div>

  <div class="text-center sns-btn mb-3">
    <img src="${ctx}/resources/images/social/naver.png" alt="Naver" />
    <img src="${ctx}/resources/images/social/kakao.png" alt="Kakao" />
    <img src="${ctx}/resources/images/social/google.png" alt="Google" />
  </div>

  <div class="small text-muted text-center mb-2">
    개인정보 보호를 위해 공유 PC에서 사용 시 <br>로그아웃 상태를 꼭 확인해 주세요.
  </div>


</div>

<script>
  const toggleBtn = document.getElementById("togglePassword");
  const passwordInput = document.getElementById("password");
  const icon = toggleBtn.querySelector("i");

  toggleBtn.addEventListener("click", () => {
    const isPassword = passwordInput.type === "password";
    passwordInput.type = isPassword ? "text" : "password";
    icon.classList.toggle("fa-eye");
    icon.classList.toggle("fa-eye-slash");
  });
</script>

