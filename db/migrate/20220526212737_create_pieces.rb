class CreatePieces < ActiveRecord::Migration[6.0]
  def change
    create_table :pieces do |t|
      t.string :name
      t.timestamps
    end
    create_table :eventhavepieces do |t|
      t.integer :piece_id
      t.integer :event_id
    end
  end
end
