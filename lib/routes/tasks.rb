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
        @task = @workflow.add_task(params[:task])
        if @task.save
          haml :'workflows/show'
        else
          haml :'tasks/new'
        end
      end
      
      get '/:id/edit' do
        haml 'edit'
      end
      
      put '/:id/update' do
        haml 'update'
      end
      
      get '/:id/position' do
        @task = Task.find(params[:id])
        @task.set_position(params[:x], params[:y])
      end
    end
  end
end
