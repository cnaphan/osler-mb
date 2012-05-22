Osler - Message Broker Flows
========

Overview
--------
The purpose of the Osler Message Broker is to route and transform event messages to and from the various applications that make up the Osler ecosystem. There are three distinct phases of the overall message flow, separated by queues:

* Receiving events and translating them into the canonical format
	* RestIn.msgflow - Receives events via REST and puts them on the incoming queue
	* SoapIn.msgflow - Receives events via SOAP, strips the SOAP envelope and adds them to the incoming queue 
	* TwsIn.msgflow - Receives events via SOAP in TWS format according to BPM's WSDL, strips the SOAP envelope and adds them to the incoming queue
	
* Processing the event
	* ProcessEvent.msgflow - Takes an event from the incoming queue, propogates a copy to each destination according to their configured access method, then adds a log message to the log queue.
	* SoapFormatting.msgflow - Takes a SOAP message and translate it according to the destination's format
	* SendEventHttp.msgflow - Takes a message and sends it via HTTP to the destination URL
	* SendEventJms.msgflow - Takes a message and sends it to a JMS queue	
	
* Logging the resposne
	* LogEvent.msgflow - Takes a log message and sends it to the console via REST.
	* LogResponse.msgflow - Takes a response log message and sends it to the console via REST.
	* TestJms.msgflow - Takes a JMS response message and sends it to the console via REST.
	
The relationship between the message flows is given in the diagram below.
![Message Flow Diagram](https://github.com/cnaphan/osler-mb/raw/master/MessageFlows.png)

Developing XSL
--------------
Message transformations are achieved

