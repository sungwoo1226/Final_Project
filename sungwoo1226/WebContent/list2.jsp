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
<title>중학생</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/base.css" rel="stylesheet">
	<script src="js/jquery-1.8.2.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</head>
<body>
<div class="container navbar navbar-fixed-bottom"
	role="navigation">
	
	<div class="container-fluid">
			<ul class="nav navbar-nav">
	
						<A href="index.jsp">home</A>
					<A href="signup.jsp">signup</A>
					<LI><A href="login.jsp">login</A></LI>
					</ul>
					
	</div>
</div>
<jsp:include page="share/header.jsp">
		<jsp:param name="current" value="고등학생" />
	</jsp:include>

<jsp:include page="share/footer.jsp" />
</body>
</html>