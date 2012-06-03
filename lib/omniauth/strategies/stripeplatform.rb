require 'omniauth-oauth2'
require 'stripe'


module OmniAuth
  module Strategies
    class StripePlatform < OmniAuth::Strategies::OAuth2

      DEFAULT_SCOPE = 'read_write'

      option :name, "stripeplatform"


      option :client_options, {
        :site => 'https://manage.stripe.com',
	:authorize_url => '/oauth/authorize',
	:token_url => '/oauth/token'
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


	Stripe.api_key =  access_token.get(:site)


	def raw_info
	@raw_info = Stripe::Customer.create(
      :description => "Customer created through Stripe Platform OAuth application."
	    )  
	end

	

    end
  end
end


OmniAuth.config.add_camelization 'stripeplatform', 'StripePlatform'


