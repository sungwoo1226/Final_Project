<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"  import="java.sql.*" 
		import="org.apache.commons.lang3.StringUtils"%>

<%
String[][] menu = {
{"index.jsp", "home" },
{"list1.jsp", "Lecture_list1" },
{"list2.jsp", "Lecture_list2" },
{"list3.jsp", "Lecture_list3" },
};
String currentMenu = request.getParameter("current");

Connection conn = null;
PreparedStatement stmt = null;
ResultSet rs = null;

String dbUrl = "jdbc:mysql://localhost:3306/web2012";
String dbUser = "web";
String dbPassword = "asdf";

String userid = "";
int id  = 0;

try {
	Class.forName("com.mysql.jdbc.Driver");

	conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
	stmt = conn.prepareStatement("SELECT * FROM users");		
	rs = stmt.executeQuery();

	while(rs.next()) {
		userid = rs.getString("userid");
		id = rs.getInt("id");
		
	}
} catch (SQLException e) {
} finally {
if (rs != null) try{rs.close();} catch(SQLException e) {}
if (stmt != null) try{stmt.close();} catch(SQLException e) {}
if (conn != null) try{conn.close();} catch(SQLException e) {}
}

%>

<!-- Navbar================================================== -->

<div class="container navbar navbar-inverse navbar-fixed-top" role="navigation">
	
	
	<div class="container-fluid">
		
		<div class="navbar-header">
			<a class="navbar-brand" href="./index.jsp">Web</a>
		</div>
		<div class="collapse navbar-collapse" >
			<ul class="nav navbar-nav">
				<%
					for(String[] menuItem : menu) {
						if (currentMenu != null && currentMenu.equals(menuItem[1])) {
							out.println("<li class='active'>");
						} else {
							out.println("<li class=''>");
						}
			
						out.println("<a href='"+menuItem[0]+"'>"+menuItem[1]+"</a>");
						out.println("</li>");
					}
				%>
			</ul>
			<%
					if (session.getAttribute("userId") == null) {
				%>
			<LI><A href="signup.jsp" style="margin-left:150px;" >Sign up</A>
			<a href="login.jsp" style="margin-left:10px;">Login</A></LI>
			<%
					} else {
			%>
			
			<!-- <LI><A href="show.jsp" style="margin-left:150px;" >My page</A>-->
					%>
			<LI><A href="show.jsp?id=<%= session.getAttribute("numId")%>" style="margin-left:150px;" >My page</A>
			
			<a href="logout.jsp" style="margin-left:10px;">Logout</A>
			<%
			if(session.getAttribute("per") != null){
			%>
			<a href="admin.jsp" style="margin-left:10px;">admin_page</A></LI>
			
			<%
			}}
			%>
		</div>
		
	</div>
	
</div>


<div class="container container-fluid" style="padding-top: 50px">
	<h1>Sungwoo1226 &amp; Web Programming</h1>
</div>


