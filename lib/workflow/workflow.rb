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
  
  def add_task(params)
    last_task = tasks.sort_by(&:top).last
    if last_task
      position = {:position => "#{last_task.left},#{last_task.top + 40}"}
    else
      position = {}
    end
    task = Task.new(params.merge(position))
    tasks << task
    task
  end
  
  def tasks
    @tasks = MyModels::Task.filter({:workflow_id => @id}).map do |task|
      Task.new({:id => task.id, :name => task.name, :workflow => self, :position => task.position})
    end 
  end
  
  def tasks_height
    tasks.map(&:top).max + 40
  end
  
  def tasks_width
    tasks.map(&:left).max + 160
  end
  
  def save
    save_to_model(MyModels::Workflow, [:name, :description])
  end
end

