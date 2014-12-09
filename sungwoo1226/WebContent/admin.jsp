<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*" import="java.sql.*"%>

<%
try{
	 Class.forName("com.mysql.jdbc.Driver");
}catch(ClassNotFoundException e){
	e.printStackTrace();
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
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
	
	<div class="form-group">
		<a href="admin_member.jsp" class="btn btn-primary">Member</a>
	</div>

	<div class="form-group">
		<a href="admin_lecture.jsp" class="btn btn-primary">Lecture</a>
	</div>
	
	<jsp:include page="share/footer.jsp" />
</body>
</html>