require 'omniauth/strategies/oauth2'


module OmniAuth
  module Strategies
    class StripePlatform < OmniAuth::Strategies::OAuth2

      DEFAULT_SCOPE = 'read_write'
      DEFAULT_RESPONSE_TYPE = 'code'
      DEFAULT_GRANT = 'authorization_code'

      option :name, "stripeplatform"


      option :client_options, {
        :site => 'https://manage.stripe.com',
	:authorize_url => '/oauth/authorize',
	:token_url => '/oauth/token'
		             }

	def request_phase
        super
       end	

	

    end
  end
end


OmniAuth.config.add_camelization 'stripeplatform', 'StripePlatform'


