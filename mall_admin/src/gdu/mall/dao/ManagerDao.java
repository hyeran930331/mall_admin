package gdu.mall.dao;

import gdu.mall.util.*;
import gdu.mall.vo.*;
import java.sql.*;
import java.util.*;

public class ManagerDao {
	
	// 승인 대기중인 메니저 목록
	//level0 리스트
		public static ArrayList<Manager> selectManagerListByZero() throws Exception{
			System.out.println("~~~~~~~~~~~~~~~매니저 레벨0 실행~~~~~~~~~~~~~~~");
			ArrayList<Manager> list = new ArrayList<>();
			String sql ="SELECT manager_id managerId, manager_date managerDate FROM manager WHERE manager_level = 0";
			Connection conn = DButil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			System.out.println("\tDB drive 연결완료~~~~~~~~~~~~~~~");

			ResultSet rs= stmt.executeQuery();
			System.out.println("byzero Manager stmt : "+stmt);
			System.out.println("byzero Manager rs : "+rs);
			 
			 while(rs.next()) {
				 System.out.println("목록있음");
				 Manager m = new Manager(); // 잠깐 쓰일때 알파벳이나 temp를 쓴다.
				 m.setManagerId(rs.getString("managerId"));
				 m.setManagerDate(rs.getString("managerDate"));
				 
				 list.add(m);
			 }
			 return list;
		}
	
	// 관리자수정 메서드
	public static int updateManagerLevel (int managerNo, int managerLevel) throws Exception{
		System.out.println("~~~~~~~~~~~~~~~업데이트 매니저 레벨실행~~~~~~~~~~~~~~~");
		// 1.쿼리 정의
		/*
		 * update테이블 set열 = 변경할값, where 조건
		 */
		String sql = "UPDATE manager SET manager_level = ? WHERE manager_no = ? ";
		
		//2.전처리 변수생성,초기화
		int rowCnt = 0; 
				
		// 3. DB 처리
		Connection conn = DButil.getConnection(); //커넥션 메서드
				
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, managerLevel);
		stmt.setInt(2, managerNo);
		ResultSet rs = stmt.executeQuery();
		System.out.println("update Manager stmt : "+stmt);
		System.out.println("update Manager rs : "+rs);
				
		rowCnt = stmt.executeUpdate();// 입력성공시 1, 실패 0
	
		//4.
		return rowCnt;
	}
	
	
	//managerList 행의 총수 - 매니저아이디 검색에 따라서
	public static int totalCount(String searchWord) throws Exception{

		String sql = "";
		int totalRow = 0;
		
		Connection conn = DButil.getConnection();
		PreparedStatement stmt = null;
			
		if(searchWord.equals("")) {
			sql = "SELECT COUNT(*) cnt From manager";
			stmt = conn.prepareStatement(sql);
		} else {
			sql = "SELECT COUNT(*) cnt From manager WHERE manager_id like ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
		}
			
		System.out.printf("stmt totalClientCount:%s\n", stmt);
			
		ResultSet rs = stmt.executeQuery();
			
		if(rs.next()) {
			totalRow = rs.getInt("cnt");
		}
			
		return totalRow;
	}
		
	
	// 관리자 삭제 메서드
	public static int deleteManager(int managerNo) throws Exception{
		System.out.println("~~~~~~~~~~~~~~~딜리트 매니저 실행~~~~~~~~~~~~~~~");
		// 1.쿼리 정의
		/*
		 * DELETE FROM [테이블] WHERE [조건]
		 */
		String sql = "DELETE FROM manager WHERE manager_no = ? ";
		
		//2.전처리 변수생성,초기화
		int rowCnt = 0;
				
		// 3. DB 처리
		Connection conn = DButil.getConnection(); //커넥션 메서드
				
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, managerNo);
		ResultSet rs = stmt.executeQuery();
		System.out.println("delete Manager stmt : "+stmt);
		System.out.println("delete Manager rs : "+rs);
				
		rowCnt = stmt.executeUpdate();  // 입력성공시 1, 실패 0
		
		//4.
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
			sql = "SELECT count(*) FROM manager";
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
	
	
	//리스트 메서드
	public static ArrayList<Manager> selectManagerList(int beginRow, int rowPerPage, String searchWord) throws Exception{

		System.out.println("~~~~~~~~~~~~~~~셀렉트 매니저 리스트실행~~~~~~~~~~~~~~~");
		//리턴값 초기화
		 ArrayList<Manager> list = new ArrayList<>();	 
		//처리
		 Connection conn = DButil.getConnection();
		 PreparedStatement stmt = null;
		 String sql="";
		 
		 if(searchWord.equals("")) {//검색어가 없으면
			sql = "SELECT manager_no managerNo, manager_id managerID, manager_name managerName, manager_date managerDate, manager_level managerLevel FROM manager ORDER BY manager_date DESC LIMIT ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			System.out.println("stmt managerList: "+ stmt);
		 } else {//검색어가 있으면
			sql = "SELECT manager_no managerNo, manager_id managerID, manager_name managerName, manager_date managerDate, manager_level managerLevel FROM manager WHERE manager_id like ? ORDER BY manager_date DESC LIMIT ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
			System.out.println("stmt managerList: "+ stmt);
		 }
		 
		 
		 ResultSet rs = stmt.executeQuery();
		 while(rs.next()) {
			 Manager m = new Manager(); // 잠깐 쓰일때 알파벳이나 temp를 쓴다.
			 m.setManagerNo(rs.getInt("managerNo"));
			 m.setManagerId(rs.getString("managerID"));
			 m.setManagerName(rs.getString("managerName"));
			 m.setManagerDate(rs.getString("managerDate"));
			 m.setManagerLevel(rs.getInt("managerLevel"));
			 
			 list.add(m);//ArrayList에 쿼리 추가
		 }

		//4. 리턴
		 return list;
	}//리스트 메서드 끝
	
	// id 사용가능여부 메소드
	public static String selectManagerId(String managerId) throws Exception {
		System.out.println("~~~~~~~~~~~~~~~셀렉트아이디 실행~~~~~~~~~~~~~~~");
		// 1.쿼리 정의
		String sql = "SELECT manager_id FROM manager WHERE manager_id = ?";

		//2.전처리 변수생성,초기화
		String returnManagerId = null;
		
		// 3. DB 처리
		Connection conn = DButil.getConnection(); //커넥션 메서드
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, managerId);
		ResultSet rs = stmt.executeQuery();	
		System.out.println("select Manager Id stmt : "+stmt);
		System.out.println("select Manager Id rs : "+rs);
		
		//쿼리끝
		
		if(rs.next()) {
			System.out.println("\t"+managerId+"사용중인 아이디 입니다");
			returnManagerId = rs.getString("manager_id");
		} else {
			System.out.println("\t"+managerId+"사용중인 아이디가 아닙니다");
		}
		// 4. 리턴
		return returnManagerId;
	}//메서드끝
	
	// 입력 메서드
	public static int insertManager(String managerId, String managerPw, String managerName) throws Exception {
		System.out.println("~~~~~~~~~~~~~~~~ 인설트 매니저 메서드 ~~~~~~~~~~~~~~~"); 
		// 1.쿼리 정의
		String sql = "INSERT INTO manager(manager_id, manager_pw, manager_name, manager_date, manager_level) VALUES(?,?,?,now(),0)";
		
		//2.전처리 변수생성,초기화
		int rowCnt = 0; 
		
		// 3. DB 처리
		Connection conn = DButil.getConnection(); //커넥션 메서드
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, managerId);
		stmt.setString(2, managerPw);
		stmt.setString(3, managerName);
		rowCnt = stmt.executeUpdate();
		System.out.println("insert Manager stmt : "+stmt);
		
		// 4. 리턴
		return rowCnt;
	}//입력메서드
	
	// 로그인 메서드
	public static Manager login(String managerId, String managerPw) throws Exception { //예외가 발생하면 throw //리턴값을 1개. 입력값을 2개인데, 묶어서 보내기도함.
		System.out.println("~~~~~~~~~~~~~~~~ 매니저 로그인 메서드 ~~~~~~~~~~~~~~~"); 
		//0. 쿼리 전처리
		Manager m = null;
		/*
		 * 매니저 아이디와 패스워드를 받아서, 아이디랑 네임을 가져온다.
		 * SELECT manager_id, manager_name 
		 * From manager
		 * WHERE manager_id=? and manager_pw=? and manager_level>0 레벨이 0이 넘을때만.
		 */
		String sql = "SELECT manager_id, manager_name, manager_level From manager WHERE manager_id=? and manager_pw=?";
		
		
		//1. 정보불러오기
		Class.forName("org.mariadb.jdbc.Driver");
		System.out.print("\n"); 
		
		Connection conn = DButil.getConnection(); //메서드 활용
		System.out.println("~~~~~~입력값 Id,Pw 확인중");	
		System.out.printf("login id=%s, pw=%s\n", managerId, managerPw);
			
			
		PreparedStatement stmt= conn.prepareStatement(sql);
		stmt.setString(1,managerId);
		stmt.setString(2,managerPw);
		ResultSet rs = stmt.executeQuery();
		System.out.println(rs);
		System.out.println("~~~~~~매니저 Id,Pw 확인중");		
			
		if(rs.next()) { // 확인해서 있으면
			System.out.println("~~~~~~매니저 Id,Pw 찾음");	
			m = new Manager();
			m.setManagerId(rs.getString("manager_id"));
			m.setManagerName(rs.getString("manager_name"));
			m.setManagerLevel(rs.getInt("manager_level"));
		}//if
			
		return m;
	}//로그인 메서드끝
	
}//클래스끝