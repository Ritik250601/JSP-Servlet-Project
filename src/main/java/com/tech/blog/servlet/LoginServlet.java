package com.tech.blog.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		PrintWriter out = response.getWriter();
		
		//fetch email and password from the user
		String userEmail = request.getParameter("email");
		String userPassword = request.getParameter("password");
		
		// User Dao object
		
		UserDao ud = new UserDao(ConnectionProvider.getConnection());
		User user = ud.getUserByEmailPassword(userEmail, userPassword);
		if(user == null) {
			//error 
			Message message = new  Message("Invalid details! try agin", "error", "alert-danger");
			response.sendRedirect("login_page.jsp");
			
			HttpSession s = request.getSession();
			s.setAttribute("msg", message);
			
		}
		else {
			//login success
			HttpSession s = request.getSession();
			s.setAttribute("currentUser", user);
			response.sendRedirect("profile.jsp");
		}
		
		
		
	
	}
	
	
	

}
