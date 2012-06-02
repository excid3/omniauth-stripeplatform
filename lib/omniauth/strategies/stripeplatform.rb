require 'omniauth/strategies/oauth2'
require 'base64'
require 'openssl'
require 'rack/utils'
require 'multi_json'
require 'stripe'

module OmniAuth
  module Strategies
    class Stripeplatform < OmniAuth::Strategies::OAuth2

     option :name, "stripeplatform"


      option :client_options, {
        :site => 'https://manage.stripe.com',
        :authorize_url => '/oauth2/authorize',
        :token_url => '/oauth2/token'
		             }

      option :access_token_options, {
        :header_format => 'OAuth %s',
        :param_name => 'access_token',
      }

      info do
        {
        'email' => email,
         }
           end

      


    end
  end
end
