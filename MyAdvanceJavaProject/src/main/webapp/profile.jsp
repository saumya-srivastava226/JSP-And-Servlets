<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
  <%@page import="com.tech.blog.entities.User" %>  
  <%@page import ="com.tech.blog.entities.Message" %>
  <%@page import="com.tech.blog.dao.*" %>
  <%@page import="com.tech.blog.helper.ConnectionProvider" %>
  <%@page import="java.util.ArrayList" %>
  <%@page import="com.tech.blog.entities.*" %>
  <%@page errorPage="error_page.jsp" %>
  
  <%
  	User user=(User)session.getAttribute("currentUser");
  
  	if(user==null)
  	{
  		response.sendRedirect("login_page.jsp");
  	}
  
  %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Profile</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<link href="css/mystyle.css" rel="stylesheet" types="text/css"/>




</head>
<body>
  <!--  navbar -->
  <nav class="navbar navbar-expand-lg navbar-light primary-background">
  <a class="navbar-brand" href="index.jsp">TechDelight</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="#">Learn Code with Saumya <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">Contact</a>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          Categories
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#">Programming Languages</a>
          <a class="dropdown-item" href="#">Project Implementation</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">Data Structures and Algorithms</a>
        </div>
      </li>
      <li class="nav-item">
        <a class="nav-link disabled"  href="#" data-toggle="modal" data-target="#add-post-modal">Do Post</a>
      </li> 
      
    </ul>
   
   <ul class="navbar-nav mr-right">
    <li class="nav-item">
        <a class="nav-link disabled" href="#!" data-toggle="modal" data-target="#profile-modal"> <%=user.getName() %></a>
      </li>
   
      <li class="nav-item">
        <a class="nav-link disabled" href="LogoutServlet">Logout</a>
      </li> 
   </ul>
   
   
  </div>
</nav>
  
  <!--  end of navber -->
  
  <%
			Message m=(Message)session.getAttribute("msg");
			if(m!=null)
			{
				%>
				  <div class="alert alert-primary" roles="alert">
				     <%= m.getContent() %>
				  </div>
				  
				  
				  
				<% 
				
				session.removeAttribute("msg");
			}
		
		
		%>
		<!-- Main Body of the page -->
		
		<main>
		<div class="container">
		
		<div class="row mt-4">
		<div class="col-md-4">
			<!-- This is first column we will show all the categories here -->
			
			<div class="list-group">
     <a href="#" onclick="getPosts(0,this)" class=" c-link list-group-item list-group-item-action  active  ">
      All posts
      </a>
      <% 
      		PostDao d=new PostDao(ConnectionProvider.getConnection());
      		ArrayList<Category> list1=d.getAllCategories();
      		for(Category cc:list1)
      		{
      			%>
      				<a href="#" onclick="getPosts(<%=cc.getCid() %>,this)" class=" c-link list-group-item list-group-item-action active"><%= cc.getName()%></a>
      			
      			<% 
      			
      			
      		}
      			
      
      
      %>
      
      
      
      
      </div>
		
		</div>
		<div class="col-md-8" >
			<!-- This is the second column , all the posts will be displayed here -->
			<div class="container" id="loader">
			<i class="fa fa-refresh fa-4x"></i>
			<h3 class="mt-2">Loading..</h3>
			 </div>
			 
			 <div class="container-fluid" id="post-container">
			 
			 </div>
		
		</div>
		
		
		</div>
		
		
		
		</div>
		
		</main>
		
		
		
		<!-- end main body -->
  
  
  
  <!-- modal view -->
  
  <!-- Button trigger modal -->


<!-- Modal -->
<div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header primary-background text-white text-center">
        <h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="container text-center">
        
        
        <img class="img-fluid"src="pics/<%=user.getProfile()  %> ">
        <h5 class="modal-title" id="exampleModalLabel"><%=user.getName() %></h5>
        
        <!-- details of the user -->
        
        <div id="profile-details">
        <table class="table">
  
  <tbody>
    <tr>
      <th scope="row">ID:</th>
      <td><%=user.getId()%></td>
     
    </tr>
    <tr>
      <th scope="row">Email:</th>
      <td><%=user.getEmail() %></td>
      
    </tr>
    <tr>
      <th scope="row">Gender:</th>
      <td><%=user.getGender() %></td>
     
    </tr>
  </tbody>
</table>
        
  </div>
        
        
        
        <!-- edit profile -->
        
        
        <div id="profile-edit" style="display:none;">
        	<h2 class="mt-2">Please Edit Carefully</h2>
        	
        	<form action="EditServlet" method="post" enctype="multipart/form-data">
        	<table class="table">
        	  <tr>
        	  	<td>ID:</td>
        	  	<td><%=user.getId() %></td>
        	  
        	  
        	  </tr>
        	   <tr>
        	  	<td>Email:</td>
        	  	<td><input type="email" class="form-control" name="user_email" values="<%=user.getEmail() %>"></td>
        	  
        	  
        	  </tr>
        	   <tr>
        	  	<td>Name:</td>
        	  	<td><input type="text" class="form-control" name="user_name" values="<%=user.getName() %>"></td>
        	  
        	  
        	  </tr>
        	  
        	   <tr>
        	  	<td>Password:</td>
        	  	<td><input type="password" class="form-control" name="user_password" values="<%=user.getPassword() %>"></td>
        	  
        	  
        	  </tr>
        	<tr>
        	  	<td>Gender:</td>
        	  	<td><%=user.getGender() %></td>
        	  
        	  
        	  </tr>
        	  <tr>
        	  	<td>New Profile pic:</td>
        	  	<td><input type="file" class="form-control" name="image"></td>
        	  
        	  
        	  </tr>
        	</table>
        	
        	<div class="container">
        	<button type="submit" class="btn btn-outline-primary">
        	Save
        	</button>
        	
        	</div>
        	
        	</form>
        	
        	
        	
        </div>
        
        
        
        </div>
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button id="edit-profile-button" type="button" class="btn btn-primary">EDIT</button>
      </div>
    </div>
  </div>
</div>
  
  <!--  end of modal view -->
  
  
  
  <!-- add post modal -->
  
 

<!-- Modal -->
<div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Your blog details</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      
        <!--  All the content that we need we are going to include that in our modal body -->
     
     <form id="add-post-form" action="AddPostServlet" method="post">
     
    	<div class="form-group">
      <select class="form-control" name="cid">
      <option selected disabled>...Select Category..</option>
     
     	 <%
                PostDao postd = new PostDao(ConnectionProvider.getConnection());
     	        ArrayList<Category> list = postd.getAllCategories();
                  for (Category c : list) {
          
                 %>
                      <option value="<%= c.getCid()%>"><%= c.getName()%></option>

                 <%
                     }
         %>
     	
      
      
     
     
     
     </select>
    	
    	
    	</div>
     
     
     <div class="form-group">
     <input name="pTitle" type="text" placeholder="Enter blog title" class="form-control"/>
      </div>
      
      <div class="form-group">
      <textarea  name="pContent" class="form-control" placeholder="What's in your mind?"></textarea>
      </div>
      <div class="form-group">
      <textarea  name="pCode" class="form-control" placeholder="Do you have code?"></textarea>
      </div>
      
       <div class="form-group">
       <label >Your picture(if any):</label>
       <br>
      <input name="pic" type="file">
      </div>
     
     
     <div class="container text-center">
     <button type="submit" class="btn btn-outline-primary">Post</button>
     </div>
     
     </form>
     
     
     
     
     
     
     
        ...
      </div>
     
    </div>
  </div>
</div>
 

<!--  end of post modal -->
  
  
  
  
  
  <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
  
  <script>
  $(document).ready(function(){
	  
	  let editStatus=false;
	  
	  
	  
	  $('#edit-profile-button').click(function(){
		 // alert("button clicked");
		 
		 if(editStatus==false)
			 {
			 $("#profile-details").hide()
			 
			 $("#profile-edit").show();
			 
			 editStatus=true;
			 
			 $(this).text("Back")
			 
			 
			 }
		 else
			 {
			 $("#profile-details").show()
			 
			 $("#profile-edit").hide();
			 editStatus=false;
			 $(this).text("Edit")
			 
			 }
		 
	  })
	  
  });
  
  </script>
  <!-- now add post javascript -->
  
  <script>
  $(document).ready(function(e){
	
	  $("#add-post-form").on("submit",function(event){
		// this code gets called when form is submitted
		event.preventDefault();
		console.log("you have clicked on submit")
		
		// we will fetch all the data of the form
		
		let form=new FormData(this);
		
		// now requesting to server
		
		$.ajax({
			url:"AddPostServlet",
			type:'POST',
			data:form, 
			success:function(data,textStatus,jqXHR){
				
				console.log(data);
				if(data.trim()==='done')
					{
						swal("Good job,","Saved Successfully","success");
					}
				else
					{
					   swal("Error ","Try again!","error");
					}
				
				
			},
			error:function(jqXHR,textStatus,errorThrown){
				swal("Error ","Try again!","error");
				
			},
			
			processData:false,
			contentType:false
			
		})
		
		
		  
	  })
	  
	  
  })
  
  
  
  
  
  </script>
  <!-- laoding post using ajax -->
  <script> 
  
  
  
  	function getPosts(catId,temp){
  			$("#loader").show();
  			$("#post-container").hide()
  			$(".c-link").removeClass('active')
  			
  			
            $.ajax({
  			
  			url:"load_posts.jsp",
  			data:{cid: catId},
  			success:function(data,textStatus,jqXHR){
  				console.log(data);
  				$("#loader").hide();
  				$("#post-container").show();
  				$("#post-container").html(data)
  				$(temp).addClass('active')
  				
  			}
  			
  			
  			
  		})
  		
  		
  	}
  
  
  	$(document).ready(function(e){
  		
  		getPosts(0)
  		
  		
  		
  		
  		
  		
  	})
  
  
  
  </script>
  
  
</body>
</html>