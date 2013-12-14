require 'ovchipkaart/version'
require 'ovchipkaart/scraper'
require 'yaml'

module Ovchipkaart

  # Configuration with defaults and YML support
  @config = { username: 'foo', password: 'bar' }

  @valid_config_keys = @config.keys

  # Configure through hash
  def self.configure(options = {})
    options.each { |key, value| @config[key.to_sym] = value if @valid_config_keys.include? key.to_sym }
  end

  # Configure through yaml file
  def self.configure_with(path_to_yaml_file)
    begin
      config = YAML::load(IO.read(path_to_yaml_file))
    rescue Errno::ENOENT
      log(:warning, "YAML configuration file couldn't be found. Using defaults."); return
    rescue Psych::SyntaxError
      log(:warning, "YAML configuration file contains invalid syntax. Using defaults."); return
    end

    configure(config)
  end

  def self.config
    @config
  end
end
