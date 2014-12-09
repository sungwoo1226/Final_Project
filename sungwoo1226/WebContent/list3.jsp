<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*" import="java.sql.*"%>

<%	
try{
	 Class.forName("com.mysql.jdbc.Driver");
}catch(ClassNotFoundException e){
	e.printStackTrace();
}
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;

	String dbUrl = "jdbc:mysql://localhost:3306/web2012";
	String dbUser = "web";
	String dbPassword = "asdf";

	// 페이지 설정
	int pageNo = 1;

	try {
		pageNo = Integer.parseInt(request.getParameter("page"));
	} catch (NumberFormatException ex) {
	}

	int numInPage = 10; // 한페이지에 출력할 아이템 개수
	int startPos = (pageNo - 1) * numInPage; // 몇 번째 아이템 부터 이 페이지에?
	int numItems, numPages;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강의목록1</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/base.css" rel="stylesheet">
	<script src="js/jquery-1.8.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</head>
<body>
	<jsp:include page="share/header.jsp">
		<jsp:param name="current" value="Lecture_list1" />
	</jsp:include>

	<div class="container">
		<table class="table table-bordered table-stripped">
			<tr>
				<td><img src="img/ken.png" width="200" height="300" alt="" />
				
				<ul>
				<li>강좌유형 : 문제풀이</li>
				<li>강좌구성 : 주 1회 / 총 10강 713분</li>
				<li>제작방식 : 동영상 강의</li>
				</ul>
				</td>
				<td><img src="img/final.jpg" width="200" height="300" alt="" />
				
				<ul>
				<li>대상학년 : 고3</li>
				<li>수강기간 : 80일(교재배송기간포함)</li>
				</ul>
				</td>
			
		</table>
		<%
			try {
				Class.forName("com.mysql.jdbc.Driver");

				// DB 접속
				conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

				stmt = conn.createStatement();

				// users 테이블: user 수 페이지수 개산
				rs = stmt.executeQuery("SELECT COUNT(*) FROM list1");
				rs.next();
				numItems = rs.getInt(1);
				numPages = (int) Math.ceil((double) numItems
						/ (double) numInPage);
				rs.close();
				stmt.close();

				// users 테이블 SELECT
				stmt = conn.createStatement();
				rs = stmt.executeQuery("SELECT * FROM list1 ORDER BY id LIMIT "+ startPos + ", " + numInPage);
		%>

		<div class="row">
			<div class="col-md-12 page-info">
				<div class="pull-left">
					Total <b><%=numItems%></b> lectures
				</div>
				<div class="pull-right">
					<b><%=pageNo%></b> page / total <b><%=numPages%></b> pages
				</div>
			</div>
		</div>
		<table class="table table-bordered table-stripped">
			<thead>
				<tr>
					<th>강의명</th>
					<th>강의보기</th>
				</tr>
			</thead>
			<tbody>
				<%
					while (rs.next()) {
				%>
				<tr>

					<td><%=rs.getString("lec_name")%></td>
					<td><%=rs.getString("lec_url")%></td>
				</tr>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>


		<nav class="pagination_centered">
			<ul class="pagination">
				<%
					// 페이지 네비게이션을 위한 준비
						int startPageNo, endPageNo;
						int delta = 5;
						startPageNo = (pageNo <= delta) ? 1 : pageNo - delta;
						endPageNo = startPageNo + (delta * 2) + 1;

						if (endPageNo > numPages) {
							endPageNo = numPages;
						}

						// 이전 페이지로
						if (pageNo <= 1) {
				%>
				<li class="disabled"><a href="#">&laquo;</a></li>
				<%
					} else {
				%>
				<li><a href="index.jsp?page=<%=pageNo - 1%>">&laquo;</a></li>
				<%
					}

						// 페이지 목록 출력 (현재-delta ~ 현재+delta까지)
						String className = "";
						for (int i = startPageNo; i <= endPageNo; i++) {
							className = (i == pageNo) ? "active" : "";
							out.println("<li class='" + className + "'>");
							out.println("<a href='index.jsp?page=" + i + "'>" + i
									+ "</a>");
							out.println("</li>");
						}

						// 다음 페이지로
						if (pageNo >= numPages) {
				%>
				<li class="disabled"><a href="#">&raquo;</a></li>
				<%
					} else {
				%>
				<li><a href="index.jsp?page=<%=pageNo + 1%>">&raquo;</a></li>
				<%
					}
				%>
			</ul>
			<%
				if (session.getAttribute("per") != null) {
			%>
			<div class="form-group">
				<a href="admin_lecture.jsp" class="btn btn-primary">modify</a>
			</div>

			<%
				}
			%>
		</nav>
		<%
			} catch (SQLException e) {
				// SQL 에러의 경우 에러 메시지 출력
				out.print("<div class='alert'>" + e.getLocalizedMessage()
						+ "</div>");
			} finally {
				// 무슨 일이 있어도 리소스를 제대로 종료
				if (rs != null)
					try {
						rs.close();
					} catch (SQLException e) {
					}
				if (stmt != null)
					try {
						stmt.close();
					} catch (SQLException e) {
					}
				if (conn != null)
					try {
						conn.close();
					} catch (SQLException e) {
					}
			}
		%>
	</div>
	<jsp:include page="share/footer.jsp" />
</body>
</html>