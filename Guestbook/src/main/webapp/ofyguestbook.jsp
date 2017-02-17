<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>

<%@ page import="java.util.Collections" %>

<%@ page import="com.google.appengine.api.users.User" %>

<%@ page import="com.google.appengine.api.users.UserService" %>

<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="com.googlecode.objectify.*" %>

<%@ page import="guestbook.Greeting" %>

<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>

<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>

<%@ page import="com.google.appengine.api.datastore.Query" %>

<%@ page import="com.google.appengine.api.datastore.Entity" %>

<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>

<%@ page import="com.google.appengine.api.datastore.Key" %>

<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

 

<html>

	<form action="/cron/mycronjob"></form>
  <style>
  img{
  	max-width : auto;
  	height : auto;
  }
  h1{
  	text-align: center;
  	color: #cc5500;
  	background-color: black;
  }
  </style>
  
	<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
  <head>
  <title>Texas Sports Blog Arnav and Nicole!</title>
  </head>

  <body>
  <h1>Welcome to the Texas Sportz Blog!<br/>
 	<img src = "https://cdn0.vox-cdn.com/thumbor/SOhWXIOg4sfzO3ztUHAWMHxT9qQ=/44x0:802x426/1600x900/cdn0.vox-cdn.com/uploads/chorus_image/image/47783137/Texas_dunk.0.0.png" 
 				alt="Texas Dunks" width="1000" height = "300">

 

<%
	ObjectifyService.register(Greeting.class);

	List<Greeting> greetings = ObjectifyService.ofy().load().type(Greeting.class).list();   

	Collections.sort(greetings); 

    String guestbookName = request.getParameter("guestbookName");

    if (guestbookName == null) {

        guestbookName = "Sportz Blog";

    }

    pageContext.setAttribute("guestbookName", guestbookName);

    UserService userService = UserServiceFactory.getUserService();

    User user = userService.getCurrentUser();

    if (user != null) {

      pageContext.setAttribute("user", user);

%>

<p>Hello, ${fn:escapeXml(user.nickname)}! (You can

<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>

<%
if (greetings.isEmpty()) {

    %>

    <p>${fn:escapeXml(guestbookName)} has no posts.</p>
    
        <form action="/ofysign" method="post">

 		 <div><textarea name="content" rows="5" cols="100"></textarea></div>

 		 <div><input type="submit" value="Submit Blog Post" /></div>

	 		  <input type="hidden" name="guestbookName" value="${fn:escapeXml(guestbookName)}"/>

		</form>

    <%

} else {
	
	

    %>
    
        <form action="/ofysign" method="post">

 		 <div><textarea name="content" rows="5" cols="100"></textarea></div>

 		 <div><input type="submit" value="Submit Blog Post" /></div>

	 		  <input type="hidden" name="guestbookName" value="${fn:escapeXml(guestbookName)}"/>

		</form>

    <p>Messages in ${fn:escapeXml(guestbookName)}:</p>
<%    }

    } else {

%>

<p>Hello,

<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>

to be able to contribute to Sportz Blog.</p>

<%
    }

if (greetings.isEmpty()) {

    %>

    <p>${fn:escapeXml(guestbookName)} has no posts.</p>
<%
    }

%>
 

<%

//    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

//    Key guestbookKey = KeyFactory.createKey("Guestbook", guestbookName);

    // Run an ancestor query to ensure we see the most up-to-date

    // view of the Greetings belonging to the selected Guestbook.

//    Query query = new Query("Greeting", guestbookKey).addSort("date", Query.SortDirection.DESCENDING);

//    List<Entity> greetings = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5));

    
	


		Collections.reverse(greetings);
        for (Greeting greeting : greetings) {

            pageContext.setAttribute("greeting_content",

                                     greeting.getContent());

            if (greeting.getUser() == null) {


            } else {

                pageContext.setAttribute("greeting_user",

                                         greeting.getUser());
                %>


                <p><b>${fn:escapeXml(greeting_user.nickname)}</b> wrote:</p>

               

                <blockquote>${fn:escapeXml(greeting_content)}</blockquote>

<%

            

            
            
        }

    }

%>

	
  </h1> 

  </body>

</html>