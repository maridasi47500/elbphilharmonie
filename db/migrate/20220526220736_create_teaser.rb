class CreateTeaser < ActiveRecord::Migration[6.0]
  def change
    create_table :teasers do |t|
      t.string :image
      t.string :subtitle
      t.string :title
      t.integer :mylabel_id
      t.string :url
      t.timestamps
    end
    create_table :eventhaveteasers do |t|
      t.integer :teaser_id
      t.integer :event_id
    end
  end
end
