require 'padrino-helpers'

SiteConfig = OpenStruct.new(
                     :title => 'Workflow Monitor',
                     :author => 'David Henry',
                     :url_base => 'http://workflow-monitor.herokuapp.com/'
                    )

  
class Routes < Sinatra::Base
  
  class SinatraBaseWithHelper < Sinatra::Base
    register Padrino::Helpers
    register Sinatra::Namespace
    
    not_found do
      haml :'404'
    end

    error do
      haml :'500'
    end
  end
  
  require 'routes/root'
  use Root

  require 'routes/tasks'
  use Tasks

  require 'routes/workflows'
  use Workflows

end


