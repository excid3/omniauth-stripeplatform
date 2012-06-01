require 'omniauth/strategies/oauth2'
require 'base64'
require 'openssl'
require 'rack/utils'

module OmniAuth
  module Strategies
    class Stripeplatform < OmniAuth::Strategies::OAuth2
     class NoAuthorizationCodeError < StandardError; end

      option :name, 'stripeplatform'

      option :client_options, {
        :site => 'https://manage.stripe.com',
        :authorize_url => '/oauth2/authorize',
        :token_url => '/oauth2/token'
      }

      uid { raw_info['id'] }

      info do
        {
          # 'name'  => raw_info['name'],
          'email' => raw_info['email']
        }
      end


      def raw_info
        @raw_info ||= access_token.get('/me').parsed
      end
    end
  end
end
#OmniAuth.config.add_camelization 'testoauth2strategy', 'TestOAuth2Strategy'require 'omniauth/strategies/oauth2'
