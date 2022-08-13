class AddUrlToFestivals < ActiveRecord::Migration[6.0]
  def change
    add_column :festivals, :url, :string
  end
end
