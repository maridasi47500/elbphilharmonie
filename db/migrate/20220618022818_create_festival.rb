class CreateFestival < ActiveRecord::Migration[6.0]
  def change
    create_table :festivals do |t|
      t.date :begindate
      t.date :enddate
      t.string :title
      t.text :subtitle
      t.text :description
      t.string :image1
      t.string :image2
      t.timestamps
    end
    create_table :festivalshavevideos do |t|
      t.integer :festival_id
      t.integer :video_id
    end
    create_table :festivalshavepromoters do |t|
      t.integer :festival_id
      t.integer :promoter_id
    end
    create_table :festivalshaveblogs do |t|
      t.integer :festival_id
      t.integer :blog_id
    end
    create_table :blogs do |t|
      t.string :title
      t.string :type
      t.text :subtitle
      t.string :shortsubtitle
      t.string :littlepic
      t.string :littlepictitle
      t.string :image
      t.text :description
      t.string :url
      
      t.timestamps
    end
    create_table :blogshavepictures do |t|
      t.integer :blog_id
      t.integer :mypic_id
    end
    create_table :blogshavecontents do |t|
      t.integer :blog_id
      t.integer :content_id
    end
    create_table :contentshavevideos do |t|
      t.integer :video_id
      t.integer :content_id
    end
    create_table :contentshaveblogs do |t|
      t.integer :content_id
      t.integer :blog_id
    end
    create_table :contents do |t|
      t.text :content
    end
    create_table :mypics do |t|
      t.string :image
      t.timestamps
    end
    
    create_table :livestreams do |t|
      t.integer :blog_id
      t.string :url
      t.date :begins
      t.date :ends
      
      t.timestamps
    end
    create_table :concert_broadcasts do |t|
      t.text :description
      t.timestamps
    end
    create_table :eventshavebroadcasts do |t|
      t.integer :event_id
      t.integer :concert_broadcast_id
      t.timestamps
    end
  end
end
