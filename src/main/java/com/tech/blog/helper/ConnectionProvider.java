package com.tech.blog.helper;

import java.sql.*;

public class ConnectionProvider {

	private static Connection con;

	public static Connection getConnection() {
		try {
			if (con == null) {

//				load the driver
				Class.forName("com.mysql.cj.jdbc.Driver");

//					create connection
				String url = "jdbc:mysql://localhost:3306/techBlog";
				String userName = "root";
				String password = "pC12345@";
				con = DriverManager.getConnection(url, userName, password);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return con;
	}

}
