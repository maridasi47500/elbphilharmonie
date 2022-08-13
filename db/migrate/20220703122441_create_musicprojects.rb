class CreateMusicprojects < ActiveRecord::Migration[6.0]
  def change
    create_table :musicprojects do |t|
      t.string :title
      t.string :subtitle
      t.string :image
      t.string :caption
      t.string :year
      t.string :mytype
      t.date :registerstart
      t.date :registerend
      t.date :start
      t.date :end
      t.text :description
      t.integer :event_status_id
    end
    create_table :musicprojectshaveevents do |t|
      t.integer :musicproject_id
      t.integer :events_id
    end
    create_table :musicprojectshaveblogs do |t|
      t.integer :musicproject_id
      t.integer :blog_id
    end
    create_table :musicprojectshavephotos do |t|
      t.integer :mypic_id
      t.integer :musicproject_id
    end
    create_table :musicprojectshavepromoters do |t|
      t.integer :promoter_id
      t.integer :musicproject_id
    end
  end
end
