<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="file.FileDAO"%>
<%@ page import="java.io.File"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>디테일 화면</title>
<style>
a {
	text-decoration: none;
	color: black;
}
</style>
</head>
<body bgcolor="#eebc71">

	<%
		int int_today = 0;
		int int_day = 0;
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		String today = request.getParameter("today");
		String[] post_t = new String[100];
		String[] post_n = new String[100];

		if (today == null) {
			today = "0";
		}
		int_today = Integer.parseInt(today);
		int_day = Integer.parseInt(day);

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int i = 0;

		try {
			String url = "jdbc:mysql://localhost:3308/testdb";
			String id = "kim";
			String pw = "123123";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, id, pw);
			System.out.println("디테일박스_연결성공입니당~");

			sql = "select * from file where date_month='" + month + "' and date_day='" + day + "'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				post_t[i] = rs.getString("title");
				post_n[i] = rs.getString("name");
				++i;
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
	%>
	<h2><%=month%>월
		<%=day%>일
	</h2>
	<hr>
	<%
		if (int_today <= int_day) {
	%>
	<form action="uploadAction.jsp" method="post" enctype="multipart/form-data">
		작성자:<input type="text" name="name"><br> 
		제목:<input type="text" name="title"><br>
		내용:<input type="text" name="content"><br> 
		파일:<input type="file" name="file"><br>
		<br> <input type="submit" value="업로드"><br>
	</form>
	<hr>
	<%
		}
	%>
	<ul align="left">
		<%
			for (int c = 0; c < i; c++) {
		%>
		<h4>

			<li><a href="fileDownload.jsp?title=<%=post_t[c]%>" target='main'><%=post_n[c]+"_"%><%=post_t[c]%>&nbsp;</a></li>
			<br>

		</h4>
		<%
			}
		%>
	</ul>
</body>
</html>