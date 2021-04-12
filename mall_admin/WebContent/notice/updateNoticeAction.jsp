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
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	
	//디버깅
	System.out.printf("<updateNoticdOneAction> \n noticeNo: %s\n noticeTitle: %s\n noticeContent: %s\n",noticeNo, noticeTitle, noticeContent);
	
	//vo에 넣기
	Notice n = new Notice();
	n.setNoticeNo(noticeNo);
	n.setNoticeTitle(noticeTitle);
	n.setNoticeContent(noticeContent);
	//dao호출
	NoticeDao.updateNoticeOne(n);
	//noticeOne 재실행
	response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeNo="+noticeNo);
	
%>
​