require 'omniauth/strategies/oauth2'
module OmniAuth
  module Strategies
    class Stripeplatform < OmniAuth::Strategies::OAuth2


      option :client_options, {
        :site => 'https://manage.stripe.com',
	:authorize_url => '/oauth/authorize',
	:token_url => '/oauth/token'
		             }
	option :token_params, {
	:parse => :json
	}

      

    end
  end
end
