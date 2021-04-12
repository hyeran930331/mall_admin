package gdu.mall.dao;

import java.sql.*;
import java.util.*;

import gdu.mall.util.*;
import gdu.mall.vo.*;
import gdu.mall.dao.*;


public class EbookDao {
	// 스테이트만 수정 메서드
	public static int updateEbookState(Ebook e) throws Exception{
		System.out.println("~~~~~~~~~~~~~~~업데이트 이북 스테이트 실행~~~~~~~~~~~~~~~");
		// 1.쿼리 정의
		/*
		 * update테이블 set열(변경할값, where 조건
		 * UPDATE ebook 
		 * SET ebook_state =? 
		 * WHERE ebook_isbn = ?";
		 */
		int rowCnt = 1;
		String sql = "UPDATE ebook SET ebook_state =? WHERE ebook_isbn = ?";
			
		Connection conn = DButil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, e.getEbookState());
		stmt.setString(2, e.getEbookISBN());
		
		stmt.executeUpdate();
		
		return rowCnt;
	}//수정메서드	
	
	// 서머리만 수정 메서드
	public static int updateEbookSummary(Ebook e) throws Exception{
		System.out.println("~~~~~~~~~~~~~~~업데이트 이북 서머리 실행~~~~~~~~~~~~~~~");
		// 1.쿼리 정의
		/*
		 * update테이블 set열 = 변경할값, where 조건
		 * UPDATE ebook 
		 * SET ebook_state =? 
		 * WHERE ebook_isbn = ?";
		 */
		int rowCnt = 1;
		String sql = "UPDATE ebook SET ebook_summary =? WHERE ebook_isbn = ?";
		
		Connection conn = DButil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, e.getEbookSummary());
		stmt.setString(2, e.getEbookISBN());
		
		stmt.executeUpdate(); 
			
		return rowCnt;
	}//수정메서드	
	
	// 삭제 메서드
	public static void deleteEbook(String ebookISBN) throws Exception{
		System.out.println("~~~~~~~~~~~~~~~딜리트 카테고리 실행~~~~~~~~~~~~~~~");
		// 1.쿼리 정의
		/*
		 * DELETE FROM [테이블] WHERE [조건]
		 */
		String sql = "DELETE FROM ebook WHERE ebook_ISBN = ? ";
				
		//2.전처리 변수생성,초기화
		int rowCnt = 0; // 입력성공시 1, 실패 0
						
		// 3. DB 처리
		Connection conn = DButil.getConnection(); //커넥션 메서드
						
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebookISBN);
		System.out.println("delete ebook stmt : "+stmt);
							
		stmt.executeUpdate();
		//쿼리끝

	}// 삭제 메서드	
	
	// 수정 메서드
	public static int updateEbook(Ebook e) throws Exception{
		System.out.println("~~~~~~~~~~~~~~~업데이트 이북 실행~~~~~~~~~~~~~~~");
		// 1.쿼리 정의
		/*
		 * update테이블 set열 = 변경할값, where 조건
		 * UPDATE ebook 
		 * SET 
		 * 1 category_name = ?, 2 ebook_title = ?, 
		 * 3 ebook_author = ?, 4 ebook_company = ?, 
		 * 5 ebook_page_count = ?, 6 ebook_price = ?, 
		 * 7 ebook_summary = ?, 8 ebook_state =? ) 
		 * VALUES (?,?,?,?,?,?,?,?) WHERE ebook_isbn = ?";
		 */
		String sql = "UPDATE ebook SET category_name = ?, ebook_title = ?, ebook_author = ?, ebook_company = ?, ebook_page_count = ?, ebook_price = ?, ebook_summary = ?, ebook_state =? WHERE ebook_isbn = ?";
		int rowCnt = 0;
		
		Connection conn = DButil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, e.getCategoryName());
		stmt.setString(2, e.getEbookTitle());
		stmt.setString(3, e.getEbookAuthor());
		stmt.setString(4, e.getEbookCompany());
		stmt.setInt(5, e.getEbookPageCount());
		stmt.setInt(6, e.getEbookPrice());
		stmt.setString(7, e.getEbookSummary());
		stmt.setString(8, e.getEbookState());
		stmt.setString(9, e.getEbookISBN());
	
		ResultSet rs = stmt.executeQuery();
		
		return rowCnt;
	}//수정메서드
	
	//ebook state lsit
	public static ArrayList<String> selectEbookStateName() throws Exception{
		System.out.println("~~~~~~~~~~~~~~~~셀렉트이북 스테이트 메서드 ~~~~~~~~~~~~~~~");
		String sql = "SELECT ebook_state ebookState FROM ebook";
		//초기화
		Connection conn = DButil.getConnection();//메서드
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println("select Ebook Name stmt : "+stmt);
		
		ResultSet rs = stmt.executeQuery();
		
		ArrayList<String> list = new ArrayList<>();
		//list란 이름인 String타입의 arraylist를 만든다.
		//ArrayLIst<String> list = new ArrayList<String>(); 
		//이라고 되어있다면 String객체들만 add되어질수있고 다른 타입의 객체는 사용이 불가능합니다.
		while(rs.next()) {
			list.add(rs.getString("ebook_state"));
		}
		return list;
	}//메서드끝		
	
	// ebookimg
	public static int updateEbookImg(Ebook e) throws Exception {
		String sql ="UPDATE ebook SET ebook_img=? WHERE ebook_isbn =?";
		Connection conn = DButil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, e.getEbookImg());
		stmt.setString(2, e.getEbookISBN());
		int rowCnt = stmt.executeUpdate();
		return rowCnt;
	}//메서드끝

	//중복확인 메서드 ebookISBN
	public static String overlapebookISBN(String ebookISBN) throws Exception{
		//1.sql
		String sql = "SELECT ebook_isbn ebookISBN from ebook WHERE ebook_isbn=?";
		//2.초기화
		String returnEbookISBN = null;
		//3.DB연결
		Connection conn = DButil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebookISBN);
		
		System.out.printf("stmt: %s <--overlapEbookISBN \n",stmt);
			
		ResultSet rs = stmt.executeQuery();
			
		if(rs.next()) {
			returnEbookISBN = rs.getString("ebookISBN");
		}else {
			returnEbookISBN = "";
		}
		return returnEbookISBN;
	}//메서드끝
	
	//셀렉트 상세 페이지 메서드
	public static Ebook selectEbookOne(String ebookISBN) throws Exception{
		System.out.println("~~~~~~~~~~~~~~~~이북 셀렉트이북 원 메서드 ~~~~~~~~~~~~~~~");
		//sql은 모두 다 가져와야 한다
		String sql = "SELECT ebook_no ebookNo, ebook_isbn ebookISBN, category_name categoryName, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_summary ebookSummary, ebook_company ebookCompany, ebook_page_Count ebookPageCount, ebook_price ebookPrice, ebook_img ebookImg, ebook_date ebookDate, ebook_state ebookState FROM ebook WHERE ebook_isbn = ?";
		//초기화
		Ebook e = null;
		//DB연동
		Connection conn = DButil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ebookISBN);
		System.out.printf("stmt: %s    <EbookDao.selectEbookOne>\n", stmt);
		
		ResultSet rs = stmt.executeQuery();
		e = new Ebook();
		while(rs.next()) {
			e.setEbookNo(rs.getInt("ebookNo"));
			e.setEbookISBN(rs.getString("ebookISBN"));
			e.setCategoryName(rs.getString("categoryName"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setEbookAuthor(rs.getString("ebookAuthor"));
			e.setEbookSummary(rs.getString("ebookSummary"));
			e.setEbookCompany(rs.getString("ebookCompany"));
			e.setEbookImg(rs.getString("ebookImg"));
			e.setEbookDate(rs.getString("ebookDate"));
			e.setEbookState(rs.getString("ebookState"));
			e.setEbookPageCount(rs.getInt("ebookPageCount"));
			e.setEbookPrice(rs.getInt("ebookPrice"));			
		}
			
		return e;
	}//메서드끝
	
	// 입력메서드
	public static int insertEbook(Ebook e) throws Exception{
		System.out.println("~~~~~~~~~~~~~~~~인설트 이북 메서드 ~~~~~~~~~~~~~~~");
		/*
		 * INSERT INTO ebook
		 * (
		 * ebook_date,
		 *1 ebook_isbn,
		 *2 category_name,
		 *3 ebook_title,
		 *4 ebook_author,
		 *5 ebook_company,
		 *6 ebook_page_count,
		 *7 ebook_price,
		 *8 ebook_summary,
		 * ebook_img,
		 * ebook_state
		 * )
		 * VALUES
		 * (now(),?,?,?,?,?,?,?,?,'defalut.jps','판매중')
		 */
		String sql = "INSERT INTO ebook (ebook_date, ebook_isbn, category_name, ebook_title, ebook_author, ebook_company, ebook_page_count, ebook_price, ebook_summary, ebook_img, ebook_state ) VALUES (now(),?,?,?,?,?,?,?,?,'default.jpg','판매중')";
		int rowCnt = 0;
		
		Connection conn = DButil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, e.getEbookISBN());
		stmt.setString(2, e.getCategoryName());
		stmt.setString(3, e.getEbookTitle());
		stmt.setString(4, e.getEbookAuthor());
		stmt.setString(5, e.getEbookCompany());
		stmt.setInt(6, e.getEbookPageCount());
		stmt.setInt(7, e.getEbookPrice());
		stmt.setString(8, e.getEbookSummary());
		ResultSet rs = stmt.executeQuery();
		
		return rowCnt;
	}
	
	// 전체 행의 수 
	public static int totalCount() throws Exception {
		System.out.println("~~~~~~~~~~~~~~~~ 토탈 카운트 메서드 ~~~~~~~~~~~~~~~");
		//1.
		String sql = "";
		Connection conn = DButil.getConnection();
		PreparedStatement stmt= null;
		
		//if(searchWord.equals("")) {
			sql = "SELECT count(*) FROM ebook";
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
	
	//ebookList 만들기 
		public static ArrayList<Ebook> selectEbookListByPage(int beginRow, int rowPerPage, String categoryName) throws Exception{
			//리턴값 초기화
			ArrayList<Ebook> list = new ArrayList<>();
			//db연결
			Connection conn = DButil.getConnection();
			PreparedStatement stmt = null;
			String sql = null;
			//sql - categoryName에 따른 동적쿼리?
			if(categoryName.equals("")) {//categoryName 없으면
				sql = "SELECT ebook_no ebookNo, category_name categoryName, ebook_isbn ebookISBN, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_date ebookDate, ebook_price ebookPrice FROM ebook ORDER BY ebook_date DESC LIMIT ?,?";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, beginRow);
				stmt.setInt(2, rowPerPage);
			} else {//categoryName 있으면
				sql = "SELECT ebook_no ebookNo, category_name categoryName, ebook_isbn ebookISBN, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_date ebookDate, ebook_price ebookPrice FROM ebook WHERE category_name = ? ORDER BY ebook_date DESC LIMIT ?,?";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, categoryName);
				stmt.setInt(2, beginRow);
				stmt.setInt(3, rowPerPage);
			}
			System.out.printf("stmt : %s<EbookDao.java>\n",stmt);
			//쿼리완성
			ResultSet rs = stmt.executeQuery();
			
			//리턴값
			while(rs.next()) {
				Ebook e = new Ebook();
				e.setCategoryName(rs.getString("categoryName"));
				e.setEbookISBN(rs.getString("ebookISBN"));
				e.setEbookTitle(rs.getString("ebookTitle"));
				e.setEbookAuthor(rs.getString("ebookAuthor"));
				e.setEbookDate(rs.getString("ebookDate"));
				e.setEbookPrice(rs.getInt("ebookPrice"));
				e.setEbookNo(rs.getInt("ebookNo"));
				list.add(e);
			}
		
			return list;
		}	
}
