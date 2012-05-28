# OmniAuth Etsy

A very alpha and unofficial [OmniAuth](https://github.com/intridea/omniauth) strategy for Etsy. To use it, you'll need OmniAuth and a registered application on [Etsy](https://www.etsy.com/developers/register) to get a token and secret.

## Usage with Rails

Create an initializer file, and tell OmniAuth you'd like to register etsy as a provider:

    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :etsy, 'token', 'secret'
    end

Etsy allows for sandbox API requests; to utilize it add sandbox to your config:

    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :etsy, 'token', 'secret', :sandbox => true
    end

Optionally, you may also pass in comma-separated [Permission Scopes](http://www.etsy.com/developers/documentation/getting_started/oauth#section_permission_scopes):


    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :etsy, 'token', 'secret', :scope => 'email_r,profile_r,listings_r'
    end

Note: If for some reason you receive a 400 error, it's probably your scopes.

## Auth hash

This is what you can expect in your `request.env['omniauth.auth']`:

```ruby

  provider: etsy
  uid: 12341241
  info:
    nickname: nickname
    email: you@email.com
    user_id: 12341241
    profile:
      user_profile_id: 12341241
      user_id: 12341241
      login_name: nickname
      bio: ''
      gender: private
      birth_month: '0'
      birth_day: '0'
      birth_year: '0'
      join_tsz: 1337366290
      materials: ''
      country_id: ''
      region: ''
      city: ''
      location: ''
      avatar_id: ''
      lat: ''
      lon: ''
      transaction_buy_count: 0
      transaction_sold_count: 0
      is_seller: false
      image_url_75x75: http://www.etsy.com/images/avatars/default_avatar_75px.png
      first_name: ''
      last_name: ''

## Installation

Add OmniAuth and OmniAuth::Etsy to your application's Gemfile:

    gem 'omniauth', '~>1.0'
    gem 'omniauth-etsy', '0.0.1'

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
