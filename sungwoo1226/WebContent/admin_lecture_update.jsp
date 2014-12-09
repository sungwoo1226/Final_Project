<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*" import="java.util.*"
	import="org.apache.commons.lang3.StringUtils"%>
<%
	// DB 접속을 위한 준비
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/web2012";
	String dbUser = "web";
	String dbPassword = "asdf";
	
	request.setCharacterEncoding("utf-8");

	// Request로 ID가 있는지 확인
	int id = 0;
	try {
		id = Integer.parseInt(request.getParameter("id"));
	} catch (Exception e) {}
	String lec_name = request.getParameter("lec_name");
	String lec_url = request.getParameter("lec_url");
	
	List<String> errorMsgs = new ArrayList<String>();
	int result = 0;
	
	if (lec_name == null || lec_name.trim().length() == 0) {
		errorMsgs.add("강좌명을 반드시 입력해주세요.");
	}

	
	if (lec_url == null || lec_url.trim().length() == 0) {
		errorMsgs.add("강좌 링크를 반드시 입력해주세요. 돈벌기 싫으세요?");
	}
	

	if (errorMsgs.size() == 0) {
		try {
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
			stmt = conn.prepareStatement(
					"UPDATE list1 " + "SET  lec_name=?, lec_url=? " + "WHERE id=?"
					);
			stmt.setString(1,  lec_name);
			stmt.setString(2,  lec_url);
			stmt.setInt(3,  id);
			
			result = stmt.executeUpdate();
			if (result != 1) {
				errorMsgs.add("변경에 실패하였습니다.");
			}
		} catch (SQLException e) {
			errorMsgs.add("SQL 에러: " + e.getMessage());
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자_강의목록 변경</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/base.css" rel="stylesheet">
<script src="js/jquery-1.8.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</head>
<body>
	<jsp:include page="share/header.jsp">
		<jsp:param name="current" value="Sign Up" />
	</jsp:include>

<%
	 if(session.getAttribute("per") == null){ 
	%>
		
	 			<script type= text/javascript>
			alert("권한이 없습니다.");
			window.location.replace("index.jsp");
		</script>		
	<%
	 }
	%>

	<div class="container">
		<% if (errorMsgs.size() > 0) { %>
		<div class="alert alert-danger">
			<h3>Errors:</h3>
			<ul>
				<% for(String msg: errorMsgs) { %>
				<li><%=msg %></li>
				<% } %>
			</ul>
		</div>
		<div class="form-group">
			<a onclick="history.back();" class="btn btn-default">뒤로 돌아가기</a>
		</div>
		<% } else if (result == 1) { %>
		<div class="alert alert-success">
			<b><%= lec_name %></b> 강좌 정보가 수정되었습니다.
		</div>
		<div class="form-group">
			<a href="admin_lecture.jsp" class="btn btn-default">목록으로</a>
		</div>
		<%}%>
	</div>
</body>
</html>