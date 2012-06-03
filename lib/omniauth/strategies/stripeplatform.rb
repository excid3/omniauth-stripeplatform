require 'omniauth/strategies/oauth2'


module OmniAuth
  module Strategies
    class StripePlatform < OmniAuth::Strategies::OAuth2

      DEFAULT_SCOPE = 'read_write'
      DEFAULT_RESPONSE_TYPE = 'code'
      DEFAULT_GRANT = 'authorization_code'
      CLIENT_SECRET = 'yebV2wGX65K8tSfsFJZgCsuIi3Y0pIq2'


      option :name, "stripeplatform"


      option :client_options, {
        :site => 'https://manage.stripe.com',
	:authorize_url => '/oauth/authorize',
	:token_url => '/oauth/token'
		             }

	
      option :access_token_options, {
        :header_format => "Bearer #{client.secret}"
      }

 def authorize_params
        super.tap do |params|
          params[:response_type] ||= DEFAULT_RESPONSE_TYPE
          params[:client_id] = client.id
        end
      end

      def token_params
        super.tap do |params|
          params[:grant_type] ||= DEFAULT_GRANT
          params[:client_id] = client.id
          params[:client_secret] = CLIENT_SECRET
        end
      end


    end
  end
end


OmniAuth.config.add_camelization 'stripeplatform', 'StripePlatform'


