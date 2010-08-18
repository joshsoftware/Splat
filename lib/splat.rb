
$:.unshift File.dirname(__FILE__)

require 'active_support'
require  File.dirname(__FILE__) + '/splat/gateway'
require  File.dirname(__FILE__) + '/splat/error'
require  File.dirname(__FILE__) + '/splat/response'


module Splat

  class Base

    @@gateways = {}
    @vendor = nil
    attr_reader :number_format_regx

    def initialize(vendor_name)
      self.vendor = vendor_name

      if number_format = Gateway.default_configuration['number_format']
        @number_format_regx =  Regexp.new(number_format)
      else
        raise SplatError.new("default:  number_format not define in splat.yml") unless number_format
      end

    end

    def send_sms(message, number, options = {})
      options[:response] = Response.new
      unless validate_phone?(number)
        return options[:response].invalid_phone_format(number)
      end
      get_vender_object(vendor).send_sms(message, number, options) 
    end

    def send_bulk_sms(message, numbers = [], options = {})
       options[:response] = validate_phones(numbers)    
       get_vender_object(vendor).send_bulk_sms(message, numbers - options[:response].invalid_phone_numbers, options)
    end

    def send_bulk_sms_with_insertion(message, insertions ={}, options = {})
       options[:response] = validate_phones(insertions.keys)    

       insertions.delete_if do |key, value|
         !options[:response].phone_numbers[key].nil?
       end

       get_vender_object(vendor).send_bulk_sms_with_insertion(message, insertions, options)
    end

    def vendor
      raise SplatError.new('Vendor is nil.Set vendor name.') unless @vendor
      @vendor
    end

    private 

    def vendor=(vendor_name)
      raise SplatNoGatewaySupportError.new("#{vendor_name} not supported") unless get_vender_object(vendor_name) 
      @vendor = vendor_name
    end

    def get_vender_object(name)
      unless @@gateways[name.to_s]
        @@gateways[name.to_s] = Gateway[name].new if Gateway[name]
      end
      @@gateways[name.to_s]
    end

    def validate_phone?(number)
      number.to_s =~ number_format_regx
    end

    def validate_phones(numbers)
      response = Response.new
      numbers.each do |number|
        response.invalid_phone_format(number) unless validate_phone?(number)
      end
      response
    end

  end

end




