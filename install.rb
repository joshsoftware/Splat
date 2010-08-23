require 'fileutils'
require 'rubygems'

dir = File.dirname(__FILE__)
templates = File.join(dir, 'generators', 'templates')
config = File.join('config', 'splat.yml')
vendor_sconfig = File.join('config', 'vendors.yml')

[config, script].each do |path| 
  FileUtils.cp File.join(templates, path), File.join(RAILS_ROOT, path) unless File.exist?(File.join(RAILS_ROOT, path))
end
puts IO.read(File.join(dir, 'README.rdoc'))
