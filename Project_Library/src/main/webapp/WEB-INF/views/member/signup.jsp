<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container mt-5" style="max-width: 500px;">
    <h2 class="text-center mb-4">📋 회원가입</h2>

    <form action="<c:url value='/signup' />" method="post" onsubmit="return validateForm();">
		<div class="mb-3">
		    <label class="form-label">아이디</label>
		    <div class="input-group">
		        <input type="text" name="username" id="username" class="form-control" required />
		        <button type="button" class="btn btn-outline-secondary" onclick="checkId()">중복 확인</button>
		    </div>
		    <small id="idCheckMsg" class="text-danger"></small>
		</div>

        <div class="mb-3">
            <label class="form-label">비밀번호</label>
            <input type="password" name="password" class="form-control" required />
        </div>

        <div class="mb-3">
            <label class="form-label">이름</label>
            <input type="text" name="name" class="form-control" required />
        </div>

        <div class="mb-3">
            <label class="form-label">생년월일</label>
            <input type="date" name="birthDate" class="form-control" required />
        </div>

        <button type="submit" class="btn btn-success w-100">가입하기</button>
    </form>

    <div class="mt-3 text-center">
        <button type="button" class="btn btn-outline-secondary btn-sm"
                onclick="location.href='${ctx}/login'">
            ← 로그인으로 돌아가기
        </button>
    </div>
    
</div><!-- container -->


    
<script>

// 회원가입 AJAX 검사
function checkId() {
    const username = document.getElementById("username").value;
    const msg = document.getElementById("idCheckMsg");
	const idRegex = /^[a-zA-Z0-9]{4,20}$/; // 영문숫자, 4-20자리
	
	/* 아이디 규칙 */
	if (!idRegex.test(username)) {
	    alert("아이디는 영문자와 숫자 조합 4~20자 사이여야 합니다.");
	    return;
	}

    if (!username) {
        msg.innerText = "아이디를 입력해주세요.";
        return;
    }
	// 숫자 달라고 요청보내기
    fetch(ctx + "/api/check-id?username=" + encodeURIComponent(username))
        .then(res => res.text())
        .then(count => {
            if (parseInt(count) === 0) {
                msg.innerText = "사용 가능한 아이디입니다.";
                msg.className = "text-success";
            } else {
                msg.innerText = "이미 사용 중인 아이디입니다.";
                msg.className = "text-danger";
            }
        });
}

// 비밀번호 유효성 검사
function validateForm() {
    const pw = document.querySelector("input[name='password']").value;
    const name = document.querySelector("input[name='name']").value;
    const birth = document.querySelector("input[name='birthDate']").value;

    const pwRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d!@#$%^&*]{8,}$/;

    if (!pwRegex.test(pw)) {
        alert("비밀번호는 8자 이상, 숫자와 영문자를 포함해야 합니다.");
        return false;
    }

    if (!name || !birth) {
        alert("이름과 생년월일을 입력해주세요.");
        return false;
    }

    return true;
}
</script>
	

