class CreateEventhavecat < ActiveRecord::Migration[6.0]
  def change
    create_table :eventhavecats do |t|
      t.integer :event_id
      t.integer :eventcat_id
    end
  end
end
