<%@ page import="java.io.File"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 파일 디비전체보기</title>
</head>
<body bgcolor="#ffeedd" align="center">
	<%
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		String gettitle = request.getParameter("title");

		String directory = application.getRealPath("/upload/");
		String files[] = new File(directory).list();

		try {
			String url = "jdbc:mysql://localhost:3308/testdb";
			String id = "kim";
			String pw = "123123";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, id, pw);
			System.out.println("디비_연결성공입니당~");

			sql = "select * from file where title='" + gettitle + "'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
	%>
			<table border=1 align="center">
			<tr>
			<td>날짜</td><td>작성자</td><td>제목</td><td>내용</td><td>파일</td>
			</tr>
	<%
		while (rs.next()) {
				String name = rs.getString("name");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String date_month = rs.getString("date_month");
				String date_day = rs.getString("date_day");
				String fileName = rs.getString("fileName");
				
				out.write("<tr><td>" + date_month + "월 " + date_day + "일" + "</td>");
				out.write("<td>" + name + "</td><td>" + title + "</td><td>" + content + "</td>");
				out.write("<td><a href=\"" + request.getContextPath() + "/downloadAction?file="
						+ java.net.URLEncoder.encode(fileName, "UTF-8") + "\">" + fileName + "</a></td>");
				out.write("</tr></table>");
	%>
		<input type="button" name="backBtn" value="뒤로가기" 
			onclick="window.location.href='http://localhost:8080/SE_Project/Calendar.jsp'">
		<input type="button" name="modifyBtn" value="수정하기"
			onclick="window.location.href='http://localhost:8080/SE_Project/modifyForm.jsp?title=<%=title %>&name=<%=name%>'">	
		<input type="button" name="deleteBtn" value="삭제하기" 
			onclick="window.location.href='http://localhost:8080/SE_Project/deleteForm.jsp?title=<%=title %>&name=<%=name%>'">	
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
	%>
</body>
</html>