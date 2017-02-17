package guestbook;

import java.io.IOException;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import com.sendgrid.*;

@SuppressWarnings("serial")
public class cronlogServlet extends HttpServlet{
	private static final Logger _logger = Logger.getLogger(cronlogServlet.class.getName());
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
	throws IOException {
	try {
	_logger.info("Cron Job has been executed");
	Email from = new Email("test@example.com");
    String subject = "Sending with SendGrid is Fun";
    Email to = new Email("test@example.com");
    Content content = new Content("text/plain", "and easy to do anywhere, even with Java");
    Mail mail = new Mail(from, subject, to, content);
    SendGrid sg = new SendGrid(System.getenv("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"));
    Request request = new Request();
      request.method = Method.POST;
      request.endpoint = "mail/send";
      request.body = mail.build();
      Response response = sg.api(request);
      System.out.println(response.statusCode);
      System.out.println(response.body);
      System.out.println(response.headers);
    
	}catch (IOException ex){
		throw ex;
	}
	}
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
	throws ServletException, IOException {
	doGet(req, resp);
	}
}
