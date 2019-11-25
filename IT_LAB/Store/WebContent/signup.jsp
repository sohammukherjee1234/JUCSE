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
	<form class="registration-form" action="signup" method="post">
		<input class="registration-input" type = "text" name="fname" placeholder="Enter first name" required>
		<input class="registration-input" type = "text" name="lname" placeholder="Enter last name" required>
		<input class="registration-input" type = "text" type="email" name="email" placeholder="Enter email" required>
		<input class="registration-input" type = "text" name="uname" placeholder="Enter username" required>
		<input class="registration-input" type = "password" name="pass" placeholder="Enter password" required>
		<div class="gender">
		  <strong>Sex</strong> 
		  <label class="radio">
		    <input type="radio" name="sex" value="M">
		    Male
		  </label>
		  <label class="radio">
		    <input type="radio" name="sex" value="F">
		    Female
		  </label>
		  <label class="radio">
		    <input type="radio" name="sex" value="O" checked>
		    Other
		  </label>
		</div>
		
		<div class="preference">
		  <strong>Preference</strong> 
		  <label class="radio">
		    <input type="radio" name="pref" value="0">
		    New arrivals
		  </label>
		  <label class="radio">
		    <input type="radio" name="pref" value="1" checked>
		    Discounted items
		  </label>
		</div>
		
		<input class="registration-btn btn btn-primary" type = "submit" name="signup" value="Create Account">&nbsp;
		<button class="registration-secondary-btn" id="signin" onclick="location.href = 'index.jsp';">Already have an account? Log in</button>
	</form>
	
</body>
</html>