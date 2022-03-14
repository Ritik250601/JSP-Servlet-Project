<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">


<!-- Bootsrap css -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">


<!-- mycss -->
<link rel="stylesheet" type="text/css" href="./css/style.css" />


<!-- fontawasome -->

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.d-flex {
	clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 91%, 63% 100%, 40% 91%, 0 99%, 0 0);
}
</style>
<title>register|</title>
</head>
<body>
	<!-- Navbar -->
	<%@include file="navbar.jsp"%>
	<!-- Navbar End -->

	<main class="d-flex primary-background" style="padding-bottom: 80px;">
		<div class="container">
			<div class="col-md-6 offset-md-3">
				<div class="card">
					<div class="card-header text-center">
						<span class="fa fa-3x  fa-user-circle"></span> Register Here <br>
					</div>

					<div class="card-body">

						<form action="RegisterServlet" method="POST" id="reg-form">
							<div class="mb-3">
								<label for="user_name" class="form-label" >User Name</label> <input
									type="text" class="form-control" id="exampleInputUserName" name="user_name"
									aria-describedby="emailHelp" placeholder="Enter email">
							</div>


							<div class="mb-3">
								<label for="exampleInputEmail1" class="form-label" >Email
									address</label> <input type="email" class="form-control" name="user_email"
									id="exampleInputEmail1" aria-describedby="emailHelp">
								<div id="emailHelp" class="form-text">We'll never share
									your email with anyone else.</div>
							</div>


							<div class="mb-3">
								<label for="exampleInputPassword1" class="form-label" >Password</label>
								<input type="password" class="form-control" name="user_password"
									id="exampleInputPassword1">
							</div>

							<div class="mb-3">
								<label for="gender" class="form-label" >Select Gender</label> <br>
								<input type="radio" id="gender1" value="Male" name="gender">Male <input
									type="radio" id="gender" value="Female" name="gender">Female
							</div>


							<div class="mb-3">
								<textarea name="about" class="form-control" id="" rows="5"
									placeholder="Enter something about yourself"></textarea>
							</div>

							<div class="mb-3 form-check">
								<input type="checkbox" class="form-check-input" name="check"
									id="exampleCheck1" value="checked"> <label class="form-check-label"
									for="exampleCheck1">agree terms and condition</label>
							</div>
							<br >
							<div class="container" id="loader" style="display:none">							
							<span class="fa fa-refresh fa-spin fa-3x"></span>
							<h4>Please wait....</h4>
							</div>
							<br>
							<button type="submit" class="btn btn-primary" id="submitHandler">Submit</button>
						</form>

					</div>


				</div>
				<div class="card-footer"></div>


			</div>

		</div>

	</main>

	<!-- Bootsrap js -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
		
		
		<!-- Jquery CDN -->
		
		<!-- Jquery CDN -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"
		integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
		crossorigin="anonymous"></script>
	<script type="text/javascript" src="./js/myjs.js"></script>
		<!-- end of Jquery Cdn -->
		
		
		
		<!-- sweet aleart -->
		
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
		
		
	<!-- Ajax Script -->
	
	<script>
	$(document).ready(function() {
	
	$('#reg-form').on('submit', function(event) {
		console.log("inside reg form")
	
		event.preventDefault();
		let form = new FormData(this);
		//send register servlet
		
		$("#submit-btn").hide();
		$("#loader").show();
		$.ajax({
			url:"RegisterServlet",
			type:"POST", 
			data:form,
			success: function(data, textStatus, jqXHR){
				console.log(data);
				$("#submitHandler").hide();
				let title;
				let text;
				let icon;
				if(data.trim()  ==="done"){
					title="Successfully login";
					text = "Please Try Again..";
					icon:"success";
					locationPage = "login_page.jsp"
					
				}
				else{
					title="Registration  failed";
					text  = "we are reduirecting you Home page";
					icon:"failure";
					locationPage = "register_page.jsp";
					
				}
				swal({
					  title: title,
					  text: text,
					  icon: icon,
					  button: "Okay",
					}).then((value) => {
						window.location = "login_page.jsp"
					});
			},
			error: function(jqXHR, textStatus, errorThrown){
				swal("something went wrong... try again").then((value) => {
			
				})
				$("#submitHandler").hide();
			},
			processData: false, 
			contentType:false
		})
		
	})	
	})
	
	
	
	</script>
	
	<!-- Ajax Scriptp end -->


</body>
</html>