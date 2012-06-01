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

	uid do
	  request.params[options.uid_field.to_s]
	end

	info do
	  options.fields.inject({}) do |hash, field|
		      hash[field] = request.params[field]
		          hash
			    end
	end



      
    end
  end
end
