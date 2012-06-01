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
        :authorize_url => 'https://manage.stripe.com/oauth2/authorize',
        :token_url => 'https://manage.stripe.com/oauth2/token'
      }
uid { raw_info['id'] }

      info do
        {
         'email' => email,
          }
           end

def raw_info
        access_token.options[:mode] = :query
        @raw_info ||= access_token.get('/user').parsed
      end

      def email
        raw_info['email'] || emails.first
      end

      def emails
        access_token.options[:mode] = :query
        @emails ||= access_token.get('/user/emails').parsed
      end
      
    end
  end
end
