<%@ page contentType="text/html;charset=UTF-8" %>

<div class="container mt-5">
    <h2 class="mb-4 text-center">📋 마이페이지</h2>

    <!-- 내 정보 -->
    <div class="card mb-4">
        <div class="card-body">
            <h5 class="card-title">👤 내 정보</h5>
            <p><strong>아이디:</strong> ${member.username}</p>
            <p><strong>이름:</strong> ${member.name}</p>
            <p><strong>생년월일:</strong> ${member.birthDate}</p>
            <p><strong>포인트:</strong> ${member.points} P</p>
        </div>
    </div>

    <!-- 비밀번호 변경 -->
    <div class="card mb-4">
        <div class="card-body">
            <h5 class="card-title">🔐 비밀번호 변경</h5>
            <form action="${ctx}/member/change-password" method="post">
                <div class="mb-2">
                    <input type="password" name="currentPassword" class="form-control" placeholder="현재 비밀번호" required />
                </div>
                <div class="mb-2">
                    <input type="password" name="newPassword" class="form-control" placeholder="새 비밀번호" required />
                </div>
                <button class="btn btn-outline-primary">비밀번호 변경</button>
            </form>
            <!-- 회원 탈퇴 -->
            <form action="${ctx}/member/delete" method="post" onsubmit="return confirm('정말 탈퇴하시겠습니까?');">
				<button class="btn btn-outline-danger">회원 탈퇴</button>
        	</form>
        </div>
    </div>
    
</div>

