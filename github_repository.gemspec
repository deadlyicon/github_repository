# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'github_repository/version'

Gem::Specification.new do |spec|
  spec.name          = "github_repository"
  spec.version       = GithubRepository::VERSION
  spec.authors       = ["Jared Grippe"]
  spec.email         = ["jared@deadlyicon.com"]
  spec.description   = %q{A simple API for interacting with a github repo via the v3 API}
  spec.summary       = %q{A simple API for interacting with a github repo via the v3 API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
