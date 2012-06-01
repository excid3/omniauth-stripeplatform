require 'omniauth/strategies/oauth2'
require 'base64'
require 'openssl'
require 'rack/utils'
require 'multi_json'

module OmniAuth
  module Strategies
    class Stripeplatform < OmniAuth::Strategies::OAuth2
     class NoAuthorizationCodeError < StandardError; end

      option :client_options, {
        :site => 'https://manage.stripe.com',
        :authorize_url => '/oauth2/authorize',
        :token_url => '/oauth2/token'
      }

   def request_phase
     redirect client.code.authorize_url({:redirect_uri => callback_url}.merge(options.authorize_params))
      end

      def callback_phase

    # Attach the redirect_uri and our live-mode API key
        return fail!(:invalid_credentials) unless identity
        super
      end




      uid{ identity.uid }
      info{ identity.info }

      def registration_path
        options[:registration_path] || "#{path_prefix}/#{name}/register"
      end

      def on_registration_path?
        on_path?(registration_path)
      end

      def identity
        @identity ||= model.authenticate(request['auth_key'], request['password'])
      end

      def model
        options[:model] || ::Identity
      end  
	




      
    end
  end
end
