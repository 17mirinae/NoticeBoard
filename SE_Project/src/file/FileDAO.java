package file;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Connection;

//File 테이블 관련 DAO(Database Access Object)를 작성합니다.
public class FileDAO {
	private Connection conn;
	String sql = "";

	public FileDAO() {
		try {
			String url = "jdbc:mysql://localhost:3308/testdb";
			String id = "kim";
			String pw = "123123";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, id, pw);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int upload(String name, String title, String content, String fileName, String fileRealName,
			String date_month, String date_day) {
		sql = "insert into file value(?,?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, title);
			pstmt.setString(3, content);
			pstmt.setString(4, fileName);
			pstmt.setString(5, fileRealName);
			pstmt.setString(6, date_month);
			pstmt.setString(7, date_day);

			return pstmt.executeUpdate();// 정상적으로 성공한 경우 1의 값을 반환함

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	public int delete(String name, String title, String password) {
		System.out.println("이름;" + name + "/제목:--" + title + "/비번;" + password);
		boolean key = false;
		if (name.equals("김성은") && password.equals("2015301014")) {
			key = true;
		} else if (name.equals("정주영") && password.equals("2015301073")) {
			key = true;
		} else if (name.equals("정민지") && password.equals("2017301067")) {
			key = true;
		} else if (name.equals("박성형") && password.equals("2017301029")) {
			key = true;
		} else if (name.equals("고승윤") && password.equals("2013301003")) {
			key = true;
		}

		if (key == true) {
			sql = "delete from file where title='" + title + "'";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt = conn.prepareStatement(sql);

				return pstmt.executeUpdate();// 정상적으로 성공한 경우 1의 값을 반환함

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
	
	//작성자이름,바꾼제목,원래제목(for update문 조건문에 사용됨),바꾼내용,바꾼파일명,원래파일명,월,일,비번
	public int modify(String name, String title,String now_title, String content, String fileName, String now_fileName,String password) {
		
		System.out.println("FileDAO---->이름:" + name + "///원래제목:" + now_title +"//바뀐제목:"+title +"//내용:" + content + "/비번:" + password 
									+"///바꾼파일이름:" + fileName + "//기존 파일이름" + now_fileName);

		boolean key = false;
		if (name.equals("김성은") && password.equals("2015301014")) {
			key = true;
		} else if (name.equals("정주영") && password.equals("2015301073")) {
			key = true;
		} else if (name.equals("정민지") && password.equals("2017301067")) {
			key = true;
		} else if (name.equals("박성형") && password.equals("2017301029")) {
			key = true;
		} else if (name.equals("고승윤") && password.equals("2013301003")) {
			key = true;
		}

		if (key == true) {
			if (fileName.equals("nofileName")) {//파일 수정 안했을때 
				sql = "update file set title='" + title + "', content='" + content + "',fileName='"+now_fileName+"',fileRealName='"+now_fileName+"'"
							+"where title='"+now_title+"'";
			}else {//파일 수정 했을 때 
				sql = "update file set title='" + title + "', content='" + content + "',fileName='"+fileName+"',fileRealName='"+fileName+"'"
						+"where title='"+now_title+"'";
			}
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt = conn.prepareStatement(sql);

				return pstmt.executeUpdate();// 정상적으로 성공한 경우 1의 값을 반환함

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
}
