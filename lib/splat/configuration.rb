require 'yaml'

module Splat

  #Singleton class
  class Configuration

    @options = nil

    def initialize
      @options = YAML.load_file('config/splat.yml')
      @options = @options.merge YAML.load_file('config/vendors.yml') 
    end

    def self.instance
      @@configuration
    end

    def vendor(vendor = "default")
      @options[vendor.to_s] 
    end

    def all
      @options
    end

    def vendors
      @options.keys
    end

    @@configuration = Configuration.new
    private_class_method :new

  end
end
