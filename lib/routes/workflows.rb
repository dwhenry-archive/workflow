class Routes
  class Workflows < SinatraBaseWithHelper
    namespace '/workflows' do
      get '' do
        @workflows = Workflow.all
        haml :'workflows/index'
      end
      
      get '/new' do
        @workflow = Workflow.new
        haml :'workflows/new'
      end

      post '' do
        @workflow = Workflow.new(params[:workflow])
        if @workflow.save
          haml :'workflows/show'
        else
          haml :'workflows/new'
        end
      end
      
      get "/:id" do |id|
        begin
          @workflow = Workflow.find(id)
          haml :'workflows/show'
        rescue RecordNotFoundError => e
          @error = e.message
          halt 404
        end
      end      

      get "/:id/edit" do |id|
        begin
          @workflow = Workflow.find(id)
          haml :'workflows/edit'
        rescue RecordNotFoundError => e
          @error = e.message
          halt 404
        end
      end      
    end
  end
end
