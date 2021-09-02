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
        <span>eLib</span>
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
                <xsl:call-template name="mir.languageMenu" />
              </ul>
            </div>
            <div class="search-button">
              <a
                data-toggle="collapse"
                href="#searchfield_box"
                role="button"
                aria-expanded="false"
                aria-controls="searchfield_box"
                class="js-search-toggle" />
            </div>
            <div class="first-aid-button">
              <a href="https://www.tiho-hannover.de/notdienst" class="first-aid-button__link">
                <svg class="first-aid-button__icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 388.8 388.8"><path style="fill:#fff;" d="M222 210c-5 0-8-4-8-8v-37h-39v37c0 4-4 8-8 8h-37v39h37c4 0 8 3 8 8v36h39v-36c0-5 3-8 8-8h36v-39h-36z"></path><path style="fill:#fff;" d="M334 89H55c-25 0-55 15-55 56v173c0 41 30 56 55 56h279c25 0 55-15 55-56V145c0-41-30-56-55-56zm-60 164c0 6-5 12-12 12h-32v32c0 7-5 12-12 12h-47c-7 0-12-5-12-12v-32h-33c-6 0-12-6-12-12v-47c0-7 6-12 12-12h33v-33c0-6 5-12 12-12h47c6 0 12 6 12 12v33h32c7 0 12 5 12 12v47zM246 15H146a23 23 0 00-25 25v36h16V40c0-3 0-9 9-9h97c9 0 9 6 9 9v36h16V40c0-13-9-24-22-25z"></path></svg>
                <span class="first-aid-button__txt">Notdienst</span>
              </a>
            </div>
          </nav>
        </div>
      </div>

      <form
        id="searchfield_box"
        action="{$WebApplicationBaseURL}servlets/solr/find"
        class="searchfield_box form-inline my-0 collapse"
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

    <div class="container">
      <div class="row">
        <div class="col">
          <div id="options_nav_box" class="mir-prop-nav">
            <nav>
              <ul class="navbar-nav ml-auto flex-row">
                <xsl:call-template name="mir.loginMenu" />
              </ul>
            </nav>
          </div>
        </div>
      </div>
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
            <div class="col-xl-3 col-md-6 mb-3">
              <h3 class="">TiHo-Services</h3>
              <ul>
                <li>
                  <a href="/universitaet/die-tiho/ueber-die-tiho" title="Universität">
                    <span>Universität</span>
                  </a>
                </li>
                <li>
                  <a href="/studium-lehre" title="Studium &amp; Lehre">
                    <span>Studium &amp; Lehre</span>
                  </a>
                </li>
                <li>
                  <a href="/forschung" title="Forschung">
                    <span>Forschung</span>
                  </a>
                </li>
                <li>
                  <a href="/kliniken-institute" title="Kliniken &amp; Institute">
                    <span>Kliniken &amp; Institute</span>
                  </a>
                </li>
              </ul>
              <p><a href="/login">TiHo intern</a></p>
            </div>
            <div class="col-xl-3 col-md-6 mb-3">
              <h3 class="">Informationen</h3>
              <ul>
                <li>
                  <a href="/notdienst" title="Notdienst">
                    <span>Notdienst</span>
                  </a>
                </li>
                <li>
                  <a href="/anfahrt" title="Anfahrt">
                    <span>Anfahrt</span>
                  </a>
                </li>
              </ul>
            </div>
            <div class="col-xl-6 col-md-12">
              <h3 class="">Kontakt</h3>
              <p>
                Stiftung Tierärztliche Hochschule Hannover<br/>
                Bünteweg 2<br />
                30559 Hannover
              </p>
              <p>
                Tel.: +49 511 953-60<br />
                Fax: +49 511 953-8050<br/>
                <a href="javascript:linkTo_UnCryptMailto(%27kygjrm8gldmYrgfm%2Bfyllmtcp%2Cbc%27);">info(at)tiho-hannover.de</a><br />
                <a href="https://www.tiho-hannover.de/" target="_blank">www.tiho-hannover.de</a>
              </p>
              <a href="https://www.facebook.com/tihohannover" target="_blank" a="">
                <img src="https://www.tiho-hannover.de/fileadmin/_processed_/c/2/csm_f_logo_RGB-Black_100_65b005d42c.png" alt="Facebook-Logo" style="margin-right: 30px;" width="50" height="50" border="3" align="left" />
              </a>
              <a href="https://www.youtube.com/user/TiHoVideos" target="_blank" a="">
                <img src="https://www.tiho-hannover.de/fileadmin/_processed_/8/3/preview_youtube_social_circle_dark_9420a7e292.png" alt="youtube-Logo" width="50" height="50" border="3" align="left" />
              </a>
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
