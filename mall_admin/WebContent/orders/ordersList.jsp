<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.vo.*" %>
<%@ page import = "gdu.mall.dao.*" %>
<%@ page import="gdu.mall.util.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Mail.Book &mdash; Website Template by Colorlib</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/fonts/icomoon/style.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/animate.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/owl.carousel.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap-datepicker.css">
    
    
    <link rel="stylesheet" href="<%=request.getContextPath()%>/fonts/flaticon/font/flaticon.css">
  
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/aos.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/jquery.fancybox.min.css">
    

    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
    
  </head>
  <body data-spy="scroll" data-target=".site-navbar-target" data-offset="300">

	<%
	System.out.println("\n----------Orderist.jsp 실행----------");

	//레벨 1 미만 보안코드
	Manager m = (Manager)session.getAttribute("sessionManager");
	if(m == null || m.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	%>
	    
	<%
	// 현재페이지
	int currentPage = 1;
	if (request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		System.out.println("-----커렌트 페이지 : "+currentPage);
	}
	
	// 페이지당 수
	int rowPerPage = 10;
	if (request.getParameter("rowPerPage") != null){
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		System.out.println("-----로우퍼 페이지 : "+rowPerPage);
	}
		
	//시작
	int beginRow = (currentPage -1) *rowPerPage ;
		
	
	%>

  <!-- 전체를 감싸는-->
  <div class="site-wrap">
  
   	<!-- 0메뉴바 div -->
	<!-- 모바일버전. 안채워둠 -->
    <div class="site-mobile-menu site-navbar-target">
      <div class="site-mobile-menu-header">
        <div class="site-mobile-menu-close mt-3">
          <span class="icon-close2 js-menu-toggle"></span>
        </div>
      </div>
      <div class="site-mobile-menu-body"></div>
    </div> <!-- .site-mobile-menu -->
    
    <!-- 데스크탑버전. -->
    <div class="site-navbar-wrap">
      <div class="site-navbar site-navbar-target js-sticky-header">
        <div class="container">
          <div class="row align-items-center">
          	<!-- 메뉴바 2개 div -->
           	<!-- 왼쪽 로고 div -->
            <div class="col-6 col-md-4 half">
              <h1 class="my-0 site-logo"><a href="<%=request.getContextPath()%>/adminIndex.jsp">Mail<span class="text-primary">.</span>book</a></h1>
            </div>
         	<!-- 오른쪽 버튼 div -->
            <!-- 관리자화면 메뉴(네비게이션) include -->
	   			<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
          </div>
        </div>
      </div>
    </div> <!-- END .site-navbar-wrap --> 
	
	<!-- 페이지 -->
		<div class="site-blocks-cover" id="home-section">
		<div class="container">
		<div class="row">
		<div class="col-md-12 ml-auto align-self-center">
	            
			<div class="intro">
				<div class="text">
					<h1 class="IN"><span class="text-primary">주문</span> 목록</h1>
	                매니저 [ <%=m.getManagerName() %> ]님, LEVEL : <%=m.getManagerLevel() %>	
	                <br>
	            </div> 
	        </div>
	             
				<!-- 글 전체 -->		       
				<div class="d-flex">   
                	<!-- 상단 몇개씩보기 -->	
                	<div class="TR">
		               	<form action="<%=request.getContextPath()%>/orders/ordersList.jsp" method="post">
							<select class="form-control IN" name="rowPerPage">
								<%
								for (int i=10; i <=30; i+=5){
									if(rowPerPage == i){
								%>
										<option value="<%=i %>" selected="selected"> <%=i %></option>
								<%
									} else {
								%>
									<option value="<%=i %>"> <%=i %></option>
								<%
									}
								}
								%>
							</select>
							<button class="btn btn-white" type="submit">보기</button>
						</form>
					</div>
	
					<!-- 테이블 -->
					<table class="table table-second table-hover TC">
						<thead>
							<th>orderNo</th>
							<th>(ebookNo) ebookTitle [ebookISBN]</th>
							<th>(clientNo) clientMail</th>
							<th>orderDate</th>
							<th>orderState수정</th>
						</thead>
						
						<tbody>
							<%
							//String searchWord ="";
							//public static ArrayList<Ebook> selectOrdersListByPage(int rowPerPage, int beginRow) throws Exception { //입력값 필요 없음
							ArrayList<OrdersAndEbookAndClient> ordersList = OrdersDao.selectOrdersListByPage(beginRow,rowPerPage);
				
								for(OrdersAndEbookAndClient oec : ordersList){
								System.out.println(oec.getOrders().getOrdersNo()+"<---주문번호");
							%>
								<tr>
									<td><%=oec.getOrders().getOrdersNo()%></td>
									<td>
									
									<a href="<%=request.getContextPath()%>/ebook/ebookOne.jsp?ebookISBN=<%=oec.getEbook().getEbookISBN()%>">
									(<%=oec.getOrders().getEbookNo()%>) <%=oec.getEbook().getEbookTitle()%>  [﻿<%=oec.getEbook().getEbookISBN()%>]
									</a>
									</td>
									<td>(<%=oec.getOrders().getClientNo()%>) <%=oec.getClient().getClientMail()%></td>
									<td><%=oec.getOrders().getOrdersDate()%></td>
									<td>
										<form action="<%=request.getContextPath()%>/orders/updateOrdersAction.jsp" method="post">
										<%=oec.getOrders().getOrdersState()%>
										
										<input type="hidden" name="ordersNo" value="<%=oec.getOrders().getOrdersNo()%>">
										<select name="ordersState">
											<option value="결제확인">결제확인</option>
											<option value="배송완료">배송완료</option>
											<option value="주문요청">취소요청</option>
											<option value="취소완료">취소완료</option>
										</select>
										<button class="btn btn-primary" type="submit">승인</button>
										</form>
									</td>
								</tr>
							<%
								}//for끝
							%>
						</tbody>
					</table>
					
					<!-- 페이징 -->
					<div>
					<%
					if(currentPage > 1){//현재 페이지가 1보다 크면 이전이 나오게 해라.
					%>
					<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>">이전</a>
					<%      
					}//이전 if 끝
					%>
					      
					      
					<%
					int totalRow = OrdersDao.totalCount(); //메서드활용
					int lastPage = totalRow/rowPerPage;
					System.out.println("\t total Row : "+ totalRow);
					System.out.println("\t last Page : "+ lastPage);
					        
					    
					if (totalRow% rowPerPage !=0){ //현재 페이지가 전체게시글/페이지행 몫이 딱 떨어지거나. 몫보다 클때.
						lastPage += 1;  // 잘안씀 lastPage - lastPage+1; lastPage++
					}//보드 케이블의 총 행수 구하는 if 끝
					         
					if(currentPage<lastPage) {//현재 페이지가 라스트 페이지보다 작으면 다음이 나오게 해라.
					%>
					
					<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>">다음</a>
					
					<% 
					}//다음 if끝
					%>
					</div>
		
		</div>
		
		</div> <!-- <div class="site-blocks-cover" id="home-section">-->
		</div> <!-- <div class="container">-->
		</div> <!-- <div class="row">-->
		</div> <!--  <div class="col-md-12 ml-auto align-self-center">-->
	
	</div>
</body>
</html>