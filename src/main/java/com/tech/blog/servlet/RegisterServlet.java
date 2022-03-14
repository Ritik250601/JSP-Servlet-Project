package com.tech.blog.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
@MultipartConfig
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter out = response.getWriter();
		// TODO Auto-generated method stub
		
		//first we will check for check button terms and conditions
		String check = request.getParameter("check");		

		if(check == null) {
			
	        out.println("");
	        out.close();
	        return;
		}
		
	
	   
	    	String userName = request.getParameter("user_name");
		    String email = request.getParameter("user_email");
		    String password = request.getParameter("user_password");
		    String gender = request.getParameter("gender");
		    String about = request.getParameter("about");
		    	    
		    //creating a user object
		    
		    User user = new User(userName, email, password, gender,about);
		    
		    //creating user Dao Object
		    Connection con = ConnectionProvider.getConnection();
		    UserDao dao = new UserDao(con);
		    boolean result = dao.saveUser(user);
		    if(result) {
		    	out.println("done");
		    }
		    else {
		    	out.println("Error");
		    }
	
	   
		
	}

}
