
require 'net/http'

module Splat

  class Clickatell <  Gateway

    def initialize()
      super
      self.required_config([:api_keu, :username, :password])

    end
 
    def send_sms(message, number, options = {})
       options[:response].message =  call_service(message, parse_number(number))
       options[:response]
    end

    def send_bulk_sms(message, numbers, options = {})
      numbers = numbers.collect{ |x| parse_number(x) }.join(',')
      options[:response].message = call_service(message, numbers)
      options[:response]
    end

    def send_bulk_sms_with_insertion(message, insertions = {}, options = {})
      
      number_message_map  = insert_values(message, insertions)
      number_message_map.each do |number, message|
         options[:response].add(number, call_service(message, parse_number(number)))
      end
      options[:response]
    end

    private 

    def call_service(message, number)
#      url = "#{@url}&mobileno=#{number}&msgtext=#{url_escape(message)}&priority=High"
#      Net::HTTP.get URI.parse(url)
      "sent"
    end

    def parse_number(number)
      number.split(' ').last
    end

  end

end
