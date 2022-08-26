package com.tech.blog.servlets;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;

/**
 * Servlet implementation class EditServlet
 */
@MultipartConfig
public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		String userName=request.getParameter("user_name");
		String userEmail=request.getParameter("user_email");
		String userPassword=request.getParameter("user_password");
		Part part =request.getPart("image");
		String image=part.getSubmittedFileName();
		
		//get the user from the session
		
		HttpSession s=request.getSession();
		User user=(User)s.getAttribute("currentUser");
		
		user.setEmail(userEmail);
		user.setName(userName);
		user.setPassword(userPassword);
		String oldFile=user.getProfile();
		user.setProfile(image);
		
		// Data need to updated in database as well
		
		UserDao userDao=new UserDao(ConnectionProvider.getConnection());
		 boolean ans=userDao.updateUser(user);
		 if(ans)
		 {
			 out.println("Updated to db");
			 
			 
			 String pathOld=request.getSession().getServletContext().getRealPath("/")+"pics"+File.separator+oldFile;
			 String path=request.getSession().getServletContext().getRealPath("/")+"pics"+File.separator+user.getProfile();
			 // Helper delete function is not working fine here. We will have to write it somewhere else
			 
			 if(!oldFile.equals("default.png"))
			 {
				 Helper.deleteFile(pathOld);
			 }
			
			
			 
			 // Now the delete function should work fine
			 
			 
			 if(Helper.saveFile(part.getInputStream(), path))
			 {
				 out.println("Profile Updated");
				 Message msg=new Message("Profile Updated","success","alert-success");
					//HttpSession s=request.getSession();
					s.setAttribute("msg",msg);
			 }
			 else
			 {
				 Message msg=new Message("Something went wrong","error","alert-danger");
					//HttpSession s=request.getSession();
					s.setAttribute("msg",msg);
				 
			 }
		 }
		 else
		 {
			 out.println("Not updated");
			 Message msg=new Message("Something went wrong!","error","alert-danger");
				//HttpSession s=request.getSession();
				s.setAttribute("msg",msg);
		 }
		response.sendRedirect("profile.jsp");
		
		
		
	}

}
