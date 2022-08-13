class CreateFestivalshavespotifies < ActiveRecord::Migration[6.0]
  def change
    create_table :festivalshavespotifies do |t|
      t.integer :festival_id
      t.integer :spotify_id
    end
  end
end
