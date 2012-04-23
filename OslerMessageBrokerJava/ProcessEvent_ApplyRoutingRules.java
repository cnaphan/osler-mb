import com.ibm.broker.javacompute.MbJavaComputeNode;
import com.ibm.broker.plugin.MbElement;
import com.ibm.broker.plugin.MbException;
import com.ibm.broker.plugin.MbMessage;
import com.ibm.broker.plugin.MbMessageAssembly;
import com.ibm.broker.plugin.MbOutputTerminal;


public class ProcessEvent_ApplyRoutingRules extends MbJavaComputeNode {

	public void evaluate(MbMessageAssembly assembly) throws MbException {
		MbOutputTerminal out = getOutputTerminal("out");
		//MbOutputTerminal alt = getOutputTerminal("alternate");

		  
		
		for (int i = 0; i < 1; i++) {
			String requestUrl = "http://osler.eecs.uottawa.ca/PFM/services/PFMServer";
			String accessMethod = "SOAP";
			
			MbMessage newEnv = new MbMessage(assembly.getMessage());
				
			// Set the HTTP request URL in the local environment (which will be used to call the web service later on the message flow)
			// TODO For some reason, if I don't have both methods of setting the RequestURL, something fails... either the URL doesn't appear in the traces or it doesn't get used in the HTTPRequest node... strange bug
			newEnv.getRootElement().
				createElementAsLastChild(MbElement.TYPE_NAME, "Destination", null).
				createElementAsLastChild(MbElement.TYPE_NAME, "HTTP", null).
				createElementAsLastChild(MbElement.TYPE_NAME_VALUE, "RequestUrl", requestUrl);
			
			newEnv.getRootElement().evaluateXPath("?Destination/?HTTP/?RequestURL[set-value('"+requestUrl+"')]");					
			
			// Set the routing label in the local environment, which will route the message to the proper method
			newEnv.getRootElement().evaluateXPath("?Destination/?RouterList/?DestinationData/?label[set-value('"+accessMethod+"')]");
			
			
			/*MbElement labelDestination = destination.createElementAsLastChild(MbElement.TYPE_NAME, "RouterList", null).			
				createElementAsLastChild(MbElement.TYPE_NAME, "DestinationData", null);
			labelDestination.createElementAsLastChild(MbElement.TYPE_NAME_VALUE, "label", "SOAP");
			*/
			
			/*destination.createElementAsLastChild(MbElement.TYPE_NAME, "SOAP", null).
				createElementAsLastChild(MbElement.TYPE_NAME, "Request", null).
				createElementAsLastChild(MbElement.TYPE_NAME, "Transport", null).
				createElementAsLastChild(MbElement.TYPE_NAME_VALUE, "WebServiceURL", "http://localhost/osler-mb/event/receive/soap");*/			
			

			
			//<bedRequest><patientId>Pa77777</patientId><providerId>Pro12345</providerId><unitId>Unit223</unitId><timestamp>2012-04-01 12:30:15</timestamp></bedRequest>
			newEnv.finalizeMessage(MbMessage.FINALIZE_NONE);
			MbMessageAssembly outAssembly = new MbMessageAssembly(assembly,	newEnv,assembly.getExceptionList(), assembly.getMessage());
			out.propagate(outAssembly);
		}
		
		// Extract variables need to log
		
		// Insert log record into database
		
		// Get routing destinations for this event type
		
		// Add destination information to the message's local environment
		

	}	

}
