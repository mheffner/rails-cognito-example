require 'cognito_jwt_keys'
require 'cognito_client'

class ApplicationController < ActionController::Base
  before_action :check_signed_in

  def check_signed_in
    @is_signed_in = false
    @current_user = nil
    @cognito_session = nil

    cognito_session = nil
    if session[:cognito_session_id]
      begin
        cognito_session = CognitoSession.find(session[:cognito_session_id])
      rescue ActiveRecord::RecordNotFound
      end
    end

    unless cognito_session
      return
    end

    now = Time.now.tv_sec

    if cognito_session.expire_time > now
      # Still valid, use
      #

      Rails.logger.info("Found a non-expired cognito session: #{cognito_session.id}")
      @is_signed_in = true
      @current_user = cognito_session.user
      @cognito_session = cognito_session
      return
    end

    Rails.logger.info("Refreshing cognito session: #{cognito_session.id}")

    # Need to refresh token
    if refresh_cognito_session(cognito_session)
      @is_signed_in = true
      @current_user = cognito_session.user
      @cognito_session = cognito_session
      return
    end
  end

  def refresh_cognito_session(cognito_session)
    client = new_cognito_client()

    resp = client.refresh_id_token(cognito_session.refresh_token)

    return false unless resp

    cognito_session.expire_time = resp.id_token[:exp]
    cognito_session.issued_time = resp.id_token[:auth_time]
    cognito_session.audience = resp.id_token[:aud]

    cognito_session.save!
  end

  def new_cognito_client
    CognitoClient.new(:redirect_uri => auth_sign_in_url)
  end
end
