package gdu.mall.dao;

import java.sql.*;
import gdu.mall.util.*;
import java.util.*;
import gdu.mall.vo.*;

public class CommentDao {
	public static int selectCommentCnt(int noticeNo) throws Exception {
	      int rowCnt = 0;
	      String sql = "select count(*) cnt from comment where notice_no=?";
	      //DB 연결
	      Connection conn = DButil.getConnection();
	      PreparedStatement stmt = conn.prepareStatement(sql);
	      stmt.setInt(1, noticeNo);
	      
	      System.out.println("selectCommentCnt " + stmt); // 디버깅
	      ResultSet rs = stmt.executeQuery();      
	      if(rs.next()) {
	         rowCnt = rs.getInt("cnt");
	         System.out.println("\t rowCnt-->" + rowCnt);
	      }
	      return rowCnt;
	}//메소드 끝
	
	public static int insertComment(Comment comment) throws Exception{
		int rowCnt = 0;
		
		//1.쿼리
		String sql = "INSERT INTO comment(notice_no ,manager_id, comment_content, comment_date) VALUES (?,?,?,NOW())";
		
		//2.DB연동
		Connection conn = DButil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, comment.getNoticeNo());
		stmt.setString(2, comment.getManagerId());
		stmt.setString(3, comment.getCommentContent());
		
		//3.디버깅
		System.out.printf("stmt: %s<ComentDao.insertcoment>\n", stmt);
		
		//4.쿼리 업데이트
		stmt.executeUpdate();
		return rowCnt;
	}//메소드끝
	
	public static ArrayList<Comment> selectCommentListByNoticeNo(int noticeNo) throws Exception{
		//1.쿼리
		//String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_date noticeDate, manager_id ManagerId FROM notice ORDER BY notice_date DESC LIMIT ?,?";
		
		String sql="SELECT comment_no commentNo, manager_id managerId, comment_content commentContent, comment_date commentDate FROM comment WHERE notice_no=?";
		ArrayList<Comment> list = new ArrayList<>();
		
		//2.DB연동
		Connection conn = DButil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		
		//3.디버깅
		System.out.printf("stmt: %s <CommentDao.selectCommentListByNoticeNo> \n", stmt);
				
		//4.배열 완성
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) { //rs.next()가 있을때까지
			System.out.printf("댓글있음\n");
			Comment cm = new Comment();
			cm.setCommentNo(rs.getInt("commentNo"));
			cm.setManagerId(rs.getString("managerId"));
			cm.setCommentContent(rs.getString("commentContent"));
			cm.setCommentDate(rs.getString("commentDate"));

			list.add(cm);
		}
		return list;
	}//메소드끝
	
	
	//deleteComment 메서드 오버로딩 - 메서드이름은 같고(매개변수 갯수나 값이 다름)
	public static int deleteComment(int commentNo, String managerId) throws Exception{ //comment.commentNo comment.managerId
		String sql = "DELETE from comment where comment_no=? and manager_id =?";
		int rowCnt = 0;
		
		//2.DB연동
		Connection conn = DButil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		stmt.setString(2, managerId);

		//3.디버깅
		System.out.printf("stmt: %s<commenDao.deletecommen>\n", stmt);
		
		//4.쿼리 업데이트
		stmt.executeUpdate();
		return rowCnt;
	}//메소드끝
	
	public static int deleteComment(int commentNo) throws Exception{ //comment.commentNo comment.managerId
		String sql = "delete from comment where comment_no=?";
		int rowCnt = 0;

		//2.DB연동
		Connection conn = DButil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);

		//3.디버깅
		System.out.printf("stmt: %s<commenDao.deletecommen>\n", stmt);
		
		//4.쿼리 업데이트
		stmt.executeUpdate();
		
		return rowCnt;
	}//메소드끝
}
