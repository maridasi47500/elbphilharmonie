class CreateContentshaveseries < ActiveRecord::Migration[6.0]
  def change
    create_table :contentshaveseries do |t|
      t.integer :content_id
      t.integer :concert_series_id
    end
  end
end
