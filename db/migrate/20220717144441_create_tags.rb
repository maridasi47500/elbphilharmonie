class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.string :name
      t.string :url
      t.timestamps
    end
    create_table :blogshavetags do |t|
      t.integer :tag_id
      t.integer :blog_id
      t.timestamps
    end
  end
end
