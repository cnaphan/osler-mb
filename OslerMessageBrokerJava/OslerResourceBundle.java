import java.util.ListResourceBundle;

// This class allows for event logging.
public class OslerResourceBundle extends ListResourceBundle  {

	public static final String MESSAGE_SOURCE = OslerResourceBundle.class.getName();                                               
    public static final String INFO = "INFO";
    public static final String WARNING = "WARNING";   
    public static final String ERROR = "ERROR";
  
    private Object[][] messages  = {{INFO, "User Message: {0}" },
    								{WARNING, "Warning-{0}"},
    								{ERROR, "User Error - Message: {0}, Stack Trace: {1}"}};
    
   public Object[][] getContents()
    {
      return messages;
    } 

}
