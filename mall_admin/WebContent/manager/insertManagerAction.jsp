<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="gdu.mall.dao.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매니저 인설트 액션</title>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	%>

	<%
	System.out.println("-------------insert Manager Action.jsp 실행 -------------");
	// 1.수집
	String managerId = request.getParameter("managerId");
	String managerPw = request.getParameter("managerPw");
	String managerName = request.getParameter("managerName");

	System.out.printf("ID: %s, pw: %s, name: %s\n",managerId, managerPw, managerName);
	
	// 2-1. 중복된 아이디가 있다면, null이 아니면 사용불가.
	String returnManagerId = ManagerDao.selectManagerId(managerId);
	
	if(returnManagerId != null) { //리턴값이 null이 아니라면, 사용중인아이디
		System.out.println(managerId+"사용중인 아이디 입니다");
		response.sendRedirect(request.getContextPath()+"/manager/insertManagerForm.jsp");
		return; // 더이상 코드를 진행안하고 끝낸다.
	} else {
		// 2-2. 중복된 아이디가 없다면,
		System.out.println(managerId+"사용 가능한 아이디 입니다");
		ManagerDao.insertManager(managerId, managerPw, managerName);
	}
	%>
	<!-- 3. 출력 -->
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
          </div>
        </div>
      </div>
    </div> <!-- END .site-navbar-wrap --> 
    
    <!-- 1 매니저-->
	  <div class="site-blocks-cover" id="home-section">
	   <div class="container">
	    <div class="row">
	          
	          <div class="col-md-12 ml-auto align-self-center">
	           <div class="intro">
	            <div class="text">
	              	
	              	<h1>매니저 등록 <span class="text-primary">성공, 승인 후</span> 사용 가능합니다. <a class="btn btn-primary" href="<%=request.getContextPath()%>/adminIndex.jsp#manager_level=0"> 확인하러 </a></h1>
					
			    </div>
			   </div>
			  </div>
			 
		</div>
	   </div>
	  </div>
</body>
</html>