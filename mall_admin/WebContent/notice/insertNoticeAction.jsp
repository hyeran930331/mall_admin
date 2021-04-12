<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
	<%
	//레벨 2 미만 보안코드
	Manager m = (Manager)session.getAttribute("sessionManager");
	if(m == null || m.getManagerLevel() < 2){
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
	String managerId = request.getParameter("managerId");
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	
	//디버깅
	System.out.printf("managerId: %s\n noticeTitle: %s\n noticeContent: %s\n",managerId, noticeTitle, noticeContent);
	
	//전처리
	Notice n = new Notice();
	n.setManagerId(managerId);
	n.setNoticeTitle(noticeTitle);
	n.setNoticeContent(noticeContent);

	//dao에서 호출
	NoticeDao.insertNotice(n);
	
	//noticeList 재실행
	response.sendRedirect(request.getContextPath()+"/notice/noticeList.jsp");
%>