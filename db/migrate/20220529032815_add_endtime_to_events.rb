class AddEndtimeToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :endtime, :time
  end
end
