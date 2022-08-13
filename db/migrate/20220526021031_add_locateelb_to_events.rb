class AddLocateelbToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :venues, :locateelb, :boolean
    add_column :venues, :description, :text
    add_column :events, :description, :text
    create_table :venueinfos do |t|
      t.string :type
      t.integer :venue_id
      t.text :description_en
      t.text :description_d
    end
  end
end
