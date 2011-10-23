class Routes
  class Tasks < SinatraBaseWithHelper
    namespace '/workflows/:workflow_id/tasks' do
      get '/new' do
        @workflow = Workflow.find(params[:workflow_id])
        @task = Task.new({:workflow => @workflow})
        haml :'/tasks/new'
      end
      
      post '' do
        @workflow = Workflow.find(params[:workflow_id])
        @task = Task.new(params[:task])
        if @task.save
          haml :'workflows/show'
        else
          haml :'tasks/new'
        end
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
