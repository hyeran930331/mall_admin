<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.vo.*" %>
<%@ page import="gdu.mall.dao.*"%>
	<%
	request.setCharacterEncoding("UTF-8");
	System.out.println("\n----------deleteNoticeAction.jsp 실행 ---------");
	%>
	
	<%
	//레벨 1 미만 보안코드
	Manager m = (Manager)session.getAttribute("sessionManager");
	if(m == null || m.getManagerLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	%>
	<%
	
	//수집
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));

	//디버깅
	System.out.printf("noticeNo: %s<deleteNoticeOneAction.jsp>\n",noticeNo);
	
	//댓글이 있는 공지글인지 질문!
	//public static int selectCommentCnt(int noticeNo) throws Exception {
	int rowCnt = CommentDao.selectCommentCnt(noticeNo); //크기찾는 메소드
	if(rowCnt!=0){
		System.out.printf("\n\t"+noticeNo + "공지글의 댓글이 %s개있습니다.\n 삭제불가능합니다 ", rowCnt);
		response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeNo="+noticeNo);
		return;
	}
	
	//dao삭제 메서드 호출
	NoticeDao.deleteNotice(noticeNo);
	
	//list 재실행
	response.sendRedirect(request.getContextPath()+"/notice/noticeList.jsp");
%>