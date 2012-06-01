require 'omniauth/strategies/oauth2'
require 'base64'
require 'openssl'
require 'rack/utils'
require 'multi_json'
require 'stripe'

module OmniAuth
  module Strategies
    class Stripeplatform < OmniAuth::Strategies::OAuth2
     class NoAuthorizationCodeError < StandardError; end

      option :client_options, {
        :site => 'https://manage.stripe.com',
        :authorize_url => 'https://manage.stripe.com/oauth2/authorize',
        :token_url => 'https://manage.stripe.com/oauth2/token'
      }

      info do
        {
         'email' => email,
          }
           end

	 customer = Stripe::Customer.create({
         :description => "Customer created through Stripe Platform OAuth application."
		       }, access_token)
 
	 @stripe_response = JSON.pretty_generate(customer.to_hash)
      
    end
  end
end
