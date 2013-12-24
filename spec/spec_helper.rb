require 'simplecov'
require 'coveralls'

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
if ENV['TRAVIS_CI'].nil?
  SimpleCov.start
else
  SimpleCov.start do
    add_filter 'lib/ovchipkaart/scraper.rb'
    add_filter 'spec/lib/ovchipkaart/scraper_spec.rb'
  end
end

require 'ovchipkaart'

# Add support files
Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each { |file| require file }

# Add factories
Dir[File.join(File.dirname(__FILE__), "factories/**/*.rb")].each { |file| require file }

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.treat_symbols_as_metadata_keys_with_true_values = true

  config.order = 'random'
end
