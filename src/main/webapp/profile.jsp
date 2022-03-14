<%@page import="java.lang.StackWalker.Option"%>
<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.util.List"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.stream.Collector"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page errorPage="error_page.jsp"%>
<%
User user = (User) session.getAttribute("currentUser");

if (user == null) {
	response.sendRedirect("login_page.jsp");
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- Bootsrap css -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">


<!-- fontawasome -->

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- mycss -->
<link rel="stylesheet" type="text/css" href="./css/style.css" />

<style>
.banner-background {
	clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 91%, 63% 100%, 40% 91%, 0 99%, 0 0);
}

.logout {
	margin-left: 0;
	padding-left: 0;
}
</style>
</head>
<body>
	<!--navbar-->



	<nav class="navbar navbar-expand-lg navbar-dark primary-background">
		<div class="container-fluid">
			<a class="navbar-brand" href="/TechBlog">Navbar </a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#">Learn code with Ritik <i
							class="fa fa-drupal" style="font-size: 24px"></i></a></li>



					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">
							Categories </a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="#">Programming
									Language</a></li>
							<li><a class="dropdown-item" href="#">Project
									Implementation</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="#">Data Structure</a></li>
						</ul></li>

					<li class="nav-item"><a class="nav-link" href="#"><span
							class="fa fa-address card-0"></span>Contact</a></li>


					<li class="nav-item"><a class="nav-link" href="#"
						data-bs-toggle="modal" data-bs-target="#add-post-Modal"><span
							class="fa fa-asterisk">Do Post</span></a></li>

				</ul>

				<div class="d-flex">
					<ul class="navbar-nav mr-right">
						<li class="nav-item"><a class="nav-link" href="#!"
							data-bs-toggle="modal" data-bs-target="#profile-Modal"> <span
								class="fa fa-user-circle "></span> <%=user.getName()%>
						</a></li>

						<li class="nav-item"><a class="nav-link" href="LogoutServlet">
								<span class="fa fa-user-plus "></span> Logout
						</a></li>
					</ul>

				</div>
			</div>
	</nav>


	<!--end of navbar-->

	<!-- main body of the page -->

	<main>
		<div class="container">
			<div class="row">
				<!--  first col -->
				<div class="col-md-4">


					<!-- categories -->
					<ul class="list-group mt-4">
						<li class="list-group-item active" aria-current="true">All
							Posts</li>

						<%
						PostDao pd = new PostDao(ConnectionProvider.getConnection());
						ArrayList<Category> lst2 = pd.getCategories();

						for (Category cat : lst2) {
						%>

						<li class="list-group-item"><%=cat.getName()%></li>


						<%
						}
						%>

					</ul>

				</div>


				<!-- second col -->
				<div class="col-md-8" >
					<!-- posts -->
					<div class="container text-center" id="loader">
						<i class="fa fa-refresh fa-4x fa-spin"></i>
						<h3 class="mt-2">Loading...</h3>

					</div>
					<div class="container-fluid" id="post-container">
					
					</div>


				</div>
			</div>


		</div>


	</main>



	<!-- end of main body -->


	<!-- Profile Modal -->
	<div class="modal fade" id="profile-Modal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header primary-background text-white">
					<div class="container text-center">
						<h5 class="modal-title" id="exampleModalLabel">My Profile</h5>
					</div>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="container text-center">
						<img class="img-fluid"
							style="border-radius: 50%; max-width: 10rem;"
							src="pics/<%=user.getProfile()%>" /> <br>
						<h5 class="modal-title mt-3" id="exampleModalLabel"><%=user.getName()%></h5>

						<!-- Details -->
						<div id="profile-details">
							<table class="table">
								<tbody>
									<tr>
										<th scope="row">Id :</th>
										<td><%=user.getId()%></td>
									</tr>
									<tr>
										<th scope="row">Email :</th>
										<td><%=user.getEmail()%></td>

									</tr>
									<tr>
										<th scope="row">Gender :</th>
										<td colspan="2"><%=user.getGender()%></td>
									</tr>

									<tr>
										<th scope="row">Status :</th>
										<td colspan="2"><%=user.getAbout()%></td>
									</tr>
								</tbody>
							</table>
						</div>

						<!-- Profile edit -->
						<div id="profile-edit" style="display: none">
							<h3 class="mt-2">Please edit carefully</h3>
							<form action="EditServlet" method="post"
								enctype="multipart/form-data">
								<table class="table">
									<tr>
										<th scope="row">Id :</th>
										<td><%=user.getId()%></td>
									</tr>

									<tr>
										<th scope="row">Email :</th>
										<td><input type="email" class="form-control"
											name="user_email" value="<%=user.getEmail()%>"></td>
									</tr>


									<tr>
										<th scope="row">Name :</th>
										<td><input type="text" class="form-control" name="name"
											value="<%=user.getName()%>"></td>
									</tr>


									<tr>
										<th scope="row">Password :</th>
										<td><input type="password" class="form-control"
											name="user_password" value="<%=user.getPassword()%>"></td>
									</tr>


									<tr>
										<th scope="row">Gender :</th>
										<td><%=user.getGender().toUpperCase()%></td>
									</tr>


									<tr>
										<th scope="row">About :</th>
										<td><textarea rows="3" class="
												form-control"
												name="user_about">
										<%=user.getAbout()%>
										</textarea></td>
									</tr>

									<tr>
										<th scope="row">New Profile:</th>
										<td><input type="file" name="user_image"
											class="form-control" value="DEFAULT.Png"></td>
									</tr>
								</table>


								<div class="container">
									<button type="submit" class="btn btn-outline-primary">Save</button>
								</div>
							</form>
						</div>


					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary"
						id="edit-profile-button">Edit</button>
				</div>
			</div>
		</div>
	</div>

	<!--  end of Profile Modal -->



	<!-- Add post Modal -->
	<!-- Modal -->
	<div class="modal fade" id="add-post-Modal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Provide the
						Post details</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form action="AddPostServlet" method="POST" id="add-post-form">
						<div class="form-group">
							<select class="form-control" name="cid">
								<option selected disabled>---Select Category---</option>
								<%
								PostDao postd = new PostDao(ConnectionProvider.getConnection());
								ArrayList<Category> lst = postd.getCategories();

								for (Category c : lst) {
								%>
								<Option value="<%=c.getcId()%>">
									<%=c.getName().toUpperCase()%></Option>

								<%
								}
								%>


							</select>
						</div>
						<br>

						<div class="form-group">
							<input type="text" name="pTitle" placeholder="Enter Post Title"
								class="form-control" />
						</div>

						<br>

						<div class="form-group">
							<textarea name="pContent" class="form-control"
								style="height: 200px" placeholder="Enter Your Content"></textarea>
						</div>

						<br>
						<div class="form-group">
							<textarea class="form-control" name="pCode" style="height: 200px"
								placeholder="Enter Your Program if any"></textarea>
						</div>



						<div class="form-group">
							<br> <label>Select your pic</label> <br> <input
								type="file" name="pic" class="form-control" />
						</div>
						<div class="container text-center my-3">
							<button type="submit" class="btn btn-primary">Post</button>
						</div>
					</form>



				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>

				</div>
			</div>
		</div>
	</div>


	<!-- End of profile modal -->




	<!-- Bootsrap js -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>


	<!-- Jquery CDN -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"
		integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
		crossorigin="anonymous"></script>

	<!-- sweet alert cdn -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>



	<script>
		$(document).ready(function() {
			let edit_status = false;
			$('#edit-profile-button').click(function() {
				if (edit_status === false) {

					$("#profile-details").hide();
					$("#profile-edit").show();
					edit_status = true;
				} else {
					$("#profile-details").show();
					$("#profile-edit").hide();
					edit_status = false;
				}

			})

		});
	</script>

	<!-- Post javascript -->
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							// 
							$('#add-post-form')
									.on(
											"submit",
											function(event) {
												// this code gets called when from is submitted

												event.preventDefault();
												console.log("submitted")

												let form = new FormData(this);
												console.log(form)
												// now requestin to server

												$
														.ajax({
															url : "AddPostServlet",
															type : "POST",
															data : form,
															success : function(
																	data, p1,
																	p2) {
																if (data.trim() === "done") {
																	swal(
																			"Good job!",
																			"You clicked the button!",
																			"success");
																} else {

																	swal(
																			"Error!",
																			"Something went wrong Please try again!",
																			"error");
																}

															},
															error : function(
																	msg) {
																swal(
																		"Error!",
																		"Something went wrong Please try again!",
																		"error");
															},
															processData : false,
															contentType : false

														})
											})
						})
	</script>
	
	<script>
	//loadig post using ajax
	$(document).ready(function(e) {
		
	$.ajax({
		url:"load_posts.jsp",
		success: function(data, p2, p3){
			console.log(data);
			$('#loader').hide();
			$("#post-container").html(data);
		}
	    
	})
		
	})
	
	
	
	
	
	</script>

</body>
</html>