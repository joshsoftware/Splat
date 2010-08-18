module Splat
  module Utils

    def url_escape(data)
      URI.escape(data, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    end

  end
end
