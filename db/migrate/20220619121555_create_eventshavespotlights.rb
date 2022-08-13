class CreateEventshavespotlights < ActiveRecord::Migration[6.0]
  def change
    create_table :eventshavespotlights do |t|
      t.integer :event_id
      t.integer :spotlight_id
    end
  end
end
