<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sorry Something went wrong</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<link href="css/mystyle.css" rel="stylesheet" types="text/css"/>
</head>
<body>
<div class="container text-center">
<img src="images/browser.png" class="img-fluid">
<h3 class="display-3">Sorry!!Something went wrong..</h3>
<%=exception  %>
<a href="index.jsp" class="btn btn-lg mt-3">Home</a>

</div>

</body>
</html>