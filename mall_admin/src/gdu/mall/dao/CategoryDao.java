package gdu.mall.dao;

import java.sql.*;
import java.util.ArrayList;

import gdu.mall.util.DButil;
import gdu.mall.vo.Category;

public class CategoryDao {
	//셀렉트 카테고리네임 메서드
	public static ArrayList<String> categoryNameList() throws Exception{
			System.out.println("~~~~~~~~~~~~~~~~ 카테고리 네임 리스트  메서드 ~~~~~~~~~~~~~~~");
			//1. 쿼리
			String sql = "SELECT category_name FROM category ORDER BY category_weight DESC";
			//2.
			
			//3.	
			Connection conn = DButil.getConnection();//메서드
			PreparedStatement stmt = conn.prepareStatement(sql);
			System.out.println("Category Name stmt : "+stmt);
			
			ResultSet rs = stmt.executeQuery();
			
			ArrayList<String> list = new ArrayList<>();
			//list란 이름인 String타입의 arraylist를 만든다.
			//ArrayLIst<String> list = new ArrayList<String>(); 
			//이라고 되어있다면 String객체들만 add되어질수있고 다른 타입의 객체는 사용이 불가능합니다.
			while(rs.next()) {
				list.add(rs.getString("category_name"));
			}
			return list;
	}//셀렉트 카테고리네임 메서드
	
	//셀렉스 리스트 메서드
	public static ArrayList<Category> selectCategoryList() throws Exception{
			System.out.println("~~~~~~~~~~~~~~~~ 셀렉트  리스트  메서드 ~~~~~~~~~~~~~~~");
			//1. 쿼리는 뒤에 쓰는걸로
			
			//2.
			
			//3.
			String sql = "SELECT category_name categoryName, category_weight categoryWeight FROM category ORDER BY category_weight DESC";
			PreparedStatement stmt = null;
			
			Connection conn = DButil.getConnection();//메서드
			stmt = conn.prepareStatement(sql);
			System.out.println("selectCategoryList stmt : "+stmt);
			
			ResultSet rs = stmt.executeQuery();
			ArrayList<Category> list = new ArrayList<>();
			
			while(rs.next()) {
				Category c = new Category();
				c.setCategoryName(rs.getString("categoryName"));
				c.setCategoryWeight(rs.getInt("categoryWeight"));
				list.add(c);
			}
			return list;
	}//리스트 메서드

	// 삭제 메서드
	public static void deleteCategory(String categoryName) throws Exception{
			System.out.println("~~~~~~~~~~~~~~~딜리트 카테고리 실행~~~~~~~~~~~~~~~");
			// 1.쿼리 정의
			/*
			 * DELETE FROM [테이블] WHERE [조건]
			 */
			String sql = "DELETE FROM category WHERE category_name = ? ";
					
			//2.전처리 변수생성,초기화
			int rowCnt = 0; // 입력성공시 1, 실패 0
							
			// 3. DB 처리
			Connection conn = DButil.getConnection(); //커넥션 메서드
							
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, categoryName);
			System.out.println("delete category stmt : "+stmt);
							
			stmt.executeUpdate();
			//쿼리끝

		}// 삭제 메서드		
		
		// 수정 메서드
		public static void updateCategory (int categoryWeight, String categoryName) throws Exception{
			System.out.println("~~~~~~~~~~~~~~~업데이트 카테고리 실행~~~~~~~~~~~~~~~");
			// 1.쿼리 정의
			/*
			 * update테이블 set열 = 변경할값, where 조건
			 */
			String sql="UPDATE category SET category_weight =? WHERE category_name=?";
			
			Connection conn = DButil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, categoryWeight);
			stmt.setString(2, categoryName);
			System.out.println("updateCategory stmt : "+stmt);
			
			stmt.executeUpdate();
			
			ResultSet rs = stmt.executeQuery();
			System.out.println("update category stmt : "+stmt);
						
			stmt.executeUpdate();
		
		}//수정메서드	
		
		// categoryName 중복체크 메서드
		public static String selectCategoryName(String categoryName) throws Exception {
			System.out.println("~~~~~~~~~~~~~~셀렉트 카테고리 실행~~~~~~~~~~~~~~~");

			String sql = "SELECT category_Name categoryName FROM category WHERE category_Name = ?";
						
			String returnCategoryName = null;
					
			Connection conn = DButil.getConnection();
						
			PreparedStatement stmt = conn.prepareStatement(sql);
			System.out.println("selectCategoryName "+stmt);
						
			stmt.setString(1, categoryName);
			ResultSet rs = stmt.executeQuery();		
			if(rs.next()) {
				returnCategoryName = rs.getString("categoryName");
			}
			return returnCategoryName;
		}//중복 확인메서드
		
		//카테고리 입력
		public static void insertCategory(String categoryName, int categoryWeight) throws Exception {
			System.out.println("~~~~~~~~~~~~~~~인설트 카테고리 실행~~~~~~~~~~~~~~~");

			String sql="INSERT INTO category(category_name, category_weight, category_date) VALUES(?,?,now())";
			
			Connection conn = DButil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, categoryName);
			stmt.setInt(2, categoryWeight);
			System.out.println("insertCategory stmt : "+stmt);
			
			stmt.executeUpdate();
		}
}// class