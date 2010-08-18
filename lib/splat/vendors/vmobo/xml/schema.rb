require 'xsd/qname'
require "xsd/mapping"

module VmoboSchema
  # {}attributes
  class Attributes
    @@schema_type = "attributes"
    @@schema_ns = nil
    @@schema_element = [["custom_message", "SOAP::SOAPString"]]

    attr_accessor :custom_message

    def initialize(custom_message = nil)
      @custom_message = custom_message
    end
  end

  # {}recipient
  class Recipient
    @@schema_type = "recipient"
    @@schema_ns = nil
    @@schema_element = [["phone_number", "SOAP::SOAPString"], ["attributes", "Attributes"]]

    attr_accessor :phone_number
    attr_accessor :attributes

    def initialize(phone_number = nil, attributes = nil)
      @phone_number = phone_number
      @attributes = attributes
    end
  end

  # {}recipients
  class Recipients < ::Array
    @@schema_type = "recipient"
    @@schema_ns = nil
    @@schema_element = [["recipient", ["Recipient[]", XSD::QName.new(nil, "recipient")]]]
  end

  # {}request
  class Request
    @@schema_type = "request"
    @@schema_ns = nil
    @@schema_element = [["user", "SOAP::SOAPString"], ["app_id", "SOAP::SOAPString"], ["message", "SOAP::SOAPString"], ["keyword", "SOAP::SOAPString"], ["recipients", "Recipients"]]

    attr_accessor :user
    attr_accessor :app_id
    attr_accessor :message
    attr_accessor :keyword
    attr_accessor :recipients

    def initialize(user = nil, app_id = nil, message = nil, keyword = nil, recipients = nil)
      @user = user
      @app_id = app_id
      @message = message
      @keyword = keyword
      @recipients = recipients
    end
  end
end
