class Workflow
  include SaveToModel
  
  attr_accessor :id, :name, :description, :errors
  def self.all
    MyModels::Workflow.all.map do |wf|
      new(:id => wf.id, :name => wf.name, :description => wf.description)
    end
  end
  
  def self.find(id)
    wf = MyModels::Workflow.find(:id => id)
    if wf
      new(:id => wf.id, :name => wf.name, :description => wf.description)
    else
      raise RecordNotFoundError, "Workflow (id: #{id})"
    end
  end
  
  def initialize(params={})
    @id = params[:id]
    @name = params[:name]
    @description = params[:description]
    @errors = []
  end
  
  def tasks
    MyModels::Task.filter({:workflow_id => @id}).map do |task|
      Task.new({:name => task.name, :workflow => self})
    end 
  end
  
  def save
    save_to_model(MyModels::Workflow, [:name, :description])
  end
end

