<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.Manager" %>
<%@ page import="gdu.mall.dao.ManagerDao" %>
<%
	System.out.println("-------------login Manager Action.jsp 실행 -------------");

	// 1. 요청 수집(전처리)
	String managerId = request.getParameter("managerId");
	String managerPw = request.getParameter("managerPw");
	System.out.println("\t "+managerId+" <-- param managerId");
	System.out.println("\t "+managerPw+" <-- param managerPw");
	
	// 2. 처리
	Manager manager = ManagerDao.login(managerId, managerPw);
	System.out.println("----- 목록에 있으면 @/없으면 null : "+manager);
	if(manager != null) {
		System.out.println("-----로그인 성공!");
		session.setAttribute("sessionManager", manager);
	} else {
		System.out.println("-----로그인 실패");
	}
	
	// 3. 출력 or 재요청(redirect)
	response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
%>