package gdu.mall.dao;

import java.sql.*;
import java.util.ArrayList;
import gdu.mall.util.*;
import gdu.mall.vo.*;

public class NoticeDao {
	//noticeOne 업데이트
	public static void updateNoticeOne(Notice n) throws Exception{
		//1. 쿼리
		String sql = "UPDATE notice SET notice_title=?, notice_content=? WHERE notice_no=?";
		//2. db연동
		Connection conn = DButil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, n.getNoticeTitle());
		stmt.setString(2, n.getNoticeContent());
		stmt.setInt(3, n.getNoticeNo());
		//3. 디버깅
		System.out.printf("stmt: %s<EbookDao.updateNoticeOne>\n", stmt);
		//4. 쿼리 업데이트
		stmt.executeUpdate();
	}
	//공지 삭제
	public static void deleteNotice(int noticeNo) throws Exception{
		//1.쿼리
		String sql = "DELETE FROM notice WHERE notice_no=?";
		//2.DB연동
		Connection conn = DButil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		//3.디버깅
		System.out.printf("stmt: %s<EbookDao.deleteNotice>\n", stmt);
		//4.쿼리 업데이트
		stmt.executeUpdate();
	}
	//공지 추가
	public static void insertNotice(Notice n) throws Exception{
		//1.쿼리
		String sql = "INSERT INTO notice(notice_title,notice_content,notice_date,manager_id) VALUES (?,?,NOW(),?)";
		//2.DB연동
		Connection conn = DButil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, n.getNoticeTitle());
		stmt.setString(2, n.getNoticeContent());
		stmt.setString(3, n.getManagerId());
		//3.디버깅
		System.out.printf("stmt: %s<EbookDao.insertNotice>\n", stmt);
		//4.쿼리 업데이트
		stmt.executeUpdate();
	}
	//naoiceOne
	public static Notice selectNoticeOne(int noticeNo) throws Exception{
		//1.sql
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent, notice_date noticeDate, manager_id managerId FROM notice WHERE notice_no=?";
		//2.초기화
		Notice n = null;
		//3.DB연결
		Connection conn = DButil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		
		//4.디버깅
		System.out.printf("stmt: %s<NoticeDat.selectNoticeOne>\n", stmt);
			
		//5.쿼리완성
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setManagerId(rs.getString("managerId"));
			n.setNoticeContent(rs.getString("noticeContent"));
			n.setNoticeTitle(rs.getString("noticeTitle"));
			n.setNoticeDate(rs.getString("noticeDate"));
			
		}
		//6.리턴값
		return n;
	}
	
	//전체 행의 수 구하기!
	public static int totalCount() throws Exception{
		//1.sql
		String sql="SELECT COUNT(*) cnt FROM notice";
		//2.초기화
		int totalRow = 0;
		//3.db연동
		Connection conn = DButil.getConnection();
		PreparedStatement stmt = null;		
		//4-1.쿼리
		stmt = conn.prepareStatement(sql);

		//4-2.디버깅
		System.out.printf("stmt: %s<NoticeDao.totalCount>\n", stmt);
		//5. 쿼리완성
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			totalRow = rs.getInt("cnt");
		}
		
		//6.리턴값
		return totalRow;
	}
	//noticeList만들기 -시작행, 페이지당 행의 수
	public static ArrayList<Notice> selectNoticeList(int beginRow, int rowPerPage) throws Exception{
		//0.쿼리
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_date noticeDate, manager_id ManagerId FROM notice ORDER BY notice_date DESC LIMIT ?,?";
		//1.초기화
		ArrayList<Notice> list = new ArrayList<>();
	
		//2.DB연동
		Connection conn = DButil.getConnection();
		//3-1.쿼리
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);

		//3-2.디버깅
		System.out.printf("stmt: %s<noticeDao.selectNoticeList>\n", stmt);
		
		//4.게시판 배열 완성
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeTitle(rs.getString("noticeTitle"));
			n.setNoticeDate(rs.getString("noticeDate"));
			n.setManagerId(rs.getString("managerId"));
			
			list.add(n);
		}
		
		//5.리턴값
		return list;
	}

}