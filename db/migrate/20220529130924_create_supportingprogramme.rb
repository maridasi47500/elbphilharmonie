class CreateSupportingprogramme < ActiveRecord::Migration[6.0]
  def change
    create_table :supportingprogrammes do |t|
      t.integer :event_id
      t.integer :otherevent_id
    end
  end
end
