
require 'net/https'
require  File.dirname(__FILE__) + '/xml/twilio_xml' 

module Splat

  class Twilio <  Gateway

    def initialize()
      super
      self.required_config([:provider_url, :account_sid, :auth_token])
      @service_url = self.config_option(:provider_url)
      @account_sid = self.config_option(:account_sid)
      @auth_token  = self.config_option(:auth_token)
      @api_version = self.config_option(:api_version) || '2008-08-01'
      @phone_number  = self.config_option(:phone_number)

      @send_service_url = URI.parse("#{@service_url}/#{@api_version}/Accounts/#{@account_sid}/SMS/Messages")

      #if options[:callbacks]
      #   before_send = options[:callback][:before_send]
      #end
    end
 
    def send_sms(message, number, options = {})
      options[:response].add(number, call_service(message, number))
      options[:response]
    end

    def send_bulk_sms(message, numbers, options = {})
      numbers.each do |number|
        options[:response].add(number, call_service(message, number))
      end
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

      http = Net::HTTP.new(@send_service_url.host, @send_service_url.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(@send_service_url.request_uri)
      request.basic_auth(@account_sid, @auth_token)
      request.set_form_data({'To' => parse_number(number), 
                             'From' => @phone_number, 
                             'Body' => message })

      response = XSD::Mapping.xml2obj(http.request(request).body)

      if response.RestException
        return response.RestException.message
      end

      response.SMSMessage.status

    end

    def parse_number(number)
      number.tr(' ', '')
    end

  end

end
