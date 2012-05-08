<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
	xmlns:pat="http://patientflowmonitoring/" 
	xmlns:wbe="http://osler.eecs.uottawa.ca:9081/wbe/"
	exclude-result-prefixes="pat"
	version="1.0">
	
	<xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
	<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
	
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*">
		<xsl:variable name="eventName" select="concat(translate(substring(name(.), 5, 1), $lowercase, $uppercase), substring(name(.), 6))"/>
		<soapenv:Envelope>
			<soapenv:Header/>
			<soapenv:Body>
				<xsl:element name="wbe:{$eventName}">
					<xsl:element name="{$eventName}">
						<xsl:apply-templates/>
					</xsl:element>
				</xsl:element>
			</soapenv:Body>
		</soapenv:Envelope>
	</xsl:template>
	
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/patientId">
		<Patient_ID><xsl:apply-templates/></Patient_ID>
	</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/providerId">
		<Provider_ID><xsl:apply-templates/></Provider_ID>
	</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/physicianId">
		<Physician_ID><xsl:apply-templates/></Physician_ID>
	</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/roomId">
		<Room_ID><xsl:apply-templates/></Room_ID>
	</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/bedId">
		<Bed_ID><xsl:apply-templates/></Bed_ID>
	</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/unitId">
		<Unit_ID><xsl:apply-templates/></Unit_ID>
	</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/locationId">
		<Location_ID><xsl:apply-templates/></Location_ID>
	</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/orderId">
		<Order_ID><xsl:apply-templates/></Order_ID>
	</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/orderType">
		<OrderType><xsl:apply-templates/></OrderType>
	</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/ctas">
		<CTAS><xsl:apply-templates/></CTAS>
	</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/timestamp">
		<timestamp><xsl:apply-templates/></timestamp>
	</xsl:template>	
</xsl:stylesheet>