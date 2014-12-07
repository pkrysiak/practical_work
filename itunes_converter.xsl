<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output encoding="UTF-8" method="xml" version="1.0"/>
    <xsl:template match="/">
        <iTunes>
            <Tracks>
                <xsl:for-each select="//key[text()='Tracks']/following-sibling::dict/dict">
                    <xsl:variable name="track_id" select="key[text()='Track ID']/following-sibling::integer[1]"/>
                    <xsl:variable name="title">
                        <xsl:choose>
                            <xsl:when test="key[text()='Name']">
                                <xsl:value-of select="key[text()='Name']/following-sibling::string[1]"/>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:variable name="artist">
                        <xsl:choose>
                            <xsl:when test="key[text()='Artist']">
                                <xsl:value-of select="key[text()='Artist']/following-sibling::string[1]"/>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:variable name="album">
                        <xsl:choose>
                            <xsl:when test="key[text()='Album']">
                                <xsl:value-of select="key[text()='Album']/following-sibling::string[1]"/>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:variable name="genre">
                        <xsl:choose>
                            <xsl:when test="key[text()='Genre']">
                                <xsl:value-of select="key[text()='Genre']/following-sibling::string[1]"/>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:variable name="year">
                        <xsl:choose>
                            <xsl:when test="key[text()='Year']">
                                <xsl:value-of select="key[text()='Year']/following-sibling::integer[1]"/>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:variable name="duration">
                        <xsl:choose>
                            <xsl:when test="key[text()='Total Time']">
                                <xsl:value-of select="key[text()='Total Time']/following-sibling::integer[1]"/>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:variable>
                    <Track id="{$track_id}" title="{$title}" artist="{$artist}">
                        <Album>
                            <xsl:value-of select="$album"/>
                        </Album>
                        <Genre>
                            <xsl:value-of select="$genre"/>
                        </Genre>
                        <Duration>
                            <xsl:value-of select="$duration"/>
                        </Duration>
                        <Year>
                            <xsl:value-of select="$year"/>
                        </Year>
                    </Track>
                </xsl:for-each>
            </Tracks>
            <Playlists>
                <xsl:for-each select="//key[text()='Playlists']/following-sibling::array/dict">
                    <xsl:variable name="playlist_id" select="key[text()='Playlist ID']/following-sibling::integer[1]"/>     
                    <Playlist id="{$playlist_id}">
                        <Pltracks>
                            <xsl:for-each select="array/dict">
                                <xsl:variable name="track" select="string"/>
                                <Pltrack id="{$track}"/>
                            </xsl:for-each>
                        </Pltracks>
                    </Playlist>
                </xsl:for-each>
            </Playlists>
        </iTunes>
    </xsl:template>
</xsl:stylesheet>