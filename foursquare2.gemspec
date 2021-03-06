# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "foursquare2"
  s.version = "2.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matt Mueller", "Marco Moura", "Gerardo Ortega"]
  s.date = "2018-11-11"
  s.description = "Gives access to all endpoints in version 2 of foursquare's API with syntax that will be familiar to those who used the original foursquare gem by Jeremy Welch."
  s.email = %w(muellermr@gmail.com email@marcomoura.com g3ortega@gmail.com)
  s.extra_rdoc_files = [
    "LICENSE.txt"
  ]
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test}/*`.split("\n")
  s.homepage = "http://github.com/mattmueller/foursquare2"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Foursquare API v2 gem in the spirit of the original foursquare gem"

  s.add_runtime_dependency("faraday", ["~> 0.15.4"])
  s.add_runtime_dependency("faraday_middleware", [">= 0.12.2"])
  s.add_runtime_dependency("hashie", ["< 4.0.0", ">= 3.6.0"])
  s.add_development_dependency("bundler", ["~> 1.0"])
  s.add_development_dependency "rake", "~> 10.3.1"
  s.add_development_dependency("awesome_print", [">= 0"])
  s.add_development_dependency("shoulda", [">= 0"])
  s.add_development_dependency("fakeweb", ["~> 1.3"])
  s.add_development_dependency("json_pure", ["~> 1.4"])
  s.add_development_dependency("multi_json", ["< 2.0.0", ">= 0.0.5"])
  s.add_development_dependency("test-unit", ["~> 3.0"])
  s.add_development_dependency("jnunemaker-matchy", [">= 0"])
  s.add_development_dependency("mocha", [">= 0"])

end