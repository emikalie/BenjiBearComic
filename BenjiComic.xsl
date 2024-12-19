<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <xsl:key name="charactersByName" match="character" use="@name"/>
    <xsl:variable name="charNames"
        select="//character/@name ! normalize-space() => distinct-values()"/>

    <!-- Template match for root element -->
    <xsl:template match="/xml">
        <xsl:variable name="document" select="current()" as="element()"/>
        <html>
            <head>
                <title>Benji Comic</title>
                <link rel="stylesheet" href="basepage.css"/>
                <!--<style>
                    body { font-family: Arial, sans-serif; margin: 20px; }
                    h1 { color: #4CAF50; }
                    table { border-collapse: collapse; width: 100%; margin-bottom: 20px; }
                    th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
                    th { background-color: #f2f2f2; }
                    ul { list-style-type: disc; margin-left: 20px; }
                </style>-->
            </head>
            <body>
                <!--Nav Bar-->
                <nav>
                    <ul>
                        <li>
                            <a href="index.html">Home</a>
                        </li>
                        <li>
                            <a href="comic.html">Comic Info</a>
                        </li>
                        <li>
                            <a href="Comic_pages.html">Comic Read View</a>
                        </li>
                    </ul>
                </nav>
                <!--Comic Info-->
                <div class="container">
                    <section id="project">
                        <header>
                            <h2>Our Selected Comic</h2>
                            <p>Discover the story and context of our selected comic book. Using
                                CBML, we aim to preserve and analyze its narrative structure,
                                artwork, and historical significance.</p>
                        </header>

                        <article>
                            <h3>Comic Book Details</h3>
                            <ul>
                                <li>
                                    <strong>Title:</strong>
                                    <em>Giggle Comics: Benjie Bear</em>
                                </li>
                                <li><strong>Publication Date:</strong> October 1943</li>
                                <li><strong>Publisher:</strong> Creston Publications Corp.</li>
                                <li><strong>Description:</strong> Giggle Comics was an American
                                    anthology comic that came out in October of 1943 towards the end
                                    of WWII. The comic features a variety of strip comics featuring
                                    animals in all sorts of perculiar situations. For this specific
                                    project we focused on the very first issue of the comic, and the
                                    first strip comic, Benjie Bear. Benjie Bear is about a bear cub
                                    that ventures into a far for fresh eggs. Throughout his 8 page
                                    aventure he gets to taste a variaty of treats.</li>
                            </ul>
                        </article>
                        <footer>
                            <p>Visit our personal websites:</p>
                            <ul>
                                <li>
                                    <a href="https://gabvoz13.github.io/Digit100/">Gabriella's
                                        Website</a>
                                </li>
                                <li>
                                    <a href="https://sites.psu.edu/digit100homesite/">Emily Kalie's
                                        Website</a>
                                </li>
                            </ul>
                        </footer>
                    </section>
                </div>

                <h1>Comic Book Analysis</h1>



                <!-- List of Characters -->
                <h2>List of Characters</h2>
                <ul>
                    <!-- Deduplicate characters using the key -->
                    <xsl:for-each select="$charNames">
                        <li>
                            <xsl:value-of select="current()"/>
                        </li>
                    </xsl:for-each>
                </ul>



                <!-- Table of Dialogue Frequency -->
                <h2>Dialogue Frequency by Character</h2>
                <table>
                    <tr>
                        <th>Character</th>
                        <th>Dialogue Count</th>
                    </tr>


                    <xsl:for-each select="$charNames">
                        <xsl:sort
                            select="count($document//panel[character/name = current()]/dialogue)"/>
                        <tr>
                            <td>
                                <xsl:value-of select="current()"/>
                            </td>
                            <td>
                                <xsl:value-of
                                    select="count($document//panel[character/@name ! normalize-space() = current()]//dialogue)"
                                />
                            </td>
                        </tr>
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
                                <td>
                                    <xsl:value-of select="@shape"/>
                                </td>
                                <td>
                                    <xsl:value-of select="count(//panel[@shape = current()/@shape])"
                                    />
                                </td>
                            </tr>
                        </xsl:if>
                    </xsl:for-each>
                </table>

                <!-- Table of Locations for 5 Pages -->
                <xsl:for-each select="page">
                    <div class="comic-layout">
                        <!-- Comic Page Section -->
                        <div class="comic-page">
                            <img>
                                <xsl:attribute name="src">
                                    <xsl:text>images/Comic_pages/BB</xsl:text>
                                    <xsl:value-of select="@number"/>
                                    <xsl:text>.jpg</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="alt">
                                    <xsl:text>Comic Page BB</xsl:text>
                                    <xsl:value-of select="@number"/>
                                </xsl:attribute>
                            </img>
                        </div>

                        <!-- Comic Info Section -->
                        <div class="comic-info">
                            <h3>Page <xsl:value-of select="@number"/></h3>
                            <table>
                                <tr>
                                    <th>Panel</th>
                                    <th>Description</th>
                                </tr>
                                <xsl:for-each select="panel">
                                    <tr>
                                        <td>
                                            <xsl:value-of select="@order"/>
                                        </td>
                                        <td>
                                            <xsl:value-of select="scene/@description"/>
                                        </td>
                                    </tr>
                                </xsl:for-each>
                            </table>
                        </div>
                    </div>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
