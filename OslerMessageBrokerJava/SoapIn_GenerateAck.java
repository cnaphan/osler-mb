import com.ibm.broker.javacompute.MbJavaComputeNode;
import com.ibm.broker.plugin.*;


public class SoapIn_GenerateAck extends MbJavaComputeNode {

	public void evaluate(MbMessageAssembly inAssembly) throws MbException {
		MbOutputTerminal out = getOutputTerminal("out");				
		MbMessage inMessage = inAssembly.getMessage();
	    MbMessage outMessage = new MbMessage();  // create an empty output message
	    MbMessageAssembly outAssembly = new MbMessageAssembly(inAssembly, outMessage);	       
	    
	    //MbElement inRoot = inMessage.getRootElement();
	    MbElement outRoot = outMessage.getRootElement();
	    MbElement outBody = outRoot.createElementAsLastChild("XMLNSC");  // create the 'Body' XMLNSC element
	    // Get the root element name of the original message
	    String rootElementName = OslerMessageUtils.getEventName(inMessage);
	    // Compose a response element for the output by appending the word Response to whatever
	    // the incoming root event name is
	    String responseElementName = rootElementName + "Response";
	    // Create a single element with the response element	    
	    MbElement responseElement = outBody.createElementAsLastChild(MbXMLNSC.FOLDER, responseElementName, null);
	    // Set the namespace properly
	    responseElement.setNamespace("http://patientflowmonitoring/");
	    // Add another element inside that one with the same name and the content "Message received"
	    responseElement.createElementAsLastChild(MbXMLNSC.FOLDER, responseElementName, "Message received");
	    
		out.propagate(outAssembly);
	}

}
