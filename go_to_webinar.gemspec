# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'go_to_webinar/version'

Gem::Specification.new do |spec|
  spec.name          = 'go_to_webinar'
  spec.version       = GoToWebinar::VERSION
  spec.authors       = ['Danilo Jeremias da Silva', 'Michael Bennett']
  spec.email         = ['daniloj.dasilva@gmail.com', 'michael@michaelbennett.nyc']

  spec.summary       = 'Client for Go To Webinar API.'
  spec.description   = 'Client for Go To Webinar API.'
  spec.homepage = 'https://github.com/RecruitiFi/go_to_webinar'.freeze
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rest-client','~> 2.0'
  spec.add_dependency 'oauth2', '~> 1.4.4'
  spec.add_dependency 'redis', '~> 4.0'

  spec.add_development_dependency 'bundler', '~> 2.1.4'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.6'
  spec.add_development_dependency 'webmock', '~> 3.0'
end
