<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
	<%
	System.out.println("-------------update 실행-------------");
	%>
	
	<%
	// 0. 전처리 레벨2 미만 접근제한
	Manager m = (Manager)(session.getAttribute("sessionManager"));
	if(m==null){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if(m.getManagerLevel() < 2){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		System.out.println("매니저 레벨이 낮아서 <레벨수정기능은> 안됩니다.");
		return;
	}
	%>
	
	<%
	// 수집 코드 구현
	request.setCharacterEncoding("UTF-8");
	System.out.println("-----입력값 확인-----");
	System.out.println(request.getParameter("managerNo"));
	System.out.println(request.getParameter("managerLevel"));
	
	
	int managerNo = Integer.parseInt(request.getParameter("managerNo"));
	int managerLevel = Integer.parseInt(request.getParameter("managerLevel"));
	System.out.println("----- 변수 초기화 확인-----");
	System.out.println(managerNo+"<-- param managerNo");
	System.out.println(managerLevel+"<-- param managerlevel");
	
	// dao 수정 메서드 호출 코드 구현
	ManagerDao.updateManagerLevel(managerNo, managerLevel);
	
	//수정 후 매니저리스트로 이동
	response.sendRedirect(request.getContextPath()+"/manager/managerList.jsp");
%>