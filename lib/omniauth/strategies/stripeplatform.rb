require 'omniauth/strategies/oauth2'
require 'omniauth-oauth2'
require 'stripe'


module OmniAuth
  module Strategies
    class StripePlatform < OmniAuth::Strategies::OAuth2

      option :name, "stripeplatform"


      option :client_options, {
        :site => 'https://manage.stripe.com',
	:authorize_url => '/oauth/authorize',
	:token_url => '/oauth/token'
		             }
	option :token_params, {
        :parse => :query
      }

      option :access_token_options, {
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
	 @raw_info ||= MultiJson.load(access_token.get('https://api.stripe.com/v1/customers').body)
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
	end

	

    end
  end
end


OmniAuth.config.add_camelization 'stripeplatform', 'StripePlatform'


