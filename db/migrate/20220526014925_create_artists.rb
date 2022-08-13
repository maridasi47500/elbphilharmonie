class CreateArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :artists do |t|
      t.string :name
      t.timestamps
    end
    create_table :musical_instruments do |t|
      t.string :name_en
      t.string :name_de
      t.timestamps
    end
    create_table :musicians do |t|
      t.integer :artist_id
      t.integer :musical_instrument_id
    end
    create_table :performers do |t|
      t.integer :musician_id
      t.integer :event_id
    end
  end
end
