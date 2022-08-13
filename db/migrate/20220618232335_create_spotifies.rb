class CreateSpotifies < ActiveRecord::Migration[6.0]
  def change
    create_table :spotifieshavesubscriptions do |t|
      t.integer :spotify_id
      t.integer :subscription_id
    end
    create_table :spotifies do |t|
      t.string :image
      t.string :iframe
      t.string :caption
    end
  end
end
