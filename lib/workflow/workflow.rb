class Workflow
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
  
  def save
    model = MyModels::Workflow.new(:name => self.name, :description => self.description)
    return true if model.save
    @errors = model.errors
    return false
  end
end