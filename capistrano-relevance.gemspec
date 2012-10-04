# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/relevance/version'

Gem::Specification.new do |gem|
  gem.name          = "capistrano-relevance"
  gem.version       = Capistrano::Relevance::VERSION
  gem.authors       = ["Yoko Harada and Jason Rudolph"]
  gem.email         = ["opensource@thinkrelevance.com"]
  gem.description   = %q{A collection of default Capistrano recipes commonly used on Relevance projects}
  gem.summary       = %q{Relevance recipes for Capistrano}
  gem.homepage      = "https://github.com/relevance/capistrano-relevance"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  # You actually need an unreleased version of Capistrano (2.13.4.1? or 2.13.5?). See README.
  gem.add_runtime_dependency "capistrano", "~> 2.13.4"
end
