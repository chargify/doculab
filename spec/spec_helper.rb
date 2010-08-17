# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"
require "rspec/rails"

# ActionMailer::Base.delivery_method = :test
# ActionMailer::Base.perform_deliveries = true
# ActionMailer::Base.default_url_options[:host] = "test.com"

Rails.backtrace_cleaner.remove_silencers!

# Configure capybara for integration testing
require "capybara/rails"
Capybara.default_driver   = :rack_test
Capybara.default_selector = :css

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

Rspec.configure do |config|
  # Remove this line if you don't want Rspec's should and should_not
  # methods or matchers
  require 'rspec/expectations'
  config.include Rspec::Matchers

  # == Mock Framework
  config.mock_with :rspec
end

# Returns a "known good" permalink
def good_permalink
  return @good_permalink unless @good_permalink.nil?
  
  permalink = 'overview'
  filepath = Doculab::Doc.directory.join("#{permalink}.textile")
  
  if File.exist?(filepath)
    @good_permalink = permalink
  else
    raise StandardError, "The permalink '#{permalink}' does not correspond to a file at #{filepath}"
  end
end

# Returns a "known bad" permalink
def bad_permalink
  return @bad_permalink unless @bad_permalink.nil?
  
  permalink = 'foobar'
  filepath = Doculab::Doc.directory.join("#{permalink}.textile")
  
  if File.exist?(filepath)
    raise StandardError, "The permalink '#{permalink}' corresponds to an existing file (#{filepath}), and this spec expects it be non-existant"
  else
    @bad_permalink = permalink
  end
end
