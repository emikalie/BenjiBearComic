<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" encoding="UTF-8" indent="yes" />

    <!-- Template match for root element -->
    <xsl:template match="/xml">
        <html>
            <head>
                <title>Benji Comic</title>
                <style>
                    body { font-family: Arial, sans-serif; margin: 20px; }
                    h1 { color: #4CAF50; }
                    table { border-collapse: collapse; width: 100%; margin-bottom: 20px; }
                    th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
                    th { background-color: #f2f2f2; }
                    ul { list-style-type: disc; margin-left: 20px; }
                </style>
            </head>
            <body>
                <h1>Comic Book Analysis</h1>
                
                <!-- List of Characters -->
                <h2>List of Characters</h2>
                <ul>
                    <xsl:for-each select="//character">
                        <xsl:if test="not(preceding::character[@name = current()/@name])">
                            <li><xsl:value-of select="@name" /></li>
                        </xsl:if>
                    </xsl:for-each>
                </ul>

                <!-- Table of Dialogue Frequency -->
                <h2>Dialogue Frequency by Character</h2>
                <table>
                    <tr>
                        <th>Character</th>
                        <th>Dialogue Count</th>
                    </tr>
                    <xsl:for-each select="//character[dialogue]">
                        <xsl:if test="not(preceding::character[@name = current()/@name])">
                            <tr>
                                <td><xsl:value-of select="@name" /></td>
                                <td>
                                    <xsl:value-of select="count(//character[@name = current()/@name]/dialogue)" />
                                </td>
                            </tr>
                        </xsl:if>
                    </xsl:for-each>
                </table>

                <!-- Table of Panel Shapes -->
                <h2>Panel Shapes and Counts</h2>
                <table>
                    <tr>
                        <th>Panel Shape</th>
                        <th>Count</th>
                    </tr>
                    <xsl:for-each select="//panel">
                        <xsl:if test="not(preceding::panel[@shape = current()/@shape])">
                            <tr>
                                <td><xsl:value-of select="@shape" /></td>
                                <td>
                                    <xsl:value-of select="count(//panel[@shape = current()/@shape])" />
                                </td>
                            </tr>
                        </xsl:if>
                    </xsl:for-each>
                </table>

                <!-- Table of Locations -->
                <h2>Scene Descriptions</h2>
                <table>
                    <tr>
                        <th>Page</th>
                        <th>Panel Order</th>
                        <th>Description</th>
                    </tr>
                    <xsl:for-each select="//scene">
                        <tr>
                            <td><xsl:value-of select="ancestor::page/@number" /></td>
                            <td><xsl:value-of select="ancestor::panel/@order" /></td>
                            <td><xsl:value-of select="@description" /></td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
