<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body bgcolor="#ffeedd" align="center">
	<%
		String name = request.getParameter("name");
		String title = request.getParameter("title");
	%>
	<h2>수정하려면 비밀번호를 입력하세요!</h2>
	<form action="modifyReForm.jsp?name=<%=name %>&title=<%=title %>" method="post">
		비밀번호:<input type="text" name="password"><input type="submit"
			name="passwordBtn" value="확인">
	</form>
</body>
</html>