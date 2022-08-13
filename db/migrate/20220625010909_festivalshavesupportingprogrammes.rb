class Festivalshavesupportingprogrammes < ActiveRecord::Migration[6.0]
  def change
    create_table :festivalshavesupportingprogrammes do |t|
      t.integer :festival_id
      t.integer :event_id
    end
  end
end
