package com.tech.blog.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.tech.blog.dao.PostDao;
import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Post;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;

@WebServlet("/AddPostServlet")
@MultipartConfig
public class AddPostServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		
		// Fetching data from form
		int cid = Integer.parseInt(request.getParameter("cid"));
		String pTitle = request.getParameter("pTitle");
		String pContent = request.getParameter("pContent");
		String pCode = request.getParameter("pCode");
		Part part = request.getPart("pic");
		String pic = part.getSubmittedFileName();
	
		// getting current user
	    HttpSession session = request.getSession();    
	    User user = (User) session.getAttribute("currentUser");
	    int userId = user.getId();
	    
	    //JDBC
	    Connection con = ConnectionProvider.getConnection();
	    Post p = new Post(pTitle, pContent, pCode, pic, cid, userId);
	    PostDao pd = new PostDao(con);
	    boolean result = pd.savePost(p);
	    	if(result) {
	    		out.print("done");
	    	String path = request.getRealPath("/") + "blog_pics" + File.separator + pic;
	    	System.out.println(request.getRealPath("/"));
	  
	    	Helper.saveFile(part.getInputStream(), path);
	    }
	    else {
	    	out.print("fail");
	    }
	    	
	}

}
