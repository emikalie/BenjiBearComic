<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:output method="html" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" 
        indent="yes" encoding="UTF-8" />
    
    <!-- Include CSS for styling, input later-->
    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title>Benjie Bear Comic</title>
                <link rel="stylesheet" href="styles.css" type="text/css" />
            </head>
            <body>
                <h1>Benjie Bear Comic Story</h1>
                <div class="page-container">
                    <xsl:apply-templates select="xml/page"/>
                </div>
            </body>
        </html>
    </xsl:template>
    
    <!-- Template to handle each page -->
    <xsl:template match="page">
        <div class="page" id="page-{@number}">
            <h2>Page <xsl:value-of select="@number" /></h2>
            <div class="panels">
                <xsl:apply-templates select="panel"/>
            </div>
        </div>
    </xsl:template>
    
    <!-- Template to handle each panel -->
    <xsl:template match="panel">
        <div class="panel panel-{@shape}" id="panel-{@order}">
            <h3>Panel <xsl:value-of select="@order" /></h3>
            <xsl:apply-templates select="character|scene"/>
        </div>
    </xsl:template>
    
    <!-- Template to handle character elements -->
    <xsl:template match="character">
        <div class="character">
            <strong>Character: </strong><xsl:value-of select="@name"/> (<xsl:value-of select="@action" />)
            <xsl:if test="dialogue">
                <div class="dialogue">
                    <strong>Dialogue:</strong> 
                    <xsl:value-of select="dialogue"/>
                    <span class="how">(<xsl:value-of select="dialogue/@how" />)</span>
                </div>
            </xsl:if>
        </div>
    </xsl:template>
    
    <!-- Template to handle scene elements -->
    <xsl:template match="scene">
        <div class="scene">
            <strong>Scene Description:</strong> <xsl:value-of select="@description"/>
        </div>
    </xsl:template>
</xsl:stylesheet>
