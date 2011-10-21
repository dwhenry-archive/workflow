class Routes
  class Workflow < Sinatra::Base
    register Sinatra::Namespace

    namespace '/workflow' do
      get '' do
        @workflows = Workflow.all
        haml :'workflows/index'
      end
      
      get '/:id/show' do
        haml 'show process'
      end
      
    end
  end
end
