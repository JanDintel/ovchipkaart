require 'ovchipkaart'

# Add support files
Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each { |file| require file }

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = 'random'
end
