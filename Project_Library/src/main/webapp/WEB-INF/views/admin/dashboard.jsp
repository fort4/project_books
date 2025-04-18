<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<div class="container mt-5">
    <h2 class="mb-4 text-center">📊 관리자 통계 대시보드</h2>
	
	<!-- 차트들(chart js로) -->
	<div class="row row-cols-1 row-cols-md-2 g-5 mb-5">
	  <div class="col">
	    <h4 class="text-center">👥 회원 통계 차트</h4>
	    <canvas id="memberChart"></canvas>
	  </div>
	  <div class="col">
	    <h4 class="text-center">📚 도서 및 대여 통계</h4>
	    <canvas id="bookChart"></canvas>
	  </div>
	</div>
	
    <div class="row row-cols-1 row-cols-md-3 g-4 justify-content-center text-center">
        <!-- 전체 회원 -->
        <div class="col">
            <div class="card h-100 text-bg-primary">
                <div class="card-body">
                    <h5 class="card-title">전체 회원 수</h5>
                    <p class="display-5">${totalMembers}</p>
                </div>
            </div>
        </div>

        <!-- 일반 회원 -->
        <div class="col">
            <div class="card h-100 text-bg-primary">
                <div class="card-body">
                    <h5 class="card-title">일반 회원</h5>
                    <p class="display-5">${userMembers}</p>
                </div>
            </div>
        </div>

        <!-- 관리자 -->
        <div class="col">
            <div class="card h-100 text-bg-primary">
                <div class="card-body">
                    <h5 class="card-title">관리자 수</h5>
                    <p class="display-5">${adminMembers}</p>
                </div>
            </div>
        </div>

        <!-- 탈퇴 회원 -->
        <div class="col">
            <div class="card h-100 text-bg-primary">
                <div class="card-body">
                    <h5 class="card-title">탈퇴 회원</h5>
                    <p class="display-5">${deletedMembers}</p>
                </div>
            </div>
        </div>

        <!-- 전체 도서 -->
        <div class="col">
            <div class="card h-100 text-bg-primary">
                <div class="card-body">
                    <h5 class="card-title">전체 도서 수</h5>
                    <p class="display-5">${totalBooks}</p>
                </div>
            </div>
        </div>

        <!-- 대여 중 -->
        <div class="col">
            <div class="card h-100 text-bg-primary">
                <div class="card-body">
                    <h5 class="card-title">대여 중인 도서</h5>
                    <p class="display-5">${rentedBooks}</p>
                </div>
            </div>
        </div>

        <!-- 대여 요청 대기 -->
        <div class="col">
            <div class="card h-100 text-bg-primary">
                <div class="card-body">
                    <h5 class="card-title">승인 대기 요청</h5>
                    <p class="display-5">${pendingRequests}</p>
                </div>
            </div>
        </div>
    </div>
    
</div>

<script>
// 📊 회원 통계 차트 (막대형)
const memberCtx = document.getElementById('memberChart').getContext('2d');
new Chart(memberCtx, {
  type: 'bar',
  data: {
    labels: ['전체 회원', '일반 회원', '관리자', '탈퇴 회원'],
    datasets: [{
      label: '회원 수',
      data: [${totalMembers}, ${userMembers}, ${adminMembers}, ${deletedMembers}],
      backgroundColor: ['#0d6efd', '#198754', '#ffc107', '#6c757d']
    }]
  },
  options: {
    responsive: true,
    plugins: {
      legend: { display: false },
      title: {
        display: false
      }
    },
    scales: {
      y: {
        beginAtZero: true,
        ticks: {
          font: {
            size: 14
          }
        }
      },
      x: {
        ticks: {
          font: {
            size: 14
          }
        }
      }
    }
  }
});

// 📚 도서 및 대여 통계 차트 (도넛형)
const bookCtx = document.getElementById('bookChart').getContext('2d');
new Chart(bookCtx, {
  type: 'doughnut',
  data: {
    labels: ['전체 도서', '대여 중', '승인 대기'],
    datasets: [{
      data: [${totalBooks}, ${rentedBooks}, ${pendingRequests}],
      backgroundColor: ['#0dcaf0', '#dc3545', '#fd7e14']
    }]
  },
  options: {
    responsive: true,
    plugins: {
      legend: {
        position: 'bottom',
        labels: {
          font: {
            size: 14
          }
        }
      },
      title: {
        display: false
      }
    }
  }
});
</script>

