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
<title>SE WEB SCHEDULE</title>

<style type="text/css">
td {
	border-radius: 8px;
}

a {
	text-decoration: none;
}
</style>
<script language="JavaScript">
	//<--새로고침 스크립트
	function pagestart() {
		window.setTimeout("pagereload()", 5000);
	}
	function pagereload() {
		location.reload();
	}
//스크립트끝-->
</script>
</head>
<body bgcolor="#ffeedd" onLoad="pagestart()">
	<h3 align="center"
		onclick="window.location.href='http://localhost:8080/noLabProject/Calendar'">SE
		Lab Schedule</h3>
	<%
		java.util.Calendar cal = java.util.Calendar.getInstance(); //Calendar객체 cal생성
		int currentYear = cal.get(java.util.Calendar.YEAR); //현재 날짜 기억
		int currentMonth = cal.get(java.util.Calendar.MONTH);
		int currentDate = cal.get(java.util.Calendar.DATE);
		String Year = request.getParameter("year"); //나타내고자 하는 날짜
		String Month = request.getParameter("month");
		int year, month;
		if (Year == null && Month == null) { //처음 호출했을 때
			year = currentYear;
			month = currentMonth;
		} else { //나타내고자 하는 날짜를 숫자로 변환
			year = Integer.parseInt(Year);
			month = Integer.parseInt(Month);
			if (month < 0) {
				month = 11;
				year = year - 1;
			} //1월부터 12월까지 범위 지정.
			if (month > 11) {
				month = 0;
				year = year + 1;
			}
		}
	%>

	<table border="1" align="center" width="1000">
		<!-- 달력 상단 부분, 더 좋은 방법이 없을까? -->
		<tr>
			<td align=center width=300>
				<!-- 년 도--> <a
				href="Calendar.html?year=<%out.print(year - 1);%>&month=<%out.print(month);%>">◀</a>
				<%
					out.print(year);
				%>년 <a
				href="Calendar.html?year=<%out.print(year + 1);%>&month=<%out.print(month);%>">▶</a>
			</td>
			<td align=center width=400>
				<!-- 월 --> <a
				href="Calendar.html?year=<%out.print(year);%>&month=<%out.print(month - 1);%>">◀</a>
				<%
					out.print(month + 1);
				%>월 <a
				href="Calendar.html?year=<%out.print(year);%>&month=<%out.print(month + 1);%>">▶</a>
			</td>
			<td align=center width=300><input type='button' value='목록형으로 보기'
				onclick="window.location.href='#'" /></td>
		</tr>
	</table>
	<table border="1" align="center" cellpadding='12' width="1000">
		<!-- 달력 부분 -->
		<tr align="center">
			<td>일</td>
			<!-- 일=1 -->
			<td>월</td>
			<!-- 월=2 -->
			<td>화</td>
			<!-- 화=3 -->
			<td>수</td>
			<!-- 수=4 -->
			<td>목</td>
			<!-- 목=5 -->
			<td>금</td>
			<!-- 금=6 -->
			<td>토</td>
			<!-- 토=7 -->
		</tr>
		<tr height=100>
			<%
				//디비 연결 소스
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = "";
				String[] post = new String[100];
				int cnt = 0;

				try {
					String url = "jdbc:mysql://localhost:3308/testdb";
					String id = "kim";
					String pw = "123123";
					Class.forName("com.mysql.jdbc.Driver");
					conn = DriverManager.getConnection(url, id, pw);
					System.out.println("캘린더_연결성공");

					//날짜 출력 소스
					int day = 0;
					cal.set(year, month, 1); //현재 날짜를 현재 월의 1일로 설정
					int startDay = cal.get(java.util.Calendar.DAY_OF_WEEK); //현재날짜(1일)의 요일
					int end = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH); //이 달의 끝나는 날
					int br = 0; //7일마다 줄 바꾸기
					for (int i = 0; i < (startDay - 1); i++) { //빈칸출력
						out.println("<td>&nbsp;</td>");
						br++;
						if ((br % 7) == 0) {
							out.println("<br>");
						}
					}
					for (int i = 1; i <= end; i++) { //날짜출력
						sql = "select * from schedule where date_month='" + (month + 1) + "' and date_day='" + i + "'";
						pstmt = conn.prepareStatement(sql);
						rs = pstmt.executeQuery();

						while (rs.next()) {
							post[cnt] = rs.getString("title");
							++cnt;
						}
						if (year == currentYear && month == currentMonth && i == currentDate) {//오늘이면 테이블 색 노랑으로 변경
							out.println("<td width=143 bgcolor=yellow><a href='DetailBox.html?month=" + (month + 1)
									+ "&day=" + i + "&today=" + currentDate + "' target='detailBox' style='color: black'>"
									+ i + "</a><br>");
							if (cnt != 0) {//일정이 있으면
								for (int j = 0; j < cnt; j++) {
									out.println("<font size=2>" + post[j] + "</font><br>");
								}
							}
							out.println("</td>");
							cnt = 0;

						} else {//오늘이 아닌 다른날 
							out.println(
									"<td width=143><a href='DetailBox.html?month=" + (month + 1) + "&day=" + i + "&today="
											+ currentDate + "' target='detailBox' style='color: black'>" + i + "</a><br>");
							if (cnt != 0) {//일정이 있으면
								for (int j = 0; j < cnt; j++) {
									out.println("<font size=2>" + post[j] + "</font><br>");
								}
							}
							out.println("</td>");
							cnt = 0;
						}
						br++;
						if ((br % 7) == 0 && i != end) {
							out.println("</tr><tr height=100>");
						}
					}
					while ((br++) % 7 != 0) //말일 이후 빈칸출력
						out.println("<td>&nbsp;</td>");

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
		</tr>
	</table>
</body>
</html>