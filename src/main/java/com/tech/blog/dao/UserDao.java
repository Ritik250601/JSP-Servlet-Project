package com.tech.blog.dao;
import java.sql.*;

import com.mysql.cj.xdevapi.Result;
import com.tech.blog.entities.User;

public class UserDao {

	private Connection con;
	
	public UserDao(Connection con) {
		this.con = con;
	}
	
	// method to insert user into database
	
	public boolean saveUser(User user) {
		
		boolean f = false;
		try {
			String query = "INSERT INTO user(name, email, password, gender, about) VALUES (?, ?, ?, ?, ?)";
			
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getGender());
			pstmt.setString(5, user.getAbout());
			
			pstmt.executeUpdate();
			f = true;
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return f;
	}
	
	
	//get user by username and user password

	  
	public User getUserByEmailPassword(String email, String password ) {
		
		User user = null;
		try {
			String query = "select * from user WHERE email = ? and password = ?";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, email);
			pstmt.setString(2, password);
			
			
			ResultSet resultSet = pstmt.executeQuery();
			if(resultSet.next()) {
				
				user = new User();
				
				//data from db
				int userId = resultSet.getInt("id");
				String userName = resultSet.getString("name");
				String userEmail = resultSet.getString("email");
				String userGender = resultSet.getString("gender");
				String userAbout = resultSet.getString("about");
				String userProfile =  resultSet.getString("profile");
				
				//set to user Object
				user.setId(userId);
				user.setName(userName);
				user.setEmail(userEmail);
				user.setGender(userGender);
				user.setAbout(userAbout);
				user.setProfile(userProfile);
				
						
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return user;
	}
	
	public boolean editUser(User user) {
		boolean f = false;
		try {
		
			String query = "UPDATE user SET name=?, email = ?, password = ?, about = ?, profile = ? WHERE id = ?";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getAbout());
			pstmt.setString(5, user.getProfile());
			pstmt.setInt(6, user.getId());
			pstmt.executeUpdate();
			f = true;
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return f;
	}
	
	
}
