class Changecolumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :venueinfos, :type, :mytype
  end
end
