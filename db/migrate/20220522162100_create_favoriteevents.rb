class CreateFavoriteevents < ActiveRecord::Migration[6.0]
  def change
    create_table :favoriteevents do |t|
      t.integer :event_id
      t.integer :user_id
    end
  end
end
