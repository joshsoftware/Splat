module Spalt

  module Validator

    def valid_phone?(number)
      number.to_s =~ number_format_regx
    end

    def valid_phones?(numbers)
    end

  end

end
