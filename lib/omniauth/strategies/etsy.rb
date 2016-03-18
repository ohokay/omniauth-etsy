require 'omniauth-oauth'

module OmniAuth
  module Strategies
    class Etsy < OmniAuth::Strategies::OAuth

      option :client_options, {
        :site               => "https://openapi.etsy.com/v2",
        :request_token_path => "/oauth/request_token",
        :access_token_path  => "/oauth/access_token",
        :authorize_url      => "https://www.etsy.com/oauth/signin"
      }

      uid { user_hash['user_id'] }

      info do
        info = {
          'nickname' => raw_info['login_name'],
          'email' => raw_info['primary_email'],
          'user_id' => raw_info['user_id'],
        }
        info['profile'] = profile_info if user_hash['Profile']

        info
      end

      extra do
        { raw_info: raw_info }
      end

      def request_phase
        if options.scope
          options.request_params.merge!(:scope => options.scope.gsub(',', ' '))
        end
        options.authorize_params.merge!({:oauth_consumer_key => options.consumer_key})
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

      def includes
        options.includes || "Profile"
      end

      def user_hash
        @user_hash ||= MultiJson.decode(@access_token.get("/users/__SELF__?includes=#{includes}").body)['results'][0]
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      rescue ::OAuth::Error => e
        raise e.response.inspect
      end
    end
  end
end
