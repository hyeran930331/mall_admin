<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
	<%	
	//레벨 1 미만 보안코드
	Manager m = (Manager)session.getAttribute("sessionManager");
	if(m == null || m.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	%>
	<%
	//인코딩
	 request.setCharacterEncoding("UTF-8");
	%>
	<%
	//수집
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String managerId = request.getParameter("managerId");
	String commentContent = request.getParameter("commentContent");
	
	//디버깅
	System.out.printf("\n managerId: %s\n commentContent: %s\n noticeNo: %s\n",managerId, commentContent, noticeNo);
	//전처리
	Comment c = new Comment();
	c.setManagerId(managerId);
	c.setNoticeNo(noticeNo);
	c.setCommentContent(commentContent);

	//dao에서 호출
	CommentDao.insertComment(c);
	
	//noticeList 재실행
	response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeNo="+noticeNo);
%>