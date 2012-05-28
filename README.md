# OmniAuth Etsy

An unofficial [OmniAuth](https://github.com/intridea/omniauth) strategy for Etsy. To use it, you'll need OmniAuth and a registered application on [Etsy](https://www.etsy.com/developers/register).

## Usage

`OmniAuth::Etsy` is Rack middleware. Below are examples written specifically for Rails 3.1+, however it can be used in other frameworks based off of Rack (Sinatra, etc). See the [OmniAuth docs](https://github.com/intridea/omniauth) for detailed usage examples.

Create an initializer file, and tell OmniAuth you'd like to register Etsy as a provider:

    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :etsy, ENV['ETSY_TOKEN'], ENV['ETSY_SECRET']
    end

Etsy allows for sandbox API requests; to utilize it add sandbox to your config:

    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :etsy, ENV['ETSY_TOKEN'], ENV['ETSY_SECRET'], :sandbox => true
    end

Note: Etsy's sandbox API may return rather _unusual_ results. I advise when making read-only requests to simply forgo the sandbox.

Optionally, you may also pass in comma-separated [Permission Scopes](http://www.etsy.com/developers/documentation/getting_started/oauth#section_permission_scopes):


    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :etsy, ENV['ETSY_TOKEN'], ENV['ETSY_SECRET'], :scope => 'email_r,profile_r,listings_r'
    end

Note: If for some reason you receive a 400 error, it's probably your scopes.

## Auth hash

On callback this is what you can expect in your `request.env['omniauth.auth']` info hash:

```ruby
provider: etsy
uid: 12341241
info:
  nickname: 'nickname'
  email: 'you@email.com'
  user_id: 12341241
  first_name: 'Bill'
  last_name: 'Clinton'
  name: 'Bill Clinton'
  image: 'http://www.etsy.com/images/avatars/default_avatar_75px.png'
  profile:
    user_profile_id: 12341241
    user_id: 12341241
    login_name: 'nickname'
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
    image_url_75x75: 'http://www.etsy.com/images/avatars/default_avatar_75px.png'
    first_name: 'Bill'
    last_name: 'Clinton'
```

## Installation

Add OmniAuth and OmniAuth::Etsy to your application's Gemfile:

    gem 'omniauth', '~>1.0'
    gem 'omniauth-etsy', '~>0.1.0'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth
    $ gem install omniauth-etsy

`OmniAuth::Etsy` has been used on both Ruby 1.9.2 and REE 1.8.7.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
