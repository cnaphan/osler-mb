import com.ibm.broker.plugin.*;

// This class is inherited from the classes that perform event routing in order to provide some utility
// methods for working with the routing table.
public class OslerMessageUtils {

	// Extracts an event name from a message
	public static String getEventName (MbMessage msg) throws MbException {	
		try {
			// Get the first element (after XMLNSC and XML) and get its name, which will be of the format:
			// <eventName>
			MbElement xmlnscElement = msg.getRootElement().getFirstElementByPath("XMLNSC");
			MbElement root = xmlnscElement.getFirstChild();			
			// If there's a xml tag first, skip it
			if (root.getName().toLowerCase().startsWith("xml", 0)) {
				root = root.getNextSibling();
			}			
			return root.getName();
		} catch (NullPointerException npe) {
			throw new MbUserException("OslerRouting","getEventName",OslerResourceBundle.MESSAGE_SOURCE,OslerResourceBundle.ERROR,
	                "NullPointerException while retrieving event name",
	                new String[] {msg.toString()});
		}		
	}

}
