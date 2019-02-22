<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
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
<!-- <script language="JavaScript">
function pagestart() {
window.setTimeout("pagereload()", 5000);
}
function pagereload() {
location.reload();
}
</script> -->
</head>

<body bgcolor="#eebc71">
	<%
		int int_today = 0;
		int int_day = 0;
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		String today = request.getParameter("today");
		String[] post = new String[100];

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

			sql = "select * from schedule where date_month='" + month + "' and date_day='" + day + "'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				post[i] = rs.getString("title");
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
		//out.println("today="+Integer.parseInt(today)+"/selectedDay="+day);
		if (int_today <= int_day) {
	%>
	<form name="addScheduleFORM" method="POST" align="left">
		제목<br> <input type="text" name="title" size="22"><br>
		파일<br> <input type="text" name="title" size="22"><br>
		내용<br>
		<textarea name="content" rows="2" cols="25"></textarea>
		<br> <br> <input type="submit" name="uploadBtn" value="업로드">&nbsp;&nbsp;<input
			type="reset" name="resetBtn" value="초기화">
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
			<li><a href="showPost.html?title=<%=post[c]%>" target='main'><%=post[c]%>&nbsp;</a></li>
			<br>

		</h4>
		<%
			}
		%>
	</ul>
	<%
		try {
			String url = "jdbc:mysql://localhost:3308/testdb";
			String id = "kim";
			String pw = "123123";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, id, pw);

			String getName = "se";
			String getTitle = request.getParameter("title");
			if (getTitle.equals("")) {
				out.println("<script>alert('모든 칸을 채우세요');</script>");
			} else {
				sql = "insert into schedule(name,title,date_month,date_day) values(?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, getName);
				pstmt.setString(2, getTitle);
				pstmt.setString(3, month);
				pstmt.setString(4, day);

				pstmt.executeUpdate();
				System.out.println("디비에 추가하기 성고고오옹");
				//화면이동(다시 달력으로)
				response.sendRedirect("DetailBox.html?month=" + month + "&day=" + day);
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
</body>

</html>