<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
	xmlns:pat="http://patientflowmonitoring/"
	version="1.0">	
	<xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
	<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
	<xsl:strip-space elements="*"/>	
	<xsl:output method="text" version="string" encoding="string" omit-xml-declaration="yes" standalone="no" indent="no"	media-type="string" cdata-section-elements="*"/>	
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*"><xsl:variable name="eventName" select="concat(translate(substring(local-name(.), 1, 1), $lowercase, $uppercase), substring(local-name(.), 2))"/>event:<xsl:value-of select="$eventName"/>,<xsl:apply-templates/>
	</xsl:template>	
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/patientId">Patient_ID:<xsl:apply-templates/>,</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/providerId">Provider_ID<xsl:apply-templates/>,</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/physicianId">Physician_ID<xsl:apply-templates/>,</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/roomId">Room_ID<xsl:apply-templates/>,</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/bedId">Bed_ID<xsl:apply-templates/>,</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/unitId">Unit_ID<xsl:apply-templates/>,</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/locationId">Location_ID:<xsl:apply-templates/>,</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/orderId">orderId:<xsl:apply-templates/>,</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/orderType">orderType:<xsl:apply-templates/>,</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/ctas">CTAS:<xsl:apply-templates/>,</xsl:template>
	<xsl:template match="/soapenv:Envelope/soapenv:Body/pat:*/timestamp">timestamp:<xsl:value-of select="concat(concat(substring(.,1,10), '/'), translate(substring(., 12, 8), ':', '-'))"/></xsl:template>	
</xsl:stylesheet>