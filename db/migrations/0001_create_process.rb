Sequel.migration do
  up do
    create_table :processes do
      primary_key :id
      String :name
      String :description
      Integer :workflow_id
      String :position
      # Float
    end
  end
  down do
    drop_table(:processes)
  end
end
