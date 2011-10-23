# Generated by cucumber-sinatra. (2011-10-21 07:53:47 +0100)

ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '..', 'environment.rb')
require File.join(File.dirname(__FILE__), '..', '..', 'lib/workflow.rb')

require 'ruby-debug'
require 'capybara'
require 'capybara/cucumber'
require 'rspec'

Capybara.app = Routes

class WorkflowWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
end

World do
  WorkflowWorld.new
end