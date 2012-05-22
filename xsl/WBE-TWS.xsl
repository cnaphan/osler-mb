<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:tws="http://WIN-687RHJV6VUL:19086/teamworks/webservices/OPPOD/WFMCoordinationEventService.tws"
	version="1.0">
	
	<!-- Can't use the name directly because this format uses dynamic namespaces -->
	<xsl:template match="/*[local-name()='connector']/*[local-name()='connector-bundle']/*">
		<xsl:variable name="eventName" select="substring(local-name(.), 1, string-length(local-name(.)) - string-length('object'))"/>
		<xsl:element name="tws:{$eventName}">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="/*[local-name()='connector']/*[local-name()='system']"></xsl:template>
	<xsl:template match="/*[local-name()='connector']/*[local-name()='timestamp']"></xsl:template>
	<xsl:template match="/*[local-name()='connector']/*[local-name()='loginfo']"></xsl:template>
	
	
	<xsl:template match="/*[local-name()='connector']/*[local-name()='connector-bundle']/*/*">
		<xsl:element name="tws:{local-name(.)}"><xsl:apply-templates/></xsl:element>
	</xsl:template>	

	<xsl:template match="/*[local-name()='connector']/*[local-name()='connector-bundle']/*/*[local-name()='timestamp']">
		<tws:timestamp><xsl:value-of select="substring(., 1, 19)"/></tws:timestamp>
	</xsl:template>

</xsl:stylesheet>
