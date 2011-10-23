$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'sinatra'
require 'sinatra/namespace'
require 'json'
# require 'mongoid'
# require 'airbrake'

require 'workflow/workflow'
require 'workflow/process'
require 'routes'

require 'my_models'

class RecordNotFoundError < StandardError; end