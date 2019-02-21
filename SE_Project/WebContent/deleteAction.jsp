<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="file.FileDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body bgcolor="#ffeedd">
	<%
		String name = request.getParameter("name");
		String title = request.getParameter("title");
		String password = request.getParameter("password");
		System.out.println("deleteForm->이름:"+name+"///제목:"+title+"///비번:"+password);
		new FileDAO().delete(name, title, password);
		//placeholder="Enter your username"

		response.sendRedirect("http://localhost:8080/SE_Project/Calendar.jsp");
	%>
</body>
</html>