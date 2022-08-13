class CreateVenues < ActiveRecord::Migration[6.0]
  def change
    create_table :venues do |t|
      t.string :name_en
      t.string :name_de
      t.string :url
      t.timestamps
    end
    create_table :pics do |t|
      t.string :type
      t.integer :venue_id
      t.string :title
      t.string :url
      t.timestamps
    end
    create_table :venueshavevenues do |t|
      t.integer :venue_id
      t.integer :othervenue_id
    end
  end
end
