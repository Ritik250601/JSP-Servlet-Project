package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;

public class PostDao {
	private Connection con;
	
	public PostDao(Connection con) {
		this.con = con;
	}
	
	public ArrayList<Category> getCategories(){
		ArrayList<Category> lst = new ArrayList<Category>();
		
		try {
			String query = "SELECT * FROM categories";
			Statement st = con.createStatement();
			ResultSet set = st.executeQuery(query);
			
			while(set.next()) {
				int cid = set.getInt("cid");
				String name = set.getString("name");
				String description = set.getString("description");
				Category c = new Category(cid, name, description);
				lst.add(c);
			}
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
		return lst;
	}
	
	public boolean savePost(Post p) {
		boolean f = false;
			
		try {
		String query = "INSERT INTO posts(pTitle, pContent, pCode, pPic, catId, userId) VALUE(?, ?, ?, ?, ?, ?)";
		
		PreparedStatement pstmt = con.prepareStatement(query);
		pstmt.setString(1, p.getpTitle());
		pstmt.setString(2, p.getpContent());
		pstmt.setString(3, p.getpCode());
		pstmt.setString(4, p.getpPic());
		pstmt.setInt(5, p.getCatId());
		pstmt.setInt(6, p.getUserId());
		pstmt.executeUpdate();
		
		f = true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
		return f;
	}

	//get all posts from db
	public List<Post> getAllPosts(){
		List<Post> list =  new ArrayList<Post>();
	     	
		try {
			String query = "SELECT * FROM posts";
			Statement stmt = con.createStatement();
			ResultSet set = stmt.executeQuery(query);
			while(set.next()) {
		    int pid = set.getInt("pid");
			String pTitle = set.getString("pTitle");
			String pContent = set.getString("pContent");
			String pCode = set.getString("pCode");
			String pPic = set.getString("pPic");
			int catId = set.getInt("catId");
			int userId = set.getInt("userId");
	        Post post = new Post(pTitle, pContent, pCode, pPic, catId, userId);
	        post.setpId(pid);
	        list.add(post);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	
	//get post from db by id
	public List<Post> getPostById(int catId){
		List<Post> list = new ArrayList<Post>();
		
		try {
			String query = "SELECT * FROM posts WHERE catId=?";
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1, catId);
			ResultSet set = pstmt.executeQuery();
			
			while(set.next()) {
		    int pid = set.getInt("pid");
			String pTitle = set.getString("pTitle");
			String pContent = set.getString("pContent");
			String pCode = set.getString("pCode");
			String pPic = set.getString("pPic");
			int userId = set.getInt("userId");
	        Post post = new Post(pTitle, pContent, pCode, pPic, catId, userId);
	        post.setpId(pid);
	        list.add(post);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
}
