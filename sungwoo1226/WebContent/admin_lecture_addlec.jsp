<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*" import="java.sql.*"%>
	
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
	String lec_name = "";
	String lec_url = "";
	
	// Request로 ID가 있는지 확인
	int id = 0;
	try {
		id = Integer.parseInt(request.getParameter("id"));
	} catch (Exception e) {}

	if (id > 0) {
		// Request에 id가 있으면 update모드라 가정
		actionUrl = "admin_lecture_update.jsp";
		try {
		    Class.forName("com.mysql.jdbc.Driver");

		    // DB 접속
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

	 		// 질의 준비
			stmt = conn.prepareStatement("SELECT * FROM list1 WHERE id = ?");
			stmt.setInt(1, id);
			
			// 수행
	 		rs = stmt.executeQuery();
			
			if (rs.next()) {
				lec_name = rs.getString("lec_name");
				lec_url = rs.getString("lec_url");
			
				
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
		actionUrl = "admin_lecture_register.jsp";
	}
%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자_강의목록</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/base.css" rel="stylesheet">
	<script src="js/jquery-1.8.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</head>
<body>
<jsp:include page="share/header.jsp">
		<jsp:param name="current" value="문제풀이" />
	</jsp:include>

<jsp:include page="share/footer.jsp" />
<div class="container">

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
					<label class="col-sm-2 control-label" for="lec_name">Lecture name</label>
					<div class="col-sm-3">
						<input type="lec_name" class="form-control" placeholder="Lecture name" name="lec_name" value="<%=lec_name%>">
					</div>
				</div>

				
				<div class="form-group ">
					<label class="col-sm-2 control-label" for="lec_url">Lecture URL</label>
					<div class="col-sm-3">
						<input type="lec_url" class="form-control" placeholder="Lecture URL" name="lec_url" value="<%=lec_url%>">
					</div>
				</div>


				<div class="form-group">
					<input type=button value="Cancel" OnClick="javascript:history.back(-1)"
						class="col-sm-offset-2 btn btn-default">
					<% if (id <= 0) { %>
						<input type="submit" class="btn btn-default btn-primary" value="add">
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