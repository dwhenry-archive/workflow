require 'rubygems'
require File.join(File.dirname(__FILE__), 'environment')
require File.join(File.dirname(__FILE__), 'lib', 'workflow.rb')

set :run, false
set :environment, :production

# FileUtils.mkdir_p 'log' unless File.exists?('log')
# log = File.new("log/sinatra.log", "a+")
# $stdout.reopen(log)
# $stderr.reopen(log)

run Routes
