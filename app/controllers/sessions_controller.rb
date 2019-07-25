class SessionsController < ApplicationController
  def signin
    redirect_to cognito_signin_url
  end

  def signout
    redirect_to cognito_signout_url
  end

  def signup
    redirect_to cognito_signup_url
  end

private

  def cognito_signin_url
    CognitoUrls.login_uri(ENV['AWS_COGNITO_APP_CLIENT_ID'],
                          signin_redirect_uri)
  end

  def cognito_signup_url
    CognitoUrls.signup_uri(ENV['AWS_COGNITO_APP_CLIENT_ID'],
                           signin_redirect_uri)
  end

  def cognito_signout_url
    CognitoUrls.logout_uri(ENV['AWS_COGNITO_APP_CLIENT_ID'],
                           signout_redirect_uri)
  end

  def signin_redirect_uri
    auth_sign_in_url
  end

  def signout_redirect_uri
    auth_sign_out_url
  end
end
