<%@ page import="file.FileDAO"%>
<%@ page import="java.io.File"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 파일 업로드</title>
</head>
<body>
	<%
		java.util.Calendar cal = java.util.Calendar.getInstance(); //Calendar객체 cal생성
		int currentMonth = cal.get(java.util.Calendar.MONTH);
		int currentDate = cal.get(java.util.Calendar.DATE);
		
		String directory = application.getRealPath("/upload/");
		int maxSize = 1024 * 1024 * 100;
		String encoding = "UTF-8";

		MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxSize, encoding,
				new DefaultFileRenamePolicy());

		String name = multipartRequest.getParameter("name");
		String title = multipartRequest.getParameter("title");
		String content = multipartRequest.getParameter("content");
		String fileRealName = multipartRequest.getFilesystemName("file");
		String fileName = multipartRequest.getOriginalFileName("file");
		String date_month =String.valueOf(currentMonth+1);
		String date_day =String.valueOf(currentDate);

		new FileDAO().upload(name, title, content, fileName, fileRealName, date_month, date_day);
		response.sendRedirect("http://localhost:8080/SE_Project/DetailBox.jsp?month="+date_month+"&day="+date_day);
	%>

</body>
</html>