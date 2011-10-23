Sequel.migration do
  up do
    create_table :workflows do
      primary_key :id
      String :name
      String :description
    end
  end
  down do
    drop_table(:workflows)
  end
end
