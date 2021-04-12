<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@page import="gdu.mall.dao.*"%>
	<%
	System.out.println("\n----------inset Ebook Action.jsp 실행 ---------");

	
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
	String categoryName = request.getParameter("categoryName");
	String ebookTitle = request.getParameter("ebookTitle");
	String ebookAuthor = request.getParameter("ebookAuthor");
	String ebookCompany = request.getParameter("ebookCompany");
	int ebookPageCount = Integer.parseInt(request.getParameter("ebookPageCount"));
	int ebookPrice = Integer.parseInt(request.getParameter("ebookPrice"));
	String ebookSummary = request.getParameter("ebookSummary");
	
	//카테고리 중복체크
	//if(CategoryDao.selectCategoryName(categoryName) != null) {
	//	System.out.println("-----이미 등록된 카테고리 입니다.");
	//	response.sendRedirect(request.getContextPath()+"/category/insertCategoryForm.jsp");
	//	return;
	//}
	
	//카테고리 입력 메서드 호출
	Ebook e = new Ebook();
	e.setEbookTitle(ebookTitle);
	
	//2.중복된 카테고리 생성 불가
	String returnEbookISBN = EbookDao.overlapebookISBN(ebookISBN);//categoryDao에 중복된지 확인 코드
	
	if(returnEbookISBN != ""){//카테고리 사용중
		System.out.println(returnEbookISBN+"<--- returnEbookISBN");
		System.out.println("중복된 ISBN 입니다.");
		response.sendRedirect(request.getContextPath()+"/ebook/ebookList.jsp");
		return;
	}
	
	//3.중복된 카테고리 없으면 생성 - categoryDao에 생성 코드 만듬
	e.setEbookISBN(ebookISBN);
	
	e.setCategoryName(categoryName);
	e.setEbookAuthor(ebookAuthor);
	e.setEbookCompany(ebookCompany);
	e.setEbookPageCount(ebookPageCount);
	e.setEbookPrice(ebookPrice);
	e.setEbookSummary(ebookSummary);
	System.out.println("ebook : "+e);
	EbookDao.insertEbook(e);
	
	//카테고리 목록으로 돌아가기
	System.out.println("----------추가 완료----------");
	response.sendRedirect(request.getContextPath()+"/ebook/ebookList.jsp");
%>