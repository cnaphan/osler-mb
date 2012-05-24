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
	* SoapFormatting.msgflow - Takes a SOAP message and translates it according to the destination's format
	* SendEventHttp.msgflow - Takes a message and sends it via HTTP to the destination URL
	* SendEventJms.msgflow - Takes a message and sends it to a JMS queue	
	
* Logging the response
	* LogEvent.msgflow - Takes a log message and sends it to the console via REST.
	* LogResponse.msgflow - Takes a response log message and sends it to the console via REST.
	* TestJms.msgflow - Takes a JMS response message and sends it to the console via REST.
	
The relationship between the message flows is given in the diagram below.
![Message Flow Diagram](https://github.com/cnaphan/osler-mb/raw/master/MessageFlows.png)

Handling SOAP
-------------
There are many options for handling SOAP messages in Message Broker. Namely, I can think of three:

1. Treating them as simple HTTP messages with some extra XML in them (i.e. using HttpInput node)
2. Supplying a WSDL and receiving messages as SOAP operations (i.e. using a SoapInput node in WSDL mode)
3. Receiving messages generic SOAP messages (i.e. using a SoapInput node in Gateway mode)

I have chosen the first method, although it is not hard to use several methods or to change between one and another. I avoided the WSDL method because I do not think that the broker should need to be redeployed every time there is a change to events. If a WSDL is absolutely necessary (if PFM abandons hosting one and BPM needs one), then I would suggest exploring having the broker host an alternative WSDL.

Developing XSL
--------------
Message transformations are achieved using XML stylesheet transformations (aka XLS), a standard XML tool and a standard node in Message Broker. I develop XSLs in jEdit, which has a nifty XSLT Processor plug-in for developing and testing XSLs. The Message Broker Toolkit also supports compiling and running XSLs, which can be useful because the IBM XLS compiler is a bit more strict than others. I use the naming convention A-B.xls, where A is the source format and B is the destination format. Unfortunately, it doesn't capture all the details, such as whether the message has a SOAP envelope or not, or things like the fact that WBE sends and receives in different formats. Read through and understand what the XLS does before making changes to it. 

XSLs are pre-compiled by Message Broker and are apparently quite fast. Also, with sufficient testing prior to deployment, I've never had any errors or hiccups with XSL, so I think it is the right tool for the job. It also avoids the need to do transformations in a programmatic manner, which is complex.

I have used XSL for several years, but I still use !(this tutorial on W3Schools)[http://www.w3schools.com/xsl/] for a refresher on certain functions.

Broker Computation Programming
------------------------------
The broker allows you to add bits of code here and there using a variety of languages. The primary one is ESQL, a SQL variant _somewhat_ well-suited to working with message trees. The others are Java, PHP and .NET (C# presumably). It is tempting to use only Java but I have found ESQL to be the proper choice for most uses. The main reason is that 99% of documentation for Message Broker is in the "IBM Help" and 90% of the example code is ESQL. Some broker features like shared variables are simply not available in anything but ESQL, as well. So, unless you have at least a year of broker development experience and are an ace with XPath, or are doing something only supported in Java (like JDBC connections), I would advise sticking to ESQL.

Also, since ESQL is so archaic and proprietary, there should be fewer migration issues. :)

A final point about coding: the point of the broker is to avoid lots of code. If you find yourself writing a lot of code, it's probably a bad sign. (Or maybe a sign that you should just put the routing logic into a Grails applicatioin) Since the broker should do nothing but route messages, the code should be restricted primarily to `SET` statments, as well as a few `IF`s and loops.

Alternative Implementations
---------------------------
Here are some alternate ways that the broker could've been implemented, with notes in case you want to go this way.

###Simplified Routing in IBM WebSphere Message Broker
If you find my current routing logic too complex and restrictive, consider scrapping my flows and making it simpler. Mainly, the broker design could be a lot less complex if I did not support dynamically configurable destinations. For instance, instead of routing to labels such as HTTP and SOAP, I could route to labels such as PFM, BPM, which would be preconfigured in the message flow to apply the correct formating and use the right nodes and parameters. This would be much more clear and easy to read, but you would have to redeploy the BAR every time you make a change to the destination. (The event rules could still be in a XML file, unless you want to hardcode those, too)

###Use an Open Source Broker
Refer to my report for details on Mule ESB and Fuse ESB. If I had to pick right now, I'd use Fuse, as we already use Apache ActiveMQ and Apache CXF, so why not add another Apache-based product? Fuse also has a much higher install base. Mule seems perfectly acceptable, too, though. I would use the simplified routing scheme described in the section above and deploy either Mule or Fuse onto the same server as PFM. Mule/Fuse do not have dependencies on a queue manager like IBM Message Broker does, so there's less overhead. You can also re-use the XSLs from Message Broker.

I think that if you really understood the IBM Message Broker implementation and were comfortable with Active MQ, SOAP, etc... you could have Mule or Fuse implemented in about 2 weeks.

###Put the Routing Logic into a Grails Application
Here there are two options: make the routing logic part of PFM or make a separate web application that handles only routing. I recommend using the [routing plugin](http://grails.org/plugin/routing) which is based on Apache Camel, which Fuse also uses under the hood. This gives you the adapter and transformation functionality you need to do the routing, and a Groovy DSL to code with. Basically, you would be concentrating all the routing logic into one Grails application or one module of PFM (or CEM) and using the simplest possible mechanisms elsewhere.

The downside to this is that it does scale well. If the hospital already has a broker of some sort, it would be better to have the routing as a modular component that could be separated from PFM and re-developed in a way that makes sense for the hospital (BizTalk, Fuse, IBM MB, etc...). This would allow the hospital to leverage their existing broker infrastructure.

Gotchas 
-------
1. I use a lot of Trace nodes, which are not considered a best practice. Other methods allow you to turn tracing on and off at run-time. But I find Trace nodes produce much better traces than any other methods and getting visibility into the broker at key places is so important to developing the message flows, so I feel it's worthwhile. I also use File-based traces (also not a best practice) because I find the Event Viewer to be painful to use.

2. PubSub is only half-implemented. The idea would be that if there are destinations with the PubSub access method, then the broker would publish the event in various formats on the appropriate publication topic. The access method exists and there is some code in `ProcessEvents.esql` but the `Publication` nodes are not there yet.

3. JMS is only half-implemented. You can route a message to a local JMS queue within a local MQ queue manager. That's not very useful. Another option, specific to ActiveMQ, is to !(expose the queue via REST services)[http://activemq.apache.org/rest.html], which is configurable through ActiveMQ. This would allow you to use the REST access method along with the desired format, which is much easier from a brokering perspective than setting up a remote queue definition.
