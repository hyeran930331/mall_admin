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
	System.out.println("\n----------noticeList.jsp 실행----------");
	
	//레벨 1 미만 보안코드
	Manager m = (Manager)session.getAttribute("sessionManager");
	if(m == null || m.getManagerLevel() < 1){
		return;
	}
	%>
	<%
	//페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		System.out.printf("currentPage: %s<noticeList.jsp>\n",currentPage);
	}
		
	//페이지당 행의 수
	int rowPerPage = 10;
	if(request.getParameter("rowPerPage") != null){
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		System.out.printf("rowPerPage: %s<noticeList.jsp>\n",rowPerPage);
	}
			
	//시작 행
	int beginRow = (currentPage - 1) * rowPerPage;
		
	//Dao에서 게시글 호출 , noticeList
	ArrayList<Notice> list = NoticeDao.selectNoticeList(beginRow, rowPerPage);
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
	              	<h1 class="IN"><span class="text-primary">공지</span> 목록</h1>
	                매니저 [ <%=m.getManagerName() %> ]님, LEVEL : <%=m.getManagerLevel() %>	
					
	                <div class="TR">
	                 <a class="btn btn-primary" href ="<%=request.getContextPath()%>/notice/insertNoticeForm.jsp">공지추가</a>
	                </div>
	                <br>
				</div> 
			</div>
	             
			<!-- 글 전체 -->		       
			<div class="d-flex">   
				<!-- 상단 몇개씩보기 -->	
	            <div>
			    <form action="<%=request.getContextPath()%>/ebook/ebookList.jsp" method="post">
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
	
				<!-- 게시판 시작 -->
				<table class="table table-second table-hover TC">
					<thead>
						<tr>
							<th>noticeNo</th>
							<th>noticeTitle</th>
							<th>managerId</th>
							<th>noticeDate</th>
							<th>삭제</th>
						</tr>
					</thead>
					
					<tbody>
						<%
						for(Notice n : list){
						%>
						<tr>
							<td><%=n.getNoticeNo()%></td>
							<td><a href="<%=request.getContextPath()%>/notice/noticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>"><%=n.getNoticeTitle()%></a></td>
							<td><%=n.getManagerId()%></td>
							<td><%=n.getNoticeDate()%></td>
							<td><a class="btn btn-info" href="<%=request.getContextPath()%>/notice/deleteNoticeAction.jsp?noticeNo=<%=n.getNoticeNo()%>">삭제</a></td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
				
				<!-- 페이징 -->
				<!-- 이전버튼 -->
				<%
				if(currentPage > 1){ //현재페이지가 1일때 if
				%>
					<a href = "<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>">이전</a>
				<%
				}//if 끝
				%>
				
				<% 
				int totalRow = NoticeDao.totalCount();
				int lastPage = totalRow/rowPerPage ;
					
				if(totalRow  %rowPerPage != 0){//전체페이지가 나누어 떨어지지 않으면if
					lastPage += 1;
				}//if끝
						
				//다음버튼 만들기
				if(currentPage < lastPage){//현재페이지가 마지막 페이지보다 작으면
				%>
					<!-- 다음버튼 -->
					<a href = "<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>">다음</a>
				<%		
				} //if끝
				%>
				</div>
				
		</div> <!-- <div class="site-blocks-cover" id="home-section">-->
		</div> <!-- <div class="container">-->
		</div> <!-- <div class="row">-->
		</div> <!--  <div class="col-md-12 ml-auto align-self-center">-->
	
	</div>
	
</body>
</html>