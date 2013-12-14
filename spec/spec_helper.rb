require 'ovchipkaart'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = 'random'
end

Ovchipkaart.configure_with('spec/support/credentials.yml')
