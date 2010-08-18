
require 'net/http'
require  File.dirname(__FILE__) + '/xml/schema'

module Splat

  class Vmobo <  Gateway
    include VmoboSchema

     SUCCESSFUL = "200"
     BAD_REQUEST = "400"
     FORBIDDEN   = "403"
     SERVICE_UNAVAILABLE = "503"
     INTERNAL_ERROR = "500"

     SUPPORTED_COUNTRY_CODES = ['+91']

    def initialize()
      super
      self.required_config([:provider_url, :username, :api_key, :keyword])
      @url = URI.parse(self.config_option(:provider_url))
      @username = self.config_option(:username)
      @api_key  = self.config_option(:api_key)
      @keyword  = self.config_option(:keyword)
      @custom_message = SOAP::SOAPRawString.new("<%= custom_message %>")
    end

    def supported_country_code
      SUPPORTED_COUNTRY_CODE
    end
 
    def send_sms(message, number, options = {})
       call_service make_request(message, [number]), options[:response]
    end

    def send_bulk_sms(message, numbers, options = {})
      call_service make_request(message, numbers), options[:response]
    end

    def send_bulk_sms_with_insertion(message, insertions = {}, options = {})
       call_service make_request_with_insertion(insert_values(message, insertions)), options[:response]
    end

    private 

    def call_service(request, response = Response.new)
      request_xml = XSD::Mapping.obj2xml(request, 'request')
      http_response = Net::HTTP.post_form(@url, {'xml_request' => request_xml})

      case http_response.code
      when SUCCESSFUL
           response = parse_response(http_response.body, response)
      when BAD_REQUEST
           response.message = 'Bad Request'
      when FORBIDDEN
           response.message = 'Forbidden. You do not have permission to access this resource.'
      when SERVICE_UNAVAILABLE
           response.message = 'Service unavailable. An internal problem prevented us from returning data to you.'
      when INTERNAL_ERROR
           response.message = 'Internal error.'
      end
      response
    end

    def make_request(message, numbers)
      recipients = Recipients.new()
      numbers.each do |number|
         recipients << Recipient.new(parse_number(number))   
      end

      Request.new(@username, @api_key, message, @keyword, recipients)
    end

    def make_request_with_insertion(number_message_map)
      recipients = Recipients.new()
      number_message_map.each do |number, message|
        recipients << Recipient.new(parse_number(number), Attributes.new(message))
      end
       Request.new(@username, @api_key, @custom_message, @keyword, recipients)
    end

    def parse_response(response_xml, response)
      res_obj = XSD::Mapping.xml2obj(response_xml)
      recipients = res_obj.successful_recipients.recipient
      if recipients.instance_of? Array
         recipients.each do |recipient|
           response.add(recipient.xmlattr_phone_number, Response::SUCCESSFUL)
         end
      else 
        response.add(recipients.xmlattr_phone_number, Response::SUCCESSFUL)
      end
      #For failed recipients
       if res_obj.failed_recipients.instance_of? String
          failed_recipients = res_obj.failed_recipients.split(',')
          failed_recipients.each do |recipient|
            response.add(recipient, Response::FAIL)
          end
       end
       response
    end

    def parse_number(number)
        number.split(' ').last
    end

  end

end
