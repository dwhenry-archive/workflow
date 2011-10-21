Sequel.migration do
  up do
    create_table :workflow do
      primary_key :id
      String :name
      String :description
    end
  end
  down do
    drop_table(:workflow)
  end
end
