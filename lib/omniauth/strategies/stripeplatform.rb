require 'omniauth/strategies/oauth2'
require 'base64'
require 'openssl'
require 'rack/utils'
require 'oauth2'
require 'stripe'


module OmniAuth
  module Strategies
    class StripePlatform < OmniAuth::Strategies::OAuth2 < OAuth2
      class NoAuthorizationCodeError < StandardError; end

      DEFAULT_SCOPE = 'read_write'

      option :client_options, {
        :site => 'https://manage.stripe.com',
        :token_url => '/oauth/token'
      }

      option :token_params, {
        :parse => :query
      }

      option :access_token_options, {
        :header_format => 'OAuth %s',
        :param_name => 'access_token'
      }

      option :authorize_options, [:scope]
	
     set :client, OAuth2::Client.new(settings.client_id, '', options)

    code = params[:code]

    # Attach the redirect_uri and our live-mode API key
    params = { 
      :redirect_uri => settings.redirect_url,
      :headers => {'Authorization' => "Bearer #{settings.api_key}"}
    }   

    # Make a request to the access_token_uri endpoint to get an access_token
    @token = settings.client.auth_code.get_token(code, params)

    # Use the access_token as you would a regular live-mode API key
    Stripe.api_key = @token.token
    customer = Stripe::Customer.create(
      :description => "Customer created through Stripe Platform OAuth application."
    )   

    @stripe_response = JSON.pretty_generate(customer.to_hash)

    erb :callback



	


    end
  end
end
