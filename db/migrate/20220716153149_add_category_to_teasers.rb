class AddCategoryToTeasers < ActiveRecord::Migration[6.0]
  def change
    add_column :teasers, :category, :string
  end
end
