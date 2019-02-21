<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
		
<html>
<head>
<meta charset="UTF-8">
<title>SE LabBoard</title>
  <link rel="stylesheet" href="/css/bootstrap.css"> 
</head>
<body>
<pre><b><font size=12>SE Lab's Board</font></b>
<div class="container" align="right"><span align="left"><a href='http://www.naver.com' title='Calendar'><img src="/resources/icon/calendar.png"></a></span><span
 style="margin-left:980px;"><a href='#' title='My Page'><img src="/resources/icon/mypage.png"></a>&nbsp; &nbsp; &nbsp;<a href='#' title='Logout'><img src="/resources/icon/logout.png"></a></span>
</div>
</pre>
<br>
<div class="container" align="right">
	<form id="boardSearch" name="boardSearch" onsubmit="return false;" method="post">
	<b>
	<select id="type" name="type" style="text-align:center; border:solid; width:90px; height:30px;">
			<option value="" disabled selected>검색</option>
			<option value="제목">제목</option>
			<option value="기타">작성자</option>
			<optgroup label="분류">분류	
				<option value="자료">자료</option>
				<option value="공지사항">공지사항</option>
				<option value="기타">기타</option>
			</optgroup>
	</select>
	</b>
		<input type="text" id="value" name="value" style="border:solid; width:120px; height:30px;">&nbsp;&nbsp;
		<a href='#' Onclick='fn_search()' title='Board Search'><img src="/resources/icon/search.png"></a>
	</form>
</div>

<div class="container">
    <form id="boardForm" name="boardForm" method="post"> 
	<table class="table table-striped table-hover">
		<thead>
			<tr></tr>
			<tr>
				<th>번호</th>
				<th>분류</th>
				<th>제목</th>
				<th>작성자</th>
				<th>최초 게시일</th>
				<th>마지막 수정일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${memberList}" var="member" varStatus="status">
				<tr>
					<td><c:out value="${member.num}"/></td>
					<td><c:out value="${member.type}"/></td>
					<td><b><a href='#' onClick='fn_view(${member.num})'><c:out value="${member.title}"/></a></b></td>
					<td><c:out value="${member.writer_name}"/></td>
					<td><c:out value="${member.first_date}"/></td>
					<td><c:out value="${member.update_date}"/></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div align="right">
	<a href='/writeForm' title='Add new Board'><img src="/resources/icon/add_board.png"></a>
	</div>
	</form>
	
<script> 
//글조회
function fn_view(num){
    
    var form = document.getElementById("boardForm");
    var url = "<c:url value='/viewForm' />";
    url = url + "?num=" + num;
    
    form.action = url;    
    form.submit(); 
}
//글검색
function fn_search(){
    
    var form = document.getElementById("boardSearch");
    var url = "<c:url value='/search' />";
    
    form.action = url;    
    form.submit(); 
}
</script>
</div>

</body>
</html>
