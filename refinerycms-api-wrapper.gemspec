# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'refinery/api/version'

Gem::Specification.new do |spec|
  spec.name          = "refinerycms-api-wrapper"
  spec.version       = Refinery::API::VERSION
  spec.authors       = ["Brice Sanchez", "Ian Rodriguez"]

  spec.summary       = %q{This wraps the Refinery CMS API in a simple yet flexible way.}
  spec.description   = %q{Interact with Refinery CMS API using this awesome gem.}
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"
  spec.add_dependency "faraday_middleware"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rack-test", "~> 0.6.3"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "pry"
end
