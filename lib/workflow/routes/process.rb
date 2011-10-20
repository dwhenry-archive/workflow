module Workflow
  class Routes
    class Process < Sinatra::Base
      register Sinatra::Namespace

      namespace '/process' do
        get '' do
          haml :'tasks/index'
        end
        
        get '/:id/show' do
          haml 'show process'
        end
        
        namespace '/:process_id/tasks' do
          get '/new' do
            haml 'new task'
          end
        
          post '/create' do
            haml 'create task'
          end
        
          delete '/:id' do
            haml 'delete task'
          end
        end
      end
    end
  end
end
