class Task
  include SaveToModel
  
  attr_accessor :id, :name, :errors, :workflow, :workflow_id
  def initialize(params={})
    @errors = []
    @workflow = params[:workflow] || Workflow.find(params[:workflow_id])
    @workflow_id = params[:workflow_id] || @workflow.id
    @name = params[:name]
  end

  def save
    save_to_model(MyModels::Task, [:name, :workflow_id])
  end
end
