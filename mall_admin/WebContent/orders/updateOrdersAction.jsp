<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@page import="gdu.mall.dao.*"%>
<%
	System.out.println("\n----------updateOrdersAction.jsp 실행 ---------");

	//레벨 2미만 보안코드
	Manager m = (Manager)session.getAttribute("sessionManager");
	if(m == null || m.getManagerLevel() < 2){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	//수집
	request.setCharacterEncoding("utf-8");
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	String orderState = request.getParameter("ordersState");
	
	//디버깅
	System.out.printf("\n ordersNo: %s,orderState: %s <updateOrdersAction.jsp>\n",ordersNo,orderState );
	
	//카테고리 수정 메서드 호출
	OrdersDao.updateState(ordersState, ordersNo);
	
	//카테고리 목록으로 돌아가기
	System.out.println("----------수정 완료----------");
	response.sendRedirect(request.getContextPath()+"/orders/ordersList.jsp");
%>