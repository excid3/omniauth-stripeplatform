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

		option :token_params, {
		  :parse => :query
			}


	option :access_token_options, {
	   :header_format => "OAuth %s",
	   :param_name => 'access_token'
			}

	option :authorize_params, {
	    :header_format => "Bearer %s(:client_secret)"
		}
  

	def request_phase
        authorize_params[:headers][:authorize] = "Bearer #{client.secret}"
        redirect client.auth_code.authorize_url({:redirect_uri => callback_url}.merge(authorize_params))
      end


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


