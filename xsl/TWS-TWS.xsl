<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
	xmlns:tws="http://WIN-687RHJV6VUL:19086/teamworks/webservices/OPPOD/WFMCoordinationEventService.tws"
	version="1.0">
	                                    
	<xsl:template match="/soapenv:Envelope/soapenv:Body/tws:*">		
		<soapenv:Envelope>
			<soapenv:Header/>
			<soapenv:Body>
				<xsl:element name="tws:{local-name(.)}">
					<xsl:apply-templates/>
				</xsl:element>
			</soapenv:Body>
		</soapenv:Envelope>
	</xsl:template>
	
	<xsl:template match="/soapenv:Envelope/soapenv:Body/tws:*/tws:*">
		<xsl:element name="{local-name(.)}"><xsl:value-of select="."/></xsl:element>
	</xsl:template>
	
</xsl:stylesheet>