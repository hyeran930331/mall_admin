<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@page import="gdu.mall.dao.*"%>
	<%
	System.out.println("\n----------update Ebook Summary Action.jsp 실행 ---------");

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
	String ebookISBN = request.getParameter("ebookISBN"); 
	String ebookSummary = request.getParameter("ebookSummary"); 
	
	System.out.println("\t"+ebookISBN+"<----ebookISBN");
	System.out.println("\t"+ebookSummary+"<----ebookSummary");

	Ebook e = new Ebook();
	e.setEbookISBN(ebookISBN); 
	e.setEbookSummary(ebookSummary);
	
	EbookDao.updateEbookSummary(e);
	
	//카테고리 목록으로 돌아가기
	System.out.println("----------서머리 수정 완료----------");
	response.sendRedirect(request.getContextPath()+"/ebook/ebookOne.jsp?ebookISBN="+ebookISBN);
%>