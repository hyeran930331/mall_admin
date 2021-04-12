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
	request.setCharacterEncoding("utf-8");
	%>
	<%
	System.out.println("\n----------insert Ebookt Form.jsp 실행----------");
	
	// 세션 검사 관리자 권한 1 이상만 볼 수 있도록.
	Manager m = (Manager)session.getAttribute("sessionManager");
	if(m == null || m.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	%>
	<!-- 3. 출력 -->
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
					<h1 class="IN"><span class="text-primary">Ebook</span> 등록</h1>
	                매니저 [ <%=m.getManagerName() %> ]님, LEVEL : <%=m.getManagerLevel() %>	
	                <br>
	                <a class="btn btn-success" href="<%=request.getContextPath()%>/ebook/ebookOne.jsp?ebookISBN=<%=e.getEbookISBN()%>">돌아가기</a>
				</div> 
			</div>
	             
			<!-- 글 전체 -->		       
			<div class="d-flex TR">   
			<!-- 1 테이블 -->  
			<form action="<%=request.getContextPath()%>/ebook/insertEbookAction.jsp">
				<button class="btn btn-primary" type="submit">이북추가</button>
				<table class="table table-second table-hover TC">
					<tr>
						<th> <!-- 0 -->
							categoryName
						</th>
						
						<td>
						<!-- 카테고리 눌렀을 때, 카테고리별로 리스트를 나오게 함 (네비게이션) -->
						<div>	
							<%
							//public static ArrayList<String> categoryNameList() throws Exception{
							ArrayList<String> list3 = CategoryDao.categoryNameList();
							System.out.println(list3.size()+"<---카테고리네임리스트 크기");
							%>
							
							<select name="categoryName">	
							<%
							for(String ct : list3){
							%>
								<option value="<%=ct%>"><%=ct%></option>
							<%
							}
							%>
							</select>
						</div>
						</td>
					</tr>
			
					<tr> <!-- 1 -->
						<th>
							ebookISBN
						</th>
						<td>
							<input type="text" name="ebookISBN">
						</td>
					</tr>
			
					<tr> <!-- 2 -->
						<th>
							ebookTitle
						</th>
						<td>
							<input type="text" name="ebookTitle">
						</td>
					</tr>
					
					<tr> <!-- 3 -->
						<th>
							ebookAuthor
						</th>
						<td>
							<input type="text" name="ebookAuthor">
						</td>
					</tr>
					
					<tr> <!-- 4 -->
						<th>
							ebookPrice
						</th>
						<td>
							<input type="text" name="ebookPrice">
						</td>
					</tr>
					
					<tr> <!-- 5 -->
						<th>
							ebookCompany
						</th>
						<td>
							<input type="text" name="ebookCompany">
						</td>
					</tr>
					
					<tr> <!-- 6 -->
						<th>
							ebookPageCount
						</th>
						<td>
							<input type="text" name="ebookPageCount">
						</td>
					</tr>
					
					<tr> <!-- 7 -->
						<th>
							ebookSummary
						</th>
						<td>
							<textarea rows="5" cols="80" name="ebookSummary"> </textarea>
						</td>
					</tr>
			
			<!-- 이미지, 스테이트, 데이트, 번호는 자동생성  -->
		</table>
		</form>
	
		</div> <!-- <div class="site-blocks-cover" id="home-section">-->
		</div> <!-- <div class="container">-->
		</div> <!-- <div class="row">-->
		</div> <!--  <div class="col-md-12 ml-auto align-self-center">-->
	
	</div>
	
</body>
</html>