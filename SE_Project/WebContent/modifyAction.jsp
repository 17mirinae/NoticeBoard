<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="file.FileDAO"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String directory = application.getRealPath("/upload/");
		int maxSize = 1024 * 1024 * 100;
		String encoding = "UTF-8";

		MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxSize, encoding,
				new DefaultFileRenamePolicy());
		
		String name =  request.getParameter("name");
		String title = multipartRequest.getParameter("title");
		String now_title =request.getParameter("now_db_title");
		String content = multipartRequest.getParameter("content");
		String password = request.getParameter("password");
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		String fileName = multipartRequest.getOriginalFileName("file");
		String now_fileName=request.getParameter("now_db_fileName");

		System.out.println("modifyAction->이름:" + name +"/원래제목:"+ now_title+"///바꾼제목:" + title + "//내용:" + content + "/비번:" + password
				+ "///달:" + month + "///일:" + day + "///바꾼파일이름:" + fileName+"//기존 파일이름"+now_fileName);
		if(fileName==null){
			fileName="nofileName";
		}
		new FileDAO().modify(name, title,now_title,content, fileName,now_fileName,password);

		response.sendRedirect("http://localhost:8080/SE_Project/Calendar.jsp");
	%>
</body>
</html>