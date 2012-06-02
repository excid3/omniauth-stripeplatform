require 'omniauth-oauth2'
require 'omniauth/strategies/oauth2'
require 'omniauth'
require 'oauth2'


module OmniAuth
  module Strategies
    class Stripeplatform < OmniAuth::Strategies::OAuth2
	
      option :name, "stripeplatform"


      option :client_options, {
        :site => 'https://manage.stripe.com',
	:authorize_url => '/oauth/authorize',
	:token_url => '/oauth/token'
		             }
	option :token_params, {
	:parse => :json

	}

	option :access_token_options, {
        :header_format => 'OAuth %s',
        :param_name => 'access_token'
      }


uid { raw_info['id'] }
      
      info do
        prune!({
                   
          'email' => raw_info['email']
        })
      end
      
      credentials do
        prune!({
          'expires' => access_token.expires?,
          'expires_at' => access_token.expires_at
        })
      end
      
      extra do
        prune!({
          'raw_info' => raw_info
        })
      end
      
      def raw_info
        @raw_info ||= access_token.get('/me.json').parsed
      end
      
      def build_access_token
        super.tap do |token|
          token.options.merge!(access_token_options)
        end
      end

      def access_token_options
        options.access_token_options.inject({}) { |h,(k,v)| h[k.to_sym] = v; h }
      end

      def authorize_params
        super.tap do |params|
          # params.merge!(:display => request.params['display']) if request.params['display']
          params[:scope] ||= DEFAULT_SCOPE
        end
      end
      
      private
      
      def prune!(hash)
        hash.delete_if do |_, value| 
          prune!(value) if value.is_a?(Hash)
          value.nil? || (value.respond_to?(:empty?) && value.empty?)
        end
      end
      

    end
  end
end


OmniAuth.config.add_camelization 'stripeplatform', 'StripePlatform'


