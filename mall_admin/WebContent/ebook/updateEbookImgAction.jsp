<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
	
	<%
	request.setCharacterEncoding("utf-8");
	%>
	
	<%
	// String ebookISBN = request.getParameter("ebookISBN");
	// String ebookImg = request.getParameter("ebookImg");
	// System.out.println(ebookISBN); // why null? 
 	// System.out.println(ebookImg); // why null? multi 폼타입 파일을 request로 값을 받을수 없다.
 			
 	// 파일을 다운로드 받을 위치
 	//새로고침 안해도 바로 확인 폴더에서는 확인x
 	//String path = application.getRealPath("img"); // img라는 폴더의 OS상의 실제 폴더
	
 	//강제지정, 바로확인, 폴더에서도 확인
 	//폴더확인
 	String path = "C:/Users/GDJ34/git/mall_admin_css/mall_admin_css/mall_admin0405/WebContent/img";//학원
 	//폴더확인
 	//String path = "C:/Users/82106/Desktop/goodee/mall_admin0329/WebContent/img"; //노트북
 	System.out.println(path); 
 	
 	int size = 1024 * 1024 * 500; // 500MB
 	// MultipartRequest(페이지의request, 파일이저장될경로, 가능파일크기, request에인코딩, 동일이름네임정책) 
	MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
 	String ebookISBN = multi.getParameter("ebookISBN");
 	String ebookImg = multi.getFilesystemName("ebookImg");
 	System.out.println(ebookISBN);
 	System.out.println(ebookImg);
 	
 	Ebook e = new Ebook();
 	e.setEbookISBN(ebookISBN);
 	e.setEbookImg(ebookImg);
 	EbookDao.updateEbookImg(e);
 	response.sendRedirect(request.getContextPath()+"/ebook/ebookOne.jsp?ebookISBN="+ebookISBN);
	%>
