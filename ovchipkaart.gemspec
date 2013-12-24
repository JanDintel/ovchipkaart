# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'ovchipkaart/version'

Gem::Specification.new do |spec|
  spec.name          = 'ovchipkaart'
  spec.version       = Ovchipkaart::VERSION
  spec.authors       = ['Jan van der Pas']
  spec.email         = ['janvanderpas@gmail.com']
  spec.description   = "An unofficial OV Chipkaart gem, which scrapes the OV Chipkaart website (ov-chipkaart.nl) and provides an easy to use Ruby API."
  spec.summary       = 'Unofficial Ruby OV Chipkaart API gem'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.requirements         << 'chromedriver, v2.8'
  spec.post_install_message = "Make sure that the chromedriver is installed before using the ovchipkaart gem."

  spec.add_runtime_dependency 'nokogiri',           '~> 1.6.0'
  spec.add_runtime_dependency 'capybara',           '~> 2.2.0'
  spec.add_runtime_dependency 'selenium-webdriver', '~> 2.38.0'

  spec.add_development_dependency 'bundler',        '~> 1.3'
  spec.add_development_dependency 'rake'
end
