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

Before do 
  DB.tables.each do |table| 
    DB[table].delete 
  end 
end

# Around does not wrap Background tasks.. only the Scenario tasks.. Fail..
# Around('~@javascript') do |scenario, block|
#   Sequel::Model.db.transaction do 
#     block.call 
#     raise Sequel::Error::Rollback 
#   end 
# end