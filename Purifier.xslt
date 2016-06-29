<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:svg="http://www.w3.org/2000/svg" xmlns="http://www.w3.org/2000/svg">
<xsl:output method="xml" encoding="iso-8859-1" doctype-system="http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd" doctype-public="-//W3C//DTD SVG 1.1//EN" indent="yes"/>
<!-- Copy into heading of saved .svg image -->
<!-- <?xml version="1.0" encoding="UTF-8"?> required for IE -->
<!-- <?xml-stylesheet type="text/xsl" href="PostProcessing.xslt"?> -->
<!-- Identity template recursively copies nodes and their attributes -->
  <xsl:template match="@*|node()"> 
    <xsl:copy>	
     <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- Empty template does not copy script elements -->
  <xsl:template match="svg:script"/> 
</xsl:stylesheet> 