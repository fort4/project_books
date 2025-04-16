<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<h2>📊 관리자 대시보드</h2>
<hr>

<div class="row my-4">
  <div class="col-md-3">
    <div class="card text-white bg-primary mb-3">
      <div class="card-body text-center">
        <h5 class="card-title">총 회원 수</h5>
        <p class="card-text display-6">${memberCount} 명</p>
      </div>
    </div>
  </div>
  <div class="col-md-3">
    <div class="card text-white bg-success mb-3">
      <div class="card-body text-center">
        <h5 class="card-title">총 도서 수</h5>
        <p class="card-text display-6">${bookCount} 권</p>
      </div>
    </div>
  </div>
  <div class="col-md-3">
    <div class="card text-white bg-warning mb-3">
      <div class="card-body text-center">
        <h5 class="card-title">총 대여 수</h5>
        <p class="card-text display-6">${rentalCount} 회</p>
      </div>
    </div>
  </div>
  <div class="col-md-3">
    <div class="card text-white bg-danger mb-3">
      <div class="card-body text-center">
        <h5 class="card-title">Top 도서</h5>
        <p class="card-text">📘 ${topBookTitle}</p>
      </div>
    </div>
  </div>
</div>

<div class="mt-5">
  <h4>📈 도서 대여 TOP 5</h4>
  <canvas id="rentalChart" height="120"></canvas>
</div>

<script>
  const bookLabels = [
    <c:forEach var="book" items="${topBooks}" varStatus="loop">
      "${book.title}"<c:if test="${!loop.last}">,</c:if>
    </c:forEach>
  ];
  const rentalCounts = [
    <c:forEach var="book" items="${topBooks}" varStatus="loop">
      ${book.rentalCount}<c:if test="${!loop.last}">,</c:if>
    </c:forEach>
  ];

  const chartCanvas = document.getElementById('rentalChart').getContext('2d');
  const chart = new Chart(chartCanvas, {
    type: 'bar',
    data: {
      labels: bookLabels,
      datasets: [{
        label: '대여 횟수',
        data: rentalCounts,
        backgroundColor: 'rgba(54, 162, 235, 0.6)',
        borderColor: 'rgba(54, 162, 235, 1)',
        borderWidth: 1
      }]
    },
    options: {
      responsive: true,
      scales: {
        y: {
          beginAtZero: true,
          ticks: {
            stepSize: 1
          }
        }
      }
    }
  });
</script>

