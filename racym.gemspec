# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'racym/version'

Gem::Specification.new do |spec|
  spec.name          = "racym"
  spec.version       = Racym::VERSION
  spec.authors       = ["David Raffauf"]
  spec.email         = ["david@usertesting.com"]
  spec.description   = %q{Rails Application Configuration for Yield Main}
  spec.summary       = %q{Used as a shortcut to rails configuration.}
  spec.homepage      = ""

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "railties", ">= 3.2.13","< 5.0"
  
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
