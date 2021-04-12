<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.vo.*" %>
<%@ page import = "gdu.mall.dao.*" %>
<%@ page import = "gdu.mall.util.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Mail.Book &mdash; Website Template by Colorlib</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900" rel="stylesheet">
    <link rel="stylesheet" href="fonts/icomoon/style.css">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/animate.css">
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/owl.theme.default.min.css">
    <link rel="stylesheet" href="css/bootstrap-datepicker.css">
    
    
    <link rel="stylesheet" href="fonts/flaticon/font/flaticon.css">
  
    <link rel="stylesheet" href="css/aos.css">
    <link rel="stylesheet" href="css/jquery.fancybox.min.css">
    

    <link rel="stylesheet" href="css/style.css">
    
  </head>
  <body data-spy="scroll" data-target=".site-navbar-target" data-offset="300">
  


  <div class="site-wrap">

 	<%
	System.out.println("----------admin Index. jsp 실행 ----------");
	if(session.getAttribute("sessionManager") == null)
	
	{ //session객체를 활용해서 "sessionManager"에 저장한 값을 가져오는데 그게 null이면,
	%>
	
	<!-- if null 절을 감싸는  -->
   <div>
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
		    <div class="col-8 col-md-8 mb-5 t-14">
			</div>
          </div>
        </div>
      </div>
    </div> <!-- END .site-navbar-wrap --> 
				
	  <!-- 1로그인 + 2manager level=0 -->
	  <!-- 1로그인 -->
	  <div class="site-blocks-cover" id="home-section">
	      
	      <div class="img-wrap">
	        <div class="owl-carousel slide-one-item hero-slider">
	          <div class="slide">
	            <img src="images/glint_hero_1.jpg" alt="Image">  
	          </div>
	          <div class="slide">
	            <img src="images/glint_hero_2.jpg" alt="Image">  
	          </div>
	          <div class="slide">
	            <img src="images/glint_hero_3.jpg" alt="Image">  
	          </div>
	        </div>
	      </div>
	      
	      <div class="container">
	        <div class="row">
	          <div class="col-md-6 ml-auto align-self-center">
	            <div class="intro">
	            
	              <div class="heading">
	                <h1>매일<span class="text-primary">.</span>북</h1>
	              </div>
	              
	              <div class="text">
	                <h3>Mail을 이용해 책을 <br>어디서든 매일 book</h3>
	              	<br>
	              	<br>
	              	<h2 class="title text-primary mb-3">관리자 로그인</h2>
				    
				       <div class="d-flex">              
				              <form action="<%=request.getContextPath()%>/manager/loginManagerAction.jsp" method="post" class="form-subscribe">
				                <div class="form-group mb-3">
				                  <input type="text"  name="managerId" class="form-control border-white text-white bg-transparent" 
				                 name="managerId" placeholder="ManagerID" aria-describedby="button-addon2">
				                </div>
				                <div class="form-group mb-3">
				                  <input type="password" class="form-control border-white text-white bg-transparent" 
				                  name="managerPw" placeholder="Enter Password" aria-describedby="button-addon2">
				                </div>
				                <div class="form-group">
				                  <button class="btn btn-primary px-5" type="submit">&nbsp;관리자  로그인&nbsp;</button>
				                </div>
				              </form>
				            </div>
				            
				   	<p><a href="<%=request.getContextPath()%>/manager/insertManagerForm.jsp" class="btn btn-primary px-5">관리자가입신청</a></p>
	
	              </div>
	            </div>
	          </div>
	        </div>
	      </div>
	    </div> <!-- END .site-blocks-cover -->
	    
	    <!-- 2manager level=0 -->
		<div class="site-section bg-light" id="manager_level=0">
		<div class="container">
			
			<div class="row mb-5 ">
	          <div class="col-md-7 section-title text-center mx-auto">
	            <span class="sub-title mb-2 d-block">manager_level = 0</span>
	            <h2 class="title text-primary mb-3">승인대기 목록</h2>
	          </div>
	        </div>
	      	
	      	<div class="row">
		      <%
		      //public static ArrayList<Manager> selectManagerListByZero()
		     ArrayList<Manager> manager = ManagerDao.selectManagerListByZero();
              %>
				
			<%
			//이미지가 3,4만 쓰고싶어서
			int c = 0;
			int i = 0;
			for(Manager man: manager){
				c += 1;
				i = (c%2)+3;
			%>
			<!-- 리스트 -->
				<div class="col-lg-6 mb-4">
				<div class="testimonial bg-white h-100">
				<div class="d-flex align-items-center vcard">
					<figure class="mb-0 mr-3">
		        	  <img src="images/person_<%=i%>.jpg" alt="Image" class="img-fluid ounded-circle">
		            </figure>
					<div class="vcard-text">
			            <span class="d-block"><%=man.getManagerId()%></span>
			            <span class="position"><%=man.getManagerDate()%></span>
					</div>
				</div>
		        </div>
				</div>
			<%
			}
			%>  
			</div> <!-- row -->
			
		</div> <!-- container -->
		</div> <!-- site session-->
		
   </div>
   
   <% 
   } else { //null값이 아니면, 로그인성공.
	// session앞에 형변한 연산자() 사용!
   Manager manager = (Manager)(session.getAttribute("sessionManager"));
   %>
   
   <!-- else 절을 감싸는 -->
   <div>
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
    
   <!-- 1로그인성공안내 + 2최근이슈5개씩 -->
   <!-- 1로그인성공안내 -->
	<div class="site-blocks-cover" id="home-section">
	  
	  <div class="img-wrap">
		<div class="owl-carousel slide-one-item hero-slider">
	 	  <div class="slide">
			 <img src="<%=request.getContextPath()%>/images/glint_hero_1.jpg" alt="Image">  
		  </div>
	  	  <div class="slide">
		 	<img src="<%=request.getContextPath()%>/images/glint_hero_2.jpg" alt="Image">  
	  	  </div>
	    <div class="slide">
			<img src="<%=request.getContextPath()%>/images/glint_hero_3.jpg" alt="Image">  
	    </div>
		</div>
	  </div>
	  
	  <div class="container">
		<div class="row">
		  <div class="col-md-6 ml-auto align-self-center">
		   <div class="intro">
		
		    <div class="heading">
				<h1>매일<span class="text-primary">.</span>북</h1>
		    </div>
		  	<div class="text">
		     <h3>Mail을 이용해 책을 <br>어디서든 매일 book</h3>
		  	 <br>
		  	 <br>
		  	 <br>
		  	 <br>
		  	 
			</div>
			<h2 class="title text-primary mb-3">
				<%=manager.getManagerName() %>님 반갑습니다.
				<br>
				LEVEL : <%=manager.getManagerLevel() %>	
			 </h2>
		   </div>
		   <a href="<%=request.getContextPath()%>/manager/logoutManagerAction.jsp" class="btn btn-primary px-5">로그아웃</a>
		  </div>
		</div>
	  </div>
	</div> <!-- END .site-blocks-cover -->
	
   <!-- 2최근이슈 -->
	<div class="site-section" id="what-we-do-section">		

	<%
	ArrayList<Notice> noticeList = NoticeDao.selectNoticeList(0, 5);
	ArrayList<Manager> managerList = ManagerDao.selectManagerList(0, 5, "");
	ArrayList<Client> clientList = ClientDao.selectClientListByPage(0, 5, "");//.
	ArrayList<Ebook> ebookList = EbookDao.selectEbookListByPage(0, 5, "");
	//public static ArrayList<OrdersAndEbookAndClient> selectOrdersListByPage(int beginRow, int rowPerPage) throws Exception{
	ArrayList<OrdersAndEbookAndClient> oecList = OrdersDao.selectOrdersListByPage(0, 5);
	%>
    
      <div class="container">
        <div class="row mb-5">
          <div class="col-lg-6 section-title">
            <span class="sub-title mb-2 d-block">최근 이슈</span>
            <h2 class="title text-primary">최근 5개 중요이슈</h2>
          </div>
        </div>
        
          <div class="col-lg-10 ml-auto">
            <div class="row">
            
            <!-- 매니저 목록 -->
              <div class="col-md-6 col-lg-4 mb-4 mb-lg-4">
                <div class="service h-100 bg-op">
                  <h3>managerList <a class="readmore" href="<%=request.getContextPath()%>/manager/managerList.jsp">more</a></h3>
                  <table class="table table-hover bl">
						<tr class="thead-light">
							<th><h3>Id</h3></th>
							<th><h3>Name</h3></th>
						</tr>		
						<%
						for(Manager mm: managerList){
						%>
						<tr scope="row">
							<td><h3><%=mm.getManagerId()%></h3></td>
							<td><h3><%=mm.getManagerName()%></h3></td>
						</tr>
						<%
						}
						%>
					</table>
                </div>
              </div>
              
             <!-- 고객 목록 -->
              <div class="col-md-6 col-lg-4 mb-4 mb-lg-4">
                <div class="service h-100">
                  <h3>clientList <a class="readmore" href="<%=request.getContextPath()%>/client/clientList.jsp">more</a> </h3>
                  <table class="table table-hover">
						<tr class="thead-light">
							<th><p>No</p></th>
							<th><p>Date</p></th>
						</tr>		
						<%
						for(Client c: clientList){
						%>
						<tr scope="row">
							<td><p><%=c.getClientNo()%></p></td>
							<td><p><%=c.getClientDate()%></p></td>
						</tr>
						<%
						}
						%>
					</table>
                </div>
              </div>
              
             <!-- Ebook 목록 -->
              <div class="col-md-6 col-lg-4 mb-4 mb-lg-4">
                <div class="service h-100">
                  <h3>ebookList <a class="readmore" href="<%=request.getContextPath()%>/ebook/ebookList.jsp">more</a> </h3>
                  <table class="table table-hover">
						<tr class="thead-light">
							<th><p>No</p></th>
							<th><p>Title</p></th>
						</tr>		
						<%
						for(Ebook e: ebookList){
						%>
						<tr scope="row">
							<td><p><%=e.getEbookNo()%></p></td>
							<td><p><%=e.getEbookTitle()%></p></td>
						</tr>
						<%
						}
						%>
					</table>
                </div>
              </div>
              
              <!-- 주문목록 -->
              <div class="col-md-6 col-lg-6 mb-4 mb-lg-4">
                <div class="service h-100 bg-op">
					<h3>ordersList <a class="readmore" href="<%=request.getContextPath()%>/orders/ordersList.jsp">more</a> </h3> 
					<table class="table table-hover bl">
						<tr class="thead-light">
							<th><h3>No</h3></th>
							<th><h3>Title</h3></th>
							<th><h3>Date</h3></th>
						</tr>		
						<%
						for(OrdersAndEbookAndClient oec: oecList){
						%>
						<tr scope="row">
							<td><h3><%=oec.getOrders().getOrdersNo()%></h3></td>
							<td><h3><%=oec.getEbook().getEbookTitle()%></h3></td>
							<td><h3><%=oec.getOrders().getOrdersDate()%></h3></td>
						</tr>
						<%
						}
						%>
					</table>
					</div>
				</div>
            
            
              <!-- 공지목록 -->
              <div class="col-md-6 col-lg-6 mb-4 mb-lg-4">
                <div class="service h-100">
					<h3>noticeList <a class="readmore" href="<%=request.getContextPath()%>/notice/noticeList.jsp">more</a> </h3> 
					<table class="table table-hover">
						<thead class="thead-light">
						<tr>
							<th><p>Date</p></th>
							<th><p>Title</p></th>
							<th><p>ID</p></th>
							
						</tr>
						</thead>		
						<%
						for(Notice n: noticeList){
						%>
						<tr scope="row">
							<td><p><%=n.getNoticeDate()%></p></td>
							<td><p><%=n.getNoticeTitle()%></p></td>
							<td><p><%=n.getManagerId()%></p></td>
						</tr>
						<%
						}
						%>
					</table>
					</div>
				</div>
				
            </div> <!-- row -->
          </div> <!-- 글자칸 -->
        </div> <!-- 전체컨테이너 -->
        
      </div> <!-- 최근이슈 -->
    </div> <!-- else 절 END .site-section -->
   <%
   }
   %>
</div>   
<div>
	<footer>
        <div class="row pt-5 mt-5 text-center">
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