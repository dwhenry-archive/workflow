SiteConfig = OpenStruct.new(
                     :title => 'Workflow Monitor',
                     :author => 'David Henry',
                     :url_base => 'http://workflow-monitor.herokuapp.com/'
                    )

module Workflow
  class Routes < Sinatra::Base
    configure do |config|
      # mongo_env = YAML.load_file(File.join(File.dirname(__FILE__) ,'..', '..', 'config', 'mongoid.yml'))[config.environment.to_s]
      # Mongoid.config do |config|
      #   mongo_connection = Mongo::Connection.new(mongo_env["host"]).db(mongo_env["database"])
      #   mongo_connection.authenticate(mongo_env["user"], mongo_env["password"]) if mongo_env["user"]
      #   config.master = mongo_connection
      # end
      
    end

    require 'workflow/routes/root'
    use Root

    require 'workflow/routes/process'
    use Process

    require 'workflow/routes/tasks'
    use Tasks
  end
end


