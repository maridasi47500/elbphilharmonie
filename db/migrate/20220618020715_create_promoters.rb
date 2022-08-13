class CreatePromoters < ActiveRecord::Migration[6.0]
  def change
    create_table :promoters do |t|
      t.string :name
      t.timestamps
    end
    create_table :eventshavepromoters do |t|
      t.integer :event_id
      t.integer :promoter_id
      t.timestamps
    end
  end
end
