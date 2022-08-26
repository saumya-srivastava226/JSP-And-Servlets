package com.tech.blog.servlets;


import java.io.PrintWriter;

import com.tech.blog.dao.PostDao;
import com.tech.blog.entities.Post;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

/**
 * Servlet implementation class AddPostServlet
 */
@MultipartConfig
public class AddPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddPostServlet() {
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
		
		int cid=Integer.parseInt(request.getParameter("cid"));
		
		String pTitle=request.getParameter("pTitle");
		
		String pContent=request.getParameter("pContent");
		String pCode=request.getParameter("pCode");
		Part part=request.getPart("pic");
		// Getting current user id
		HttpSession session=request.getSession();
		User user=(User)session.getAttribute("currentUser");
		
		//getSession().getServletContext().getRealPath("/");
		
		//out.println("Your blog title is "+pTitle);
		//out.println(part.getSubmittedFileName());
		
		Post p= new Post(pTitle,pContent,pCode,part.getSubmittedFileName(),null, cid, user.getId());
		
		PostDao dao=new PostDao(ConnectionProvider.getConnection());
		if(dao.savePost(p))
		{
			
			String pathOld=request.getSession().getServletContext().getRealPath("/")+"blog_pics"+File.separator+part.getSubmittedFileName();
			Helper.saveFile(part.getInputStream(), pathOld);
			out.println("done");
		}
		else
		{
			out.println("error");
		}
	}

}
