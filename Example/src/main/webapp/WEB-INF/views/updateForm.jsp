<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>Update Board</title>
<link rel="stylesheet" href="/css/bootstrap.css">
</head>

<body>
<pre><b><font size=12>Update Board</font></b>
<div class="container" align="right"><a href='#' title='My Page'><img src="/resources/icon/mypage.png"></a>&nbsp; &nbsp; &nbsp;<a
				href='#' title='Logout'><img src="/resources/icon/logout.png"></a>
</div>
</pre>
<br>
	<div class="container">
		<form id="updateForm" name="updateForm" onsubmit="return false;" method="post" enctype="multipart/form-data">
			<div>
				<div>
					<table class="table table-striped table-hover">
					<c:forEach items="${memberList}" var="member">
						<tr>
							<th>분류</th>
							<td><b>
							<c:choose>
								<c:when test="${member.type eq '자료'}">
									<select id="type" name="type" style="text-align:center; border:solid; width:110px; height:30px;">
										<option disabled selected>분류</option>
										<option selected>자료</option>
										<option>공지사항</option>
										<option>기타</option>
									</select>
								</c:when>
								<c:when test="${member.type eq '공지사항'}">
									<select id="type" name="type" style="text-align:center; border:solid; width:110px; height:30px;">
										<option disabled selected>분류</option>
										<option>자료</option>
										<option selected>공지사항</option>
										<option>기타</option>
									</select>
								</c:when>
								<c:otherwise>
									<select id="type" name="type" style="text-align:center; border:solid; width:110px; height:30px;">
										<option disabled selected>분류</option>
										<option>자료</option>
										<option>공지사항</option>
										<option selected>기타</option>
									</select>
								</c:otherwise>
							</c:choose>
							</b></td>
						</tr>
						<tr>
							<th>제목</th>
							<td><input style="width: 700px; height: 30px;" type="text" id="title"
								name="title" value="<c:out value="${member.title}"/>"/></td>
						</tr>
						<tr>
							<th>내용</th>
							<td><textarea style="width: 700px; height:300px;" rows="10" cols="10"
									id="content" name="content"><c:out value="${member.content}"/></textarea></td>
						</tr>
						<tr>
							<th>작성자</th>
							<td>
								<c:out value="${member.writer_name}"/>
							</td>
						</tr>
						<tr>
							<th>첨부파일</th>
							<td> </td>
						</tr>
					</c:forEach>
					</table>
					<c:forEach items="${memberList}" var="member">
					<div align="right">
						<a href='#' onClick='fn_updateBoard(${member.num})' title="Complete"><img src="/resources/icon/check.png"></a>&nbsp; &nbsp; &nbsp; 
						&nbsp; &nbsp; &nbsp; <a href='/' title="Back"><img src="/resources/icon/odelete.png"></a>
					</div>
					</c:forEach>
				</div>
			</div>
		</form>


		<script>
			//글쓰기
			function fn_updateBoard(number) {
				var form = document.getElementById("updateForm");
				var url = "<c:url value='/update'/>";
			  	url = url + "?num=" + number;
				form.action = url;
				form.submit();
			}

		</script>
	</div>
</body>
</html>
