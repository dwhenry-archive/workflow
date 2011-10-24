class Task
  include SaveToModel
  
  attr_accessor :id, :name, :errors, :workflow, :workflow_id, :position
  def self.find(id)
    t = MyModels::Task.find(:id => id)
    if t
      new(:id => t.id, :name => t.name, :position => t.position, :workflow_id => t.workflow_id)
    else
      raise RecordNotFoundError, "Task (id: #{id})"
    end
  end
  
  def initialize(params={})
    @errors = []
    @id = params[:id]
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
  
  def set_position(left, top)
    @position = "#{left},#{top}"
    save
  end
  
  def save
    save_to_model(MyModels::Task, [:name, :workflow_id, :position])
  end
end
