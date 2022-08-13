class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.string :title
      t.string :subtitle
      t.string :image
      t.text :description
      t.date :starts
      t.date :ends
      t.integer :elbid
      t.timestamps
    end
    create_table :subscriptionshavevideos do |t|
      t.integer :subscription_id
      t.integer :video_id
    end
  create_table :subscriptionshavepromoters do |t|
      t.integer :subscription_id
      t.integer :promoter_id
    end
    add_column :events, :subscription_id,:integer
  end
end
