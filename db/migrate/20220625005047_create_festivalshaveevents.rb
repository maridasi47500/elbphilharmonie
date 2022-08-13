class CreateFestivalshaveevents < ActiveRecord::Migration[6.0]
  def change
    create_table :festivalshaveevents do |t|
      t.integer :festival_id
      t.integer :event_id
    end
  end
end
