class AddElbidToFestivals < ActiveRecord::Migration[6.0]
  def change
    add_column :festivals, :elbid, :integer
  end
end
