class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.integer :venue_id
      t.string :title
      t.string :subtitle
      t.date :date
      t.time :time
      t.string :price
      t.string :image
      t.timestamps
    end
  end
end
