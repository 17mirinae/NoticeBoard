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
<title>게시글 보기</title>
</head>
<body bgcolor="#ffeedd">
	<%
		String title = request.getParameter("title");

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int i = 0;
		String name=null;
		String month=null;
		String day=null;

		try {
			String url = "jdbc:mysql://localhost:3308/testdb";
			String id = "kim";
			String pw = "123123";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, id, pw);
			System.out.println("showPost_연결성공입니당~");

			sql = "select * from schedule where title='" + title+ "'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				name=rs.getString("name");
				month=rs.getString("date_month");
				day=rs.getString("date_day");
			}
		%>
		<table border=1 align=center width=300 height=300>
		<tr>
		<td>날짜</td><td><%=month %>월 <%=day %>일</td></tr>
		<tr>
		<tr>
		<td>제목</td><td><%=title %></td></tr>
		<tr>
		<tr>
		<td>작성자</td><td><%=name %></td></tr>
		<tr>
		<tr>
		<td>내용</td><td> </td></tr>
		<tr>
		<tr>
		<td>파일</td><td><input type="button" name="downloadBtn" value="다운로드"></td>
		</tr>
		<tr><td colspan=2 align=center><input type="button" name="backBtn" value="뒤로가기"
			 onclick="window.location.href='http://localhost:8080/noLabProject/Calendar'" align="center"></td></tr>
		</table>
		<%
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