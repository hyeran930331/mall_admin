<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.ManagerDao" %>

	<%
	System.out.println("----------deleteManagerActio.jsp----------");
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
	// 수집 코드 구현
	int managerNo = Integer.parseInt(request.getParameter("managerNo"));
	System.out.println(managerNo+"<-- param managerNo");
	
	// dao 삭제 메서드 호출 코드 구현
	ManagerDao.deleteManager(managerNo);
	
	//삭제 후 멤버리스트로 이동
	response.sendRedirect(request.getContextPath()+"/manager/managerList.jsp");
%>