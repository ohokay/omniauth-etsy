# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-etsy/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jeff Mehlhoff"]
  gem.email         = ["jeffmehlhoff@mac.com"]
  gem.description   = %q{OmniAuth strategy for Etsy}
  gem.summary       = %q{OmniAuth strategy for Etsy}
  gem.homepage      = "http://github.com/ohokay/omniauth-etsy"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "omniauth-etsy"
  gem.require_paths = ["lib"]
  gem.version       = Omniauth::Etsy::VERSION

  gem.add_dependency 'omniauth', '~> 1.0'
  gem.add_dependency 'omniauth-oauth', '~> 1.0'
  gem.add_dependency 'multi_json'
end