Sequel.migration do
  up do
    create_table :tasks do
      primary_key :id
      String :name
      Integer :workflow_id
    end
  end
  down do
    drop_table(:tasks)
  end
end
