class AddMyorderToContents < ActiveRecord::Migration[6.0]
  def change
    add_column :contents, :myorder, :integer
  end
end
