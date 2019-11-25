<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./style.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<style>
	#disc_prc{
		text-decoration: line-through;
	}
</style>
</head>
<%
	response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader ("Expires", 0);
	if(session.getAttribute("user")==null){
		response.sendRedirect("index.jsp");
	}
	else{
%>
<div class="navbar">
<div id="srch" style="bgcolor:#D3D3D3">
	<form action = "search">
		<input class="login-input" type="text" name="find" placeholder="search" required>&nbsp;
		<input class="btn btn-success" type = "submit" name="sbmt" value="SUBMIT">&nbsp;
	</form>
</div>

<div id="header" class="header">
	<span class="username">
	<%@ page import="java.io.*,java.util.*,java.sql.*"%>
	<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
	<%
		String user = session.getAttribute("user").toString();
		out.print(user);
	%>
	</span>
	<a href="logout.jsp" class="logout">Logout</a>
</div>


</div>
<div id="items">
	<%
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/store","root","root");
			Statement stmt = conn.createStatement();
			PreparedStatement pst = conn.prepareStatement("select sex,pref from users where uname=?");
			PreparedStatement pst2;
			pst.setString(1,user);
			ResultSet rs = pst.executeQuery();
			boolean b = rs.next();
			String sx = rs.getString("sex");
			int pref = Integer.parseInt(rs.getString("pref"));
			ResultSet rs2;
			String sql2;
			if(session.getAttribute("search")==null || session.getAttribute("search").toString().equalsIgnoreCase("all")){
				if(pref==0){
					pst2 = conn.prepareStatement("select * from items where ideal_for=? or ideal_for='B' order by new_arvl desc, discount desc");
				}
				else{
					pst2 = conn.prepareStatement("select * from items where ideal_for=? or ideal_for='B' order by discount desc, new_arvl desc");
				}
				pst2.setString(1,sx);
			}
			else{
				System.out.println(session.getAttribute("search").toString());
				if(pref==0){
					pst2 = conn.prepareStatement("select * from items where upper(name) like ? order by new_arvl desc, discount desc");
				}
				else{
					pst2 = conn.prepareStatement("select * from items where upper(name) like ? order by discount desc, new_arvl desc");
				}
				pst2.setString(1,"%"+session.getAttribute("search").toString().toUpperCase()+"%");
			}
			
			rs2 = pst2.executeQuery();
			if(!(rs2.next())){
				out.println("No items found");
			}
			else{
				rs2.previous();
				while(rs2.next()){
			%>
				<div class="item-data">
					<div class="image-container">
						<img style="height: 100%; max-width: 100%;" class="image-data" src="<%="./assets/" + rs2.getString("filename")%>" alt="image"/>
					</div>
					<%if(Integer.parseInt(rs2.getString("new_arvl")) == 1){
						%>
						<span class="new-arrival">
						</span>
						<%}%>
					<span class="item-header">
						<%=rs2.getString("name")%>
					</span>
					<span class="item-desc">
						<%=rs2.getString("descr") %>
					</span>
					<div class="item-price">
					<%float d = Float.parseFloat(rs2.getString("discount"));
					float orig = Float.parseFloat(rs2.getString("price"));
					orig = orig - (orig * d) / 100;
					%>
						<span class="old-price">
						<%=rs2.getString("price") %>
						</span>
						<span class="new-price">
						<%=orig %>
						</span>
					</div>
					<span class="item-discount"><%=rs2.getString("discount")%> % off</span>
					
				</div>
			<%}
			}
		} 
		catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally{
	%>
</div>
</body>
</html>
<%}}%>