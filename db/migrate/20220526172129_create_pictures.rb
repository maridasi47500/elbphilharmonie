class CreatePictures < ActiveRecord::Migration[6.0]
  def change
    create_table :pictures do |t|
      t.integer :event_id
      t.string :type
      t.string :title
      t.string :url
    end
  end
end
