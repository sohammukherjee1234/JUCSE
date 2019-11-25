<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Apparel Store</title>
<link rel="stylesheet" href="./style.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
	<%
		if(request.getAttribute("message")!=null){
    		out.println(request.getAttribute("message"));
		}	
	%>
	<br>
	<form class="login-form" action="login" method="post">
		<input class="login-input" type = "text" name="uname" placeholder="Enter username" required><br>
		<input class="login-input" type = "password" name="pass" placeholder="Enter password" required><br>
		<div class="btn-container">
			<input class="btn btn-primary"  type = "submit" name="login" value="LOG IN">
			<button class="btn btn-primary" id="signup" onclick="location.href='signup.jsp';">SIGN UP</button>
		</div>
		<a href="forgot_password.jsp">Forgot password?</a>
	</form>
	
	
</body>
</html>