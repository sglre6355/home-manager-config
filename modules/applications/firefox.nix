{
  ...
}:
{
  programs.firefox = {
    enable = true;
    policies = {
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      DisableTelemetry = true;
      EnableTrackingProtection = {
        Value = true;
        Category = "strict";
      };
      EncryptedMediaExtensions = {
        Enabled = true;
      };
      FirefoxHome = {
        Search = false;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
      };
      Homepage = {
        StartPage = "none";
      };
      HttpsOnlyMode = "enabled";
      NewTabPage = false;
      OfferToSaveLogins = false;
      SanitizeOnShutdown = {
        FormData = true;
      };
      SearchSuggestEnabled = false;
      UserMessaging = {
        FeatureRecommendations = false;
        SkipOnboarding = true;
      };
    };
    profiles = {
      default = {
        isDefault = true;
        settings = {
          "browser.toolbars.bookmarks.visibility" = "never";
          "browser.urlbar.suggest.bookmark" = false;
          "browser.urlbar.suggest.engines" = false;
          "browser.urlbar.suggest.openpage" = false;
          "browser.urlbar.suggest.quickactions" = false;
          "browser.urlbar.suggest.quicksuggest.all" = false;
          "browser.urlbar.suggest.history" = true;
          "browser.urlbar.suggest.topsites" = false;
          "browser.urlbar.suggest.trending" = false;
          "full-screen-api.warning.timeout" = 0;
          "privacy.globalprivacycontrol.enabled" = true;
          "toolkit.tabbox.switchByScrolling" = true;
          "ui.key.menuAccessKeyFocuses" = false;
        };
      };
    };
  };
}
