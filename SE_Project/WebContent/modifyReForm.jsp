<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body bgcolor="#ffeedd" align="center">
	<%
		java.util.Calendar cal = java.util.Calendar.getInstance(); //Calendar객체 cal생성
		int currentYear = cal.get(java.util.Calendar.YEAR); //현재 날짜 기억
		int currentMonth = cal.get(java.util.Calendar.MONTH);
		int currentDate = cal.get(java.util.Calendar.DATE);

		String name = request.getParameter("name");
		String title = request.getParameter("title");
		String password = request.getParameter("password");
		System.out.println("이름:" + name + "./비번:" + password);

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

			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "";
			String db_name = "";
			String db_title = "";
			String db_content = "";
			String db_fileName = "";
			String date_month = String.valueOf(currentMonth + 1);
			String date_day = String.valueOf(currentDate);

			try {
				String url = "jdbc:mysql://localhost:3308/testdb";
				String id = "kim";
				String pw = "123123";
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection(url, id, pw);

				sql = "select * from file where title='" + title + "'";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					db_name = rs.getString("name");
					db_title = rs.getString("title");
					db_content = rs.getString("content");
					db_fileName = rs.getString("fileName");

					System.out.println("파이리:" + db_fileName);
	%>
	<form
		action="modifyAction.jsp?month=<%=date_month%>&day=<%=date_day%>&password=<%=password%>&name=<%=db_name%>&now_db_fileName=<%=db_fileName%>&now_db_title=<%=db_title %>"
		method="post" enctype="multipart/form-data">
		제목:<input type="text" name="title" value=<%=db_title%>><br>
		내용:<input type="text" name="content" value=<%=db_content%>><br>
		파일:(기존 파일명:<%=db_fileName%>)<input type="file" name="file"
			value=<%=db_fileName%>><br> <br> <input
			type="submit" value="업로드"><br>
	</form>
	<%
		}

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (rs != null) {
					try {
						rs.close();
					} catch (SQLException sqle) {
					}
				}
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException sqle) {
					}
				}
				if (conn != null) {
					try {
						conn.close();
					} catch (SQLException sqle) {
					}
				}
			}
		}else{
			System.out.println("비밀번호 오류!!!");
			response.sendRedirect("http://localhost:8080/SE_Project/Calendar.jsp");
		}
	%>
</body>
</html>