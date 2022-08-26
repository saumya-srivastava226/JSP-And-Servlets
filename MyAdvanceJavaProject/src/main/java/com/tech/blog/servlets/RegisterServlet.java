package com.tech.blog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@MultipartConfig

public class RegisterServlet extends HttpServlet {
	
	
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException
	{
		res.setContentType("text/html");
		PrintWriter out=res.getWriter();
		//out.println("<h1> Your register servlet is running </h1>");
		
		String check=req.getParameter("check");
		if(check==null)
		{
			out.println("box not checked");
		}
		else
		{
			// rest of the data will be fetched here
			
			
			String name=req.getParameter("user_name");
			String email=req.getParameter("user_email");
			String password=req.getParameter("user_password");
			String gender=req.getParameter("gender");
			
			// We have fetched the data from form and now we have to put all the data inside databases
			// Create a user object and put all the data inside it
			User user=new User(name,email,password,gender);
			
			
			
			
			
			
			
			
			// create a user dao object
			UserDao dao=new UserDao(ConnectionProvider.getConnection());
			if(dao.saveUser(user)) {
				out.println("done");
			}
			else
			{
				out.println("error");
			}
			
		}
		
		
	}
	

}
