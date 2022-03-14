package com.tech.blog.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;

/**
 * Servlet implementation class EditServlet
 */
@MultipartConfig
@WebServlet("/EditServlet")
public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//creating a printer object
		PrintWriter out = response.getWriter();
		
		
		//getting the current user from session for update operation
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentUser");
		
		
		// fetching data from user edit form
		
		String user_name = request.getParameter("name");
		String user_email = request.getParameter("user_email");
		String user_password = request.getParameter("user_password");
		String user_about = request.getParameter("user_about");
		Part part = request.getPart("user_image");
		String imageName = part.getSubmittedFileName();	
		String oldFile = user.getProfile();
	
	
		//gettting database connection
		Connection con = ConnectionProvider.getConnection();
		
		//setting the form value to userDao 
		UserDao userDao = new UserDao(con);
		user.setName(user_name);
		user.setEmail(user_email);
		
		if(user_password == null) {
			user.setPassword(user.getPassword());
		}
		else {
			user.setPassword(user_password);			
		}
		
		user.setAbout(user_about);
//		user.setProfile(user_image);
		
		boolean result = userDao.editUser(user);
	    
		if(result) {
			String oldPath =  request.getRealPath("/") + "pics" + File.separator + oldFile;
			@SuppressWarnings("deprecation")
			String path =  request.getRealPath("/") + "pics" + File.separator + user.getProfile();
			Helper.deleteFile(oldPath);
				if(Helper.saveFile(part.getInputStream(), path)) {
					out.println("updated..");
					Message msg =  new Message("Profile updated...", "success", "alert-success");
					session.setAttribute("msg", msg);
				}
				else {
					out.print("not save");
					Message msg =  new Message("Something went wrong..", "error", "alert-danger");
					session.setAttribute("msg", msg);
				}
			}
		else {
			out.println("Not updated");
			Message msg =  new Message("Something went wrong..", "error", "alert-danger");
			session.setAttribute("msg", msg);
			
		}
		
		response.sendRedirect("profile.jsp");
	
	}

}
