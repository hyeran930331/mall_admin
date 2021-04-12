package gdu.mall.dao;

import gdu.mall.util.*;
import gdu.mall.vo.*;
import java.sql.*;
import java.util.*;

public class OrdersDao {
	
	// 전체 행의 수 
	public static int totalCount() throws Exception {
		System.out.println("~~~~~~~~~~~~~~~~ 토탈 카운트 메서드 ~~~~~~~~~~~~~~~");
		//1.
		String sql = "";
		Connection conn = DButil.getConnection();
		PreparedStatement stmt= null;
			
		//if(searchWord.equals("")) {
			sql = "SELECT count(*) FROM orders";
			stmt= conn.prepareStatement(sql);
		//} else {
		//	sql = "SELECT count(*) FROM client WHERE client_mail LIKE ?";
		//	stmt= conn.prepareStatement(sql);
		//	stmt.setString(1, "%"+searchWord+"%");
		//}
					
		int totalRow = 0;
		ResultSet rs = stmt.executeQuery();
			
		if(rs.next()) {
			System.out.println("\t 목록 있음");
			totalRow = rs.getInt("count(*)");
		}
			
		System.out.println(rs);
		System.out.println(stmt);
			
		return totalRow;	
	}	
	
	// 수정 메서드
	public static void updateState(String ordersState, int ordersNo) throws Exception{
	System.out.println("~~~~~~~~~~~~~~~업데이트 스테이트 실행~~~~~~~~~~~~~~~");
		// 1.쿼리 정의
		/*
		 * update테이블 set열 = 변경할값, where 조건
		 */
		String sql="UPDATE orders SET orders_state =? WHERE orders_no=?";
			
		Connection conn = DButil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ordersState);
		stmt.setInt(2, ordersNo);
		System.out.println("updateState stmt : "+stmt);
			
		stmt.executeUpdate();
			
		ResultSet rs = stmt.executeQuery();
		System.out.println("updateState stmt : "+stmt);
								
		stmt.executeUpdate();
	
	}//수정메서드		
	
	//orders list/// orders join ebook join client 리스트 
	public static ArrayList<OrdersAndEbookAndClient> selectOrdersListByPage(int beginRow, int rowPerPage) throws Exception{
		//초기화
		ArrayList<OrdersAndEbookAndClient> list = new ArrayList<>();
		//sql
		/*
		 * SELECT o.orders_no ordersNo, o.ebook_no ebookNo, 
		 * e.ebook_title ebookTitle, o.client_no clientNo, 
		 * c.client_mail clientMail,o.orders_date ordersDate, 
		 * o.orders_state ordersState 
		 * 
		 * FROM orders o 
		 * INNER JOIN ebook e INNER JOIN client c 
		 * ON o.ebook_no = e.ebook_no AND o.client_no = c.client_no 
		 * ORDER BY o.orders_date DESC 
		 * 
		 * limit ?,?";
		 */
		String sql = "SELECT o.orders_date ordersDate, o.orders_no ordersNo, o.ebook_no ebookNo, e.ebook_title ebookTitle, o.client_no clientNo, c.client_mail clientMail, o.orders_state ordersState FROM orders o INNER JOIN ebook e INNER JOIN client c ON o.ebook_no = e.ebook_no AND o.client_no = c.client_no ORDER BY o.orders_date DESC limit ?,?";
		Connection conn = DButil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
			
		System.out.printf("stmt: %s<OrderDao.orderList>\n", stmt);
			
		ResultSet rs = stmt.executeQuery();
			
		while(rs.next()) {
			OrdersAndEbookAndClient oec = new OrdersAndEbookAndClient();
			Orders o = new Orders();
			o.setOrdersNo(rs.getInt("ordersNo"));
			o.setEbookNo(rs.getInt("ebookNo"));
			o.setClientNo(rs.getInt("clientNo"));
			o.setOrdersState(rs.getString("ordersState"));
			o.setOrdersDate(rs.getString("ordersDate"));
			//채운 다음 oec에 넣어줌
			oec.setOrders(o);
				
			Ebook e = new Ebook();
			e.setEbookTitle(rs.getString("ebookTitle"));
			oec.setEbook(e);
				
			Client c = new Client();
			c.setClientMail(rs.getString("clientMail"));
			oec.setClient(c);
				
			list.add(oec);
		}//while끝
			
		return list;
	}//메소드끝
}

