package gdu.mall.dao;

import java.sql.*;
import gdu.mall.util.*;
import java.util.*;
import gdu.mall.vo.*;

public class ClientDao {
	public static int totalCount(String searchWord) throws Exception{
		System.out.println("~~~~~~~~~~~~~~~~ 토탈 카운트 메서드 ~~~~~~~~~~~~~~~");
		//1.
		String sql = "";
		Connection conn = DButil.getConnection();
		PreparedStatement stmt= null;
		
		if(searchWord.equals("")) {
			sql = "SELECT count(*) FROM client";
			stmt= conn.prepareStatement(sql);
		} else {
			sql = "SELECT count(*) FROM client WHERE client_mail LIKE ?";
			stmt= conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
		}
				
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
	
	//셀렉스 원 메서드
	public static Client selectClientOne(String clientMail) throws Exception{
		System.out.println("~~~~~~~~~~~~~~~~ 셀렉트 클라이언트원 메서드 ~~~~~~~~~~~~~~~");
		//1. 쿼리는 뒤에 쓰는걸로
		
		//2.
		
		//3.
		Connection conn = DButil.getConnection();//메서드
		
		String sql = null;
		PreparedStatement stmt = null;

			sql = "SELECT client_mail clientMail, left(client_date,10) clientDate, client_no clientNo FROM client WHERE client_mail = '?' ";
			stmt= conn.prepareStatement(sql);
			stmt.setString(1,clientMail);
			System.out.println("\t 검색어없는 stmt : "+stmt);

		
		System.out.println("\t 고객 확인");
		ResultSet rs = stmt.executeQuery();
		System.out.println("\t ResultSet rs : "+rs);
		
		Client cl = null;
		cl = new Client(); //잠시 쓸 때는 m 처럼 짧은 변수명 사용
		while(rs.next()) {
			System.out.println("\t 같은메일 있음");
			
			cl.setClientMail(rs.getString("clientMail"));
			cl.setClientDate(rs.getString("clientDate"));
			cl.setClientNo(rs.getInt("clientNo"));
		}
		//4.
		return cl;
	}//셀렉트 원 메서드
	
	
	//셀렉스 리스트 메서드
	public static ArrayList<Client> selectClientListByPage(int beginRow, int rowPerPage, String searchWord) throws Exception{
		System.out.println("~~~~~~~~~~~~~~~~ 셀렉트 클라이언트 리스트 바이 페이지 메서드 ~~~~~~~~~~~~~~~");
		//1. 쿼리는 뒤에 쓰는걸로
		
		//2.
		ArrayList<Client> list = new ArrayList<>();
		
		//3.
		Connection conn = DButil.getConnection();//메서드
		
		String sql = null;
		PreparedStatement stmt = null;
		
		if (searchWord.equals("")) { // 검색어가 없으면
			sql = "SELECT client_mail clientMail, left(client_date,10) clientDate, client_no clientNo FROM client ORDER BY client_date DESC  Limit ?, ? ";
			stmt= conn.prepareStatement(sql);
			stmt.setInt(1,beginRow);
			stmt.setInt(2,rowPerPage);
			System.out.println("\t 검색어없는 stmt : "+stmt);
		}else { // 검색어가 있으면,
			sql = "SELECT client_mail clientMail, left(client_date,10) clientDate, client_no clientNo FROM client WHERE client_mail like ? ORDER BY client_date DESC  Limit ?, ? ";
			stmt= conn.prepareStatement(sql);
			stmt.setString(1,"%"+searchWord+"%");
			stmt.setInt(2,beginRow);
			stmt.setInt(3,rowPerPage);
			System.out.println("\t 검색어있는 stmt : "+stmt);
		}
		
		System.out.println("\t 고객리스트 확인");
		ResultSet rs = stmt.executeQuery();
		System.out.println("\t ResultSet rs : "+rs);
		System.out.printf("\t from테이블:쿼리(명령) 실행해서 select 변수 값을 beginRow %s 부터 rowPerPage %s 만큼 가져옴\n",beginRow, rowPerPage);
		
		
		while(rs.next()) {
			System.out.println("\t 목록 있음");
			Client cl = new Client(); //잠시 쓸 때는 m 처럼 짧은 변수명 사용
			cl.setClientMail(rs.getString("clientMail"));
			cl.setClientDate(rs.getString("clientDate"));
			cl.setClientNo(rs.getInt("clientNo"));
			list.add(cl);
		}
		//4.
		return list;
	}//셀렉트 리스트 메서드
	
	// 삭제 메서드
	public static int deleteClient(String clientMail) throws Exception{
		System.out.println("~~~~~~~~~~~~~~~딜리트 클라이언트 실행~~~~~~~~~~~~~~~");
		// 1.쿼리 정의
		/*
		 * DELETE FROM [테이블] WHERE [조건]
		 */
		String sql = "DELETE FROM client WHERE client_mail = ? ";
				
		//2.전처리 변수생성,초기화
		int rowCnt = 0; // 입력성공시 1, 실패 0
						
		// 3. DB 처리
		Connection conn = DButil.getConnection(); //커넥션 메서드
						
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, clientMail);
		ResultSet rs = stmt.executeQuery();
		System.out.println("delete client stmt : "+stmt);
		System.out.println("delete client rs : "+rs);
						
		rowCnt = stmt.executeUpdate();
		//쿼리끝
			
		return rowCnt;
	}// 삭제 메서드		
	
	// 수정 메서드
	public static int updateClient (String clientNewMail, String clientPw, int clientNo) throws Exception{
		System.out.println("~~~~~~~~~~~~~~~업데이트 클라이언트 실행~~~~~~~~~~~~~~~");
		// 1.쿼리 정의
		/*
		 * update테이블 set열 = 변경할값, where 조건
		 */
		String sql = "UPDATE client SET client_mail = '?', client_pw = ? WHERE client_no = '?' ";
		
		//2.전처리 변수생성,초기화
		int rowCnt = 0; 
					
		// 3. DB 처리
		Connection conn = DButil.getConnection(); //커넥션 메서드
				
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, clientNewMail);
		stmt.setString(2, clientPw);
		stmt.setInt(3, clientNo);
		ResultSet rs = stmt.executeQuery();
		System.out.println("update client stmt : "+stmt);
		System.out.println("update client rs : "+rs);
					
		rowCnt = stmt.executeUpdate();// 입력성공시 1, 실패 0
		
		//4.
		return rowCnt;
	}//수정메서드
	
}// class