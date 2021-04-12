<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@page import="gdu.mall.dao.*"%>
	<%
	System.out.println("\n----------update Ebook Action.jsp 실행 ---------");

	
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
	String ebookISBN = request.getParameter("ebookISBN"); //9수정불가
	
	String categoryName = request.getParameter("categoryName"); //1
	String ebookTitle = request.getParameter("ebookTitle"); //2
	String ebookAuthor = request.getParameter("ebookAuthor");//3
	String ebookCompany = request.getParameter("ebookCompany"); //4
	int ebookPageCount = Integer.parseInt(request.getParameter("ebookPageCount")); //5
	int ebookPrice = Integer.parseInt(request.getParameter("ebookPrice"));//6
	String ebookSummary = request.getParameter("ebookSummary"); //7
	String ebookState = request.getParameter("ebookState"); //8
	
	//카테고리 입력 메서드 호출
	Ebook e = new Ebook();
		e.setEbookISBN(ebookISBN); //9 수정불가
		
		e.setCategoryName(categoryName);//1
		e.setEbookTitle(ebookTitle);//2
		e.setEbookAuthor(ebookAuthor);//3
		e.setEbookCompany(ebookCompany);//4
		e.setEbookPageCount(ebookPageCount); //5
		e.setEbookPrice(ebookPrice); //6
		e.setEbookSummary(ebookSummary); //7
		e.setEbookState(ebookState); //8
		
	System.out.println("ebook : "+e);
	EbookDao.updateEbook(e);
	
	//카테고리 목록으로 돌아가기
	System.out.println("----------수정 완료----------");
	response.sendRedirect(request.getContextPath()+"/ebook/ebookOne.jsp?ebookISBN="+ebookISBN);
%>