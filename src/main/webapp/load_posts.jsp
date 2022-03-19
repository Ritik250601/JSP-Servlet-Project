
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.io.File"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>

<div class="row">
<% 
PostDao pd = new PostDao(ConnectionProvider.getConnection());
List<Post> allPost = pd.getAllPosts();
List <Post> post;

int cid = Integer.parseInt(request.getParameter("cid"));
if(cid == 0){
post = allPost;	
}
else{
post = allPost.stream().filter(e -> e.getCatId() == cid).collect(Collectors.toList());	
	
}


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
	