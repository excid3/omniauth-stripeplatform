require 'omniauth-oauth2'
require 'stripe'


module OmniAuth
  module Strategies
    class StripePlatform < OmniAuth::Strategies::OAuth2

     DEFAULT_SCOPE = 'read_write'

      option :name, "stripeplatform"

	OmniAuth.logger.debug "My info message"


      option :client_options, {
        :site => 'https://manage.stripe.com',
	:authorize_url => '/oauth/authorize',
	:token_url => '/oauth/token',

		             }
	option :token_params, {
        :parse => :query
      }

	option :access_token_options, {
        :header_format => "Bearer: %s(:client_secret)",
        :param_name => 'access_token'
      }



       uid{ raw_info['id'] }


	info do
	{
	:id => raw_info['id']        

        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end




	def raw_info
	end

	

    end
  end
end


OmniAuth.config.add_camelization 'stripeplatform', 'StripePlatform'


