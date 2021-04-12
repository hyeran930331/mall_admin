<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "gdu.mall.vo.*" %>
<%@ page import = "gdu.mall.dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adminIndex</title>
</head>
<body>
	<h1>adminIndex</h1>
	<!-- 
		- 2가지 화면을 분기
		- 로그인 정보는 Manager자료형 세션변수(sessionManager)를 이용 
		1)관리자 로그인 폼
		2)관리자 인증 화면 & 몰 메인페이지
	 -->
<%
	System.out.println("----------admin Index. jsp 실행 ----------");
	if(session.getAttribute("sessionManager") == null){
%>		
		<form action="<%=request.getContextPath()%>/manager/loginManagerAction.jsp">
			<table border="1">
				<tr>
					<td>ID</td>
					<td><input type="text" name="managerId"></td>
				</tr>
				<tr>
					<td>PW</td>
					<td><input type="password" name="managerPw"></td>
				</tr>
			</table>
			<button type="submit">로그인</button>
			<a href="<%=request.getContextPath()%>/manager/insertManagerForm.jsp">매니저 등록</a>
		</form>
		
<%		
		//public static ArrayList<Manager> selectManagerListByZero() throws Exception{
		ArrayList<Manager> managerList = ManagerDao.selectManagerListByZero();
%>
		
		<div>
		<h1>승인대기 중인 매니저 목록</h1>
		<table border="1">
		
			<tr>
				<td>ManagerId</td>
				<td>ManagerDate</td>
			</tr>
			<%
				for(Manager mm: managerList){
			%>
				<tr>
					<td><%=mm.getManagerId() %></td>
					<td><%=mm.getManagerDate() %></td>
				</tr>
			<%
				}
			%>
		</table>
		</div>	
	
<%					
	} else { // session앞에 형변한 연산자()) 사용!
		Manager manager = (Manager)(session.getAttribute("sessionManager"));
%>
		<!-- 관리자화면 메뉴(네비게이션) include -->
		<div>
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
		</div><!-- 인클루드는 프로젝트 명이 필요없다 -->

		<div>
			<%=manager.getManagerName() %>님 반갑습니다.
			LEVEL : <%=manager.getManagerLevel() %>	
		</div>
		
		<%
			ArrayList<Notice> noticeList = NoticeDao.selectNoticeList(0, 5);
			ArrayList<Manager> managerList = ManagerDao.selectManagerList(0, 5, "");
			ArrayList<Client> clientList = ClientDao.selectClientListByPage(0, 5, "");//.
			ArrayList<Ebook> ebookList = EbookDao.selectEbookListByPage(0, 5, "");
			//public static ArrayList<OrdersAndEbookAndClient> selectOrdersListByPage(int beginRow, int rowPerPage) throws Exception{
			ArrayList<OrdersAndEbookAndClient> oecList = OrdersDao.selectOrdersListByPage(0, 5);
		%>
		<!-- 최근 등록한 공지 5개 -->
		<div>
			<h2>noticeList <button><a href="<%=request.getContextPath()%>/notice/noticeList.jsp">more</a></button></h2>
			<table border="1">
						<tr>
							<td>NoticeTitle</td>
							<td>ManagerId</td>
						</tr>
				<%
					for(Notice n: noticeList){
				%>
						<tr>
							<td><%=n.getNoticeTitle() %></td>
							<td><%=n.getManagerId() %></td>
						</tr>
				<%
					}
				%>
			</table>
		</div>
		

		<!-- 최근 가입한 매니저 5명 -->
		<div>
		<table border="1">
			<thead>
			<tr>
				<th colspan="2">
					<h2>managerList
					<button><a href="<%=request.getContextPath()%>/manager/managerList.jsp">more</a></button></h2>
				</th>
			</tr>
			</thead>
			
			<tr>
				<td>ManagerId</td>
				<td>ManagerName</td>
			</tr>
			<%
				for(Manager mm: managerList){
			%>
				<tr>
					<td><%=mm.getManagerId() %></td>
					<td><%=mm.getManagerName() %></td>
				</tr>
			<%
				}
			%>
		</table>
		</div>
		
		<!-- 최근 가입한 고객 5명 -->
		<div>
			<h2>clientList <button><a href="<%=request.getContextPath()%>/client/clientList.jsp">more</a></button></h2>
			<table border="1">
						<tr>
							<td>ClientMail</td>
							<td>ClientDate</td>
						</tr>
				<%
					for(Client c: clientList){
				%>
						<tr>
							<td><%=c.getClientMail() %></td>
							<td><%=c.getClientDate() %></td>
						</tr>
				<%
					}
				%>
			</table>
		</div>
		
		<!-- 최근 등록한 상품 5개 -->
		<div>
			<h2>ebookList <button><a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">more</a></button></h2>
			<table border="1">
				<%
					for(Ebook e: ebookList){
				%>
						<tr>
							<td><%=e.getEbookTitle() %></td>
							<td><%=e.getEbookPrice() %></td>
						</tr>
				<%
					}
				%>
			</table>
		</div>
		
		<!-- 최근 주문한 주문 5개 -->
		<div>
			<h2>ordersList<button><a href="<%=request.getContextPath()%>/orders/ordersList.jsp">more</a></button></h2>
			<table border="1">
				<%
					for(OrdersAndEbookAndClient oec: oecList){
				%>
						<tr>
							<td><%=oec.getOrders().getOrdersNo()%></td>
							<td><%=oec.getEbook().getEbookTitle()%></td>
							<td><%=oec.getClient().getClientMail()%></td>
						</tr>
				<%
					}
				%>
			</table>
		</div>

<%		
	}
%>
</body>
</html>