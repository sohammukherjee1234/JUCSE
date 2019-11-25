<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Flight App</title>
<link rel="stylesheet" href="./style.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
	<%@ page import="java.io.*,java.util.*,java.sql.*"%>
	<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
	<form class="search-form" action="search">
		<input class="inp" type="text" name="source" placeholder="Enter starting airport" required>
		<input class="inp" type="text" name="destination" placeholder="Enter destination airport" required>
		<input class="btn btn-success" type="submit" name="searchSubmit" value="Submit">
	</form>
	<%
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/flight","root","root");
		Statement stmt = conn.createStatement();
		PreparedStatement pst = conn.prepareStatement("select * from hotdeals");
		ResultSet rs = pst.executeQuery();
		PreparedStatement ps2;
		HashMap<String, Float> deals = new HashMap<>();
		if(!(rs.next())){
			out.println("No hot deals currently available");
		}
		else{
			%>
			<div class="hotdeal">
			<img style="height: 100px; width: 200px;" src="<%="./assets/images.jpeg" %>" alt="Hot deals"/>
			<table class="table table-dark">
  						<thead>
    						<tr>
      						<th scope="col">Flight Number</th>
      						<th scope="col">Flight Name</th>
      						<th scope="col">Source</th>
      						<th scope="col">Destination</th>
      						<th scope="col">Departure Time</th>
      						<th scope="col">Arrival Time</th>
      						<th scope="col">Price</th>
    						</tr>
    					</thead>
    					<tbody>
			<%
			rs.previous();
			
			while(rs.next()){
				String flightno = rs.getString("flightno");
				float discount = Float.parseFloat(rs.getString("discount"));
				ps2 = conn.prepareStatement("select * from flightinfo where flightno=?");
				ps2.setString(1, flightno);
				ResultSet rs2 = ps2.executeQuery();
				rs2.next();
				float newprice = Float.parseFloat(rs2.getString("price"));
				newprice = newprice - (discount * newprice) / 100 ;
				deals.put(flightno, newprice);
				
			%>
				
					
    						<tr>
      						<th scope="row"><%=rs2.getString("flightno") %></th>
      						<td><%=rs2.getString("flightname") %></td>
      						<td><%=rs2.getString("source") %></td>
      						<td><%=rs2.getString("destination") %></td>
      						<td><%=rs2.getString("departuretime") %></td>
      						<td><%=rs2.getString("arrivaltime") %></td>
      						
      						<td>
      							<span class="old-price"><%=rs2.getString("price") %></span>
      							<span class="new-price"><%=newprice %></span>
      						</td>
    						</tr>
  					
			<%}
			%>
			
			</tbody>
  			</table>
			</div>
			
		<%}
		
		if(session.getAttribute("source") != null){
			
			String src = session.getAttribute("source").toString();
			String dest = session.getAttribute("destination").toString();
			
			PreparedStatement ps3 = conn.prepareStatement("select * from flightinfo where source=? and destination=?");
			ps3.setString(1, src);
			ps3.setString(2, dest);
			ResultSet rs3 = ps3.executeQuery();
			if(!rs3.next()){
				out.println("No flights available");
			}
			else{
				rs3.previous();
				while(rs3.next()){
					%>
					<div class="flightContainer">
						<div class="flightname-container">
						<span class="flightName"><%=rs3.getString("flightname") %></span>
							<span class="flightNumber"><%=rs3.getString("flightno") %></span>
							
						</div>
						<div class="source-container">
							<span class="source"><%=rs3.getString("source") %></span>
							<span class="source-time"><%=rs3.getString("departuretime") %></span>
						</div>
						<div class="duration-container">
							<span class="duration"><%=rs3.getString("duration") %></span>
							<p class="seperator"></p>
							<span class="nonstop">Non Stop</span>
						</div>
						<div class="source-container">
							<span class="source"><%=rs3.getString("destination") %></span>
							<span class="source-time"><%=rs3.getString("arrivaltime") %></span>
						</div>
						<%
						if(deals.containsKey(rs3.getString("flightno"))){
							%>
							<span class="price"><%="Rs. " + deals.get(rs3.getString("flightno")) %></span>
							
						<%}
						else{
						%>
						<span class="price"><%="Rs. " + rs3.getString("price") %></span>
						<%} %>
					</div>
				<%}
			}
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
</body>
</html>
<%} %>



