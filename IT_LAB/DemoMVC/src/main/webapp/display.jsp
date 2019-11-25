<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
 <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<div class="root">

<%
	ResultSet rs = (ResultSet)request.getAttribute("result");
	if(!rs.next()){
		out.println("No flights available");
		
	}
	else{
	%>	
		<table class="table">
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
    			%>
    			<tr>
      						<th scope="row"><%=rs.getString("flightno") %></th>
      						<td><%=rs.getString("flightname") %></td>
      						<td><%=rs.getString("source") %></td>
      						<td><%=rs.getString("destination") %></td>
      						<td><%=rs.getString("departuretime") %></td>
      						<td><%=rs.getString("arrivaltime") %></td>
      						
      						<td><%=rs.getString("price") %></td>
    						</tr>
    		<%}
    		
    	%>
    	</tbody>
    	</table>
	<%}
%>
</div>
</body>
</html>