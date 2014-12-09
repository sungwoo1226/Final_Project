<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*" import="java.sql.*"%>

<%
	try {
		Class.forName("com.mysql.jdbc.Driver");
	} catch (ClassNotFoundException e) {
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
<title>정성우&변지성</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/base.css" rel="stylesheet">
<script src="js/jquery-1.8.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>



</head>
<body>
	<jsp:include page="share/header.jsp">
		<jsp:param name="current" value="home" />
	</jsp:include>



	<div class="container">
		<%
			try {
				Class.forName("com.mysql.jdbc.Driver");

				// DB 접속
				conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

				stmt = conn.createStatement();

				// users 테이블: user 수 페이지수 개산
				rs = stmt.executeQuery("SELECT COUNT(*) FROM users");
				rs.next();
				numItems = rs.getInt(1);
				numPages = (int) Math.ceil((double) numItems
						/ (double) numInPage);
				rs.close();
				stmt.close();

				// users 테이블 SELECT
				stmt = conn.createStatement();
				rs = stmt
						.executeQuery("SELECT * FROM users ORDER BY name LIMIT "
								+ startPos + ", " + numInPage);
		%>
		
		<img src="img/web2.jpg" width="700" height="467" alt="" />
		
	
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
<script>
	$(function() {
		$("a[data-action='delete']").click(function() {
			if (confirm("정말로 삭제하시겠습니까?")) {
				location = 'delete.jsp?id=' + $(this).attr('data-id');
			}
			return false;
		});
	});
</script>
</html>