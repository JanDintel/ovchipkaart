# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ovchipkaart/version'

Gem::Specification.new do |spec|
  spec.name          = "ovchipkaart"
  spec.version       = Ovchipkaart::VERSION
  spec.authors       = ["Jan van der Pas"]
  spec.email         = ["janvanderpas@gmail.com"]
  spec.description   = "Use the OV Chipkaart website for retrieving travel information"
  spec.summary       = "Ruby wrapper for ov-chipkaart.nl"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
