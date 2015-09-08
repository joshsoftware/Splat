# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{josh-splat}
  s.version = "0.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Gautam Rege", "Jiren Patel", "Sethupathi Asokan"]
  s.date = %q{2010-07-13}
  s.description = %q{
    SPlat is an integration platform to make use of SMS integration really easy. Using this platform has the following advantages:

      * Single point of integration
      * Change vendors without changing code.
      * Send and receive SMS. 
      * Generic Exception Handling.
      * Standardized reports.
      * SMS tagged user groups.
      * SMS bogus gateway for testing.
      * Scheduling SMS for delivery.
  }
  s.email = %q{info@joshsoftware.com}
  s.extra_rdoc_files = ["LICENSE", "README.rdoc"]
  s.files = [".document", ".gitignore", "LICENSE", "README.rdoc", "Rakefile", "VERSION", "test/helper.rb", "test/test_splat.rb", "generators/splat_config/splat_generator.rb", "generators/splat_config/templates/splat.yml", "generators/splat_config/templates/vendors.yml", "init.rb", "lib/splat/configuration.rb", "lib/splat/error.rb", "lib/splat/gateway.rb", "lib/splat/initializer.rb", "lib/splat/insertion.rb", "lib/splat/request.rb", "lib/splat/response.rb", "lib/splat/utils.rb", "lib/splat/validator.rb", "lib/splat/vendors/bulksmspune/bulksmspune_gateway.rb", "lib/splat/vendors/clickatell/clickatell_gateway.rb", "lib/splat.rb", "lib/splat/vendors/twilio/twilio_gateway.rb","lib/splat/vendors/twilio/xml/twilio.xsd","lib/splat/vendors/twilio/xml/twilio_xml.rb", "test.rb"]
  s.homepage = %q{http://github.com/joshsoftware/Splat}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{SPlat is an integration platform to make use of SMS integration really easy}
  s.test_files = ["test/helper.rb", "test/test_splat.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    else
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    end
  else
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
  end
end
