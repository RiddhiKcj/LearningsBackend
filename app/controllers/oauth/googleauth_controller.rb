module Oauth
  class GoogleauthController < ApplicationController
    require 'google/apis/oauth2_v2'

    def create
      oauth2 = Google::Apis::Oauth2V2::Oauth2Service.new
      access_token = params['accesstoken']
      userinfo = oauth2.tokeninfo(access_token: access_token)
      if userinfo.email.present?
        user = User.find_by_email(userinfo.email)
        if !user
            user = User.new(email: userinfo.email, password: params['accesstoken'].slice(0,10))
            user.save
        end
        payload  = { user_id: user.id }
        session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
        render json: session.login
      else
        render json: { error: 'Login Failed' }, status: :not_found
      end
    end
  end
end
