<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:pat="http://patientflowmonitoring/"	
	version="1.0">
	
	<xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
	<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
	
	<!-- Can't use the name directly because this format uses dynamic namespaces -->
	<xsl:template match="/*[local-name()='connector']/*[local-name()='connector-bundle']/*">
		<xsl:variable name="eventName" select="concat(translate(substring(name(.), 1, 1), $uppercase, $lowercase), substring(name(.), 2, string-length(name(.)) - string-length('object') - 1))"/>
		<xsl:element name="pat:{$eventName}">
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="/*[local-name()='connector']/*[local-name()='system']"></xsl:template>
	<xsl:template match="/*[local-name()='connector']/*[local-name()='timestamp']"></xsl:template>
	<xsl:template match="/*[local-name()='connector']/*[local-name()='loginfo']"></xsl:template>
	
	
	<xsl:template match="*[local-name()='Patient_ID']">
		<patientId><xsl:apply-templates/></patientId>
	</xsl:template>	
	<xsl:template match="*[local-name()='Provider_ID']">
		<providerId><xsl:apply-templates/></providerId>
	</xsl:template>	
	<xsl:template match="*[local-name()='Physician_ID']">
		<physicianId><xsl:apply-templates/></physicianId>
	</xsl:template>	
	<xsl:template match="*[local-name()='Room_ID']">
		<roomId><xsl:apply-templates/></roomId>
	</xsl:template>
	<xsl:template match="*[local-name()='Bed_ID']">
		<bedId><xsl:apply-templates/></bedId>
	</xsl:template>
	<xsl:template match="*[local-name()='Unit_ID']">
		<unitId><xsl:apply-templates/></unitId>
	</xsl:template>
	<xsl:template match="*[local-name()='Location_ID']">
		<locationId><xsl:apply-templates/></locationId>
	</xsl:template>
	<xsl:template match="*[local-name()='Order_ID']">
		<orderId><xsl:apply-templates/></orderId>
	</xsl:template>
	<xsl:template match="*[local-name()='Order_Type']">
		<orderType><xsl:apply-templates/></orderType>
	</xsl:template>
	<xsl:template match="*[local-name()='CTAS']">
		<ctas><xsl:apply-templates/></ctas>
	</xsl:template>
	<xsl:template match="/*[local-name()='connector']/*[local-name()='connector-bundle']/*/*[local-name()='timestamp']">
		<timestamp><xsl:apply-templates/></timestamp>
	</xsl:template>

</xsl:stylesheet>