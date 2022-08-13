class AddStatusToEvevents < ActiveRecord::Migration[6.0]
  def change
    create_table :dateandtimes do |t|
      t.integer :event_id
      t.date :date
      t.date :time
      t.timestamps
    end
    create_table :event_statuses do |t|
      t.integer :event_id
      t.string :type
      t.string :status
      t.date :date
      t.string :website
      t.text :status_sub
      t.timestamps
    end
  end
end
