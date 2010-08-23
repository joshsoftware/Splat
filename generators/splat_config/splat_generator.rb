class SplatGenerator < Rails::Generator::Base

  def manifest
    record do |m|
      m.file 'splat.yml',    'config/splat.yml'
      m.file 'vendors.yml',  'config/vendors.yml'
    end
  end

  protected

  def banner
    "Usage: #{$0} splat"
  end
end

