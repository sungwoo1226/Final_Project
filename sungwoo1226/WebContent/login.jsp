<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"  import="java.sql.*" 
		import="org.apache.commons.lang3.StringUtils"%>
<%
	
	String errorMsg = null;
	String actionUrl;
	
	// DB 접속을 위한 준비
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/web2012";
	String dbUser = "web";
	String dbPassword = "asdf";
	
	// 사용자 정보를 위한 변수 초기화
	String userid = "";
	String pwd = "";
	
	//post
	String id = request.getParameter("id");	
	String password = request.getParameter("password");
	boolean login = false;
	
	try {
		Class.forName("com.mysql.jdbc.Driver");

		conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
		stmt = conn.prepareStatement("SELECT * FROM users");		
		rs = stmt.executeQuery();

		while(rs.next()) {
			userid = rs.getString("userid");
			pwd = rs.getString("pwd");
			if (userid.equals(id) && pwd.equals(password)) {
				// 로그인 성공
				session.setAttribute("userId", userid);
				login = true;
				break;
			}
		}
	} catch (SQLException e) {
		errorMsg = "SQL 에러 : " + e.getMessage();
	} finally {
	if (rs != null) try{rs.close();} catch(SQLException e) {}
	if (stmt != null) try{stmt.close();} catch(SQLException e) {}
	if (conn != null) try{conn.close();} catch(SQLException e) {}
	}
%>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원목록</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/base.css" rel="stylesheet">
	<script src="js/jquery-1.8.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</head>
<body>
<jsp:include page="share/header.jsp">
  <jsp:param name="current" value="login"/>
</jsp:include>

 <div class="container">
 <form class="form-horizontal" action="" method="post">
			<fieldset>
        <legend class="legend">Login</legend>
 <%
 	if (errorMsg != null && errorMsg.length() > 0 ) {
		// SQL 에러의 경우 에러 메시지 출력
		out.print("<div class='alert'>" + errorMsg + "</div>");
 }
				if (request.getMethod() == "POST") {
					if (id == null || password == null || id.length() == 0 || password.length() == 0) {
			%>
			<div class="error">아이디와 비밀번호를 입력하세요.</div>
			<%
				} else if (login) {
						// 로그인 성공
						response.sendRedirect("index.jsp");
						
					} else {
			%>
			<div class="error">아이디나 비밀번호가 잘못되었습니다.</div>
			<%}}%>
			
			<div class="form-group ">
					<label class="col-sm-2 control-label" for="userid">ID</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" name="id" >
					</div>
				</div>
					<div class="form-group ">
						<label class="col-sm-2 control-label" for="pwd">Password</label>
						<div class="col-sm-3">
							<input type="password" class="form-control" name="password">
						</div>
					</div>
		      
				<div class="form-group">
					<input type=button value="Cancel" OnClick="javascript:history.back(-1)" 
					class="col-sm-offset-2 btn btn-default">
					<input type="submit" class="btn btn-default btn-primary" value="Login">
				</div>
  </div>
  
</body>
</html>