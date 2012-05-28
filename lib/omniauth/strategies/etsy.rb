require 'omniauth-oauth'

module OmniAuth
  module Strategies
    class Etsy < OmniAuth::Strategies::OAuth
      option :client_options, {
        :site               => "http://sandbox.openapi.etsy.com/v2",
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
        }.merge!(profile_info)
      end

      def request_phase
        if options.scope
          options.request_params.merge!(:scope => Rack::Utils.build_query([options.scope]))
        end
        super
      end

      def profile_info
        profile = user_hash['Profile']
        if profile
          {
            'first_name' => profile['first_name'],
            'last_name' => profile['last_name'],
            'image' => profile['image_url_75x75'],
            'full_name' => "#{profile['first_name']} #{profile['last_name']}"
          }
        else
          {}
        end
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