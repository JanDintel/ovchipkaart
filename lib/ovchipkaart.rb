# encoding: utf-8
require 'ovchipkaart/setup'
require 'ovchipkaart/version'
require 'ovchipkaart/scraper'
require 'ovchipkaart/parser'
require 'ovchipkaart/api'

module Ovchipkaart
  class OvchipkaartError < StandardError; end
  class ConfigurationError < OvchipkaartError; end

  # Configuration
  MANDATORY_CONFIGURATION = { username: nil, password: nil }
  CONFIGURATIONS_KEYS = MANDATORY_CONFIGURATION.merge!({})

  # Global config hash
  @config = {}
  def self.config
    @config
  end

  # Configuration with a hash
  def self.configure(options = {})
    MANDATORY_CONFIGURATION.each_key do |mandatory_option|
      unless options.keys.map(&:to_sym).include?(mandatory_option)
        raise ConfigurationError, 'Username and password are mandatory configuration options'
      end
    end

    options.keys.map(&:to_sym).each do |given_configuration_key|
      unless CONFIGURATIONS_KEYS.keys.include? given_configuration_key
        raise ConfigurationError, 'Unknown configuration given'
      end
    end

    options.each { |key, value| @config[key.to_sym] = value }
  end

  # Configuration with a YAML file
  def self.configure_with(path_to_yaml_file)
    begin
      config = YAML::load(IO.read(path_to_yaml_file))
    rescue Errno::ENOENT
      raise ConfigurationError, 'YAML configuration file not found'
    rescue Psych::SyntaxError
      raise ConfigurationError, 'YAML configuration file contains invalid syntax'
    end

    configure(config)
  end
end
