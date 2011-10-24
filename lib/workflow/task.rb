class Task
  include SaveToModel
  
  attr_accessor :id, :name, :errors, :workflow, :workflow_id, :position
  def initialize(params={})
    @errors = []
    @workflow = params[:workflow] || Workflow.find(params[:workflow_id])
    @workflow_id = params[:workflow_id] || @workflow.id
    @name = params[:name]
    @position = params[:position] || '5,5'
  end
  
  def top
    @position.split(',').last.to_i
  end
  
  def left
    @position.split(',').first.to_i
  end
  
  def save
    save_to_model(MyModels::Task, [:name, :workflow_id, :position])
  end
end
