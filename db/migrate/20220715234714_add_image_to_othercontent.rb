class AddImageToOthercontent < ActiveRecord::Migration[6.0]
  def change
    add_column :othercontents, :image, :string
  end
end
