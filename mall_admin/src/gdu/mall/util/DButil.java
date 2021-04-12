/*
 * src 패키지 폴더 안에 
 * gdu.mall.util 패키지 안에
 * DButil.java
 */

package gdu.mall.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DButil {
	public static Connection getConnection() throws Exception{
		//System.out.println("~~~~~~~~~~~~~~~~ 커넥션 컨 메서드 ~~~~~~~~~~~~~~~"); 
		//com.mysql.jdbc.Driver
		String url ="jdbc:mysql://localhost:3306/mall"; // 맨뒤가 데이터 베이스
		String user = "root";
		String pwd = "java1004"; 
		
		Connection conn = DriverManager.getConnection(url, user, pwd);
		//System.out.println(conn);
		//System.out.println("~~~~~~mall DB:연결 성공");
		
		return conn;
	}
}