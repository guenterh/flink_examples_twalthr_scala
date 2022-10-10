<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:ebu="http://www.ebu.ch/metadata/ontologies/ebucore/ebucore#"
    xmlns:fims="http://baseTime.fims.tv#"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#" exclude-result-prefixes="xs" version="2.0">
    
    <xsl:output indent="yes" />
    
    <xsl:template match="broadcast">
        <ebu:hasPublicationEvent>
            <ebu:PublicationEvent>
                <ebu:eventStartDate rdf:datatype="xsd:date">
                    <xsl:value-of select="airdate"/>
                </ebu:eventStartDate>
                <ebu:firstShowing rdf:datatype="xsd:boolean">
                    <xsl:value-of select="first_broadcast = 'X'"/>
                </ebu:firstShowing>
                <xsl:if test="airtime">
                    <ebu:eventStartTime rdf:datatype="xsd:time">
                        <xsl:value-of select="airtime"/>
                    </ebu:eventStartTime>
                </xsl:if>
                <xsl:if test="run_time">
                    <ebu:eventDuration rdf:datatype="xsd:duration">
                        <xsl:value-of select="run_time"/>
                    </ebu:eventDuration>
                </xsl:if>

                <ebu:isReleasedBy>
                    <ebu:PublicationChannel>
                        <ebu:publicationChannelName>
                            <xsl:value-of select="prgm_id_text"/>
                        </ebu:publicationChannelName>
                        <ebu:publicationChannelId>
                            <xsl:choose>
                                <xsl:when test="prgm_id_key eq '60'">VP</xsl:when>
                                <xsl:when test="prgm_id_key eq '61'"><xsl:attribute name="rdf:resource">https://www.wikidata.org/wiki/Q48989</xsl:attribute></xsl:when>
                                <xsl:when test="prgm_id_key eq '62'">3sat-M</xsl:when>
                                <xsl:when test="prgm_id_key eq '63'"><xsl:attribute name="rdf:resource">https://www.wikidata.org/wiki/Q229805</xsl:attribute></xsl:when>
                                <xsl:when test="prgm_id_key eq '64'"><xsl:attribute name="rdf:resource">https://www.wikidata.org/wiki/Q8073</xsl:attribute></xsl:when>
                                <xsl:when test="prgm_id_key eq '67'"><xsl:attribute name="rdf:resource">https://www.wikidata.org/wiki/Q49727</xsl:attribute></xsl:when>
                                <xsl:when test="prgm_id_key eq '68'"><xsl:attribute name="rdf:resource">https://www.wikidata.org/wiki/Q262627</xsl:attribute></xsl:when>
                                <xsl:when test="prgm_id_key eq '70'"><xsl:attribute name="rdf:resource">https://www.wikidata.org/wiki/Q136009</xsl:attribute></xsl:when>
                                <xsl:when test="prgm_id_key eq '71'"><xsl:attribute name="rdf:resource">https://www.wikidata.org/wiki/Q136003</xsl:attribute></xsl:when>
                                <xsl:when test="prgm_id_key eq '75'"><xsl:attribute name="rdf:resource">https://www.wikidata.org/wiki/Q136012</xsl:attribute></xsl:when>
                                <xsl:otherwise><xsl:value-of select="prgm_id"/></xsl:otherwise>
                            </xsl:choose>
                        </ebu:publicationChannelId>
                    </ebu:PublicationChannel>
                </ebu:isReleasedBy>
            </ebu:PublicationEvent>
        </ebu:hasPublicationEvent>
    </xsl:template>
    
    <xsl:template match="broadcast_history">
        <ebu:PublicationHistory>
            <xsl:apply-templates select="broadcast" />
        </ebu:PublicationHistory>
    </xsl:template>
    
    <xsl:template match="rating_fsk">
        <xsl:if test=".">
            <ebu:hasRating>
                <rdf:Description>
                    <rdf:type rdf:resource="http://www.ebu.ch/metadata/ontologies/ebucore/ebucore#Rating"/>
                    <ebu:notRated rdf:datatype="xsd:boolean"><xsl:value-of select=". = '0000'"/></ebu:notRated>
                    <ebu:ratingId>
                        <xsl:choose>
                            <xsl:when test=". eq 'O.A.'"><xsl:attribute name="rdf:resource">https://www.wikidata.org/wiki/Q20644794</xsl:attribute></xsl:when>
                            <xsl:when test=". eq '06'"><xsl:attribute name="rdf:resource">https://www.wikidata.org/wiki/Q20644795</xsl:attribute></xsl:when>
                            <xsl:when test=". eq '06FF'"><xsl:attribute name="rdf:resource">https://www.wikidata.org/wiki/Q20644795</xsl:attribute></xsl:when>
                            <xsl:when test=". eq '12'"><xsl:attribute name="rdf:resource">https://www.wikidata.org/wiki/Q20644796</xsl:attribute></xsl:when>
                            <xsl:when test=". eq '12FF'"><xsl:attribute name="rdf:resource">https://www.wikidata.org/wiki/Q20644796</xsl:attribute></xsl:when>
                            <xsl:when test=". eq '12NF'"><xsl:attribute name="rdf:resource">https://www.wikidata.org/wiki/Q20644796</xsl:attribute></xsl:when>
                            <xsl:when test=". eq '16'"><xsl:attribute name="rdf:resource">https://www.wikidata.org/wiki/Q20644797</xsl:attribute></xsl:when>
                            <xsl:when test=". eq '18'"><xsl:attribute name="rdf:resource">https://www.wikidata.org/wiki/Q20644798</xsl:attribute></xsl:when>
                            <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
                        </xsl:choose>
                    </ebu:ratingId>
                    <ebu:ratingDescription>
                        <xsl:value-of select="../rating_fsk_txt"/>
                    </ebu:ratingDescription>
                    <ebu:hasRatingSource rdf:resource="https://www.wikidata.org/wiki/Q329126"/>
                </rdf:Description>
            </ebu:hasRating>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="rating_zdf">
        <xsl:if test=".">
            <ebu:hasRating>
                <rdf:Description>
                    <rdf:type rdf:resource="http://www.ebu.ch/metadata/ontologies/ebucore/ebucore#Rating"/>
                    <ebu:ratingName>
                        <xsl:value-of select="."/>
                    </ebu:ratingName>
                    <ebu:ratingDescription><xsl:value-of select="../rating_zdf_txt"/></ebu:ratingDescription>
                    <ebu:hasRatingSource rdf:resource="https://www.wikidata.org/wiki/Q48989"/>
                </rdf:Description>
            </ebu:hasRating>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="upm">
        <ebu:hasParticipatingAgent>
            <rdf:Description>
                <xsl:choose>
                    <xsl:when test="castrole_txt != 'Schauspieler'">
                        <rdf:type rdf:resource="http://www.ebu.ch/metadata/ontologies/ebucore/ebucore#Agent"/>
                        <ebu:hasCastRole><xsl:value-of select="castrole"/></ebu:hasCastRole>
                        <xsl:if test="string-length(full_name) > 0"><ebu:personName><xsl:value-of select="full_name"/></ebu:personName></xsl:if>
                        <xsl:if test="string-length(first_name) > 0"><ebu:givenName><xsl:value-of select="first_name"/></ebu:givenName></xsl:if>
                        <xsl:if test="string-length(last_name) > 0"><ebu:familyName><xsl:value-of select="last_name"/></ebu:familyName></xsl:if>
                        <xsl:if test="string-length(u_zus) > 0"><ebu:agentDescription><xsl:value-of select="u_zus"/></ebu:agentDescription></xsl:if>
                    </xsl:when>
                    <xsl:when test="castrole_txt = 'Schauspieler'">
                        <rdf:type rdf:resource="http://www.ebu.ch/metadata/ontologies/ebucore/ebucore#Agent"/>
                        <ebu:hasCastRole><xsl:value-of select="castrole"/></ebu:hasCastRole>
                        <xsl:if test="string-length(full_name) > 0"><ebu:personName><xsl:value-of select="full_name"/></ebu:personName></xsl:if>
                        <xsl:if test="string-length(first_name) > 0"><ebu:givenName><xsl:value-of select="first_name"/></ebu:givenName></xsl:if>
                        <xsl:if test="string-length(last_name) > 0"><ebu:familyName><xsl:value-of select="last_name"/></ebu:familyName></xsl:if>
                        <xsl:if test="string-length(u_zus) > 0"><ebu:characterName><xsl:value-of select="u_zus"/></ebu:characterName></xsl:if>
                    </xsl:when>
                    <xsl:when test="crewrole">
                        <rdf:type rdf:resource="http://www.ebu.ch/metadata/ontologies/ebucore/ebucore#Agent"/>
                        <ebu:hasCrewRole><xsl:value-of select="crewrole"/></ebu:hasCrewRole>
                        <xsl:if test="string-length(full_name) > 0"><ebu:personName><xsl:value-of select="full_name"/></ebu:personName></xsl:if>
                        <xsl:if test="string-length(first_name) > 0"><ebu:givenName><xsl:value-of select="first_name"/></ebu:givenName></xsl:if>
                        <xsl:if test="string-length(last_name) > 0"><ebu:familyName><xsl:value-of select="last_name"/></ebu:familyName></xsl:if>
                        <xsl:if test="string-length(u_zus) > 0"><ebu:agentDescription><xsl:value-of select="u_zus"/></ebu:agentDescription></xsl:if>
                    </xsl:when>
                    <xsl:when test="department">
                        <rdf:type rdf:resource="http://www.ebu.ch/metadata/ontologies/ebucore/ebucore#Department"/>
                        <ebu:organisationId><xsl:value-of select="department"/></ebu:organisationId>
                        <ebu:organisationName><xsl:value-of select="full_name"/></ebu:organisationName>
                        <xsl:if test="string-length(u_zus) > 0"><ebu:organisationDescription><xsl:value-of select="u_zus"/></ebu:organisationDescription></xsl:if>
                    </xsl:when>
                    <xsl:when test="organisation">
                        <rdf:type rdf:resource="http://www.ebu.ch/metadata/ontologies/ebucore/ebucore#Organisation"/>
                        <ebu:organisationId><xsl:value-of select="organisation"/></ebu:organisationId>
                        <ebu:organisationName><xsl:value-of select="full_name"/></ebu:organisationName>
                        <xsl:if test="string-length(u_zus) > 0"><ebu:organisationDescription><xsl:value-of select="u_zus"/></ebu:organisationDescription></xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <ebu:hasRole><xsl:value-of select="role"/></ebu:hasRole>
                        <rdf:type rdf:resource="http://www.ebu.ch/metadata/ontologies/ebucore/ebucore#Agent"/>
                        <xsl:if test="string-length(full_name) > 0"><ebu:personName><xsl:value-of select="full_name"/></ebu:personName></xsl:if>
                        <xsl:if test="string-length(first_name) > 0"><ebu:givenName><xsl:value-of select="first_name"/></ebu:givenName></xsl:if>
                        <xsl:if test="string-length(last_name) > 0"><ebu:familyName><xsl:value-of select="last_name"/></ebu:familyName></xsl:if>
                        <xsl:if test="string-length(u_zus) > 0"><ebu:agentDescription><xsl:value-of select="u_zus"/></ebu:agentDescription></xsl:if>
                    </xsl:otherwise>
                </xsl:choose>
            </rdf:Description>
        </ebu:hasParticipatingAgent>
    </xsl:template>
    
    <xsl:template match="upm_aut">
        <xsl:if test="string-length(upm_auts/ump_aut/full_name) gt 0">
            <ebu:hasParticipatingAgent><rdf:type rdf:resource="http://www.ebu.ch/metadata/ontologies/ebucore/ebucore#Agent"/>
                <ebu:personName><xsl:value-of select="ump_auts/upm_aut/full_name"/></ebu:personName>
                <xsl:if test="ump_auts/upm_aut/role[@txt = 'Autor']">
                    <ebu:hasCrewRole><xsl:value-of select="upm_auts/upm_aut/role"/></ebu:hasCrewRole>
                </xsl:if>
            </ebu:hasParticipatingAgent>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="inhalt">
        <xsl:if test="string-length(item_title)">
            <ebu:hasRelatedEditorialObject>
                <rdf:Description>
                    <rdf:type rdf:resource="http://www.ebu.ch/metadata/ontologies/ebucore/ebucore#Item"/>
                    <ebu:editorialObjectName><xsl:value-of select="item_title"/></ebu:editorialObjectName>
                    <xsl:if test="string-length(add_title) gt 0">
                        <ebu:secondaryTitle><xsl:value-of select="add_title"/></ebu:secondaryTitle>
                    </xsl:if>
                    <xsl:if test="string-length(subtitle) gt 0">
                        <ebu:subtitle><xsl:value-of select="subtitle"/></ebu:subtitle>
                    </xsl:if>
                    <xsl:apply-templates select="UPM-AUTS"/>
                    <ebu:editorialObjectDescription>
                        <xsl:value-of select="inhalt1/chunk/content"/>
                    </ebu:editorialObjectDescription>
                    
                    <xsl:variable name="starttime"><xsl:value-of select="inhalt1/chunk/start"/></xsl:variable>
                    <xsl:if test="string-length($starttime) gt 0">
                        <ebu:startTimecode rdf:datatype="fims:Timecode"><xsl:value-of select="normalize-space($starttime)"/></ebu:startTimecode>
                    </xsl:if>
                    <xsl:variable name="endtime"><xsl:value-of select="inhalt1/chunk/end"/></xsl:variable>
                    <xsl:if test="string-length($endtime) gt 0">
                        <ebu:endTimecode rdf:datatype="fims:Timecode"><xsl:value-of select="normalize-space($endtime)"/></ebu:endTimecode>
                    </xsl:if>
                </rdf:Description>
            </ebu:hasRelatedEditorialObject>
        </xsl:if>
    </xsl:template>

    <xsl:template match="fsdb/formal">
        <rdf:Description rdf:about="http://ub.uni-leipzig-de/ontologies/zdf/{luid}">
            <rdf:type rdf:resource="http://www.ebu.ch/metadata/ontologies/ebucore/ebucore#TVProgramme"/>
            <rdfs:subClassOf><rdf:Description><rdf:type rdf:resource="http://www.ebu.ch/metadata/ontologies/ebucore/ebucore#EditorialObject"/></rdf:Description></rdfs:subClassOf>
            <ebu:mainTitle>
                <xsl:value-of select="show_title"/>
            </ebu:mainTitle>

            <!--            Unterscheidung zwischen Episode und Film hier noch wichtig zu ergänzen -->
            <xsl:if test="string-length(series_title) gt 0">
                <ebu:isMemberOf>
                    <rdf:Description>
                        <rdf:type rdf:resource="http://www.ebu.ch/metadata/ontologies/ebucore/ebucore#Series"/>
                        <ebu:groupName><xsl:value-of select="series_title"/></ebu:groupName>
                    </rdf:Description>
                </ebu:isMemberOf>
            </xsl:if>
            
            <xsl:if test="string-length(string-join(inhalts/inhalt/item_title, '')) eq 0">
                <xsl:if test="string-length(string-join(inhalts/inhalt/add_title, '')) gt 0">
                    <ebu:secondaryTitle><xsl:value-of select="inhalts/inhalt/add_title"/></ebu:secondaryTitle>
                </xsl:if>
                <xsl:if test="string-length(string-join(inhalts/inhalt/subtitle, '')) gt 0">
                    <ebu:subtitle><xsl:value-of select="inhalts/inhalt/subtitle"/></ebu:subtitle>
                </xsl:if>
                <ebu:summary><xsl:value-of select="inhalts/inhalt/inhalt1/chunk/content"/></ebu:summary>
                <xsl:variable name="starttime"><xsl:value-of select="inhalts/inhalt/inhalt1/chunk/start"/></xsl:variable>
                <xsl:if test="string-length($starttime) gt 0">
                    <ebu:startTimecode rdf:datatype="fims:Timecode"><xsl:value-of select="normalize-space($starttime)"/></ebu:startTimecode>
                </xsl:if>
                <xsl:variable name="endtime"><xsl:value-of select="inhalts/inhalt/inhalt1/chunk/end"/></xsl:variable>
                <xsl:if test="string-length($endtime) gt 0">
                    <ebu:endTimecode rdf:datatype="fims:Timecode"><xsl:value-of select="normalize-space($endtime)"/></ebu:endTimecode>
                </xsl:if>
            </xsl:if>

            <ebu:hasPublicationHistory><xsl:apply-templates select="broadcast_history"/></ebu:hasPublicationHistory>
            <xsl:apply-templates select="rating_fsk"/>
            <xsl:apply-templates select="rating_zdf"/>
            <xsl:apply-templates select="inhalts/inhalt/upms"/>
            <xsl:apply-templates select="upms"/>
            <xsl:apply-templates select="inhalts"/>
        </rdf:Description>
    </xsl:template>
    
    <xsl:template match="/">
        <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
            xmlns:ebu="http://www.ebu.ch/metadata/ontologies/ebucore/ebucore#">
            <xsl:apply-templates/>
        </rdf:RDF>
    </xsl:template>
</xsl:stylesheet>
