module Splat

  module Insertion

    def insert_values(message,insertions = {}, default_insertions = {})
      number_messsage_map = {}

      insertions.each do |key, value|
        i = -1
        insertions[key] = message.gsub(/\$\d/) {|match| value[i += 1] }
      end
      insertions
    end

  end

end
