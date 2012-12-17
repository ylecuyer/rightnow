# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rightnow/version'

Gem::Specification.new do |gem|
  gem.name          = "rightnow"
  gem.version       = Rightnow::VERSION
  gem.authors       = ["Adrien Jarthon"]
  gem.email         = ["adrien.jarthon@dimelo.com"]
  gem.description   = %q{Ruby wrapper for the Oracle Rightnow Social API v2}
  gem.summary       = %q{Ruby wrapper for the Oracle Rightnow Social API v2}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
