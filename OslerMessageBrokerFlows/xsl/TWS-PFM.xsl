<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
	xmlns:pat="http://patientflowmonitoring/"
	xmlns:wfm="http://WIN-687RHJV6VUL:19086/teamworks/webservices/OPPOD/WFMCoordinationEventService.tws"
	exclude-result-prefixes="wfm"
	version="1.0">
	
	<xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
	<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
	
	<xsl:template match="/soapenv:Envelope/soapenv:Body/wfm:*">
		<xsl:variable name="eventName" select="concat(translate(substring(name(.), 5, 1), $uppercase, $lowercase), substring(name(.), 6))"/>
		<soapenv:Envelope>
			<soapenv:Header/>
			<soapenv:Body>
				<xsl:element name="pat:{$eventName}">
					<xsl:apply-templates/>
				</xsl:element>
			</soapenv:Body>
		</soapenv:Envelope>
	</xsl:template>
	
	<xsl:template match="/soapenv:Envelope/soapenv:Body/wfm:*/wfm:Patient_ID">
		<patientId><xsl:apply-templates/></patientId>
	</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/wfm:*/wfm:Provider_ID">
		<providerId><xsl:apply-templates/></providerId>
	</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/wfm:*/wfm:Physician_ID">
		<physicianId><xsl:apply-templates/></physicianId>
	</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/wfm:*/wfm:Room_ID">
		<roomId><xsl:apply-templates/></roomId>
	</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/wfm:*/wfm:Bed_ID">
		<bedId><xsl:apply-templates/></bedId>
	</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/wfm:*/wfm:Unit_ID">
		<unitId><xsl:apply-templates/></unitId>
	</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/wfm:*/wfm:Location_ID">
		<locationId><xsl:apply-templates/></locationId>
	</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/wfm:*/wfm:Order_ID">
		<orderId><xsl:apply-templates/></orderId>
	</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/wfm:*/wfm:OrderType">
		<orderType><xsl:apply-templates/></orderType>
	</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/wfm:*/wfm:CTAS">
		<ctas><xsl:apply-templates/></ctas>
	</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/wfm:*/wfm:timestamp">
		<timestamp><xsl:apply-templates/></timestamp>
	</xsl:template>	
</xsl:stylesheet>