package com.mystudy.jdbc1_statement;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Student_Insert {
	public static void main(String[] args) {
		//JDBC 이용한 DB 연동 프로그래밍 작성 절차
		//0. JDBC 라이브러리 개발환경 설정(빌드경로에 등록)
		//1. JDBC 드라이버 로딩 - 빌드패스
		//2. DB연결 - Connection 객체 생성 <- DriverManager
		//3. Statement 문 실행(SQL 문 실행)
		//4. SQL 실행 결과에 대한 처리
		//   - SELECT : 조회(검색) 데이터 결과 값에 대한 처리    // 반드시 전달받은 데이터로 작업처리하기
		//   - INSERT, UPDATE, DELETE : int 값(건수) 처리 // 실행결과가 db에 들어감
		//5. 클로징 처리에 의한 자원 반납
		//----------------------------------
		
		Connection conn = null; 
		Statement stmt = null;
		ResultSet rs = null;
		
		//1. JDBC 드라이버 로딩
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			System.out.println(">> 드라이버 로딩 성공");
		
		//2. DB연결 - Connection 객체 생성 <- DriverManager
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", 
				"MYSTUDY", "mystudypw");
		//conn에 저장을 해줘야 Connection타입의 연결객체를 사용할 수 있게된다.
			
		//3. Statement 문 실행(SQL 문 실행)
		stmt = conn.createStatement();
		String id = "2023005";
		String name = "김유신5";
		int kor = 100;
		int eng = 90;
		int math = 80;
		int tot = 0;
		double avg = 0;
		
		//statement 타입은 문자열 붙이기 방식으로 sql문장을 처리한다.
		String sql = "";
		sql += "INSERT INTO STUDENT ";
		sql += " (ID, NAME, KOR, ENG, MATH, TOT, AVG)";
//		sql += " VALUES ('2023003', '김유신', 100, 90, 80, 0, 0)";
		sql += " VALUES ('" + id + "', '" + name +"', " + kor + ", " + eng + ", " + eng + ") ";
		//자바에서는 소괄호 안에 세미콜론 넣지 않는다. : 오류 :  invalid character
		// "+id+" 옆에 작은 따옴표가 달라붙는 이유 : SQL문이기 때문에 문자열 ''
 		// 변수값 사용 시 문자열 붙이기 해줘야 한다. 
		// 문자 타입은 "" 붙여줘야함. 숫자 타입은 붙이지 않는다.
		System.out.println("sql : " + sql);
		
		//INSERT, UPDATE, DELETE 실행 : executeUpdate(sql)
		//SELECT : excuteQuery
		int result = stmt.executeUpdate(sql);
		
		//4. SQL 실행 결과에 대한 처리
		//   - SELECT : 조회(검색) 데이터 결과 값에 대한 처리    // 반드시 전달받은 데이터로 작업처리하기
		//   - INSERT, UPDATE, DELETE : int 값(건수) 처리 // 실행결과가 db에 들어감
		System.out.println("처리건수 : " + result);
		
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} finally {
			//5. 클로징 처리에 의한 자원 반납
			try {
				if (stmt != null) stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if (conn != null) conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}

	}

}