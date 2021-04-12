<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <div class="col-6 col-md-8">
   <nav class="site-navigation text-right" role="navigation">
      <div class="container">
          <div class="d-inline-block d-lg-block ml-md-0 mr-auto py-3">
            <a href="#" class="site-menu-toggle js-menu-toggle text-black">
            	<span class="icon-menu h3"></span> <span class="menu-text">Menu</span>
            </a>
          </div>           
		  <ul class="site-menu main-menu js-clone-nav d-none d-lg-none">
		 	 <li><a href="<%=request.getContextPath()%>/adminIndex.jsp" class="nav-link">홈</a></li>
			 <li><a href="<%=request.getContextPath()%>/manager/managerList.jsp" class="nav-link">관리자 승인</a></li>
			 <li><a href="<%=request.getContextPath()%>/client/clientList.jsp" class="nav-link">고객 관리</a></li>
			 <li><a href="<%=request.getContextPath()%>/category/categoryList.jsp" class="nav-link">카테고리 관리</a></li>
		 	<li><a href="<%=request.getContextPath()%>/ebook/ebookList.jsp" class="nav-link">Ebook 관리</a></li>
		 	<li><a href="<%=request.getContextPath()%>/notice/noticeList.jsp" class="nav-link">공지 관리</a></li>
		 	<li><a href="<%=request.getContextPath()%>/orders/ordersList.jsp" class="nav-link">주문 관리</a></li>
		 	<li><a href="<%=request.getContextPath()%>/manager/logoutManagerAction.jsp" class="nav-link">로그아웃</a></li>
		 </ul>     
	</div>
  </nav>
</div>