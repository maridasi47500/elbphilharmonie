class CreateHighlights < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.string :name
      t.string :url
      t.timestamps
    end
    create_table :mylabels do |t|
      t.string :name
      t.timestamps
    end
    create_table :highlights do |t|
      t.date :begindate
      t.date :enddate
      t.string :title
      t.string :subtitle
      t.string :category
      t.integer :mylabel_id
      t.string :url
      t.string :imageurl
      t.text :content
      t.string :image
      t.string :imagecaption
      t.timestamps
    end
    create_table :press do |t|
      t.string :title
      t.timestamps
    end
    create_table :presshaslinks do |t|
      t.integer :link_id
      t.integer :press_id
    end
  end
end
