module Splat

  class Response

    INVALID_NUMBER_FORMAT = "Invalid phone number format"
    SUCCESSFUL = 'Message sent successfully'
    FAIL = "Fail to send message"

    attr_accessor :phone_numbers, :message

    def initialize
      @phone_numbers = {}
    end

    def invalid_phone_format(number)
      @phone_numbers[number] = INVALID_NUMBER_FORMAT 
    end

    def add(number, message)
      @phone_numbers[number] = message 
    end

    def invalid_phone_numbers
      @phone_numbers.keys
    end

  end

end
