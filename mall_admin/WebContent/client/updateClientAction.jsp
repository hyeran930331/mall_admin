<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
    
	<%
	request.setCharacterEncoding("UTF-8");
	System.out.println("----------updateClientAction.jsp 실행 ---------");
	%>
	
	<%
	// 0. 전처리 레벨2 이하 접근제한
	Manager m = (Manager)(session.getAttribute("sessionManager"));
	if(m==null){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if(m.getManagerLevel() < 2){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	%>
	
	<%
	request.setCharacterEncoding("utf-8");
	%>
	
	<%
	// 수집 코드 
	int clientNo = Integer.parseInt(request.getParameter("clientNo"));
	String clientNewMail = request.getParameter("clientNewMail");
	String clientPw = request.getParameter("clientPw");
	System.out.println(clientNo+"<-- param clientNo");//디버깅
	
	// dao 수정 메서드 호출
	ClientDao.updateClient(clientNewMail, clientPw, clientNo);
	
	// 수정 완료 시 client.clientList로 
	response.sendRedirect(request.getContextPath()+"/client/clientList.jsp");
%>