<?xml version="1.0" encoding="ISO-8859-1"?>

<!--

This stylesheet is created for the NC3 Technical Architecture, and is
intended for the tool package documentation.

Copyright (c) 2001,2002,2003 Jens Stavnstrup/DDRE <js@ddre.dk>

-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version='1.0'
                xmlns:stbl="http://nwalsh.com/xslt/ext/com.nwalsh.saxon.Table"
                xmlns="http://www.w3.org/TR/xhtml1/transitional"
                xmlns:saxon="http://icl.com/saxon"
                exclude-result-prefixes="#default stbl saxon">

<xsl:import href="../docbook-xsl/fo/docbook.xsl"/>
<!--
<xsl:import href="doc-layout.xsl"/>
-->
<xsl:import href="../common/common.xsl"/> 


<xsl:output method="xml" indent="no"/>


<!-- ToC/LoT/Index Generation -->

<xsl:param name="generate.toc">
book  toc,figure
</xsl:param>


<!-- Processor Extensions -->

<xsl:param name="fop1.extensions" select="1"/>


<!-- Extensions -->

<xsl:param name="linenumbering.everyNth" select="1"/>
<xsl:param name="linenumbering.extension" select="1"/>
<xsl:param name="tablecolumns.extension" select="1"/> 
<xsl:param name="use.extensions" select="1"/>

<xsl:param name="title.margin.left" select="'0pc'"/>

<!-- Automatic labelling -->

<xsl:param name="section.autolabel" select="1"/>
<xsl:param name="section.label.includes.component.label" select="1" />


<!-- XSLT processing -->

<!-- Meta Info -->
<xsl:param name="make.year.ranges" select="1"/>

<!-- Tables -->

<xsl:param name="default.table.width" select="'15cm'"/>


<!-- Miscellaneous -->

<xsl:param name="formal.title.placement">
  figure after
  table after
</xsl:param>

<xsl:param name="show.comments">0</xsl:param>
<xsl:param name="ulink.hyphenate" select="''"/>


<!-- FO -->

<xsl:param name="stylesheet.result.type" select="'fo'"/>

<!-- Pagination and General Styles -->

<xsl:param name="paper.type" select="'A4'"/>
<xsl:param name="double.sided" select="1"/>


<!-- The letter A-H refers to the figure describing page 
     setup in the file "docs/manual.pdf" -->


<xsl:param name="page.margin.top" select="'15mm'"/>  
<xsl:param name="region.before.extent" select="'42pt'"/>
<xsl:param name="body.margin.top" select="'56pt'"/>

<xsl:param name="region.after.extent" select="'48pt'"/>
<xsl:param name="page.margin.bottom" select="'14mm'"/>
<xsl:param name="body.margin.bottom" select="'57pt'"/>

<xsl:param name="page.margin.inner" select="'25mm'"/>
<xsl:param name="page.margin.outer" select="'25mm'"/>

<xsl:param name="body.font.master" select="11"/>



<!-- <xsl:param name="line-height" select="'2'"/> -->

<xsl:param name="draft.mode" select="'no'"/>
<xsl:param name="draft.watermark.image" select="''"/>

<!-- Font Families -->

<xsl:param name="body.font.family" select="'Times'"/>
<xsl:param name="title.font.family" select="'Times'"/>
<!--
<xsl:param name="dingbat.font.family" select="'ZapfDingbats'"/>
-->
<xsl:param name="dingbat.font.family" select="''"/>
<xsl:param name="monospace.font.family" select="'Courier'"/>
<xsl:param name="sans.font.family" select="'Helvetica'"/>


<xsl:param name="bibliography.numbered" select="0"/> 

<!-- -->

<xsl:variable name="toc.section.depth">2</xsl:variable>


<!-- Don't prefix Chapters or Appendixes, just plain title -->

<xsl:param name="local.l10n.xml" select="document('')"/>

<l:i18n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0">
  <l:l10n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0" 
          language="en">
    <l:context name="title-numbered">
      <l:template name="appendix" text="%n.&#160;%t"/>
      <l:template name="chapter" text="%n.&#160;%t"/>
    </l:context>
  </l:l10n>
</l:i18n>



<xsl:template match="programlisting|literallayout">
  <fo:block text-align="left">
    <xsl:apply-imports/>
  </fo:block>
</xsl:template>


<!-- ==================================================================== -->
<!--    Page setup                                                        -->
<!-- ==================================================================== -->

<!-- ....................................................................

     Source: fo/pagesetup.xsl, v 1.23 - DocBook XSL 1.54.1

     Descr.: We are only using two types of pages:
             titlepage and body. (and maybe lot)
-->

<xsl:template match="*" mode="XXrunning.head.mode">
  <xsl:param name="master-reference" select="'unknown'"/>
  <xsl:param name="gentext-key" select="name(.)"/>

  <!-- remove -draft from reference -->
  <xsl:variable name="page-class">
    <xsl:choose>
      <xsl:when test="contains($master-reference, '-draft')">
        <xsl:value-of select="substring-before($master-reference, '-draft')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$master-reference"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>


  <xsl:choose>
    <xsl:when test="starts-with($master-reference, 'titlepage')">
      <fo:static-content flow-name="xsl-region-before-first">
        <fo:block/>
      </fo:static-content>
    </xsl:when>
    <xsl:otherwise>
      <!-- Make first and odd identical, even and blank identical -->
      <fo:static-content flow-name="xsl-region-before-first">

        <fo:block/>
      </fo:static-content>
      <fo:static-content flow-name="xsl-region-before-odd">
        <fo:block/>
      </fo:static-content>
      <fo:static-content flow-name="xsl-region-before-even">
        <fo:block/>
      </fo:static-content>
      <fo:static-content flow-name="xsl-region-before-blank">
        <fo:block/>
      </fo:static-content>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<xsl:template match="*" mode="XXrunning.foot.mode">
  <xsl:param name="master-reference" select="'unknown'"/>
  <xsl:param name="gentext-key" select="'TableofContents'"/>
  

  <!-- remove -draft from reference -->
  <xsl:variable name="page-class">
    <xsl:choose>
      <xsl:when test="contains($master-reference, '-draft')">
        <xsl:value-of select="substring-before($master-reference, '-draft')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$master-reference"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="foot">
<!--
    <fo:block>NATO UNCLASSIFIED</fo:block>
-->
    <fo:block space-before="5pt">- <fo:page-number/> -</fo:block>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="starts-with($master-reference, 'titlepage')">
      <fo:static-content flow-name="xsl-region-after-first">
<!--
        <fo:block text-align="center">
          <fo:block>NATO UNCLASSIFIED</fo:block>
          <fo:block>RELEASABLE FOR INTERNET TRANSMISSION</fo:block>
        </fo:block>
-->
        <fo:block/>
      </fo:static-content>
    </xsl:when>
    <xsl:otherwise>
      <fo:static-content flow-name="xsl-region-after-first">
        <fo:block text-align="center" font-size="{$body.font.size}">
          <xsl:copy-of select="$foot"/>
        </fo:block>
      </fo:static-content>
      <fo:static-content flow-name="xsl-region-after-odd">
        <fo:block text-align="center" font-size="{$body.font.size}">
          <xsl:copy-of select="$foot"/>
        </fo:block>
      </fo:static-content>
      <fo:static-content flow-name="xsl-region-after-even">
        <fo:block text-align="center" font-size="{$body.font.size}">
          <xsl:copy-of select="$foot"/>
        </fo:block>
      </fo:static-content>
      <fo:static-content flow-name="xsl-region-after-blank">
        <fo:block text-align="center" font-size="{$body.font.size}">
          <xsl:copy-of select="$foot"/>
        </fo:block>
      </fo:static-content>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<!-- ....................................................................

     Source: fo/footnote.xsl, v 1.8 - DocBook XSL 1.54.1

     Descr.: Footnotes are created using baseline-shift="super". This doesn't 
     seems to work in FOP.
     So instead we embed footnotes in square brackets.
     .................................................................... -->

<!--
<xsl:template name="format.footnote.mark">
  <xsl:param name="mark" select="'?'"/>
  <fo:inline>
    <xsl:text>[</xsl:text><xsl:copy-of 
      select="$mark"/><xsl:text>]</xsl:text>
    
  </fo:inline>
</xsl:template>
-->



</xsl:stylesheet>


