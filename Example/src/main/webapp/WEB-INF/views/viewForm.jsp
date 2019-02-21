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
<title>View Board</title>
<link rel="stylesheet" href="/css/bootstrap.css">
</head>

<body>
	<pre><b><font size=12>View Board</font></b>
<div class="container" align="right"><span align="left"><a href='/' title='List'><img src="/resources/icon/list.png"></a></span><span 
	style="margin-left:980px;"><a href='#' title='My Page'><img src="/resources/icon/mypage.png"></a>&nbsp; &nbsp; &nbsp;<a href='#' title='Logout'><img src="/resources/icon/logout.png"></a></span>
</div>
</pre>

	<div class="container">
		<form id="viewForm" name="viewForm" method="post">
			<div>
				<div>
					<table class="table table-striped table-hover">
						<c:forEach items="${memberList}" var="member">
						<tr>
							<th>분류</th>
							<td><c:out value="${member.type}"/></td>
						</tr>
						<tr>
							<th>제목</th>
							<td><c:out value="${member.title}"/></td>
						</tr>
						<tr>
							<th>최초 게시일</th>
							<td><c:out value="${member.first_date}" /></td>
						</tr>
						<tr>
							<th>마지막 업데이트일</th>
							<td><c:out value="${member.update_date}" /></td>
						</tr>
						<tr>	
							<th>내용</th>
							<td><c:out value="${member.content}"/></td>
						</tr>
						<tr>
							<th>작성자</th>
							<td><c:out value="${member.writer_name}"/></td>
						</tr>
						<tr>
							<th>첨부파일</th>
							<td> </td>
						</tr>
						</c:forEach>
					</table>
					<c:forEach items="${memberList}" var="member">
						<c:forEach items="${userList}" var="user">
							<c:if test="${member.writer_name eq user.name}">
						<div align="right">
						<a href='#' onClick='fn_popUpdate(${user.number}, ${member.num})' title='Edit board'><img src="/resources/icon/edit_board.png"></a>
						&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <a href='#' onClick='fn_popDelete(${member.num}, ${user.number}, ${fn:length(boardList)})' title='Delete board'><img src="/resources/icon/delete_board.png"></a>
						&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <a href='/' title='List'><img src="/resources/icon/odelete.png"></a>
						</div>
							</c:if>
						</c:forEach>
					</c:forEach>
				</div>
			</div>
		</form>
		<script>
			//수정
			function fn_update(number) {
				var form = document.getElementById("viewForm");
				var url = "<c:url value='/updateForm' />";
				url = url + "?num=" + number;
			  
				form.action = url;
				form.submit();
			}
		
			//수정 확인 팝업
			function fn_popUpdate(passwd, number)
			{
				var userInput = prompt("작성자의 비밀번호를 입력하세요.");
			 	if(userInput == passwd){
			 		var x = confirm("해당 게시물을 수정하시겠습니까?");
			 		 if (x)
					      return fn_update(number);
					  else
					    return false;
			 	}else
			 		return false;
			 }

			//삭제 확인 팝업
			function fn_popDelete(number, passwd, length)
			{
				var userInput = prompt("작성자의 비밀번호를 입력하세요.");
			 	if(userInput == passwd){
			 		var x = confirm("해당 게시물을 삭제하시겠습니까?");
			 		 if (x)
					      return fn_delete(number, length);
					  else
					    return false;
			 	}else
			 		return false;
			 }

			//삭제
			function fn_delete(number, length) {
				var form = document.getElementById("viewForm");
				var url = "<c:url value='/delete' />";
				url = url + "?length="+length+"&num=" + number;
				
			    form.action = url;
				form.submit();
			}
		</script>
	</div>
</body>
</html>