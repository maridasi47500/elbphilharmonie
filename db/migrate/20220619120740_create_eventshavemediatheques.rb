class CreateEventshavemediatheques < ActiveRecord::Migration[6.0]
  def change
    create_table :eventshaveblogs do |t|
      t.integer :event_id
      t.integer :blog_id
    end
  end
end
