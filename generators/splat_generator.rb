class SplatGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.file 'config/splat.yml',    'config/facebooker.yml'
      m.file 'config/vendors.yml',  'config/vendors.yml'
    end
  end

  protected

  def banner
    "Usage: #{$0} splat"
  end
end

