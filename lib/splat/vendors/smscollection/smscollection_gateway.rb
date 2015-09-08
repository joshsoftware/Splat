
require 'net/http'

module Splat

  class Smscollection <  Gateway

    def initialize()
      super
      
      @send_url = self.config_option(:provider_url)
      self.required_config([:provider_url, :username, :password, :senderid])
    end
 
    def send_sms(message, number, options = {})
      options = options || {}
      options[:response] = {} 
      options[:response][number] = call_service(message, parse_number(number))
      options[:response]
    end

    def send_bulk_sms(message, numbers, options = {})
      numbers = numbers.join(',')
      options = options || {}
      options[:response] = {} 
      options[:response][:message] = call_service(message, numbers)
      options[:response]
    end
   
    private 

    def call_service(message, number)
      message = message.split().join("+")
      url = @send_url + send_url_v2().call(message, number)
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
