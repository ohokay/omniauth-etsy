require 'omniauth-oauth'

module OmniAuth
  module Strategies
    class Etsy < OmniAuth::Strategies::OAuth

      option :client_options, {
        :site               => "http://openapi.etsy.com/v2",
        :request_token_path => "/oauth/request_token",
        :access_token_path  => "/oauth/access_token",
        :authorize_url      => "https://www.etsy.com/oauth/signin"
      }

      uid { user_hash['user_id'] }

      info do
        {
          'nickname' => raw_info['login_name'],
          'email' => raw_info['primary_email'],
          'user_id' => raw_info['user_id'],
          'profile' => profile_info
        }
      end

      def request_phase
        if options.scope
          options.request_params.merge!(:scope => options.scope.gsub(',', ' '))
        end
        prep_sandbox
        super
      end

      def callback_phase
        prep_sandbox
        super
      end

      def prep_sandbox
        if options.sandbox
          options.client_options.merge!(:site => "http://sandbox.openapi.etsy.com/v2")
        end
      end

      def profile_info
        @profile_info ||= user_hash['Profile']
        @profile_info.each { |k,v| @profile_info[k] = '' if v == nil }
      end

      def raw_info
        @data ||= user_hash
      end

      def user_hash
        @user_hash ||= MultiJson.decode(@access_token.get('/users/__SELF__?includes=Profile').body)['results'][0]
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      rescue ::OAuth::Error => e
        raise e.response.inspect
      end

    end
  end
end