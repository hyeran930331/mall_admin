<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
	<%
	request.setCharacterEncoding("UTF-8");
	System.out.println("\n----------deleteClientAction.jsp 실행 ---------");
	%>
	
	<%
	// 0. 전처리 레벨2 이하 접근제한
	Manager m = (Manager)(session.getAttribute("sessionManager"));
	if(m==null){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if(m.getManagerLevel() < 2){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		System.out.println("매니저 레벨이 낮아서 <삭제기능은> 안됩니다.");
		return;
	}
	%>
	
	<%
	// 수집
	String clientMail = request.getParameter("clientMail");
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
	int rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	String searchWord = request.getParameter("searchWord");
	System.out.println(clientMail+"<-- param clientMail");//디버깅
	
	//삭제 메서드 호출
	ClientDao.deleteClient(clientMail);
	
	//삭제 완료 시 manager.managerList로 
	response.sendRedirect(request.getContextPath()+"/client/clientList.jsp?currentPage="+currentPage+"&rowPerPage="+rowPerPage+"&serchWord="+searchWord);
	
%>