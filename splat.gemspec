# -*- encoding: utf-8 -*-
# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
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
  s.license       = "MIT"
  s.files  = `git ls-files`.split($/)
  s.homepage = %q{http://github.com/joshsoftware/Splat}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.summary = %q{SPlat is an integration platform to make use of SMS integration really easy}
  s.test_files = ["test/helper.rb", "test/test_splat.rb"]
  
end
