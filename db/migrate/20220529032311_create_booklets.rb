class CreateBooklets < ActiveRecord::Migration[6.0]
  def change
    create_table :booklets do |t|
      t.integer :event_id
      t.string :link
      t.string :title
      t.string :size
      t.timestamps
    end
  end
end
