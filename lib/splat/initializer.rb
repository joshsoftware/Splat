module Splat

  module Initializer

    Dir[File.dirname(__FILE__) + '/vendors/**/*_gateway.rb'].each do |file|
      require file
      #vendor_implemetation = File.basename(file, '.rb').camelize
      #autoload vendor_implemetation, file
    end

  end

end
