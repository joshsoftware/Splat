
require 'net/http'
require File.dirname(__FILE__) + '/configuration'
require File.dirname(__FILE__) + '/utils'
require File.dirname(__FILE__) + '/insertion'

module Splat

  autoload :Initializer, File.dirname(__FILE__) + '/initializer'

  class Gateway

    include Insertion
    include Utils

    @@vendor_implementations = {}
    @@configuration = nil

    attr_reader :vendor

    def initialize
      @vendor = self.class.name.downcase.split("::").last if self.class != Gateway
    end

    def self.inherited(subclass)
      @@vendor_implementations[subclass.name.downcase.split("::").last] = subclass
    end

    def self.[](name)
      @@vendor_implementations[name.to_s]
    end

    def self.default_configuration
      Configuration.instance.vendor
    end

    def configuration
      Configuration.instance.vendor(@vendor)
    end

    def config_option(option)
       Configuration.instance.vendor(@vendor)[option.to_s]
    end

    # Send an SMS.
    # message:: The message. This will be automatically sanitized
    #           and url-encoded.
    # number::  The number in Config::Splat.default_number_format
    # options:: The various options specified configure_options
    #
    # Return Values
    # Success:: Return the id if the message was sent to the gateway.
    #           This not imply that the messages were delivered.
    # Failure:: Raise SplatGatewayError on failure with the relevant
    #           error message and error code.
    #
    # Example:
    # message => "Hello Smith, welcome to splat" 
    # number => '+91 9812345678'
    #
    # This returns and id, for which you can track the status.
    def send_sms(message, number, options = {})
      raise SplatGatewayImplError.new("Implement send_sms(message, number, options = {}) method in #{self.class}")
    end

    # Send bulk SMS
    # message:: The message. This will be automatically sanitized
    #           and url-encoded. This message can contain string
    #           insertions.
    # number::  Array of numbers in the Config::Splat.default_number_format
    # options:: The various options specified configure_options
    # 
    # In case the numbers do not match with string insertions, the
    # default_insertion will be used. If use_default_insertion is
    # set to false, then those numbers will be skipped.
    # 
    # Return Values
    # Success:: Return the id if the message was sent to the gateway.
    #           This not imply that the messages were delivered.
    # Failure:: Raise SplatGatewayError on failure with the relevant
    #           error message and error code.
    #
    # Example:
    # message => "Hello $1, hold on to your $2"
    # numbers => [ '+91 9812345678', '+1 4034832933', '+44 123783218']
    # options => 
    #    :insertions => { 1 => [ 'Smith', 'John Doe', 'Jane'],
    #                     2 => [ 'stocks', 'socks', 'skirt']
    #                   },
    #    :default_insertion => { 1 => 'User', 2 => '' }
    # REVIEW:
    #    :insertions => { '+91 981234565' => [ 'Smith', 'stocks'],
    #                     '+1 4034832933' => ['John Doe', 'socks'],
    #                     '+44 123783218' => ['Jane', 'skirt']
    #                     '+44 122342418' => ['Jane' ]
    #    :default_insertion => { 1 => 'User', 2 => '' }
    #    }
    def send_bulk_sms(message, numbers, options = {})
      raise  SplatGatewayImplError.new("Implement send_bulk_sms(message, numbers, options = {}) in #{self.class}")
    end

    def send_bulk_sms_with_insertion(message, insertions ={}, options = {})
      raise  SplatGatewayImplError.new("Implement send_bulk_sms_with_insertion(message, insertions ={}, options = {}) in #{self.class}")
    end

    def required_config(options = [])
        options.each do |option|
          raise SplatError.new("'#{option}' not define for '#{@vendor}' in config file") if self.configuration[option.to_s].blank? 
        end
    end

  end

  unless Splat.included_modules.include?(Splat::Initializer)
    include  Initializer
  end

end
