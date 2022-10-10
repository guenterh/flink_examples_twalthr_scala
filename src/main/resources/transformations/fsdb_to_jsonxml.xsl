<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="xs"
                version="2.0">

    <xsl:output indent="yes" />

    <xsl:variable name="sanitizeDate" select="'^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-3][0-9])$'"/>

    <xsl:template name="wochentag">
        <xsl:variable name="sende_datum" select="normalize-space(SEND-DAT)" />
        <xsl:if test="$sende_datum and matches($sende_datum, $sanitizeDate)">
            <xsl:value-of select="(days-from-duration(xs:date($sende_datum)-xs:date('1950-01-02')) mod 7) + 1" />
        </xsl:if>
    </xsl:template>

    <xsl:template name="jahrestag">
        <xsl:variable name="sende_datum" select="normalize-space(SEND-DAT)" />
        <xsl:if test="$sende_datum and matches($sende_datum, $sanitizeDate)">
            <xsl:value-of select="format-date(xs:date($sende_datum), '2020-[M,2]-[D,2]')" />
        </xsl:if>
    </xsl:template>

    <xsl:template name="dauer_s">
        <xsl:analyze-string regex="^P([0-9]+)M([0-9]+)S$" select="SEND-DAU">
            <xsl:matching-substring>
                <xsl:value-of select="number(regex-group(1)) * 60 + number(regex-group(2))" />
            </xsl:matching-substring>
        </xsl:analyze-string>
    </xsl:template>

    <xsl:template name="endzeit">
        <xsl:variable name="start_datum" select="normalize-space(SEND-DAT)" />
        <xsl:variable name="start_zeit" select="normalize-space(SENDEZEIT)" />
        <xsl:variable name="dauer" select="normalize-space(SEND-DAU)" />
        <xsl:if test="$start_datum and $start_zeit and $dauer">
            <xsl:variable name="end_datum_zeit" select="dateTime(xs:date($start_datum), xs:time($start_zeit)) + xs:dayTimeDuration(concat('PT', substring($dauer, 2)))" />
            <json name="end_datum" type="string"><xsl:value-of select="format-date(xs:date($end_datum_zeit), '[Y,4]-[M,2]-[D,2]')" /></json>
            <json name="end_zeit" type="string"><xsl:value-of select="format-time(xs:time($end_datum_zeit), '[H,2]:[m,2]:[s,2]')" /></json>
        </xsl:if>
    </xsl:template>

    <xsl:template name="erstausstrahlung">
        <xsl:for-each select="AUSTRAHLUNGS/AUSTRAHLUNG">
            <xsl:sort select="SEND-DAT" />
            <xsl:if test="position() eq 1">
                <xsl:variable name="sende_datum" select="normalize-space(SEND-DAT)" />
                <json name="datum" type="string"><xsl:if test="matches($sende_datum, $sanitizeDate)"><xsl:value-of select="$sende_datum" /></xsl:if></json>
                <json name="zeit" type="string"><xsl:value-of select="normalize-space(SENDEZEIT)" /></json>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="datenqualitaet">
        <xsl:variable name="datum" select="min(AUSTRAHLUNGS/AUSTRAHLUNG/SEND-DAT/string(.))" />
        <xsl:choose>
            <xsl:when test="string-length($datum) eq 0">0</xsl:when>
            <xsl:when test="compare($datum,'1985') eq -1">1</xsl:when>
            <xsl:otherwise>2</xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="sendezeit">
        <xsl:variable name="sende_datum" select="normalize-space(SEND-DAT)" />
        <xsl:variable name="sende_datum_valid" select="matches($sende_datum, $sanitizeDate)" />
        <xsl:variable name="sende_zeit" select="normalize-space(SENDEZEIT)" />
        <xsl:variable name="title_date_time_pattern" select="concat('^.+ ', format-date(xs:date($sende_datum), '[D,2][[.]][M,2][[.]][Y,4]'), ' ([0-9]{1,2})[.]([0-9]{2})( |$)')" />

        <xsl:choose>
            <xsl:when test="$sende_datum_valid and not($sende_zeit)">
                <xsl:analyze-string select="normalize-space(../../SENDE-T)" regex="{$title_date_time_pattern}">
                    <xsl:matching-substring>
                        <xsl:if test="regex-group(1) and regex-group(2)">
                            <xsl:value-of select="concat(format-number(number(regex-group(1)) mod 24, '00'), ':', format-number(number(regex-group(2)), '00'), ':00')" />
                        </xsl:if>
                    </xsl:matching-substring>
                </xsl:analyze-string>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$sende_zeit" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="CHUNK">
        <xsl:variable name="start" select="normalize-space(START)" />
        <xsl:variable name="ende" select="normalize-space(END)" />
        <xsl:variable name="inhalt" select="normalize-space(CONTENT)" />
        <xsl:if test="(string-length($start) + string-length($ende) + string-length($inhalt)) gt 0">
            <json type="object">
                <json name="start" type="string"><xsl:value-of select="$start" /></json>
                <json name="ende" type="string"><xsl:value-of select="$ende" /></json>
                <json name="inhalt" type="string"><xsl:value-of select="replace($inhalt, '(^|[\W])ß', '$1')" /></json>
            </json>
        </xsl:if>
    </xsl:template>

    <xsl:template match="INHALT">
        <json type="object">
            <json name="id" type="string"><xsl:value-of select="LUID" /></json>
            <json name="einzel_titel" type="string"><xsl:value-of select="normalize-space(EINZEL-T)" /></json>
            <json name="unter_titel" type="string"><xsl:value-of select="normalize-space(UNTER-T)" /></json>
            <json name="sonstiger_titel" type="string"><xsl:value-of select="normalize-space(SONST-T)" /></json>
            <json name="sachinhalt" type="array"><xsl:apply-templates select="INHALT1" /></json>
            <json name="wortinhalt" type="array"><xsl:apply-templates select="WORTINH" /></json>
            <json name="bildinhalt" type="array"><xsl:apply-templates select="BILDINH" /></json>
            <json name="personen" type="array"><xsl:apply-templates select="UPMS|UPM-AUTS" /></json>
            <json name="personen_im_bild" type="array"><xsl:apply-templates select="*/CHUNK" mode="personen_im_bild" /></json>
        </json>
    </xsl:template>

    <xsl:template name="role">
        <!-- should use a shared imported template later on -->
        <xsl:variable name="function"><xsl:value-of select="normalize-space(U-FKT)" /></xsl:variable>
        <xsl:choose>
            <xsl:when test="matches($function, '^(BER|DIL|EXP|INT|KAB|MOD|PRÄ|SHM|SSP)$')">cast</xsl:when>
            <xsl:when test="matches($function, '^(AUS|AUT|CUT|KAM|KMT|KOM|REA|RED|REG|SPR|TON|UEB)$')">crew</xsl:when>
            <xsl:when test="matches($function, '^(AST|HRK|HST|LST|RDN|)$')">department</xsl:when>
            <xsl:when test="matches($function, '^(CHO|ENS|MUS|ORC|PRO)$')">organisation</xsl:when>
            <xsl:otherwise>other</xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="UPM|UPM-AUT">
        <json type="object">
            <json name="ist_autor" type="boolean">
                <xsl:choose>
                    <xsl:when test="name() eq 'UPM-AUT'">true</xsl:when>
                    <xsl:otherwise>false</xsl:otherwise>
                </xsl:choose>
            </json>
            <json name="name" type="string"><xsl:value-of select="normalize-space(U-NAME)"/></json>
            <json name="funktion" type="string"><xsl:value-of select="normalize-space(U-FKT)"/></json>
            <json name="zusatz" type="string"><xsl:value-of select="normalize-space(U-ZUS)"/></json>
            <json name="rolle" type="string"><xsl:call-template name="role" /></json>
        </json>
    </xsl:template>

    <xsl:template match="CONTENT" mode="personen_im_bild">
        <xsl:analyze-string regex='(^|\W)ß(\w+)' select=".">
            <xsl:matching-substring>
                <xsl:if test="string-length(regex-group(2)) > 2">
                    <json type="object">
                        <json name="name" type="string"><xsl:value-of select="concat(upper-case(substring(regex-group(2), 1, 1)), lower-case(substring(regex-group(2), 2)))" /></json>
                    </json>
                </xsl:if>
            </xsl:matching-substring>
        </xsl:analyze-string>
    </xsl:template>

    <xsl:template match="DOKU">
        <json name="doku" type="boolean">
            <xsl:choose>
                <xsl:when test="empty(.)">false</xsl:when>
                <xsl:otherwise>true</xsl:otherwise>
            </xsl:choose>
        </json>
    </xsl:template>

    <xsl:template match="AUSTRAHLUNG">
        <json type="object">
            <xsl:variable name="sende_datum" select="normalize-space(SEND-DAT)" />
            <xsl:variable name="produktions_nr" select="normalize-space(PROD-NR/@KF)" />

            <xsl:apply-templates select="DOKU" />
            <json name="produktions_nr" type="number"><xsl:if test="$produktions_nr"><xsl:value-of select="number($produktions_nr)" /></xsl:if></json>
            <json name="produktions_nr_text" type="string"><xsl:value-of select="PROD-NR" /></json>
            <json name="sende_datum" type="string"><xsl:value-of select="$sende_datum" /></json>
            <json name="sende_zeit" type="string"><xsl:call-template name="sendezeit" /></json>
            <json name="dauer_s" type="number"><xsl:call-template name="dauer_s" /></json>
            <xsl:call-template name="endzeit" />
            <json name="programm_id" type="number"><xsl:value-of select="PRGM-KZ/@KEY" /></json>
            <json name="programm_code" type="string"><xsl:value-of select="normalize-space(PRGM-KZ-TEXT)" /></json>
            <json name="wochentag" type="number"><xsl:call-template name="wochentag" /></json>
            <json name="jahrestag" type="string"><xsl:call-template name="jahrestag" /></json>
        </json>
    </xsl:template>

    <xsl:template match="INHALT" mode="suggest">
        <xsl:variable name="einzel_titel" select="normalize-space(EINZEL-T)" />
        <xsl:variable name="unter_titel" select="normalize-space(UNTER-T)" />
        <xsl:variable name="sonstiger_titel" select="normalize-space(SONST-T)" />
        <xsl:if test="$einzel_titel"><json type="string"><xsl:value-of select="$einzel_titel" /></json></xsl:if>
        <xsl:if test="$unter_titel"><json type="string"><xsl:value-of select="$unter_titel" /></json></xsl:if>
        <xsl:if test="$sonstiger_titel"><json type="string"><xsl:value-of select="$sonstiger_titel" /></json></xsl:if>
        <xsl:apply-templates select="UPMS|UPM-AUTS" mode="suggest" />
    </xsl:template>

    <xsl:template match="UPM|UPM-AUTS" mode="suggest">
        <xsl:variable name="name" select="normalize-space(U-NAME)" />
        <xsl:if test="$name"><json type="string"><xsl:value-of select="$name" /></json></xsl:if>
    </xsl:template>

    <xsl:template match="FORMAL" mode="suggest">
        <xsl:variable name="serien_titel" select="normalize-space(SERIEN-T)" />

        <json name="input" type="array">
            <json type="string"><xsl:value-of select="normalize-space(SENDE-T)" /></json>
            <xsl:if test="string-length($serien_titel) gt 0"><json type="string"><xsl:value-of select="$serien_titel" /></json></xsl:if>
            <xsl:apply-templates select="INHALTS/INHALT" mode="suggest" />
            <xsl:apply-templates select="UPMS|UPM-AUTS" mode="suggest" />
        </json>
    </xsl:template>

    <xsl:template match="FSDB/FORMAL">
        <json name="sendung" type="object">
            <json name="id" type="string"><xsl:value-of select="LUID" /></json>
            <json name="sende_titel" type="string"><xsl:value-of select="normalize-space(SENDE-T)" /></json>
            <json name="serien_titel" type="string"><xsl:value-of select="normalize-space(SERIEN-T)" /></json>

            <json name="freigabe_fsk" type="string"><xsl:value-of select="normalize-space(JGD-FSK)" /></json>
            <json name="freigabe_zdf" type="number"><xsl:value-of select="normalize-space(JGD-ZDF)" /></json>

            <json name="erstausstrahlung" type="object"><xsl:call-template name="erstausstrahlung" /></json>
            <json name="datenqualitaet" type="number"><xsl:call-template name="datenqualitaet" /></json>

            <json name="ausstrahlungen" type="array"><xsl:apply-templates select="AUSTRAHLUNGS" /></json>
            <json name="inhalt" type="array"><xsl:apply-templates select="INHALTS" /></json>
            <json name="personen_sendung" type="array"><xsl:apply-templates select="UPMS|UPM-AUTS" /></json>

            <json name="personen" type="array"><xsl:apply-templates select="UPMS|UPM-AUTS|INHALTS/INHALT/UPMS|INHALTS/INHALT/UPM-AUTS" /></json>

            <json name="suggest" type="object"><xsl:apply-templates select="." mode="suggest" /></json>
        </json>
    </xsl:template>
</xsl:stylesheet>
