package guestbook;
//https://20170201t132154-dot-tutorial11-157401.appspot.com/ofyguestbook.jsp


import com.google.appengine.api.users.User;

import com.google.appengine.api.users.UserService;

import com.google.appengine.api.users.UserServiceFactory;

import guestbook.Greeting;

import static com.googlecode.objectify.ObjectifyService.ofy;
 

import java.io.IOException;

import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;



 

@SuppressWarnings("serial")
public class OfySignGuestbookServlet extends HttpServlet {

    public void doPost(HttpServletRequest req, HttpServletResponse resp)

                throws IOException {

        UserService userService = UserServiceFactory.getUserService();

        User user = userService.getCurrentUser();

 

        // We have one entity group per Guestbook with all Greetings residing

        // in the same entity group as the Guestbook to which they belong.

        // This lets us run a transactional ancestor query to retrieve all

        // Greetings for a given Guestbook.  However, the write rate to each

        // Guestbook should be limited to ~1/second.

        //String guestbookName = req.getParameter("guestbookName");

        //Key guestbookKey = KeyFactory.createKey("Guestbook", guestbookName);

        String content = req.getParameter("content");

        //Date date = new Date();

        Greeting greeting = new Greeting(user, content);

        //greeting.setProperty("user", user);

        //greeting.setProperty("date", date);

        //greeting.setProperty("content", content);
                
        ofy().save().entities(greeting).now();
        
 

 

        resp.sendRedirect("/ofyguestbook.jsp");

    }

}