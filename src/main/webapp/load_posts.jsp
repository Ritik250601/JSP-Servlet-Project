
<%@page import="java.io.File"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>

<div class="row">
<% 
PostDao pd = new PostDao(ConnectionProvider.getConnection());
List<Post> post = pd.getAllPosts();
// String path = request.getRealPath("/") + "blog_pics" + File.separator;
//String contextPath = request.getContextPath();
//String path = contextPath + "/src/main/webapp/blog_pics";



for(Post p : post){
%>


<div class="col-md-6 mt-2">
<div class="card">
<img src="blog_pics/<%=p.getpPic()%>" class="card-img-top" alt="...">
<div class="card-body">
<b><%=p.getpTitle() %></b>
<p>
<%=p.getpContent() 
%>

</p>
<pre><%=p.getpCode() %></pre>

</div>



</div>


</div>





<% } %>
</div>
	