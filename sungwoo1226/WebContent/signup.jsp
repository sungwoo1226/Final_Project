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
	String name = "";
	String pwd = "";
	String email = "";
	String phone = "";
	
	// Request로 ID가 있는지 확인
	int id = 0;
	try {
		id = Integer.parseInt(request.getParameter("id"));
	} catch (Exception e) {}

	if (id > 0) {
		// Request에 id가 있으면 update모드라 가정
		actionUrl = "update.jsp";
		try {
		    Class.forName("com.mysql.jdbc.Driver");

		    // DB 접속
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

	 		// 질의 준비
			stmt = conn.prepareStatement("SELECT * FROM users WHERE id = ?");
			stmt.setInt(1, id);
			
			// 수행
	 		rs = stmt.executeQuery();
			
			if (rs.next()) {
				userid = rs.getString("userid");
				name = rs.getString("name");
				pwd = rs.getString("pwd");
				email = rs.getString("email");
				phone = rs.getString("phone");
			}
		}catch (SQLException e) {
			errorMsg = "SQL 에러: " + e.getMessage();
		} finally {
			// 무슨 일이 있어도 리소스를 제대로 종료
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
	} else {
		actionUrl = "register.jsp";
	}
%>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원가입</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/base.css" rel="stylesheet">
	<script src="js/jquery-1.8.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</head>
<body>
<jsp:include page="share/header.jsp">
  <jsp:param name="current" value="Sign Up"/>
</jsp:include>

 <div class="container">
 <%
 if (errorMsg != null && errorMsg.length() > 0 ) {
		// SQL 에러의 경우 에러 메시지 출력
		out.print("<div class='alert'>" + errorMsg + "</div>");
 }
 %>
	  <div>
		  <form class="form-horizontal" action="<%=actionUrl%>" method="post">
			<fieldset>
        <legend class="legend">Sign Up</legend>
			  	<%
			  	if (id > 0) {
			  		out.println("<input type='hidden' name='id' value='"+id+"'>");
			  	}
			  	%>
				<div class="form-group ">
					<label class="col-sm-2 control-label" for="userid">ID</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" name="userid" value="<%=userid%>">
					</div>
				</div>

				<div class="form-group ">
					<label class="col-sm-2 control-label" for="name">Name</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" placeholder="홍길동" name="name" value="<%=name%>">
					</div>
				</div>

				<% if (id <= 0) { %>
					<%-- 신규 가입일 때만 비밀번호 입력창을 나타냄 --%>
					<div class="form-group ">
						<label class="col-sm-2 control-label" for="pwd">Password</label>
						<div class="col-sm-3">
							<input type="password" class="form-control" name="pwd">
						</div>
					</div>
	
					<div class="form-group ">
						<label class="col-sm-2 control-label" for="pwd_confirm">Password Confirmation</label>
						<div class="col-sm-3">
							<input type="password" class="form-control" name="pwd_confirm">
						</div>
					</div>
				<% } %>
				<div class="form-group ">
					<label class="col-sm-2 control-label" for="email">E-mail</label>
					<div class="col-sm-3">
						<input type="email" class="form-control" placeholder="WOW@blizzard.com" name="email" value="<%=email%>">
					</div>
				</div>
				
				
				<div class="form-group ">
					<label class="col-sm-2 control-label" for="phone">Phone Number</label>
					<div class="col-sm-3">
						<input type="phone" class="form-control" placeholder="010-9959-5663" name="phone" value="<%=phone%>">
					</div>
				</div>

	
				<div class="form-group">
					<input type=button value="Cancel" OnClick="javascript:history.back(-1)"
						class="col-sm-offset-2 btn btn-default">
					<% if (id <= 0) { %>
						<input type="submit" class="btn btn-default btn-primary" value="Sign in">
					<% } else { %>
						<input type="submit" class="btn btn-default btn-primary" value="Modify">
					<% } %>
				</div>
			</fieldset>
		  </form>
    </div>
  </div>
  
</body>
</html>