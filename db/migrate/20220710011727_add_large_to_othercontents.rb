class AddLargeToOthercontents < ActiveRecord::Migration[6.0]
  def change
    add_column :othercontents, :large, :integer
  end
end
