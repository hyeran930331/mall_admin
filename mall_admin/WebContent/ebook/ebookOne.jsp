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
	<!-- 보안코드 -->
	<%
	System.out.println("\n----------EbookOne.jsp 실행----------");
	
	// 세션 검사 관리자 권한 1 이상만 볼 수 있도록.
	Manager m = (Manager)session.getAttribute("sessionManager");
	if(m == null || m.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	//수집
	String ebookISBN = request.getParameter("ebookISBN");
	System.out.printf("ebookISBN: %s<ebookOne.jsp>\n",ebookISBN);
		
	
	//dao연결
	Ebook e = EbookDao.selectEbookOne(ebookISBN);
	System.out.println("\t"+e.getEbookISBN()+"<----ebookISBN");
	System.out.println("\t"+e.getEbookState()+"<----ebookState");
	System.out.println("\t"+e.getEbookSummary()+"<----ebookSummary");

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
					<h1 class="IN"><span class="text-primary">ebook</span> 상세</h1>
	                매니저 [ <%=m.getManagerName() %> ]님, LEVEL : <%=m.getManagerLevel() %>	
	                <br>
	                <a class="btn btn-success" href="<%=request.getContextPath()%>/ebook/ebookList.jsp">돌아가기</a>
	            </div> 
	        </div>
	             
			<!-- 글 전체 -->		       
			<div class="d-flex">   
				<!-- 1 테이블 -->  
				<table class="table table-second table-hover TC">
					<tr>
						<th>ebookNO</th>
						<td><%=e.getEbookNo()%></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th>categoryName</th>
						<td><%=e.getCategoryName()%></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th>ebookTitle</th>
						<td><%=e.getEbookTitle()%></td>
						<td>&nbsp;</td>
					</tr>
					
					<tr>
					<form action="<%=request.getContextPath()%>/ebook/updateEbookStateAction.jsp?">
						<th>ebookState</th>
						<td>
							<%=e.getEbookState()%> : 
							<input type="hidden" value="<%=ebookISBN%>" name="ebookISBN">
							<select name="ebookState">
									<option value="판매중">판매중</option>
									<option value="품절">품절</option>
									<option value="절판">절판</option>
									<option value="구편절판">구편절판</option>
							</select>
						</td>
						<td>
							<button class="btn btn-white" type="submit">책상태 수정</button>
						</td>
					</form>
					</tr>
					
					<tr>
						<th>ebookAuthor</th>
						<td><%=e.getEbookAuthor()%></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th>ebookImg</th>
						<td><img width="125px" height="150px" src="<%=request.getContextPath()%>/img/<%=e.getEbookImg()%>"></td>
						<td>
							<a class="btn btn-white" href="<%=request.getContextPath()%>/ebook/updateEbookImgForm.jsp?ebookISBN=<%=e.getEbookISBN()%>">이미지 수정</a>
						</td>
					</tr>
					<tr>
						<th>ebookISBN</th>
						<td><%=e.getEbookISBN()%></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th>ebookCompany</th>
						<td><%=e.getEbookCompany()%></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th>ebookDate</th>
						<td><%=e.getEbookDate()%></td>
						<td>&nbsp;</td>
					</tr>
					
					<tr>
					<form action="<%=request.getContextPath()%>/ebook/updateEbookSummaryAction.jsp">
						<th>ebookSummary</th>
						<td>
							<input type="hidden" value="<%=e.getEbookISBN()%>" name="ebookISBN">
							<textarea cols="50" rows="5" name="ebookSummary"><%=e.getEbookSummary()%></textarea>
						</td>
						<td>
							<button class="btn btn-white" type="submit">책요약 수정</button>
						</td>
					</form>		
					</tr>
					
					
					<tr>
						<th>ebookPrice</th>
						<td><%=e.getEbookPrice()%></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th>ebookPageCount</th>
						<td><%=e.getEbookPageCount()%></td>
						<td>&nbsp;</td>
					</tr>
				</table>
	
				<a class="btn btn-primary" href="<%=request.getContextPath()%>/ebook/updateEbookForm.jsp?ebookISBN=<%=e.getEbookISBN()%>">전체 수정(이미지 제외)</a>
				
				<a class="btn btn-info" href="<%=request.getContextPath()%>/ebook/deleteEbookAction.jsp?ebookISBN=<%=e.getEbookISBN()%>">삭제</a>
				
		</div> <!-- <div class="site-blocks-cover" id="home-section">-->
		</div> <!-- <div class="container">-->
		</div> <!-- <div class="row">-->
		</div> <!--  <div class="col-md-12 ml-auto align-self-center">-->
	
	</div>
	
</body>
</html>