<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
    xmlns:mcrver="xalan://org.mycore.common.MCRCoreVersion"
    xmlns:mcrxsl="xalan://org.mycore.common.xml.MCRXMLFunctions"
    exclude-result-prefixes="i18n mcrver mcrxsl">

  <xsl:import href="resource:xsl/layout/mir-common-layout.xsl" />
  <xsl:template name="mir.navigation">

    <div id="project_logo_box">
      <a href="https://www.tiho-hannover.de/"
         class="">
         <img src="{$WebApplicationBaseURL}images/logo-tiho.svg" alt="Stiftung Tierärztliche Hochschule Hannover (TiHo)" title="zur Startseite" />
      </a>
      <a href="{concat($WebApplicationBaseURL,substring($loaded_navigation_xml/@hrefStartingPage,2),$HttpSession)}" class="project-name">
        <span>TiHo eLib</span>
      </a>
    </div>

    <div id="header_box" class="">
      <!-- Collect the nav links, forms, and other content for toggling -->
      <div class="mir-main-nav bg-white">
        <div class="">
          <nav class="navbar navbar-expand-lg navbar-light">

            <button
              class="navbar-toggler mr-3"
              type="button"
              data-toggle="collapse"
              data-target="#mir-main-nav-collapse-box"
              aria-controls="mir-main-nav-collapse-box"
              aria-expanded="false"
              aria-label="Toggle navigation">
              <span class="navbar-toggler-icon"></span>
            </button>

            <div id="mir-main-nav-collapse-box" class="collapse navbar-collapse mir-main-nav__entries">
              <ul class="navbar-nav ml-auto mt-2 mt-lg-0">
                <xsl:for-each select="$loaded_navigation_xml/menu">
                  <xsl:choose>
                    <!-- Ignore some menus, they are shown elsewhere in the layout -->
                    <xsl:when test="@id='main'"/>
                    <xsl:when test="@id='brand'"/>
                    <xsl:when test="@id='below'"/>
                    <xsl:when test="@id='user'"/>
                    <xsl:otherwise>
                      <xsl:apply-templates select="."/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:for-each>
                <xsl:call-template name="mir.basketMenu" />
                <xsl:call-template name="mir.loginMenu" />
                <xsl:call-template name="mir.languageMenu" />
              </ul>
            </div>

          </nav>
        </div>
      </div>

      <form
        id="searchfield_box"
        action="{$WebApplicationBaseURL}servlets/solr/find"
        class="searchfield_box form-inline my-0"
        role="search">
        <input
          name="condQuery"
          placeholder="{i18n:translate('mir.navsearch.placeholder')}"
          class="form-control mr-2 search-query"
          id="searchInput"
          type="text"
          aria-label="Search" />
        <xsl:choose>
          <xsl:when test="contains($isSearchAllowedForCurrentUser, 'true')">
            <input name="owner" type="hidden" value="createdby:*" />
          </xsl:when>
          <xsl:when test="not(mcrxsl:isCurrentUserGuestUser())">
            <input name="owner" type="hidden" value="createdby:{$CurrentUser}" />
          </xsl:when>
        </xsl:choose>
        <button type="submit" class="btn btn-primary my-2 my-sm-0">
          <i class="fas fa-search"></i>
        </button>
      </form>
    </div>

  </xsl:template>

  <xsl:template name="mir.jumbotwo">
    <!-- do nothing -->
  </xsl:template>

  <xsl:template name="mir.footer">

    <div class="tiho-footer-card-box">
      <div class="row tiho-footer-card">
        <div class="container">
          <div class="row">
            <div class="col-xl-6 col-md-6 mb-3">
              <h3 class="">Bibliotheks - Services</h3>
              <ul>
                <li>
                  <a href="https://www.tiho-hannover.de/bibliothek" title="Bibliothek">
                    <span>Bibliothek</span>
                  </a>
                </li>
                <li>
                  <a href="https://www.tiho-hannover.de/bibliothek/ausleihen-und-bestellen" title="Ausleihen und Bestellen">
                    <span>Ausleihen und Bestellen</span>
                  </a>
                </li>
                <li>
                  <a href="https://www.tiho-hannover.de/bibliothek/suchen-und-finden" title="Suchen und Finden Übersicht">
                    <span>Suchen und Finden Übersicht</span>
                  </a>
                </li>
                <li>
                  <a href="https://www.tiho-hannover.de/bibliothek/lernen-und-arbeiten" title="Lernen und Arbeiten">
                    <span>Lernen und Arbeiten</span>
                  </a>
                </li>
                <li>
                  <a href="https://www.tiho-hannover.de/bibliothek/schreiben-und-publizieren" title="Schreiben und Publizieren Übersicht">
                    <span>Schreiben und Publizieren Übersicht</span>
                  </a>
                </li>
              </ul>
            </div>
            <div class="col-xl-6 col-md-6">
              <h3 class="">Kontakt</h3>
              <p>
                <strong>
                  Stiftung Tierärztliche Hochschule Hannover,<br/>
                  Bibliothek<br />
                </strong>
                Bünteweg 2, Gebäude 262<br />
                30559 Hannover
              </p>
              <p>
                Tel.: +49 511 953-7100<br />
                Fax: +49 511 953-7119<br/>
                <br/>
                <a href="mailto:publikationsdienste@tiho-hannover.de">publikationsdienste(at)tiho-hannover.de</a><br />
                <a href="https://www.tiho-hannover.de/bibliothek" target="_blank">www.tiho-hannover.de/bibliothek</a>
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="container">
      <div class="row tiho-footer-nav">
        <div class="col-12 col-lg-6 mb-3">
          © 2021 Stiftung Tierärztliche Hochschule Hannover
        </div>
        <div class="col-12 col-lg-6">
          <ul class="internal_links nav navbar-nav navbar-expand-md">
            <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='below']/*" />
          </ul>
        </div>
      </div>

    </div>
  </xsl:template>

  <xsl:template name="mir.powered_by">
    <xsl:variable name="mcr_version" select="concat('MyCoRe ',mcrver:getCompleteVersion())" />
    <div id="powered_by">
      <a href="http://www.mycore.de">
        <img src="{$WebApplicationBaseURL}mir-layout/images/mycore_logo_powered_120x30_blaue_schrift_frei.png" title="{$mcr_version}" alt="powered by MyCoRe" />
      </a>
    </div>
  </xsl:template>

</xsl:stylesheet>
