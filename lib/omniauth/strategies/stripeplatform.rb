require 'omniauth/strategies/oauth2'
require 'base64'
require 'openssl'
require 'rack/utils'
require 'oauth2'
require 'stripe'

module OmniAuth
  module Strategies
    class Stripeplatform
      include OmniAuth::Strategy
	# receive parameters from the strategy declaration and save them
      def initialize(app, secret, auth_redirect, options = {})
        @secret = secret
        @auth_redirect = auth_redirect
        super(app, :stripeplatform, options)
      end

      # redirect to the Stripe website
      def request_phase
        r = Rack::Response.new
        r.redirect @auth_redirect
        r.finish
      end

      def callback_phase
         token = request.params["token"]
        sha1 = Digest::SHA1.hexdigest("a mix of  #{@secret} ")

        # check if the request comes from Stripe or not
	if sha1 == token
          
          # OmniAuth takes care of the rest
	  super
        else
	  # OmniAuth takes care of the rest
          fail!(:invalid_credentials)
        end
      end

      # normalize user's data according to http://github.com/intridea/omniauth/wiki/Auth-Hash-Schema
      def auth_hash
        OmniAuth::Utils.deep_merge(super(), {
          'uid' => @uid,
          'user_info' => {
            'name'     => @username,
            'nickname' => @username,
          }
        })
      end
    end
  end
end

