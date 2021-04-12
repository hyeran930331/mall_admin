<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@page import="gdu.mall.dao.*"%>
	<%
	System.out.println("\n----------updateCategoryAction.jsp 실행 ---------");

	// 세션 검사 관리자 권한 1 이상만 볼 수 있도록.
	Manager m = (Manager)session.getAttribute("sessionManager");
	if(m == null || m.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	%>
	
	<%
	request.setCharacterEncoding("utf-8");
	%>
	
	<%
	//수집
	String categoryName = request.getParameter("categoryName");
	int categoryWeight = Integer.parseInt(request.getParameter("categoryWeight"));
	
	//카테고리 수정 메서드 호출
	CategoryDao.updateCategory(categoryWeight, categoryName);
	
	//카테고리 목록으로 돌아가기
	System.out.println("----------수정 완료----------");
	response.sendRedirect(request.getContextPath()+"/category/categoryList.jsp");
	%>