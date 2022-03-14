
<%@page import="com.tech.blog.entities.Message"%>
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


<link rel="stylesheet" type="text/css" href="./css/style.css" />

<!-- fontawasome -->

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<link rel="stylesheet" type="text/css" href="/css/style.css" />
<title>Home |</title>
<style>
.d-flex {
	clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 91%, 63% 100%, 40% 91%, 0 99%, 0 0);
}
</style>
</head>
<body>

	<!-- Navbar -->
	<%@include file="navbar.jsp"%>
	<!-- Navbar End -->

	<main
		class="d-flex align-items-center primary-background banner-background"
		style="height: 70vh">
		<div class="container">
			<div class="row">
				<div class="col-md-4 offset-md-4">
					<div class="card">
						<div class="card-header text-center">
							<br /> <span class="fa fa-user-plus fa-3"></span>
							<p>Login Here</p>
						</div>

						<% 
						Message msg = (Message)session.getAttribute("msg");
						if(msg != null){
						%>
						
				  <div class="alert <%= msg.getCssClass() %>" role="alert">
									<%=msg.getContent() %></div>
						
						<%
						session.removeAttribute("msg");
						}
						
						%>
						
						<div class="card-body">
							<form action="LoginServlet" method="POST">
								<div class="mb-3">
									<label for="exampleInputEmail1" class="form-label">Email
										address</label> <input type="email" class="form-control"
										id="exampleInputEmail1" aria-describedby="emailHelp"
										name="email" required>
									<div id="emailHelp" class="form-text">We'll never share
										your email with anyone else.</div>
								</div>
								<div class="mb-3">
									<label for="exampleInputPassword1" class="form-label">Password</label>
									<input type="password" class="form-control"
										id="exampleInputPassword1" name="password" required>
								</div>
								<div class="container text-center">
									<button type="submit" class="btn btn-primary text-center">Submit</button>
								</div>
							</form>


						</div>
					</div>
				</div>
			</div>
		</div>
	</main>





	<!-- End Card -->

	<!-- Bootsrap js -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>


	<!-- Jquery CDN -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"
		integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
		crossorigin="anonymous"></script>



</body>
</html>
