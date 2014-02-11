# encoding: utf-8
module Ovchipkaart
  module Setup
    # YAML Configuration
    require 'yaml'

    # Capybara
    require 'capybara'
    require 'capybara/dsl'
    require 'capybara/mechanize'

    Capybara.register_driver :mechanize do |app|
      Capybara::Mechanize::Driver.new(true)
    end

    Capybara.default_driver = :mechanize
    Capybara.run_server     = false
  end
end
