# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'omniauth/stripeplatform/version'

Gem::Specification.new do |s|
  s.name     = 'omniauth-stripeplatform'
  s.version  = OmniAuth::StripePlatform::VERSION
  s.authors  = ['Anthony Joseph']
  s.email    = ['anthony@makerbreaker.com']
  s.summary  = 'Stripe Platform strategy for OmniAuth, adapted from omniauth-facebook'
  s.homepage = 'http://makerbreaker.com'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_runtime_dependency 'omniauth-oauth2', '~> 1.0.2'

  s.add_development_dependency 'rspec', '~> 2'
  s.add_development_dependency 'rake'
end
