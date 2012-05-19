# OmniAuth Etsy

A (very alpha) unofficial [OmniAuth](https://github.com/intridea/omniauth) strategy for Etsy. You'll need to register an application on [Etsy](https://www.etsy.com/developers/register) to get a token and secret.

## Useage

	Rails.application.config.middleware.use OmniAuth::Builder do
  		provider :etsy, 'token', 'secret'
	end

Optionally, you may pass in comma separated [Permission Scopes](http://www.etsy.com/developers/documentation/getting_started/oauth#section_permission_scopes):


	Rails.application.config.middleware.use OmniAuth::Builder do
  		provider :etsy, 'token', 'secret', :scope => 'email_r,listings_r'
	end



## Installation

Add OmniAuth and OmniAuth::Etsy to your application's Gemfile:
	
	gem 'omniauth', '~>1.0'
  	gem 'omniauth-etsy', '0.0.1-alpha'

And then execute:

    $ bundle

Or install it yourself as:

	$ gem install omniauth
    $ gem install omniauth-etsy

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
