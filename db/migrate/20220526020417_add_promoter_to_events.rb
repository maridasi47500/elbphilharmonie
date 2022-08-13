class AddPromoterToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :promoter, :string
  end
end
