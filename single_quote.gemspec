# -*- encoding: utf-8 -*-
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "single_quote/version"

Gem::Specification.new do |gem|
  gem.name          = "single_quote"
  gem.version       = SingleQuote::VERSION
  gem.authors       = ["Brendan Loudermilk"]
  gem.email         = ["bloudermilk@gmail.com"]
  gem.description   = %q{Write a gem description}
  gem.summary       = %q{Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency("rspec", "~> 2.11.0")
  gem.add_development_dependency("guard", "~> 1.5.3")
  gem.add_development_dependency("guard-rspec", "~> 2.1.1")
  gem.add_development_dependency("guard-bundler", "~> 1.0.0")
  gem.add_development_dependency("rb-fsevent", "~> 0.9.2")
  gem.add_development_dependency("fakefs", "~> 0.4.2")
  gem.add_development_dependency("rake", "~> 10.0.2")
end
