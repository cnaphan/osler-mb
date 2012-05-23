<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
	xmlns:tws="http://WIN-687RHJV6VUL:19086/teamworks/webservices/OPPOD/WFMCoordinationEventService.tws"
	version="1.0">	
	<xsl:strip-space elements="*"/>	
	<xsl:output method="text" version="string" encoding="string" omit-xml-declaration="yes" standalone="no" indent="no"	media-type="string" cdata-section-elements="*"/>	
	<xsl:template match="/tws:*">event:<xsl:value-of select="local-name(.)"/>,<xsl:apply-templates/></xsl:template>		
	<xsl:template match="/tws:*/tws:*"><xsl:value-of select="local-name(.)"/>:<xsl:value-of select="."/>,</xsl:template>
	<xsl:template match="/tws:*/tws:timestamp">timestamp:<xsl:value-of select="concat(concat(substring(.,1,10), '/'), translate(substring(., 12, 8), ':', '-'))"/></xsl:template>
</xsl:stylesheet>
