module Workflow
  class Routes
    class Tasks < Sinatra::Base
      register Sinatra::Namespace

      namespace '/tasks' do
        get '' do
          haml :'tasks/index'
        end
        
        get '/new' do
          haml 'new record??'
        end
        
        post '/create' do
          haml 'create'
        end
        
        get '/show/:id' do
          haml 'show'
        end
        
        get '/edit/:id' do
          haml 'edit'
        end
        
        put '/update/:id' do
          haml 'update'
        end
      end
    end
  end
end
