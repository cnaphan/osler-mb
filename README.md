Osler - Message Broker Flows
========

Overview
--------
The purpose of the Osler Message Broker is to route and transform event messages to and from the various applications that make up the Osler ecosystem. There are three distinct phases of the overall message flow, separated by queues:

* Receiving events and translating them into the canonical format
	* RestIn.msgflow - Receives events via REST and puts them on the incoming queue
	* SoapIn.msgflow - Receives events via SOAP in the PFM format, strips the SOAP envelope and adds them to the incoming queue 
	* TwsIn.msgflow - Receives events via SOAP in TWS format according to BPM's WSDL, strips the SOAP envelope and adds them to the incoming queue
	
* Processing the event
	* ProcessEvent.msgflow - Takes an event from the incoming queue, propogates a copy to each destination according to their configured access method, then adds a log message to the log queue.
	* SoapFormatting.msgflow - Takes a SOAP message and translate it according to the destination's format
	* SendEventHttp.msgflow - Takes a message and sends it via HTTP to the destination URL
	* SendEventJms.msgflow - Takes a message and sends it to a JMS queue	
	
* Logging the response
	* LogEvent.msgflow - Takes a log message and sends it to the console via REST.
	* LogResponse.msgflow - Takes a response log message and sends it to the console via REST.
	* TestJms.msgflow - Takes a JMS response message and sends it to the console via REST.
	
The relationship between the message flows is given in the diagram below.
![Message Flow Diagram](https://github.com/cnaphan/osler-mb/raw/master/MessageFlows.png)

Developing XSL
--------------
Message transformations are achieved using XML stylesheet transformations (aka XLS), a standard XML tool and a standard node in Message Broker. I develop XSLs in jEdit, which has a nifty XSLT Processor plug-in for developing and testing XSLs. I use the naming convention A-B.xls, where A is the source format and B is the destination format. Unfortunately, it doesn't capture all the details, such as whether the message has a SOAP envelope or not, or things like the fact that WBE sends and receives in different formats. Read through and understand what the XLS does before making changes to it. 

XSLs are pre-compiled by Message Broker and are apparently quite fast. Also, with sufficient testing prior to deployment, I've never had any errors or hiccups with XSL, so I think it is the right tool for the job. It also avoids the need to do transformations in a programmatic manner, which is complex.

I have used XSL for several years, but I still use !(this tutorial on W3Schools)[http://www.w3schools.com/xsl/] for a refresher.

Handling SOAP
-------------
There are many options for handling SOAP messages in Message Broker. Namely, I can think of three:

1. Treating them as simple HTTP messages with some extra XML in them (i.e. using HttpInput node)
2. Supplying a WSDL and receiving messages as SOAP operations (i.e. using a SoapInput node in WSDL mode)
3. Receiving messages generic SOAP messages (i.e. using a SoapInput node in Gateway mode)

I have chosen the first method, although it is not hard to use several methods or to change between one and another. I avoided the WSDL method because I do not think that the broker should need to be redeployed every time there is a change to events. If a WSDL is absolutely necessary (if PFM abandons hosting one and BPM needs one), then I would suggest exploring having the broker host an alternative WSDL that does not use the operation-per-event format. BPM seems quite flexible in how it marshalls its variables into the SOAP message, so a SOAP message body such as the following seems plausible:

* event
	* name
	* Patient_ID
	* ...
	* timestamp

Which could be converted by the broker into a standard format.

Broker Computation Programming
------------------------------
The broker allows you to add bits of code here and there using a variety of languages. The primary one is ESQL, a SQL variant _somewhat_ well-suited to working with message trees. The others are Java, PHP and .NET (C# presumably). It is tempting to use only Java but I have found ESQL to be the proper choice for most uses. The main reason is that 99% of documentation for Message Broker is in the "IBM Help" and 90% of the example code is ESQL. Some broker features like shared variables are simply not available in anything but ESQL, as well. So, unless you have at least a year of broker development experience and are an ace with XPath, or are doing something only supported in Java (like JDBC connections), I would advise sticking to ESQL.

Also, since ESQL is so archaic and proprietary, there should be fewer migration issues. :)
