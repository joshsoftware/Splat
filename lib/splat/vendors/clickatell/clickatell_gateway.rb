
module Splat

  class Clickatell <  Gateway

    PARSE_REGEX = /[A-Za-z0-9]+:.*?(?:(?=[A-Za-z0-9]+:)|$)/

    def initialize()
      super
      self.required_config([:provider_url, :api_key, :username, :password])
      @url      = self.config_option(:provider_url)
      @api_key  = self.config_option(:api_key)
      @username = self.config_option(:username)
      @password = self.config_option(:password)

      @last_call_time = Time.now - 30*60
      @session_id = nil
    end
 
    def send_sms(message, number, options = {})
      options[:response].add(number, parse_response(call_service(message, parse_number(number))))
      options[:response]
    end

    def send_bulk_sms(message, numbers, options = {})
      numbers = numbers.collect{ |x| parse_number(x) }.join(',')
      response = parse_response(call_batch_service(message, numbers))
      response.each do |result|
        options[:response].add(result[1].split(': ').last, result[0])
      end
      options[:response]
    end

    def send_bulk_sms_with_insertion(message, insertions = {}, options = {})
      call_batch_service_with_insertion(message, insertions, options[:response])
    end

    private 

    def get_session_id
        if (Time.now - @last_call_time) > 800
          response = http_get("#{@url}/http/auth?api_id=#{@api_key}&user=#{@username}&password=#{@password}").split(": ")
          
          unless response[0] == 'OK'
            raise SplatGatewayError.new('Cliclatell :' + response[1])
          end

          @session_id = response[1]
        end
        @last_call_time = Time.now
        @session_id
    end

    def get_batch_id(message)
      i = 0
      message = message.gsub(/\$\d/) {|match| "#field#{i += 1}#" }
      response = http_get("#{@url}/http_batch/startbatch?session_id=#{get_session_id}&template=#{url_escape(message)}").split(': ')

      unless response[0] == 'ID'
        raise SplatGatewayError.new('Cliclatell :' + response[1])
      end
      response[1]
    end

    def call_service(message, numbers)
      http_get "#{@url}/http/sendmsg?session_id=#{get_session_id}&to=#{numbers}&text=#{url_escape(message)}"
      #response = http_get "#{@url}/http/sendmsg?user=#{@username}&password=#{@password}&api_id=#{@api_key}&to=#{numbers}&text=#{url_escape(message)}"
    end
    

    def call_batch_service(message, numbers)
       batch_id = get_batch_id(message)
       response = http_get "#{@url}/http_batch/quicksend?session_id=#{get_session_id}&batch_id=#{batch_id}&to=#{numbers}"
       end_batch(batch_id)
       response
    end

    def call_batch_service_with_insertion(message, insertions, response)
       batch_id = get_batch_id(message)

       url = "#{@url}/http_batch/senditem?session_id=#{get_session_id}&batch_id=#{batch_id}"

       insertions.each do |number,fields|
         i = 0
         fields = fields.collect do |field|
                   "field#{i += 1}=#{field}" 
                  end
         response.add(number , http_get("#{url}&to=#{parse_number(number)}&#{fields.join('&')}")) 
       end
       end_batch(batch_id)
       response
    end

    def end_batch(batch_id)
      http_get "#{@url}/http_batch/endbatch?session_id=#{get_session_id}&batch_id=#{batch_id}"
    end

    def http_get(url)
      response = Net::HTTP.get URI.parse(url)               
      response
    end

    def parse_number(number)
      number.tr('+ ', '')
    end

    def parse_response(http_response)
      if http_response.scan(/ERR/).any?
        return http_response
      end
      results = http_response.split("\n").map do |line|
      response_fields = line.scan(PARSE_REGEX)
      end
      results.length == 1 ? results.first : results
    end

  end

end
