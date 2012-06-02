require 'omniauth/strategies/oauth2'
require 'base64'
require 'openssl'
require 'rack/utils'
require 'multi_json'
require 'stripe'

module OmniAuth
  module Strategies
    class Stripeplatform < OmniAuth::Strategies::OAuth2

     option :name, "stripeplatform"


      option :client_options, {
        :site => 'https://manage.stripe.com',
        :authorize_url => '/oauth2/authorize',
        :token_url => '/oauth2/token'
		             }

	option :access_token_options, {
        :header_format => 'OAuth %s',
        :param_name => 'access_token'
	:response_type => 'code'
      }


	
uid { raw_info['id'] }
      
      info do
        prune!({
          'nickname' => raw_info['username'],
          'name' => raw_info['full_name'],
          'image' => raw_info['avatar_url'],
          'description' => raw_info['description'],
          'urls' => {
            'Website' => raw_info['website']
          },
          'location' => raw_info['city']
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
