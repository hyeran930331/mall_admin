<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.vo.*" %>
<%@ page import = "gdu.mall.dao.*" %>
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
	System.out.println("----------매니저 리스트 실행----------");
	
	// 0. 전처리 레벨1 미만 접근제한
	Manager mm = (Manager)(session.getAttribute("sessionManager"));
	if(mm==null){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if(mm.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	%>
  <!-- 전체를 감싸는-->
   <div class="site-wrap">
    <div class="site-mobile-menu site-navbar-target">
      <div class="site-mobile-menu-header">
        <div class="site-mobile-menu-close mt-3">
          <span class="icon-close2 js-menu-toggle"></span>
        </div>
      </div>
      <div class="site-mobile-menu-body"></div>
    </div> <!-- .site-mobile-menu -->
    
    
    <div class="site-navbar-wrap">
      
      <div class="site-navbar site-navbar-target js-sticky-header">
        <div class="container">
          <div class="row align-items-center">
            <div class="col-6 col-md-4">
              <h1 class="my-0 site-logo"><a href="<%=request.getContextPath()%>/adminIndex.jsp">Mail<span class="text-primary">.</span>book</a></h1>
            </div>
		       <!-- include -->
		        <jsp:include page="/inc/adminMenu.jsp"></jsp:include>
          </div>
        </div>
      </div>
    </div> <!-- END .site-navbar-wrap -->  
	
	<!-- 페이지 -->
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

	//검색어
	String searchWord = "";
	if(request.getParameter("searchWord") != null){
		searchWord = request.getParameter("searchWord");
		System.out.printf("searchWord: %s <managerList.searchWord> \n",searchWord);
	}	
	%>
	  <!-- 1 매니저-->
	  <div class="site-blocks-cover" id="home-section">
	      <div class="container">
	        <div class="row">
	          
	          <div class="col-md-12 ml-auto align-self-center">
	            <div class="intro">
	              <div class="text">
	              	<h1><span class="text-primary">관리자</span> 승인</h1>
	                <br>
	                
	                <div>
	                 <h3 class="TR">ID와 Name을 확인하고 선택적으로 승인해주세요.</h3>
	                 <form class="TR" action="<%=request.getContextPath()%>/manager/managerList.jsp" method="post">
						<input type="hidden" name="rowPerPage" value="<%=rowPerPage%>">
							managerId:
						<input type="text" name="searchWord">
						<button class="btn btn-danger" type="submit">검색</button>
					</form>	
	                </div>
	                
	                   <!-- 매니저 글 전체 -->
				       
				       <div class="d-flex">   
				       	<!-- 1 테이블 -->         			              
						<table class="table table-second table-hover TC">
							<thead>
							<tr>
								<th>managerNo</th>
								<th><span class="text-primary">managerId</span></th>
								<th><span class="text-primary">managerName</span></th>
								<th>managerDate</th>
								<th>managerLevel</th>
								<th>레벨</th>
								<th>삭제 </th>
							</tr>
							</thead>
							
							<tbody>
							<%
								ArrayList<Manager> list = ManagerDao.selectManagerList(beginRow,rowPerPage,searchWord);
								for (Manager m : list) { //첫번째for
							%>
								<tr>
									<td><%=m.getManagerNo()%></td>
									<td><span class="text-primary"><%=m.getManagerId()%></span></td>
									<td><span class="text-primary"><%=m.getManagerName()%></span></td>
									<td><%=m.getManagerDate()%></td>
									<td><%=m.getManagerLevel()%></td>
									<td>
										<form action="<%=request.getContextPath()%>/manager/updateManagerLevelAction.jsp" method="post">
											<input type="hidden" name="managerNo" value="<%=m.getManagerNo()%>">
											<div class="input-group input-group-sm mb-3 input-group-prepend">
 											  <select name="managerLevel"  class="custom-select"  id="inputGroup-sizing-sm">
												<%
													for (int i=0; i<3; i++){//두번째 셀렉트반복 for
														if (m.getManagerLevel() == i) {
												%>		
															<option value="<%=i%>" selected="selected"> <%=i%></option>
												<%		
														} else {
												%>
															<option value="<%=i%>"> <%=i%></option>
												<%
														}//if
													}//두번째 포for
												%>
											 </select>
												 <div class="input-group-append">
	   											 <button class="btn btn-white" type="submit">승인</button>
												 </div>
											</div>
										</form>
									</td>
									<td class="input-group input-group-sm mb-3">
										<button class="btn btn-info" id="inputGroup-sizing-sm">
											<a href="<%=request.getContextPath()%>/manager/deleteManagerAction.jsp?managerNo=<%=m.getManagerNo()%>">삭제</a>
										</button>
									</td>
								</tr>
							<%
								}//첫번째 전체 for
							%>
							</tbody>
						</table> <!-- 매니저 테이블 끝 -->
						</div><!-- <div class="d-flex"> -->
	             </div> <!-- <div class="text"> -->
	          </div> <!-- <div class="intro"> -->
	          
	          
			<!-- 페이징 -->
							<%
								if(currentPage > 1){//현재 페이지가 1보다 크면 이전이 나오게 해라.
							%>
								<a href ="<%=request.getContextPath()%>/manager/managerList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">				이전
								</a>
							<%      
								}//이전 if 끝
							%>
							      
							      
							<%
								int totalRow = ManagerDao.totalCount(); //메서드활용
								int lastPage = totalRow/rowPerPage;
								System.out.println("\t total Row : "+ totalRow);
								System.out.println("\t last Page : "+ lastPage);
							        
							    
								if (totalRow% rowPerPage <1){ //현재 페이지가 전체게시글/페이지행 몫이 딱 떨어지거나. 몫보다 클때.
									lastPage += 1;  // 잘안씀 lastPage - lastPage+1; lastPage++
								}//보드 케이블의 총 행수 구하는 if 끝
							         
								if(currentPage<lastPage) {//현재 페이지가 라스트 페이지보다 작으면 다음이 나오게 해라.
							%>
								<a href ="<%=request.getContextPath()%>/manager/managerList.jsp?currentPage=<%=currentPage+1 %>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">
									다음
								</a>
							<% 
								}//다음 if끝
							%>
	               
	        </div> <!-- <div class="col-md-12 ml-auto pt-5 mt-5 align-self-center"> -->
	      </div> <!-- <div class="row"> -->
	    </div> <!-- <div class="container"> -->
	  </div> <!-- 매니저글 end --> <!--  <div class="site-blocks-cover" id="home-section"> -->            
	             


<div>
	<footer>
        <div class="row pt-5 mt-5 text-center d-flex">
          <div class="col-md-12">

            <p>
              <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
            Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="icon-heart text-danger" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank" >Colorlib</a>
            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
            </p>
          </div>
        </div>
    </footer>
</div>

<!-- js script -->
<div>
  <script src="js/jquery-3.3.1.min.js"></script>
  <script src="js/popper.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/owl.carousel.min.js"></script>
  <script src="js/aos.js"></script>
  <script src="js/jquery.sticky.js"></script>
  <script src="js/stickyfill.min.js"></script>
  <script src="js/jquery.easing.1.3.js"></script>
  <script src="js/isotope.pkgd.min.js"></script>
  
  <script src="js/jquery.fancybox.min.js"></script>
  <script src="js/main.js"></script>
</div>
     
  </body>
</html>