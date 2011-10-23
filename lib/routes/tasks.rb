class Routes
  class Tasks < SinatraBaseWithHelper
    namespace '/workflows/:id/tasks' do
      get '/new' do |workflow_id|
        @workflow = Workflow.find(workflow_id)
        haml :'/tasks/new'
      end
      
      post '/create' do
        haml 'create'
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
