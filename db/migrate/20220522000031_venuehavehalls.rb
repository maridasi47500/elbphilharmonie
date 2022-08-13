class Venuehavehalls < ActiveRecord::Migration[6.0]
  def change
    create_table :venuehavehalls do |t|
      t.integer :eventcat_id
      t.integer :othereventcat_id
    end
  end
end
