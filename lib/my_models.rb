Sequel::Model.plugin :validation_helpers
Sequel::Model.raise_on_save_failure = false

module MyModels
  class Workflow < Sequel::Model(:workflows)
    def validate
      super
      validates_unique(:name)
      validates_presence(:name)
      validates_presence(:description)
    end
  end

  class Task < Sequel::Model(:tasks)
    def validate
      super
      validates_unique(:name)
      validates_presence(:name)
      validates_presence(:workflow_id)
    end
  end
end