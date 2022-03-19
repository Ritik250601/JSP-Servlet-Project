
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="com.tech.blog.entities.User"%>

<%User user = (User)session.getAttribute("currentUser");
%>
<c:set  var="user" scope="session" value="<%=user%>"></c:set>


<nav class="navbar navbar-expand-lg navbar-dark primary-background">
  <div class="container-fluid">
    <a class="navbar-brand" href="/TechBlog">Home </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="#">Learn code with Ritik <i class="fa fa-drupal" style="font-size:24px"></i></a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#"><span class="fa fa-address-card-o"></span>Contact</a>
        </li>
        
        <c:if test="${user == null }">
         <li class="nav-item">
          <a class="nav-link" href="login_page.jsp"><span class="fa fa-address-card-o"></span>Login</a>
        </li>
         <li class="nav-item">
          <a class="nav-link" href="register_page.jsp"><span class="fa fa-user-plus"></span>Sign Up</a>
        </li>
        </c:if>
       
       
       
       <c:if test="${user != null }">
       <li class="nav-item">
          <a class="nav-link" href="register_page.jsp"><span class="fa fa-user-plus"></span>Logout</a>
        </li>
       </c:if>
       

        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Categories
          </a>
          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
            <li><a class="dropdown-item" href="#">Programming Language</a></li>
            <li><a class="dropdown-item" href="#">Project Implementation</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="#">Data Structure</a></li>
          </ul>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled">Disabled</a>
        </li>
      </ul>
      <form class="d-flex">
        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success" type="submit">Search</button>
      </form>
    </div>
  </div>
</nav>