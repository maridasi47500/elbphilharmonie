class AddElbidToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :elbid, :integer
  end
end
