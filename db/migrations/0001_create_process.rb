Sequel.migration do
  up do
    create_table :processes do
      primary_key :id
      String :name
      String :description
      # Float
    end
  end
  down do
    drop_table(:processes)
  end
end
