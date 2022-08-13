class CreateContentshavevideolinks < ActiveRecord::Migration[6.0]
  def change
    create_table :contentshavebloglinks do |t|
      t.integer :blog_id
      t.integer :content_id
    end
  end
end
