class CreateEventcats < ActiveRecord::Migration[6.0]
  def change
    create_table :mycats do |t|
      t.string :name_en
      t.string :name_fr
      t.timestamps
    end
    create_table :eventcats do |t|
      t.integer :mycat_id
      t.string :name_en
      t.string :name_fr
      t.string :url
      t.timestamps
    end
  end
end
