
require 'net/http'

module Splat

  class Smscollection <  Gateway

    def initialize()
      super
      @send_url = send_url_v2();
      self.required_config([:provider_url, :username, :password, :senderid])
    end
 
    def send_sms(message, number, options = {})
      options[:response].add(number, call_service(message, parse_number(number)))
      options[:response]
    end

    def send_bulk_sms(message, numbers, options = {})
      numbers = numbers.join(',')
      options[:response].message = call_service(message, numbers)
      options[:response]
    end
   
    private 

    def call_service(message, number)
      url = @send_url.call(message, number)
      Net::HTTP.get URI.parse(url)
    end

    def parse_number(number)
      number.split(' ').last
    end

    #self.config_option(:username)}&pwd=#{self.config_option(:password)}&senderid=#{self.config_option(:senderid)
    def send_url_v2
      return Proc.new{|msg, phone_numbers| "/sendsmsv2.asp?user=#{self.config_option(:username)}&password=#{self.config_option(:password)}&sender=#{self.config_option(:senderid)}&text=#{msg}&PhoneNumber=#{phone_numbers}"}
    end
    
    def schedule_url
      "/schedulesms.asp"
    end

    def balance_url
      "/balance.asp"
    end

  end

end
