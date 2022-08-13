class CreateContentshavepictures < ActiveRecord::Migration[6.0]
  def change
    create_table :contentshavepictures do |t|
      t.integer :mypic_id
      t.integer :content_id
      t.integer :range
    end
  end
end
