# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rightnow/version'

Gem::Specification.new do |gem|
  gem.name          = "rightnow-client"
  gem.version       = Rightnow::VERSION
  gem.authors       = ["Adrien Jarthon"]
  gem.email         = ["adrien.jarthon@dimelo.com"]
  gem.description   = %q{Rightnow API Ruby wrapper}
  gem.summary       = %q{Ruby wrapper for the Oracle Rightnow Social API v2}
  gem.homepage      = "https://github.com/dimelo/rightnow"

  gem.add_dependency 'faraday', '>= 0.8.0'
  gem.add_dependency 'virtus', '>= 0.5.3'
  gem.add_dependency 'typhoeus', '>= 0.5.0'
  gem.add_development_dependency 'rspec', '~> 2.6'
  gem.add_development_dependency 'webmock', '~> 1.8'
  gem.add_development_dependency 'rake'
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
