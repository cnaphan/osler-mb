<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
	xmlns:pat="http://patientflowmonitoring/"
	xmlns:wfm="http://WIN-687RHJV6VUL:19086/teamworks/webservices/OPPOD/WFMCoordinationEventService.tws"
	exclude-result-prefixes="pat"
	version="1.0">
	
	<xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
	<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
	
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*">
		<xsl:variable name="eventName" select="concat(translate(substring(local-name(.), 1, 1), $uppercase, $lowercase), substring(local-name(.), 2))"/>
		<soapenv:Envelope>
			<soapenv:Header/>
			<soapenv:Body>
				<xsl:element name="wfm:{$eventName}">
					<xsl:apply-templates/>
				</xsl:element>
			</soapenv:Body>
		</soapenv:Envelope>
	</xsl:template>
	
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/patientId">
		<wfm:Patient_ID><xsl:apply-templates/></wfm:Patient_ID>
	</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/providerId">
		<wfm:Provider_ID><xsl:apply-templates/></wfm:Provider_ID>
	</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/physicianId">
		<wfm:Physician_ID><xsl:apply-templates/></wfm:Physician_ID>
	</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/roomId">
		<wfm:Room_ID><xsl:apply-templates/></wfm:Room_ID>
	</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/bedId">
		<wfm:Bed_ID><xsl:apply-templates/></wfm:Bed_ID>
	</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/unitId">
		<wfm:Unit_ID><xsl:apply-templates/></wfm:Unit_ID>
	</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/locationId">
		<wfm:Location_ID><xsl:apply-templates/></wfm:Location_ID>
	</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/orderId">
		<wfm:Order_ID><xsl:apply-templates/></wfm:Order_ID>
	</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/orderType">
		<wfm:OrderType><xsl:apply-templates/></wfm:OrderType>
	</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/ctas">
		<wfm:CTAS><xsl:apply-templates/></wfm:CTAS>
	</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/timestamp">
		<wfm:timestamp><xsl:apply-templates/></wfm:timestamp>
	</xsl:template>	
</xsl:stylesheet>