class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videoshaveevents do |t|
      t.integer :video_id
      t.integer :event_id
    end
    create_table :videos do |t|
      t.string :overlay
      t.string :image
      t.string :caption
      t.timestamps
    end
    create_table :subscriptionshaveevents do |t|
      t.integer :subscription_id
      t.integer :event_id
    end
  end
end
