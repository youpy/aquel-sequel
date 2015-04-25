# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'aquel/sequel/version'

Gem::Specification.new do |spec|
  spec.name          = "aquel-sequel"
  spec.version       = Aquel::Sequel::VERSION
  spec.authors       = ["youpy"]
  spec.email         = ["youpy@buycheapviagraonlinenow.com"]
  spec.summary       = %q{Sequel adapter for aquel}
  spec.homepage      = "https://github.com/youpy/aquel-sequel"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "sequel"
  spec.add_dependency "aquel"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
