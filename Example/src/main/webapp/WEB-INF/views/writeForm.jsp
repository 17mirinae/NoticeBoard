<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>Write Board</title>
<link rel="stylesheet" href="/css/bootstrap.css">
</head>

<body>
<pre><b><font size=12>Write New Board</font></b>
<div class="container" align="right"><a href='#' title='My Page'><img src="/resources/icon/mypage.png"></a>&nbsp; &nbsp; &nbsp;<a
				href='#' title='Logout'><img src="/resources/icon/logout.png"></a>
</div>
</pre>
<br>
	<div class="container">
		<form id="writeForm" name="writeForm" onsubmit="return false;" method="post"  enctype="multipart/form-data">
			<div>
				<div>
					<table class="table table-striped table-hover">
						<tr>
							<th>분류</th>
							<td><b>
							<select id="type" name="type" style="text-align:center; border:solid; width:110px; height:30px;">
								<option disabled selected>분류</option>
								<option>자료</option>
								<option>공지사항</option>
								<option>기타</option>
							</select>
							</b></td>
						</tr>
						<tr>
							<th>제목</th>
							<td><input style="width: 700px; height: 30px;" type="text" id="title"
								name="title" /></td>
						</tr>
						<tr>
							<th>내용</th>
							<td><textarea style="width: 700px; height:300px;" rows="10" cols="10"
									id="content" name="content"></textarea></td>
						</tr>
						<tr>
							<th>작성자</th>
							<td>
							<select id="writer" name="writer" style="text-align:center; border:solid; width:110px; height:30px;">
								<option disabled selected>작성자</option>
								<c:forEach items="${userList}" var="user"><option value="${user.name}"><c:out value="${user.name}"/></option></c:forEach>
							</select>
							</td>
						</tr>
						<tr>
							<th>첨부파일</th>
							<td><input type="file" id="filename" name="filename"/></td>
						</tr>
					</table>
					<div align="right">
						<a href='#' onClick='fn_nullConfirm(${fn:length(memberList)})' title="Complete"><img src="/resources/icon/check.png"></a>&nbsp; &nbsp; &nbsp; 
						&nbsp; &nbsp; &nbsp; <a href='/' title="Back"><img src="/resources/icon/odelete.png"></a>
					</div>
				</div>
			</div>
		</form>


		<script>
			// type, title, writer의 value가 null인지 확인
			function fn_nullConfirm(length) {
				var type = document.getElementById("type").value;
				var title = document.getElementById("title").value;
				var writer = document.getElementById("writer").value;

				if (type!="분류" && writer!="작성자" && title!="")
					fn_addtoBoard(length);
				else
					fn_popup();
			}
			
			// null값이면 확인 팝업
			function fn_popup() {
				var x = confirm("분류, 제목, 작성자를 모두 입력해주세요!!");
				if (x)
					return false;
			}
			//글쓰기
			function fn_addtoBoard(length) {
				length = length+1;
				var form = document.getElementById("writeForm");
				form.action = "<c:url value='/write?length="+length+"'/>";
				form.submit();
			}
		</script>
	</div>
</body>
</html>
