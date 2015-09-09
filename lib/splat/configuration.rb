require 'yaml'
require 'erb' 

module Splat

  #Singleton class
  class Configuration

    @options = nil

    def initialize
      
      template = ERB.new File.new("config/splat.yml").read
      @options = YAML.load(template.result(binding))
     
       
      template = ERB.new File.new("config/vendors.yml").read
      @options.merge!(YAML.load(template.result(binding)))
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
