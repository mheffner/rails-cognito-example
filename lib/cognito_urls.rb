class CognitoUrls
  AUTHORIZE_PATH = "/oauth2/authorize"
  TOKEN_PATH = "/oauth2/token"
  LOGIN_PATH = "/login"
  LOGOUT_PATH = "/logout"
  SIGNUP_PATH = "/signup"

  class << self
    @base_oauth_uri = nil
    @base_idp_uri = nil

    def init(domain, region)
      @base_oauth_uri = "https://%s.auth.%s.amazoncognito.com" % [domain, region]
      @base_idp_uri = "https://cognito-idp.%s.amazonaws.com" % [region]
    end

    def jwks_uri(pool_id)
      path = "/%s/.well-known/jwks.json" % [pool_id]
      URI.join(@base_idp_uri, path).to_s
    end

    def refresh_token_uri
      @base_idp_uri
    end

    def authorize_uri
      URI.join(@base_oauth_uri, AUTHORIZE_PATH).to_s
    end

    def token_uri
      URI.join(@base_oauth_uri, TOKEN_PATH).to_s
    end

    def login_uri(app_client_id, redirect_uri)
      path = "%s?response_type=code&client_id=%s&redirect_uri=%s" %
        [LOGIN_PATH, app_client_id, redirect_uri]
      URI.join(@base_oauth_uri, path).to_s
    end

    def logout_uri(app_client_id, redirect_uri)
      path = "%s?response_type=code&client_id=%s&logout_uri=%s" %
        [LOGOUT_PATH, app_client_id, redirect_uri]
      URI.join(@base_oauth_uri, path).to_s
    end

    def signup_uri(app_client_id, redirect_uri)
      path = "%s?response_type=code&client_id=%s&redirect_uri=%s" %
        [SIGNUP_PATH, app_client_id, redirect_uri]
      URI.join(@base_oauth_uri, path).to_s
    end
  end
end
