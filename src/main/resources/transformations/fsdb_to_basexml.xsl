<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs xd" version="2.0">
    <xsl:output method="xml"/>

    <xsl:template match="/">
        <xsl:apply-templates select="@* | node()"/>
    </xsl:template>

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="FSDB">
        <fsdb>
            <xsl:apply-templates/>
        </fsdb>
    </xsl:template>

    <xsl:template match="FORMAL">
        <formal>
            <xsl:apply-templates/>
        </formal>
    </xsl:template>

    <xsl:template match="PROD-NR-IN">
        <prod_nr_in>
            <xsl:apply-templates select="normalize-space(.)"/>
        </prod_nr_in>
    </xsl:template>

    <xsl:template match="LUID-IN">
        <luid_in>
            <xsl:apply-templates select="normalize-space(.)"/>
        </luid_in>
    </xsl:template>

    <xsl:template match="LUID">
        <luid>
            <xsl:apply-templates select="normalize-space(.)"/>
        </luid>
    </xsl:template>

    <xsl:template match="SENDE-T">
        <show_title>
            <xsl:apply-templates select="normalize-space(.)"/>
        </show_title>
    </xsl:template>

    <xsl:template match="SERIEN-T">
        <series_title>
            <xsl:apply-templates select="normalize-space(.)"/>
        </series_title>
    </xsl:template>

    <xsl:template match="UPMS">
        <upms>
            <xsl:apply-templates/>
        </upms>
    </xsl:template>

    <xsl:template match="JGD-FSK">
        <rating_fsk>
            <xsl:apply-templates select="normalize-space(.)"/>
        </rating_fsk>
    </xsl:template>

    <xsl:template match="JGD-FSK-TXT">
        <rating_fsk_txt>
            <xsl:apply-templates select="normalize-space(.)"/>
        </rating_fsk_txt>
    </xsl:template>

    <xsl:template match="JGD-ZDF">
        <rating_zdf>
            <xsl:apply-templates select="normalize-space(.)"/>
        </rating_zdf>
    </xsl:template>

    <xsl:template match="JGD-ZDF-TXT">
        <rating_zdf_txt>
            <xsl:apply-templates select="normalize-space(.)"/>
        </rating_zdf_txt>
    </xsl:template>

    <xsl:template match="AUSTRAHLUNGS">
        <broadcast_history>
            <xsl:apply-templates/>
        </broadcast_history>
    </xsl:template>

    <xsl:template match="AUSTRAHLUNG">
        <broadcast>
            <xsl:apply-templates/>
        </broadcast>
    </xsl:template>

    <xsl:template match="DOKU">
        <first_broadcast>
            <xsl:apply-templates select="normalize-space(.)"/>
        </first_broadcast>
    </xsl:template>

    <xsl:template match="PROD-NR">
        <prod_nr_kf>
            <xsl:value-of select="normalize-space(@KF)"/>
        </prod_nr_kf>
        <prod_nr>
            <xsl:apply-templates select="normalize-space(.)"/>
        </prod_nr>
    </xsl:template>

    <xsl:template match="PROD-NR1">
        <prod_nr1>
            <xsl:apply-templates select="normalize-space(.)"/>
        </prod_nr1>
    </xsl:template>

    <xsl:template match="SENDKDAT">
        <sendkdat>
            <xsl:value-of select="normalize-space(.)"/>
        </sendkdat>
    </xsl:template>

    <xsl:template match="SEND-DAT">
        <airdate>
            <xsl:value-of select="normalize-space(.)"/>
        </airdate>
    </xsl:template>

    <xsl:template match="SEND-DAU">
        <run_time>
            <xsl:value-of select="normalize-space(.)"/>
        </run_time>
    </xsl:template>

    <xsl:template match="SENDEZEIT">
        <airtime>
            <xsl:apply-templates select="normalize-space(.)"/>
        </airtime>
    </xsl:template>

    <xsl:template match="PRGM-KZ">
        <prgm_id_key>
            <xsl:value-of select="@KEY"/>
        </prgm_id_key>
        <prgm_id>
            <xsl:apply-templates select="normalize-space(.)"/>
        </prgm_id>
    </xsl:template>

    <xsl:template match="PRGM-KZ-TEXT">
        <prgm_id_text>
            <xsl:apply-templates select="normalize-space(.)"/>
        </prgm_id_text>
    </xsl:template>

    <xsl:template match="INHALTS">
        <inhalts>
            <xsl:apply-templates/>
        </inhalts>
    </xsl:template>

    <xsl:template match="INHALT">
        <inhalt>
            <xsl:apply-templates/>
        </inhalt>
    </xsl:template>

    <xsl:template match="EINZEL-T">
        <item_title>
            <xsl:apply-templates select="normalize-space(.)"/>
        </item_title>
    </xsl:template>

    <xsl:template match="UNTER-T">
        <subtitle>
            <xsl:apply-templates select="normalize-space(.)"/>
        </subtitle>
    </xsl:template>
    <!--sollten Untertitel im Sinne von Verschriftlichung von Sprache noch kommen, werden die als subtitles bezeichnet-->

    <xsl:template match="SONST-T">
        <add_title>
            <xsl:apply-templates select="normalize-space(.)"/>
        </add_title>
    </xsl:template>

    <xsl:template match="INHALT1">
        <inhalt1>
            <xsl:apply-templates/>
        </inhalt1>
    </xsl:template>

    <xsl:template match="CHUNK">
        <chunk>
            <xsl:apply-templates/>
        </chunk>
    </xsl:template>

    <xsl:template match="START">
        <start>
            <xsl:apply-templates select="normalize-space(.)"/>
        </start>
    </xsl:template>

    <xsl:template match="END">
        <end>
            <xsl:apply-templates select="normalize-space(.)"/>
        </end>
    </xsl:template>

    <xsl:template match="CONTENT">
        <content>
            <xsl:apply-templates select="normalize-space(.)"/>
        </content>
    </xsl:template>

    <xsl:template match="BILDINH">
        <img_content>
            <xsl:apply-templates/>
        </img_content>
    </xsl:template>

    <xsl:template match="WORTINH">
        <wortinh>
            <xsl:apply-templates/>
        </wortinh>
    </xsl:template>

    <xsl:template match="UPM-AUTS">
        <upm_auts>
            <xsl:apply-templates/>
        </upm_auts>
    </xsl:template>

    <xsl:template match="UPM-AUT">
        <upm_aut>
            <xsl:apply-templates/>
        </upm_aut>
    </xsl:template>

    <xsl:template match="UPM">
        <upm>
            <xsl:apply-templates/>
        </upm>
    </xsl:template>

    <xsl:template match="U-FKT">
        <xsl:choose>
            <xsl:when test="matches(@TXT,'^(RDN|Redaktion)$')">
                <department_txt>
                    <xsl:value-of select="normalize-space(@TXT)"/>
                </department_txt>
                <department>
                    <xsl:apply-templates select="normalize-space(.)"/>
                </department>
            </xsl:when>

            <xsl:when test="matches(@TXT,'^(Produktion)$')">
                <organisation_txt>
                    <xsl:value-of select="normalize-space(@TXT)"/>
                </organisation_txt>
                <organisation>
                    <xsl:apply-templates select="normalize-space(.)"/>
                </organisation>
            </xsl:when>
            <xsl:when
                test="matches(@TXT,'^(EXP|Experte|Kaberettist|MOD|Moderator|Schauspieler)$')">
                <castrole_txt>
                    <xsl:value-of select="normalize-space(@TXT)"/>
                </castrole_txt>
                <castrole>
                    <xsl:apply-templates select="normalize-space(.)"/>
                </castrole>
            </xsl:when>
            <xsl:when
                test="matches(@TXT,'^(Ausstattung|AUT|Autor|Schnitt, Cutter|Kamera|Komponist|RED|Redakteur|REG|Regie)$')">
                <crewrole_txt>
                    <xsl:value-of select="normalize-space(@TXT)"/>
                </crewrole_txt>
                <crewrole>
                    <xsl:apply-templates select="normalize-space(.)"/>
                </crewrole>
            </xsl:when>
            <xsl:otherwise>
                <role_txt>
                    <xsl:value-of select="normalize-space(@TXT)"/>
                </role_txt>
                <role>
                    <xsl:apply-templates select="normalize-space(.)"/>
                </role>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="U-NAME">
        <full_name>
            <xsl:apply-templates select="normalize-space(.)"/>
        </full_name>
        <!--Felder Einfügen für Vor- und Nachnamen-->
        <xsl:element name="first_name"/>
        <xsl:element name="last_name"/>
    </xsl:template>


    <xsl:template match="U-ZUS">
        <u_zus>
            <xsl:apply-templates select="normalize-space(.)"/>
        </u_zus>
    </xsl:template>

    <xsl:template match="INDEX-P">
        <index_p>
            <xsl:apply-templates select="normalize-space(.)"/>
        </index_p>
    </xsl:template>

</xsl:stylesheet>
