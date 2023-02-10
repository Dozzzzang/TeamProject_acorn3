<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>예약리스트 보기(판매자)</title>
<!-- MDB -->
<link
  href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.1.0/mdb.min.css" rel="stylesheet"/>
<!-- MDB -->
<script
  type="text/javascript"
  src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.1.0/mdb.min.js"></script>
</head>
<body>
	<%-- 네비바 --%>
	<c:choose>
		<c:when test="${empty sessionScope.id }">
        	<jsp:include page="/WEB-INF/include/navbar_sidebar_SessionX.jsp"/>
      	</c:when>
      	<c:otherwise>
	      	<c:choose>
	      		<c:when test="${usersCode eq 2 }">
	      	  		<jsp:include page="/WEB-INF/include/navbar_sessionO_seller.jsp"/>
	         		<jsp:include page="/WEB-INF/include/sidebar_seller.jsp"/>
	      		</c:when>
	      		<c:when test ="${usersCode eq 3 }">
					<jsp:include page="/WEB-INF/include/navbar_sessionO_users.jsp"/>
			      	<jsp:include page="/WEB-INF/include/sidebar_user.jsp"/>
	      		</c:when>
	      		<c:when test = "${usersCode eq 1 }">
	      		</c:when>
	      	</c:choose>
      	</c:otherwise>
   	</c:choose>
   	
	<div class="container">
		<%-- 예약리스트 메뉴 --%>
		<div id="reservMenu">
			<button onClick="location.href='${pageContext.request.contextPath}/users/reservationlist?reservCateNum=1'" 
				id="request_reserv" value="1" 
				> 예약 요청 </button>
			<button onClick="location.href='${pageContext.request.contextPath}/users/reservationlist?checkReserv=true&reservCateNum=2'" 
				id="wait_pay" value="2"> 결제 대기 </button>
			<button onClick="location.href='${pageContext.request.contextPath}/users/reservationlist?checkReserv=true&isPaid=true&reservCateNum=3'" 
				id="complete_pay" value="3"> 결제 완료 </button>
			<button onClick="location.href='${pageContext.request.contextPath}/users/reservationlist?checkReserv=false&reservCateNum=4'" 
				id="pass_reserv" value="4"> 거절/지난 예약 </button>
		</div>
		
   		<%-- 예약 목록 --%>
		<c:choose>
			<c:when test="${param.reservCateNum eq 1 }">
				<h3>예약 요청 목록</h3><p>판매자가 회원님의 예약을 확인하고 있습니다.</p>
			</c:when>
			<c:when test="${param.reservCateNum eq 2 }">
				<h3>결제 대기 목록</h3><p>결제해주시면 예약이 확정됩니다.</p>
			</c:when>
			<c:when test="${param.reservCateNum eq 3 }">
				<h3>결제 완료 목록</h3><p>결제가 완료된 목록입니다.</p>
			</c:when>
			<c:when test="${param.reservCateNum eq 4 }">
				<h3>거절/지난 예약</h3><p>예약이 취소된 목록입니다.</p>
			</c:when>
		</c:choose>
		<div id="reservList">
			<table class="table">
			  <thead>
					<tr class="table-info">
						<th scope="row">예약 번호</th>
						<th scope="row">방 이름</th>
						<th scope="row">예약자 명</th>
						<th scope="row">예약자 수</th>
						<th scope="row">예약 날짜</th>
						<th scope="row">예약 시간</th>
						<th scope="row">예약 등록일</th>
						<th scope="row">총 비용</th>
						<c:choose>
							<c:when test="${(param.reservCateNum eq 1) or (empty param.reservCateNum)}">
								<th scope="row">예약 취소</th>
							</c:when>
							<c:when test="${param.reservCateNum eq 2 }">
								<th scope="row">결제하기</th>
								<th scope="row">예약 거절</th>
							</c:when>
						</c:choose>
					</tr>
			  </thead>
			  <c:forEach var="tmp" items="${list }">
						<tbody>
							<tr>
								<td>${tmp.reserv_num }</td>
								<td>${tmp.space_name }</td>
								<td>${tmp.users_id }</td>
								<td>${tmp.reserv_count }</td>
								<td>${tmp.reserv_date }</td>
								<td>${tmp.reserv_time }</td>
								<td>${tmp.reserv_reg }</td>
								<td>${tmp.totalMoney }</td>
								<c:choose>
									<c:when test="${(param.reservCateNum eq 1) or (empty param.reservCateNum)}">
										<td><button id="rejectBtn${tmp.reserv_num }" type="button" onClick="checkBtn(this.id)">Reject</button></td>
									</c:when>
									<c:when test="${param.reservCateNum eq 2 }">
										<td><button id="payBtn${tmp.reserv_num }" type="button" onClick="checkBtn(this.id)">결제하기</button></td>
										<td><button id="notpayBtn${tmp.reserv_num }" type="button" onClick="checkBtn(this.id)">취소</button></td>
									</c:when>
								</c:choose>
							</tr>
						</tbody>	
				</c:forEach>
			</table>
		</div>
	
		<%-- 페이징 --%>
		<nav>
			<ul class="pagination">
				<%--
		        	startPageNum 이 1 이 아닌 경우에만 Prev 링크를 제공한다. 
		        	&condition=${condition}&keyword=${encodedK}
		        --%>
		        <c:if test="${startPageNum ne 1 }">
		            <li class="page-item">
		            	<a class="page-link" href="reservationlist?${pathQuery }&pageNum=${startPageNum-1 }">Prev</a>
		        	</li>
		        </c:if>
		        <c:forEach var="i" begin="${startPageNum }" end="${endPageNum }">
		            <li class="page-item ${pageNum eq i ? 'active' : '' }">
		            	<a class="page-link" href="reservationlist?${pathQuery }&pageNum=${i }">${i }</a>
		        	</li>
		        </c:forEach>
		        <%--
		           마지막 페이지 번호가 전체 페이지의 갯수보다 작으면 Next 링크를 제공한다. 
		        --%>
		        <c:if test="${endPageNum lt totalPageCount }">
		            <li class="page-item">
		            	<a class="page-link" href="reservationlist?${pathQuery }&pageNum=${endPageNum+1 }">Next</a>
		        	</li>
		    	</c:if>
			</ul>
		</nav>
	</div>
	<!-- 수락 / 거절 버튼 -->
	<script>
		const checkBtn = function(clickedId){
			if(clickedId.includes("pay")){
				console.log(clickedId);
				//결제O- true, 예약 취소- false
				let isPaid = clickedId.indexOf("not") == 0 ? "false" : "true";
				let reserv_num_pay = clickedId.indexOf("not") == 0 ? clickedId.substr(9) : clickedId.substr(6);
				console.log(reserv_num_pay);
				fetch("${pageContext.request.contextPath}/users/reservation/goPay?num="+reserv_num_pay+"&isPaid="+isPaid)
	              .then(function(response){
	                  console.log(response);
	                  return response.text();
	              })
	              .then(function(data){
	            	  location.reload();
	              })
			} else if(clickedId.includes("reject")){
				//수락- true, 거절- false
				let isReservOk = "false";
				//예약 번호
				let reserv_num = clickedId.substr(9);
				fetch("${pageContext.request.contextPath}/seller/reservation/check-reserv?num="+reserv_num+"&isReservOk="+isReservOk)
	              .then(function(response){
	                  console.log(response);
	                  return response.text();
	              })
	              .then(function(data){
	            	  location.reload();
	              })
			}
		}
	</script>
	<!-- footer include -->
	<jsp:include page="/WEB-INF/include/footer.jsp"/>
</body>
</html>