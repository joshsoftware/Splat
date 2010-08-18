
module Splat

    class SplatError < StandardError
    end

    class SplatGatewayError < SplatError
    end

    class SplatFormatError < SplatError
    end

    class SplatNoGatewaySupportError < SplatError
    end

    class SplatGatewayImplError < SplatError
    end

end




