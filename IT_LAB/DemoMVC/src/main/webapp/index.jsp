<html>
<head>
	
</head>
<body>
<%
	String username = (String) request.getAttribute("username");
%>

<div class="root">
	<span class="user"><%=username %></span>
	<form action="search">
		<input type="text" name="source" placeholder="Enter source">
		<input type="text" name="destination" placeholder="Enter destination">
		<input type="submit" value="Submit"> 
	</form>
</div>

</body>

</html>
