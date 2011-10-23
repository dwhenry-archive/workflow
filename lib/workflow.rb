$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'sinatra'
require 'sinatra/namespace'
require 'json'
require 'sequel'

# require 'mongoid'
# require 'airbrake'

require 'helpers/save_to_model'

require 'workflow/workflow'
require 'workflow/task'
require 'routes'

require 'my_models'

class RecordNotFoundError < StandardError; end