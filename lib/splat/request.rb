module Splat

  class Request

    SINGLE         = 0
    BULK           = 1
    BULK_INSERTION = 2

    INVALID_NUMBER_FORMAT = "Invalid phone number format"

    attr_accessor :type
    attr_accessor :message
    attr_accessor :numbers
    attr_accessor :options

    def sms(message, number, options = {})
        @type, @message, @numbers, @options = SINGLE, message, number, options
    end


    def bulk_sms(message, numbers, options = {}))
      @type, @message, @numbers, @options = BULK, message, numbers, options
    end

    def bulk_sms_with_insertion(message, numbers, options = {}))
      @type, @message, @numbers, @options = BULK_INSERTION, message, numbers, options
    end


  end

end
